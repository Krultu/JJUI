local DragBar = {}
DragBar.__index = DragBar

local Create = require(script.Parent.System.Create)
local function createSelf()
	-- Template
	local template = Create("Frame", {
		BackgroundColor3 = Color3.fromRGB(90,90,90);
		Size = UDim2.new(0.6,0, 0.06,0);
		AnchorPoint = Vector2.new(.5, .5);
	})
	template.Name = "template"
	local uiCornerTemplate = Create("UICorner", {
		CornerRadius = UDim.new(0, 16);
	})
	uiCornerTemplate.Parent = template
	
	-- Btn
	local btn = Create("TextButton", {
		BackgroundColor3 = Color3.fromRGB(50,50,50);
		Size = UDim2.new(0.05,0, 1.75,0);
		Position = UDim2.new(0,0, -0.383,0);
		Text = "";
	})
	btn.Name = "btn"
	local uiCornerBtn = Create("UICorner", {
		CornerRadius = UDim.new(0, 16);
	})
	uiCornerBtn.Parent = btn
	
	btn.Parent = template
	template.Parent = script
end

createSelf()

local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local function reverseUpdate(self)
	self.ui.btn.Position = UDim2.new(self.progress, 0, -0.383, 0)
end

local function update(self)
	local mousePos = UIS:GetMouseLocation()
	local relPos = mousePos - self.ui.AbsolutePosition
	local percent = math.clamp(relPos.X/self.ui.AbsoluteSize.X, 0, .95)
	self.ui.btn.Position = UDim2.new(percent, 0, -0.383, 0)
	self.progress = percent > 0 and percent+.05 or percent
end

function DragBar.new(Name, Position, ColorsConfig, StartProgress)
	assert(type(Name) == "string", "Name argument must be a string.")
	assert(type(ColorsConfig) == "table", "ColorsConfig argument must be a table.")

	local self = setmetatable({
		--// Colors
		BgColor = ColorsConfig.Bg or Color3.fromRGB(90, 90, 90);
		BtnColor = ColorsConfig.Btn or Color3.fromRGB(50, 50, 50);

		--// Progress
		progress = StartProgress or 0;

		--// UI
		ui = script.template:Clone();
		holding = false;
	}, DragBar)
	
	--// Setup
	self.ui.Name = Name
	self.ui.BackgroundColor3 = self.BgColor
	self.ui.btn.BackgroundColor3 = self.BtnColor
	self.ui.Position = Position or UDim2.new(0,0,0,0)
	reverseUpdate(self)

	--// connections
	self.ui.btn.MouseButton1Down:Connect(function()
		self.holding = true
	end)
	
	UIS.InputEnded:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 then
			self.holding = false
		end
	end)
	
	RunService.Heartbeat:Connect(function()
		if self.holding then
			update(self)
		end
	end)

	return self
end

function DragBar:GetProgress()
	return self.progress
end

function DragBar:SetPosition(pos)
	self.ui.Position = pos
end

function DragBar:SetParent(p)
	self.ui.Parent = p
end

function DragBar:SetSize(s)
	self.ui.Size = s
end

function DragBar:Destroy()
	self.ui:Destroy()
	self = {}
end

return DragBar