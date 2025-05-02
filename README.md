# Default Browser Switcher Shortcut for MacOS

![](assets/browser-switcher.png)

This macOS Shortcut automatically switches your default web browser based on your battery charging status and your preferences.

## But... why?

This shortcut was designed to help MacBook users optimize their battery life by making it easy to switch between browsers depending on power status. When running on battery power, you might want to use more energy-efficient browsers like Safari, which is optimized for macOS and typically consumes less battery. When plugged in, you can automatically switch to feature-rich browsers like Chrome or Firefox without worrying about power consumption.

## How it works

1. Checks your battery state using the [Actions](https://apps.apple.com/app/id1586435171) app by [Sindre Sorhus](https://github.com/sindresorhus).
2. If your Mac **is not charging** (`unplugged`):

   - Shows a list of available browsers;
   - Lets you choose which browser to set as default;
   - Sets the selected browser as default using:

   ```bash
   /opt/homebrew/bin/defaultbrowser <selected-browser>
   ```
3. If your Mac **is charging**:

   - Shows a list of available browsers
   - Lets you choose which browser to set as default for charging state
   - Sets the selected browser as default using:

   ```bash
   /opt/homebrew/bin/defaultbrowser <selected-browser>
   ```

## Key features

- Dynamic browser selection for both charging and non-charging states;
- Lists all available browsers installed on your system;
- Remembers your last selection for each power state;
- Supports any browser that can be set as default on macOS.

## Installation & usage options

There are 9 three ways to install and use the Default Browser Switcher Shortcut. Choose the one that best fits your workflow:

### Download and install the shortcut

- Download the `.shortcut` file: [default-browser.shortcut](shortcut/default-browser.shortcut) and install it.

### Usage

#### Option 1 (Recommended and free): Hammerspoon Integration

- The script is located at: `install/hammerspoon/init.lua`
- **How to use:**
  1. Install [Hammerspoon](https://www.hammerspoon.org/) (free);
  2. Copy the `init.lua` file to your Hammerspoon configuration directory (`~/.hammerspoon/`);
  3. Reload Hammerspoon or restart the app;
  4. Use the provided shortcut or customize your own trigger in Hammerspoon.

#### Option 2: BetterTouchTool (BTT) Template

- The template is available at: `install/btt/default_browser`
- **How to use:**
  1. Install [BetterTouchTool](https://folivora.ai/) (paid);
  2. Import the template from the `install/btt/default_browser.bttpreset` directory.

#### Option 3: Ninja mode - Standalone Shell Script Utility

- Download the utility: `/install/agent/default_browser.zip`
- **How to use:**
  1. Unzip the file;
  2. Open MacOS Terminal and navigate to the zip file directory;
  3. Make the installer executable:
     ```bash
     chmod +x install.sh uninstall.sh
     ```
  4. Run the installer to set up your new MacOS agent:
     ```bash
     ./install.sh
     ```
  5. To uninstall, run the uninstall script provided in the same directory:
     ```bash
     ./uninstall.sh
     ```

---

## Dependencies

Depending on your chosen installation method, you may need to install one or more of the following:

**REQUIRED:**

- [Actions app](https://apps.apple.com/app/id1586435171) (required for battery status detection)
- [`defaultbrowser`](https://github.com/kerma/defaultbrowser) CLI tool (required for all options)

**OPTIONAL**:

- [Hammerspoon](https://www.hammerspoon.org/) (optional, for Option 1)
- [BetterTouchTool](https://folivora.ai/) (optional, for Option 2)

## Notes

- All options support dynamic browser switching based on your Mac's charging status;
- You can freely modify the scripts or templates to fit your preferences or workflow;
- For advanced users, the standalone agent can be installed or removed at any time using the provided shell scripts.

---

Feel free to modify the shell script or the shortcut to fit your browser preferences or UI workflow.

Enjoy your automatic browser switching! 🚀

## Shortcut download options

You can download the shortcut in two formats:

1. `.shortcut` file: [default-browser.shortcut](shortcut/default-browser.shortcut)

   - Direct import into the Shortcuts app;
   - Recommended for most users.
2. `.json` file: [default-browser-changer.json](shortcut/default-browser.json)

   - Useful for developers or manual modifications.
