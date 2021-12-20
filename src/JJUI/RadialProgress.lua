local RadialProgress = {}
RadialProgress.__index = RadialProgress

local Create = require(script.Parent.System.Create)
local function createSelf()
    -- Frame
	local frame = Create("Frame", {
        AnchorPoint = UDim.new(.5, .5);
		BackgroundTransparency = 1;
		Size = UDim2.new(0.1,0, 0.162,0);
	})
	frame.Name = "template"
	frame.Parent = script

    -- Left
    local leftimg = Create("ImageLabel", {
        BackgroundTransparency = 1;
        Position = UDim2.new(0,0, 0,0);
        Size = UDim2.new(.5,0, 1,0);
        ZIndex = 2;
        Image = "rbxassetid://8295839524";
        ImageColor3 = Color3.fromRGB(50,50,50);
        ImageRectSize = UDim.new(128,256);
    })
    leftimg.Name = "Left"
    leftimg.Parent = frame

    -- Right
    local rightimg = Create("ImageLabel", {
        BackgroundTransparency = 1;
        Position = UDim2.new(.5,0, 0,0);
        Size = UDim2.new(.5,0, 1,0);
        ZIndex = 1;
        Image = "rbxassetid://8295839524";
        ImageColor3 = Color3.fromRGB(50,50,50);
        ImageRectOffset = UDim.new(128,0);
        ImageRectSize = UDim.new(128,256);
    })
    rightimg.Name = "Right"
    rightimg.Parent = frame


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