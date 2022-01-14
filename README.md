![image](https://raw.githubusercontent.com/krultu/JJUI/master/.github/images/jjui-banner.png)

<div align="center">
  
 ## 📖 [Documentation](https://krultu.github.io/JJUI/) 📖
  
</div>
  
**JJUI** is a module that allows fast UI components(such as switches, drag bars, etc...) construction.

JJUI supports PC and mobile. (Not tested in console yet)

Creating a component is as simple as:
```lua
-- In a local script, assuming JJUI is inside Replicated Storage
local JJUI = require(game:GetService("ReplicatedStorage").JJUI)

-- This can be done with any component, just use the same syntax "JJUI.ComponentName"
local Switch = require(JJUI.Switch)

local MyCoolSwitch = Switch.new()
```

**Ready to get started?** Check out the **[docs here](https://krultu.github.io/JJUI/)**!
