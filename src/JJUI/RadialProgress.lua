local RadialProgress = {}
RadialProgress.__index = RadialProgress

local Create = require(script.Parent.System.Create)
local function createSelf()
    -- Frame
	local frame = Create("Frame", {
		BackgroundTransparency = 1;
		Size = UDim2.new(0.1,0, 0.175,0);
        AnchorPoint = Vector2.new(0.5, 0.5);
	})
	frame.Name = "template"
	frame.Parent = script


end

createSelf()

local TweenService = game:GetService("TweenService")

function RadialProgress.new(Name, Position, ColorsConfig, AnimationSpeed)
	assert(type(Name) == "string", "Name argument must be a string.")
    assert(type(ColorsConfig) == "table", "ColorsConfig argument must be a table.")

	local self = setmetatable({
		--// Colors
		BgColor = ColorsConfig.Bg or Color3.fromRGB(50, 50, 50);
        BarColor = ColorsConfig.Bar or Color3.fromRGB(55,155,255);

		--// UI
		ui = script.template:Clone();
        anim_s = AnimationSpeed or .15;
	}, RadialProgress)
	
	--// Setup
	self.ui.Name = Name
	self.ui.BackgroundColor3 = self.BgColor
	self.ui.Position = Position or UDim2.new(0,0,0,0)

	return self
end

function RadialProgress:SetPosition(pos)
	self.ui.Position = pos
end

function RadialProgress:SetParent(p)
	self.ui.Parent = p
end

function RadialProgress:SetSize(s)
	self.ui.Size = s
end

function RadialProgress:Destroy()
	self.ui:Destroy()
	self = {}
end

return RadialProgress