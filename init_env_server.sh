#!/usr/bin/env bash
set -e

LOCAL_DOTFILES_DIR="$HOME/code/.dotfiles"
REMOTE_DOTFILES_DIR="$HOME/.dotfiles"
REPO_URL="git@github.com:oliver.kutis/.dotfiles.git"
REMOTE="user@server"
SKIP_PULL=true

# Parse arguments
while [[ "$#" -gt 0 ]]; do
	case $1 in
	--dotfiles-dir)
		LOCAL_DOTFILES_DIR="$2"
		shift
		;;
	--remote-dotfiles-dir)
		REMOTE_DOTFILES_DIR="$2"
		shift
		;;
	--repo-url)
		REPO_URL="$2"
		shift
		;;
	--remote)
		REMOTE="$2"
		shift
		;;
	--skip-pull) SKIP_PULL=true ;;
	--no-skip-pull) SKIP_PULL=false ;;
	*)
		echo "Unknown parameter: $1"
		exit 1
		;;
	esac
	shift
done

echo "Local dotfiles dir: $LOCAL_DOTFILES_DIR"
echo "Remote dotfiles dir: $REMOTE_DOTFILES_DIR"
echo "Repo URL: $REPO_URL"
echo "Remote server: $REMOTE"
echo "Skip pull: $SKIP_PULL"

# Ensure local dotfiles repo exists
if [ ! -d "$LOCAL_DOTFILES_DIR" ]; then
	echo "Cloning dotfiles repo locally..."
	git clone "$REPO_URL" "$LOCAL_DOTFILES_DIR"
fi

# Export Pyenv info locally
echo "Exporting Pyenv versions..."
mkdir -p "$LOCAL_DOTFILES_DIR/pyenv"
pyenv versions --bare >"$LOCAL_DOTFILES_DIR/pyenv/versions.txt"
pyenv global >"$LOCAL_DOTFILES_DIR/pyenv/global.txt"

# Rsync dotfiles to remote
echo "Copying dotfiles to remote server..."
# Make remote directory without expanding $REMOTE_DOTFILES_DIR locally
ssh "$REMOTE" 'mkdir -p "$HOME/.dotfiles"'
rsync -av --delete "$LOCAL_DOTFILES_DIR/" "$REMOTE:$REMOTE_DOTFILES_DIR/"

# Execute remote setup
ssh "$REMOTE" "bash -s" <<'EOF'
set -e

# Resolve remote paths using remote $HOME
DOTFILES_DIR="$HOME/.dotfiles"

# Pull latest changes if not skipped
if [ "${SKIP_PULL}" != true ] && [ -d "$DOTFILES_DIR/.git" ]; then
    echo "Pulling latest changes..."
    cd "$DOTFILES_DIR" && git pull origin main || echo "Git pull failed"
fi

# Install Neovim locally if missing
if ! command -v nvim &>/dev/null; then
    echo "Installing Neovim..."
    mkdir -p "$HOME/.local/bin"
    ARCH=$(uname -m)
    if [[ "$ARCH" == "x86_64" ]]; then
        NVIM_URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz"
        cd /tmp
        wget -q "$NVIM_URL" -O nvim.tar.gz
        tar xzf nvim.tar.gz
        cp nvim-linux64/bin/nvim "$HOME/.local/bin/"
        chmod u+x "$HOME/.local/bin/nvim"
        rm -rf nvim.tar.gz nvim-linux64
    else
        echo "Unsupported architecture. Please install Neovim manually."
        exit 1
    fi

    # Add ~/.local/bin to PATH permanently
    grep -qxF 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.bashrc" || echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
    export PATH="$HOME/.local/bin:$PATH"
fi

# Symlink Neovim config
mkdir -p "$HOME/.config"
ln -sfn "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

# Install pyenv if missing
if ! command -v pyenv &>/dev/null; then
    echo "Installing pyenv..."
    curl https://pyenv.run | bash
    export PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
fi

# Install Python versions
while read -r version; do
    if ! pyenv versions --bare | grep -qx "$version"; then
        pyenv install "$version"
    fi
done < "$DOTFILES_DIR/pyenv/versions.txt"

# Set global Python version
GLOBAL_VERSION=$(cat "$DOTFILES_DIR/pyenv/global.txt")
pyenv global "$GLOBAL_VERSION"

echo "✅ Remote setup complete!"
EOF

echo "✅ Local + Remote sync finished!"
