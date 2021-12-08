local Switch = {}
Switch.__index = Switch

local Create = require(script.Parent.System.Create)
local function createSelf()
	-- Template
	local template = Create("ImageButton", {
		Size = UDim2.new(0.3,0, 0.09,0);
		Image = "rbxassetid://8206471480";
		ImageColor3 = Color3.fromRGB(50, 150, 250);
		AnchorPoint = Vector2.new(0.5, 0.5);
		BackgroundTransparency = 1;
	})
	template.Name = "template"
	
	local aspectRatioTemplate = Create("UIAspectRatioConstraint",{
		AspectRatio = 2;
		AspectType = Enum.AspectType.ScaleWithParentSize;
		DominantAxis = Enum.DominantAxis.Height;
	})
	aspectRatioTemplate.Parent = template

	-- Circle
	local circle = Create("ImageLabel", {
		Size = UDim2.new(1,0, 0.9,0);
		Position = UDim2.new(0.5,0, 0.5,0);
		Image = "rbxassetid://8206467461";
		AnchorPoint = Vector2.new(0, 0.5);
		BackgroundTransparency = 1;
	})
	circle.Name = "Circle"
	local aspectRatioCircle = Create("UIAspectRatioConstraint",{
		AspectRatio = 1;
		AspectType = Enum.AspectType.ScaleWithParentSize;
		DominantAxis = Enum.DominantAxis.Height;
	})
	aspectRatioCircle.Parent = circle

	circle.Parent = template
	template.Parent = script
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

function Switch:GetToggled()
	return self.Toggled
end

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