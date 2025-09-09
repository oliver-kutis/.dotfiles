#!/usr/bin/env bash
set -e

# Default values
LOCAL_DOTFILES_DIR="$HOME/code/.dotfiles"
REMOTE_DOTFILES_DIR="~/.dotfiles"
REPO_URL="git@github.com:oliver.kutis/.dotfiles.git"
REMOTE="user@server"

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

# Ensure local dotfiles repo exists
if [ ! -d "$LOCAL_DOTFILES_DIR" ]; then
	echo "Cloning dotfiles repo locally..."
	git clone "$REPO_URL" "$LOCAL_DOTFILES_DIR"
fi

# Export Pyenv info locally
echo "Exporting Pyenv versions..."
pyenv versions --bare >"$LOCAL_DOTFILES_DIR/pyenv/versions.txt"
pyenv global >"$LOCAL_DOTFILES_DIR/pyenv/global.txt"

# Sync Neovim config to dotfiles
echo "Syncing local Neovim config into dotfiles repo..."
rsync -av --delete ~/.config/nvim/ "$LOCAL_DOTFILES_DIR/nvim/.config/nvim/"

# Push updates to GitHub
echo "Committing and pushing dotfiles changes..."
cd "$LOCAL_DOTFILES_DIR"
git add .
git commit -m "Update dotfiles ($(date '+%Y-%m-%d %H:%M:%S'))" || echo "No changes to commit."
git push origin main

# Rsync dotfiles to remote
echo "Copying dotfiles to remote server..."
ssh "$REMOTE" "mkdir -p $REMOTE_DOTFILES_DIR"
rsync -av --delete "$LOCAL_DOTFILES_DIR/" "$REMOTE:$REMOTE_DOTFILES_DIR/"

# Execute remote setup script
echo "Executing remote setup..."
ssh "$REMOTE" "bash -s" <<EOF
set -e
DOTFILES_DIR="$REMOTE_DOTFILES_DIR"

echo "Applying Neovim config..."
mkdir -p "\$HOME/.config"
rsync -av "\$DOTFILES_DIR/nvim/.config/nvim" "\$HOME/.config/"

# Install Pyenv if missing
if ! command -v pyenv &>/dev/null; then
    echo "Installing pyenv..."
    curl https://pyenv.run | bash
    export PATH="\$HOME/.pyenv/bin:\$PATH"
    eval "\$(pyenv init --path)"
fi

# Install Python versions
echo "Installing Python versions..."
while read -r version; do
    if ! pyenv versions --bare | grep -q "^\$version\$"; then
        pyenv install "\$version"
    fi
done < "\$DOTFILES_DIR/pyenv/versions.txt"

# Set global Python version
GLOBAL_VERSION=\$(cat "\$DOTFILES_DIR/pyenv/global.txt")
pyenv global "\$GLOBAL_VERSION"

echo "✅ Remote setup complete!"
EOF

echo "✅ Local + Remote sync finished!"
