-- Stores the previous state
local lastPowerSource = hs.battery.powerSource()

-- Function to be called when power source changes
local function powerChanged()
    local currentPowerSource = hs.battery.powerSource()
    
    if currentPowerSource ~= lastPowerSource then
        if currentPowerSource == "AC Power" then
            hs.alert.show("Power plugged in → Running Shortcut for AC")
            hs.execute('shortcuts run "default-browser"')
        elseif currentPowerSource == "Battery Power" then
            hs.alert.show("Power unplugged → Running Shortcut for Battery")
            hs.execute('shortcuts run "default-browser"')
        end
        lastPowerSource = currentPowerSource
    end
end

-- Sets up a timer to check the battery state every 10 seconds
local powerWatcher = hs.timer.doEvery(3, powerChanged)

hs.alert.show("Hammerspoon battery watcher started.")
