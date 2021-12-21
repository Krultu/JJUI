local Switch = {}
Switch.__index = Switch

local Create = require(script.Parent.Parent.System.Create)
local function createSelf()
	local build = require(script.Parent.Parent.System.BuildInfo.Switch)
	local result = build(script)
	result.Name = "template"
end

createSelf()

local TweenService = game:GetService("TweenService")

local function update(self)
	local s = self.anim_speed
	local ap = self.toggled and 0 or 1

	local aptween = TweenService:Create(self.ui.Circle, TweenInfo.new(s), {AnchorPoint = Vector2.new(ap, 0.5)})

	local c = self.toggled and self.BgColorToggled or self.BgColorNotToggled
	local ctween = TweenService:Create(self.ui, TweenInfo.new(s), {ImageColor3 = c})

	aptween:Play()
	ctween:Play()
end

local function tupdate(self)
	self.toggled = not self.toggled
	local s = self.anim_speed
	local ap = self.toggled and 0 or 1

	local aptween = TweenService:Create(self.ui.Circle, TweenInfo.new(s), {AnchorPoint = Vector2.new(ap, 0.5)})
	
	local c = self.toggled and self.BgColorToggled or self.BgColorNotToggled
	local ctween = TweenService:Create(self.ui, TweenInfo.new(s), {ImageColor3 = c})
	
	aptween:Play()
	ctween:Play()
end

function Switch.new(Name, Position, ColorsConfig, AnimationSpeed, Callback, StartBool)
	assert(type(Name) == "string", "Name argument must be a string.")
	assert(type(ColorsConfig) == "table", "ColorsConfig argument must be a table.")
	assert(type(Callback) == "function", "Callback argument must be a function.")
	
	local self = setmetatable({
		--// Colors
		BgColorToggled = ColorsConfig.T or Color3.fromRGB(50, 150, 250);
		BgColorNotToggled = ColorsConfig.F or Color3.fromRGB(50, 50, 50);
		
		--// Callback
		cb = Callback;
		
		--// Toggled
		toggled = StartBool or false;
		
		--// Animations
		anim_speed = AnimationSpeed or .15;
		
		--// UI
		ui = script.template:Clone();
	}, Switch)
	
	--// Setup
	self.ui.Name = Name
	self.ui.Position = Position or UDim2.new(0,0,0,0)
	update(self)
	
	--// connections
	self.ui.MouseButton1Click:Connect(function()
		tupdate(self)
		
		self.cb()
	end)
	
	return self
end

--// From class
function Switch:GetToggled()
	return self.Toggled
end

--// From instance
function Switch:SetPosition(pos)
	self.ui.Position = pos
end

function Switch:SetParent(p)
	self.ui.Parent = p
end

function Switch:SetSize(s)
	self.ui.Size = s
end

function Switch:Destroy()
	self.ui:Destroy()
	self = {}
end

return Switch