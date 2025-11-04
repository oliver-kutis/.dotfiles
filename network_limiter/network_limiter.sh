#!/bin/bash
# ~/code/.dotfiles/network_limiter/network_limiter.sh
# Simple bandwidth limiter using PF + Dummynet on macOS
# Config values are in MB/s

set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONF="$DIR/network_limiter.conf"
ANCHOR_NAME="com.user.network-limiter"
PF_CONF="/etc/pf.conf"
ANCHOR_LINE="anchor \"$ANCHOR_NAME\""
LOAD_ANCHOR_LINE="load anchor \"$ANCHOR_NAME\" from \"/etc/pf.anchors/$ANCHOR_NAME\""

# Load configuration
if [[ -f "$CONF" ]]; then
	source "$CONF"
else
	echo "❌ Config file not found: $CONF"
	exit 1
fi

# Convert MB/s to Kbit/s for dnctl
DOWNLOAD_KBIT=$((DOWNLOAD_SPEED * 8 * 1000))
UPLOAD_KBIT=$((UPLOAD_SPEED * 8 * 1000))

# Ensure the anchor file exists
sudo touch "/etc/pf.anchors/$ANCHOR_NAME"

# Ensure pf.conf includes our anchor
if ! grep -q "$ANCHOR_LINE" "$PF_CONF"; then
	echo "🔧 Adding anchor to $PF_CONF ..."
	sudo cp "$PF_CONF" "$PF_CONF.bak"
	echo "$ANCHOR_LINE" | sudo tee -a "$PF_CONF" >/dev/null
	echo "$LOAD_ANCHOR_LINE" | sudo tee -a "$PF_CONF" >/dev/null
fi

enable_limiter() {
	echo "🚀 Enabling network limiter (down=${DOWNLOAD_SPEED} MB/s, up=${UPLOAD_SPEED} MB/s)..."

	# Flush existing pipes
	sudo dnctl -q flush

	# Create pipes
	sudo dnctl pipe 1 config bw "${DOWNLOAD_KBIT}Kbit/s"
	sudo dnctl pipe 2 config bw "${UPLOAD_KBIT}Kbit/s"

	# Apply rules to all interfaces
	cat <<EOF | sudo pfctl -a "$ANCHOR_NAME" -f -
dummynet in all pipe 1
dummynet out all pipe 2
EOF

	# Enable PF if not already
	sudo pfctl -E || true

	echo "✅ Network limiter enabled."
}

disable_limiter() {
	echo "🧹 Disabling network limiter..."
	sudo pfctl -a "$ANCHOR_NAME" -F all 2>/dev/null || true
	sudo dnctl -q flush
	echo "✅ Network limiter disabled."
}

status_limiter() {
	echo "📊 == Dummynet pipes =="
	sudo dnctl list 2>/dev/null | awk '
    /pipe/ {
        printf "%s: %.2f MB/s\n", $1, ($3 / 8)
    }' || echo "(none)"

	echo
	echo "📊 == PF rules for $ANCHOR_NAME =="
	if ! sudo pfctl -a "$ANCHOR_NAME" -sr 2>/dev/null; then
		echo "(no rules loaded)"
	fi
}

case "${1:-}" in
on)
	enable_limiter
	;;
off)
	disable_limiter
	;;
status)
	status_limiter
	;;
*)
	echo "Usage: $0 {on|off|status}"
	exit 1
	;;
esac
