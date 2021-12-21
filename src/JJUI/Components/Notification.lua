local Notification = {}
Notification.__index = Notification

local Create = require(script.Parent.Parent.System.Create)
local function createSelf()

	local build = require(script.Parent.Parent.System.BuildInfo.Notification)

	local sound = Create("Sound", {
		SoundId = "rbxassetid://8310632621"
	})

	local result = build(script)
	sound.Parent = result
	result.Name = "template"
end

createSelf()

local TweenService = game:GetService("TweenService")

function Notification.new(Title, Content, Parent, ColorsConfig)
	assert(type(Title) == "string", "Title argument must be a string.")
    assert(type(Content) == "string", "Content argument must be a string.")

	local self = setmetatable({
		--// Colors and font
		BgColor = ColorsConfig.Bg or Color3.fromRGB(0,0,0);
		TxtColor = ColorsConfig.Txt or Color3.fromRGB(255, 255, 255);

		--// UI
		ui = script.template:Clone();
	}, Notification)
	
	--// Setup
	self.ui.Name = "NOTIFICATION"
	self.ui.Parent = Parent
	self.ui.Container.ImageColor3 = self.BgColor
	self.ui.Container.Body.Container.Content.TextColor3 = self.TxtColor
	self.ui.Position = UDim2.new(0.5,0, 0,-100)

	self.ui.Container.Body.Container.Content.Text = Content
	self.ui.Container.Top.Title.Text = Title

	local t = TweenService:Create(self.ui, TweenInfo.new(.15), {Position = UDim2.new(0.5,0, 0,4)})
	t:Play()
	self.ui.Sound:Play()
	t.Completed:Wait()
	wait(3)
	local t2 = TweenService:Create(self.ui, TweenInfo.new(.15), {Position = UDim2.new(0.5,0, 0,-100)})
	t2:Play()
	t2.Completed:Wait()

	self.ui:Destroy()
	self = {}

	return self
end

return Notification