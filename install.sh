#!/bin/bash

# Text colors
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print with color
print_status() {
    echo -e "${BLUE}[*]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_error() {
    echo -e "${RED}[✗]${NC} $1"
}

# Check if Homebrew is installed
check_brew() {
    if ! command -v brew &> /dev/null; then
        print_status "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
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

# Install defaultbrowser
install_defaultbrowser() {
    print_status "Installing defaultbrowser..."
    brew install defaultbrowser
    
    if [ $? -eq 0 ]; then
        print_success "defaultbrowser installed successfully!"
    else
        print_error "Failed to install defaultbrowser"
        exit 1
    fi
}

# Check if defaultbrowser is executable
check_defaultbrowser() {
    if [ -x "/opt/homebrew/bin/defaultbrowser" ]; then
        print_success "defaultbrowser is installed and executable"
    else
        print_error "defaultbrowser is not installed or not executable at /opt/homebrew/bin/defaultbrowser"
        exit 1
    fi
}

# Main installation process
main() {
    echo "Starting installation process..."
    echo "--------------------------------"
    
    # Check and install Homebrew
    check_brew
    
    # Install defaultbrowser
    install_defaultbrowser
    
    # Verify installation
    check_defaultbrowser
    
    echo "--------------------------------"
    print_success "Installation completed successfully!"
    echo "You can now proceed with setting up the MacOS Browser Switcher shortcut."
}

# Run main function
main 