local RadialProgress = {}
RadialProgress.__index = RadialProgress

local Create = require(script.Parent.System.Create)
local function createSelf()
    -- Frame
	local frame = Create("Frame", {
        AnchorPoint = Vector2.new(.5, .5);
		BackgroundTransparency = 1;
		Size = UDim2.new(0.113,0, 0.184,0);
	})
	frame.Name = "template"
    --frame.Parent = script

    -- Left
    local leftimg = Create("ImageLabel", {
        BackgroundTransparency = 1;
        Position = UDim2.new(0,0, 0,0);
        Size = UDim2.new(.5,0, 1,0);
        ZIndex = 2;
        Image = "rbxassetid://8295839524";
        ImageColor3 = Color3.fromRGB(50,50,50);
        ImageRectSize = Vector2.new(128,256);
        ScaleType = Enum.ScaleType.Fit;
    })
    leftimg.Name = "Left"
    leftimg.Parent = frame

    local leftsubframe = Create("Frame", {
        AnchorPoint = Vector2.new(.5, .5);
        BackgroundTransparency = 1;
        Position = UDim2.new(1,0, .5,0);
        Size = UDim2.new(2,0, 1,0);
    })
    leftsubframe.Parent = leftimg

    local leftsubframe_subimg = Create("ImageLabel", {
        BackgroundTransparency = 1;
        Position = UDim2.new(0,0, 0,0);
        Size = UDim2.new(.5,0, 1,0);
        Image = "rbxassetid://8295840780";
        ImageRectSize = Vector2.new(128,256);
        ImageColor3 = Color3.fromRGB(55,155,255);
        ScaleType = Enum.ScaleType.Fit;
    })
    leftsubframe_subimg.Parent = leftsubframe

    -- Right
    local rightimg = Create("ImageLabel", {
        BackgroundTransparency = 1;
        Position = UDim2.new(.5,0, 0,0);
        Size = UDim2.new(.5,0, 1,0);
        ZIndex = 1;
        Image = "rbxassetid://8295839524";
        ImageColor3 = Color3.fromRGB(50,50,50);
        ImageRectOffset = Vector2.new(128,0);
        ImageRectSize = Vector2.new(128,256);
        ScaleType = Enum.ScaleType.Fit;
    })
    rightimg.Name = "Right"
    rightimg.Parent = frame

    local rightsubframe = Create("Frame", {
        AnchorPoint = Vector2.new(.5, .5);
        BackgroundTransparency = 1;
        Position = UDim2.new(0,0, .5,0);
        Size = UDim2.new(2,0, 1,0);
    })
    rightsubframe.Parent = rightimg

    local rightsubframe_subimg = Create("ImageLabel", {
        BackgroundTransparency = 1;
        Position = UDim2.new(.5,0, 0,0);
        Size = UDim2.new(.5,0, 1,0);
        Image = "rbxassetid://8295840780";
        ImageRectOffset = Vector2.new(128,0);
        ImageRectSize = Vector2.new(128,256);
        ImageColor3 = Color3.fromRGB(55,155,255);
        ScaleType = Enum.ScaleType.Fit;
    })
    rightsubframe_subimg.Parent = rightsubframe

    frame.Parent = script
end

createSelf()

local TweenService = game:GetService("TweenService")
local function update(self)
    local value = (self.progress/100) * 360

    local left = self.ui.Left.Frame
    local right = self.ui.Right.Frame

    local t1 = TweenService:Create(right, TweenInfo.new(self.anim_s), {Rotation = math.clamp(value-180, -180, 0)})
    t1:Play()
    --right.Rotation = math.clamp(value - 180, -180, 0)
    if value > 180 then
		left.Visible = true
        local t2 = TweenService:Create(left, TweenInfo.new(self.anim_s), {Rotation = math.clamp(value-360, -180, 0)})
        t2:Play()
		--left.Rotation = math.clamp(value - 360, -180, 0)
	else
		left.Visible = false
	end
end

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

        --// Values
        progress = 0;
	}, RadialProgress)
	
	--// Setup
	self.ui.Name = Name
	self.ui.BackgroundColor3 = self.BgColor
	self.ui.Position = Position or UDim2.new(0,0,0,0)

	return self
end

--// From class
function RadialProgress:SetProgress(percent)
    self.progress = percent
    self.progress = self.progress % 100
    update(self)
end

--// From instance
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