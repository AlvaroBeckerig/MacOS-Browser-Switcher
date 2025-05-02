#!/bin/bash

# -----------------------------
# Color definitions for output
# -----------------------------
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# -----------------------------
# Print status message in blue
# -----------------------------
print_status() {
    # Prints a status message in blue
    echo -e "${BLUE}[*]${NC} $1"
}

# -----------------------------
# Print success message in green
# -----------------------------
print_success() {
    # Prints a success message in green
    echo -e "${GREEN}[✓]${NC} $1"
}

# -----------------------------
# Print error message in red
# -----------------------------
print_error() {
    # Prints an error message in red
    echo -e "${RED}[✗]${NC} $1"
}

# ---------------------------------------------------
# Check if Homebrew is installed, install if missing
# ---------------------------------------------------
check_brew() {
    # Checks if Homebrew is installed; if not, installs it
    if ! command -v brew &> /dev/null; then
        print_status "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Check if installation was successful
        if [ $? -eq 0 ]; then
            print_success "Homebrew installed successfully!"
        else
            print_error "Failed to install Homebrew"
            exit 1
        fi
    else
        print_success "Homebrew is already installed"
    fi
}

# -------------------------------------------------------------------
# Setup LaunchAgent and supporting script for default browser control
# -------------------------------------------------------------------
setup_launch_agent() {
    # Get the directory where this script is located
    SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

    print_status "Creating ~/Scripts directory if not exists..."
    # Create Scripts directory in home if it doesn't exist
    mkdir -p ~/Scripts

    print_status "Copying run_default_browser.sh to ~/Scripts/..."
    # Copy the browser runner script to ~/Scripts
    cp "$SCRIPT_DIR/run_default_browser.sh" ~/Scripts/

    print_status "Setting executable permission on ~/Scripts/run_default_browser.sh..."
    # Make the script executable
    chmod +x ~/Scripts/run_default_browser.sh

    # Check if the plist file exists in the script directory
    if [ ! -f "$SCRIPT_DIR/com.default.browser.plist" ]; then
        print_error "Plist file not found at $SCRIPT_DIR/com.default.browser.plist"
        exit 1
    fi

    print_status "Copying plist template to LaunchAgents directory..."
    # Copy the plist file to the user's LaunchAgents directory
    cp "$SCRIPT_DIR/com.default.browser.plist" ~/Library/LaunchAgents/

    print_status "Updating plist ProgramArguments with correct script path in destination..."
    # Update the ProgramArguments in the plist to point to the correct script path
    sed -i '' "s|<string></string>|<string>$HOME/Scripts/run_default_browser.sh</string>|" ~/Library/LaunchAgents/com.default.browser.plist

    print_success "Plist file updated in LaunchAgents directory."

    print_status "Unloading any existing LaunchAgent (cleanup)..."
    # Unload any existing LaunchAgent to avoid duplicates or conflicts
    launchctl bootout gui/$(id -u) ~/Library/LaunchAgents/com.default.browser.plist 2>/dev/null

    print_status "Bootstrapping LaunchAgent..."
    # Register the LaunchAgent with launchctl
    launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/com.default.browser.plist

    # Check if bootstrap was successful
    if [ $? -eq 0 ]; then
        print_success "LaunchAgent bootstrapped successfully!"
    else
        print_error "Failed to bootstrap LaunchAgent"
        exit 1
    fi

    print_status "Starting LaunchAgent now (kickstart)..."
    # Start the LaunchAgent immediately
    launchctl kickstart -k gui/$(id -u)/com.default.browser

    # Check if kickstart was successful
    if [ $? -eq 0 ]; then
        print_success "LaunchAgent started successfully!"
    else
        print_error "Failed to start LaunchAgent"
        exit 1
    fi
}

# ---------------------------------------------
# Main installation process orchestrator
# ---------------------------------------------
main() {
    # Entry point for the installation process
    echo "Starting installation process..."
    echo "--------------------------------"
    
    # Check and install Homebrew if needed
    check_brew
    
    # Install defaultbrowser (function not defined in this script)
    install_defaultbrowser
    
    # Verify installation (function not defined in this script)
    check_defaultbrowser

    # Setup LaunchAgent and script
    setup_launch_agent
    
    echo "--------------------------------"
    print_success "Installation and setup completed successfully!"
    echo "The default-browser LaunchAgent is now registered and will auto-run on user login."
}

# Run main function
main