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

function Notification.new(Title:string, Content:string, Duration:number?, ColorsConfig:table?)
	local self = setmetatable({
		--// Colors and font
		BgColor = ColorsConfig ~= nil and ColorsConfig.Bg or Color3.fromRGB(0,0,0);
		TxtColor = ColorsConfig ~= nil and ColorsConfig.Txt or Color3.fromRGB(255, 255, 255);

		--// UI
		ui = script.template:Clone();
	}, Notification)
	
	--// Setup
	if not game.Players.LocalPlayer.PlayerGui:FindFirstChild("NOTIFICATION_UI") then
		-- local sg = Create("ScreenGui", {
		-- 	Name = "NOTIFICATION_UI",
		-- 	Parent = game.Players.LocalPlayer.PlayerGui
		-- })

		-- local 

		local build = require(script.Parent.Parent.System.BuildInfo.Notification.UI)
		local r = build(game.Players.LocalPlayer.PlayerGui)
	end

	self.ui.Name = "NOTIFICATION"
	self.ui.Parent = game.Players.LocalPlayer.PlayerGui.NOTIFICATION_UI.F
	self.ui.Container.ImageColor3 = self.BgColor
	self.ui.Container.Body.Container.Content.TextColor3 = self.TxtColor
	self.ui.Position = UDim2.new(0.5,0, 0,-100)

	self.ui.Container.Body.Container.Content.Text = Content
	self.ui.Container.Top.Title.Text = Title

	self.ui.Visible = false
	self.ui.Container.Size = UDim2.new(1,0, 0,1000)

	self.ui.Container.Size = UDim2.new(1,0, 0,math.floor(self.ui.Container.Body.Container.Content.TextBounds.Y) + 56)
	self.ui.Size = UDim2.new(0.45,0, 0,0)

	self.ui.Visible = true
	local t = TweenService:Create(self.ui, TweenInfo.new(.15), {Size = UDim2.new(0.45,0, 0,self.ui.Container.Size.Y.Offset)})
	t:Play()
	self.ui.Sound:Play()
	t.Completed:Wait()
	wait(Duration or 3)
	local t2 = TweenService:Create(self.ui, TweenInfo.new(.15), {Size = UDim2.new(0.5,0, 0,0)})
	t2:Play()
	t2.Completed:Wait()

	self.ui:Destroy()
	self = {}

	return self
end

return Notification