local RadialProgress = {}
RadialProgress.__index = RadialProgress

local Create = require(script.Parent.Parent.System.Create)
local function createSelf()
    local build = require(script.Parent.Parent.System.BuildInfo.RadialProgress)
	local result = build(script)
	result.Name = "template"
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