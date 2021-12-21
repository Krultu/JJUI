JJUI is a module that allows fast UI components(such as switches, drag bars, etc...) construction.

JJUI supports PC and mobile. (Not tested in console yet)

You can all components [here](api/dragbar.md).

Creating a component is as simple as:
```lua
-- In a local script, assuming JJUI is inside Replicated Storage
local JJUI = require(game:GetService("ReplicatedStorage").JJUI)

-- This can be done with any component, just use the same syntax "JJUI.ComponentName"
local Switch = require(JJUI.Switch)

local MyCoolSwitch = Switch.new()
```

Check the installation steps to continue.