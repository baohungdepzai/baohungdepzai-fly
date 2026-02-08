-- baohungdepzai Fly Mobile | Speed max 200 | Hide / Show UI

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

local plr = Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local hum = char:WaitForChild("Humanoid")

local flying = false
local speed = 50
local maxSpeed = 200

local bv, bg

-- UI
local gui = Instance.new("ScreenGui")
gui.Name = "baohungdepzai"
gui.Parent = game.CoreGui

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.fromOffset(220,150)
frame.Position = UDim2.fromScale(0.05,0.4)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,30)
title.Text = "baohungdepzai Fly"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1

local flyBtn = Instance.new("TextButton", frame)
flyBtn.Position = UDim2.fromOffset(10,40)
flyBtn.Size = UDim2.fromOffset(200,30)
flyBtn.Text = "FLY : OFF"

local speedBox = Instance.new("TextBox", frame)
speedBox.Position = UDim2.fromOffset(10,80)
speedBox.Size = UDim2.fromOffset(200,30)
speedBox.Text = "Speed (1-200)"
speedBox.ClearTextOnFocus = true

local hideBtn = Instance.new("TextButton", frame)
hideBtn.Position = UDim2.fromOffset(10,120)
hideBtn.Size = UDim2.fromOffset(200,20)
hideBtn.Text = "Ẩn / Hiện UI"

-- Fly functions
local function startFly()
	bv = Instance.new("BodyVelocity", hrp)
	bv.MaxForce = Vector3.new(1e9,1e9,1e9)
	bv.Velocity = Vector3.zero

	bg = Instance.new("BodyGyro", hrp)
	bg.MaxTorque = Vector3.new(1e9,1e9,1e9)
	bg.P = 9e4
	bg.CFrame = hrp.CFrame

	hum.PlatformStand = true

	RunService:BindToRenderStep("Fly",0,function()
		bg.CFrame = workspace.CurrentCamera.CFrame
		bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * speed
	end)
end

local function stopFly()
	RunService:UnbindFromRenderStep("Fly")
	if bv then bv:Destroy() end
	if bg then bg:Destroy() end
	hum.PlatformStand = false
end

flyBtn.MouseButton1Click:Connect(function()
	flying = not flying
	if flying then
		flyBtn.Text = "FLY : ON"
		startFly()
	else
		flyBtn.Text = "FLY : OFF"
		stopFly()
	end
end)

speedBox.FocusLost:Connect(function()
	local v = tonumber(speedBox.Text)
	if v then
		speed = math.clamp(v,1,maxSpeed)
	end
	speedBox.Text = "Speed : "..speed
end)

hideBtn.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
end)

-- Mobile: double tap to show / hide
local tap = 0
UIS.TouchTap:Connect(function()
	tap += 1
	task.delay(0.4
