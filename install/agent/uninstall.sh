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
# Unregister and remove the LaunchAgent plist file
# ---------------------------------------------------
unregister_launch_agent() {
    # Check if the LaunchAgent plist file exists
    if [ -f ~/Library/LaunchAgents/com.default.browser.plist ]; then
        print_status "Unloading LaunchAgent..."
        # Unload the LaunchAgent if loaded
        launchctl bootout gui/$(id -u) ~/Library/LaunchAgents/com.default.browser.plist 2>/dev/null
        
        # Check if unloading was successful
        if [ $? -eq 0 ]; then
            print_success "LaunchAgent unloaded successfully!"
        else
            print_error "LaunchAgent may not have been loaded or already unloaded."
        fi

        print_status "Removing LaunchAgent plist file..."
        # Remove the plist file from LaunchAgents
        rm ~/Library/LaunchAgents/com.default.browser.plist
        
        # Check if removal was successful
        if [ $? -eq 0 ]; then
            print_success "LaunchAgent plist file removed!"
        else
            print_error "Failed to remove LaunchAgent plist file."
        fi
    else
        print_status "LaunchAgent plist file not found in ~/Library/LaunchAgents."
    fi
}

# ---------------------------------------------------
# Remove the default browser script from ~/Scripts
# ---------------------------------------------------
remove_script() {
    # Check if the script exists
    if [ -f ~/Scripts/run_default_browser.sh ]; then
        print_status "Removing script ~/Scripts/run_default_browser.sh..."
        # Remove the script
        rm ~/Scripts/run_default_browser.sh
        
        # Check if removal was successful
        if [ $? -eq 0 ]; then
            print_success "Script removed!"
        else
            print_error "Failed to remove script."
        fi
    else
        print_status "Script ~/Scripts/run_default_browser.sh not found."
    fi
}

# ---------------------------------------------------
# Clean up temporary log files
# ---------------------------------------------------
clean_logs() {
    print_status "Removing logs in /tmp/..."
    # Remove log files related to the default browser agent
    rm -f /tmp/defaultbrowser.out /tmp/defaultbrowser.err /tmp/defaultbrowser.shortcut.err
    print_success "Logs cleaned."
}

# ---------------------------------------------
# Main uninstallation process orchestrator
# ---------------------------------------------
main() {
    # Entry point for the uninstallation process
    echo "Starting uninstallation..."
    echo "--------------------------"

    # Unregister LaunchAgent and remove plist
    unregister_launch_agent
    # Remove the default browser script
    remove_script
    # Clean up logs
    clean_logs

    echo "--------------------------"
    print_success "Uninstallation completed successfully!"
}

# Run main function
main