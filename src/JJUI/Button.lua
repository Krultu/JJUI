local Button = {}
Button.__index = Button

local Create = require(script.Parent.System.Create)
local function createSelf()
    -- Btn
	local btn = Create("TextButton", {
		BackgroundColor3 = Color3.fromRGB(50,50,50);
        TextColor3 = Color3.fromRGB(255,255,255);
        TextSize = 28;
		Size = UDim2.new(0.66,0, 0.16,0);
		Text = "Text";
        AnchorPoint = Vector2.new(0.5, 0.5);
	})
	btn.Name = "template"
	local uiCornerBtn = Create("UICorner", {
		CornerRadius = UDim.new(0, 16);
	})
	uiCornerBtn.Parent = btn
	
	btn.Parent = script
end

createSelf()

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local function update(self)
	if self.hovering then
        local t = TweenService:Create(self.ui.UICorner, TweenInfo.new(self.anim_s), {CornerRadius = UDim.new(0,32)})
        t:Play()
        t.Completed:Wait()
    else
        local t = TweenService:Create(self.ui.UICorner, TweenInfo.new(self.anim_s), {CornerRadius = UDim.new(0,8)})
        t:Play()
        t.Completed:Wait()
    end
end

function Button.new(Name, Position, ColorsConfig, Font, AnimationSpeed, Callback)
	assert(type(Name) == "string", "Name argument must be a string.")
    assert(type(ColorsConfig) == "table", "ColorsConfig argument must be a table.")
    assert(type(Callback) == "function", "Callback argument must be a function.")

	local self = setmetatable({
		--// Colors and font
		BgColor = ColorsConfig.Bg or Color3.fromRGB(50, 50, 50);
		TxtColor = ColorsConfig.Txt or Color3.fromRGB(255, 255, 255);
        Font = Font or Enum.Font.GothamBold;

        --// Callback
        cb = Callback;

		--// UI
		ui = script.template:Clone();
        anim_s = AnimationSpeed or .15;
        hovering = false;
	}, Button)
	
	--// Setup
	self.ui.Name = Name
	self.ui.BackgroundColor3 = self.BgColor
	self.ui.TextColor3 = self.TxtColor
	self.ui.Position = Position or UDim2.new(0,0,0,0)

	--// connections
    self.ui.MouseButton1Click:Connect(function()
        self.cb()
    end)

	self.ui.MouseEnter:Connect(function()
		self.hovering = true
	end)

    self.ui.MouseLeave:Connect(function()
		self.hovering = false
	end)
	
	RunService.Heartbeat:Connect(function()
		update(self)
	end)

	return self
end

function Button:SetPosition(pos)
	self.ui.Position = pos
end

function Button:SetParent(p)
	self.ui.Parent = p
end

function Button:SetSize(s)
	self.ui.Size = s
end

function Button:Destroy()
	self.ui:Destroy()
	self = {}
end

return Button