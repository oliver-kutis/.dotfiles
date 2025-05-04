#!/bin/bash

# Script to create and apply predefined workspace layouts in AeroSpace
# Usage: 
#   ./workspace_layout.sh apply LAYOUT_NAME - Apply a predefined layout

set -eo pipefail

# Get window ID for an app and open it if not running
get_window_id() {
    local app_name="$1"
    
    # Look for existing window
    local windows=$(aerospace list-windows --all --json)
    local window_id=$(echo "$windows" | jq -r --arg app "$app_name" '.[] | select(.["app-name"] == $app) | .["window-id"]' | head -1)
    
    # Open app if not running
    if [ -z "$window_id" ]; then
        echo "Opening $app_name..."
        open -a "$app_name"
        
        # Wait for app to launch
        for i in {1..20}; do
            sleep 0.2
            windows=$(aerospace list-windows --all --json)
            window_id=$(echo "$windows" | jq -r --arg app "$app_name" '.[] | select(.["app-name"] == $app) | .["window-id"]' | head -1)
            
            if [ -n "$window_id" ]; then
                break
            fi
        done
        
        if [ -z "$window_id" ]; then
            echo "Failed to get window ID for $app_name after waiting"
            return 1
        fi
    fi
    
    echo "$window_id"
}

# Apply the browser-chat-terminal layout
apply_browser_chat_terminal() {
    WORKSPACE="$1"
    
    # Check if workspace exists, create if not
    if ! aerospace list-workspaces --all | grep -q "^$WORKSPACE$"; then
        aerospace create-workspace "$WORKSPACE"
    fi
    
    # Switch to the workspace
    aerospace workspace "$WORKSPACE"
    
    # Flatten any existing layout
    aerospace flatten-workspace-tree
    
    # Get window IDs for required apps (or open them)
    echo "Setting up browser-chat-terminal layout..."
    
    # Try to find Safari first, then Chrome, then Firefox
    BROWSER_APP=""
    for browser in "Safari" "Google Chrome" "Firefox"; do
        if open -a "$browser" 2>/dev/null; then
            BROWSER_APP="$browser"
            break
        fi
    done
    
    if [ -z "$BROWSER_APP" ]; then
        echo "No supported browser found"
        return 1
    fi
    
    BROWSER_WIN=$(get_window_id "$BROWSER_APP")
    CHAT_WIN=$(get_window_id "ChatGPT")
    TERMINAL_WIN=$(get_window_id "Terminal")
    
    # Move all windows to current workspace
    aerospace move-node-to-workspace --window-id "$BROWSER_WIN" "$WORKSPACE"
    aerospace move-node-to-workspace --window-id "$CHAT_WIN" "$WORKSPACE"
    aerospace move-node-to-workspace --window-id "$TERMINAL_WIN" "$WORKSPACE"
    
    # Set up tiles layout
    aerospace layout tiles horizontal
    
    # Move browser to left side
    aerospace focus --window-id "$BROWSER_WIN"
    aerospace move left
    aerospace resize width=50%
    
    # Set up chat and terminal on right side
    aerospace focus --window-id "$CHAT_WIN"
    aerospace join-with right "$BROWSER_WIN"
    aerospace layout tiles vertical
    
    # Move chat up and terminal down
    aerospace focus --window-id "$CHAT_WIN"
    aerospace move up
    aerospace resize height=50%
    
    aerospace focus --window-id "$TERMINAL_WIN"
    aerospace join-with down "$CHAT_WIN"
    
    echo "Layout applied successfully"
}

apply_coding_layout() {
    WORKSPACE="$1"
    
    # Check if workspace exists, create if not
    if ! aerospace list-workspaces --all | grep -q "^$WORKSPACE$"; then
        aerospace create-workspace "$WORKSPACE"
    fi
    
    # Switch to the workspace
    aerospace workspace "$WORKSPACE"
    
    # Flatten any existing layout
    aerospace flatten-workspace-tree
    
    # Get window IDs for required apps (or open them)
    echo "Setting up coding layout..."
    
    # Try to find VS Code
    CODE_WIN=$(get_window_id "Visual Studio Code")
    TERMINAL_WIN=$(get_window_id "Terminal")
    BROWSER_WIN=$(get_window_id "Safari") # For documentation
    
    # Move all windows to current workspace
    aerospace move-node-to-workspace --window-id "$CODE_WIN" "$WORKSPACE"
    aerospace move-node-to-workspace --window-id "$TERMINAL_WIN" "$WORKSPACE"
    aerospace move-node-to-workspace --window-id "$BROWSER_WIN" "$WORKSPACE"
    
    # Set up tiles layout
    aerospace layout tiles vertical
    
    # Place code at the top (70% height)
    aerospace focus --window-id "$CODE_WIN"
    aerospace move up
    aerospace resize height=70%
    
    # Place terminal and browser at the bottom
    aerospace focus --window-id "$TERMINAL_WIN"
    aerospace join-with down "$CODE_WIN"
    aerospace layout tiles horizontal
    
    # Put terminal on left, browser on right
    aerospace focus --window-id "$TERMINAL_WIN"
    aerospace move left
    aerospace resize width=50%
    
    aerospace focus --window-id "$BROWSER_WIN"
    aerospace join-with right "$TERMINAL_WIN"
    
    echo "Coding layout applied successfully"
}

# Main execution
command="$1"
layout_name="$2"
workspace="${3:-1}" # Default to workspace 1 if not specified

if [ -z "$command" ] || [ -z "$layout_name" ]; then
    echo "Usage: $0 [apply] LAYOUT_NAME [WORKSPACE]"
    echo "Available layouts: browser-chat-terminal, coding"
    exit 1
fi

if [ "$command" != "apply" ]; then
    echo "Unknown command: $command"
    echo "Currently only 'apply' is supported"
    exit 1
fi

case "$layout_name" in
    "browser-chat-terminal")
        apply_browser_chat_terminal "$workspace"
        ;;
    "coding")
        apply_coding_layout "$workspace"
        ;;
    *)
        echo "Unknown layout: $layout_name"
        echo "Available layouts: browser-chat-terminal, coding"
        exit 1
        ;;
esac