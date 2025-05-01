# Default Browser Switcher Shortcut

![](assets/browser-switcher.png)

This macOS Shortcut automatically switches your default web browser depending on your battery charging status.

## How it works

1. Checks your battery state using the [Actions](https://apps.apple.com/app/id1586435171) app by [Sindre Sorhus](https://github.com/sindresorhushttps:/).
2. If your Mac **is not charging** (`unplugged`), it runs a shell command to set Firefox as the default browser:
   ```bash
   /opt/homebrew/bin/defaultbrowser firefox
   ```
3. If your Mac **is charging**, it runs a shell command to set Safari as the default browser:
   ```bash
   /opt/homebrew/bin/defaultbrowser safari
   ```
4. After executing the shell script, it splits the script output into separate lines.
5. It runs an AppleScript that attempts to automatically press a system UI button named starting with "use" (likely related to a permissions popup or system dialog).

## Dependencies

Make sure you have the following installed and configured:

- [Actions app](https://apps.apple.com/app/id1586435171) by Sindre Sorhus.
- [`defaultbrowser`](https://github.com/kerma/defaultbrowser) CLI tool installed at `/opt/homebrew/bin/defaultbrowser`.
- macOS with `/bin/zsh` shell.
- Automation permissions enabled for Shortcuts and System Events to control UI interactions.

## Notes

- This shortcut requires macOS permissions to control your computer (System Preferences → Security & Privacy → Privacy → Automation and Accessibility).
- Tested with the Actions app version used in Shortcut client version `3514.0.4.200`.
- You may need to adjust the AppleScript to match your system UI if the button name changes.

## Installation

1. Import the shortcut via [iCloud link(https://www.icloud.com/shortcuts/a3b954e8f5a24f0ca548b6f139182614https://) or `.shortcut` file.
2. Grant permissions when prompted.
3. Install Homebrew (if you haven't already):

   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

   For more information, visit: [https://brew.sh/](https://brew.sh/)

4. Install `defaultbrowser` using Homebrew:

   ```bash
   brew install defaultbrowser
   ```

5. Confirm that `/opt/homebrew/bin/defaultbrowser` exists and is executable.
6. Run the shortcut!

---

Feel free to modify the shell script or AppleScript to fit your browser preferences or UI workflow.

Enjoy your automatic browser switching! 🚀

## Download Options

You can download the shortcut in two formats:

1. `.shortcut` file: [Default Browser.shortcut](shortcut/Default%20Browser.shortcut)

   - Direct import into the Shortcuts app
   - Recommended for most users
2. `.plist` file: [default-browser-changer.plist](shortcut/default-browser-changer.plist)

   - Raw plist format
   - Useful for developers or manual modifications
