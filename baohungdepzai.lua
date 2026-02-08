-- baohungdepzai Fly Script (DELTA FIX)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

repeat task.wait() until player.Character
local char = player.Character
local hrp = char:WaitForChild("HumanoidRootPart")
local hum = char:WaitForChild("Humanoid")

local flying = false
local speed = 100
local bv, bg

-- GUI (Delta-safe)
local gui = Instance.new("ScreenGui")
gui.Name = "baohungdepzai"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,200,0,120)
frame.Position = UDim2.new(0,20,0.4,0)
frame.BackgroundColor3 = Color3.fromRGB(40,40,40)
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,30)
title.Text = "baohungdepzai Fly"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1

local btn = Instance.new("TextButton", frame)
btn.Size = UDim2.new(1,-20,0,30)
btn.Position = UDim2.new(0,10,0,40)
btn.Text = "BẬT / TẮT BAY"

local hide = Instance.new("TextButton", frame)
hide.Size = UDim2.new(1,-20,0,30)
hide.Position = UDim2.new(0,10,0,80)
hide.Text = "ẨN"

local show = Instance.new("TextButton", gui)
show.Size = UDim2.new(0,80,0,30)
show.Position = UDim2.new(0,10,0.85,0)
show.Text = "HIỆN"
show.Visible = false

local function startFly()
	bv = Instance.new("BodyVelocity", hrp)
	bv.MaxForce = Vector3.new(1e9,1e9,1e9)
	bg = Instance.new("BodyGyro", hrp)
	bg.MaxTorque = Vector3.new(1e9,1e9,1e9)
	hum.PlatformStand = true
end

local function stopFly()
	if bv then bv:Destroy() end
	if bg then bg:Destroy() end
	hum.PlatformStand = false
end

btn.MouseButton1Click:Connect(function()
	flying = not flying
	if flying then startFly() else stopFly() end
end)

hide.MouseButton1Click:Connect(function()
	frame.Visible = false
	show.Visible = true
end)

show.MouseButton1Click:Connect(function()
	frame.Visible = true
	show.Visible = false
end)

RunService.RenderStepped:Connect(function()
	if flying and bv and bg then
		local cam = workspace.CurrentCamera
		bg.CFrame = cam.CFrame
		bv.Velocity = cam.CFrame.LookVector * speed
	end
end)
