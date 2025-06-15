-- Ui Loading Universal Game
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Xoá UI cũ nếu có
pcall(function() player.PlayerGui:FindFirstChild("ChirikuLoadUI"):Destroy() end)

-- Tạo GUI
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "ChirikuUiLoading"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Khung chính
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 520, 0, 200)
main.Position = UDim2.new(0.5, -260, 0.45, -110)
main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
main.BackgroundTransparency = 0
main.BorderSizePixel = 0
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 16)

-- Viền RGB
local stroke = Instance.new("UIStroke", main)
stroke.Thickness = 3
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
stroke.Transparency = 0
local strokeGrad = Instance.new("UIGradient", stroke)
strokeGrad.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
	ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
	ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 0, 255)),
	ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0)),
}
task.spawn(function()
	while strokeGrad and strokeGrad.Parent do
		for i = 0, 360, 1 do
			strokeGrad.Rotation = i
			task.wait(0.02)
		end
	end
end)

-- Title
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, -40, 0, 30)
title.Position = UDim2.new(0, 20, 0, 50)
title.BackgroundTransparency = 1
title.Text = getgenv().TitleScript or "Loading Script..."
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(0, 255, 255)
title.TextScaled = true
title.TextXAlignment = Enum.TextXAlignment.Center

-- Logo
local logo = Instance.new("ImageLabel", main)
logo.Size = UDim2.new(0, 100, 0, 100)
logo.Position = UDim2.new(0, 20, 0.5, -50)
logo.BackgroundTransparency = 1
logo.Image = getgenv().LogoScript or "rbxassetid://81787064714217"
logo.ImageTransparency = 0.05
local logoCorner = Instance.new("UICorner", logo)
logoCorner.CornerRadius = UDim.new(1, 0)

-- Xoay logo ngẫu nhiên trái hoặc phải
local direction = math.random(1, 2) == 1 and 1 or -1
local speed = math.random(1.5, 3) -- random tuỳ ý
task.spawn(function()
	while logo and logo.Parent do
		logo.Rotation = (logo.Rotation + direction * speed) % 360
		task.wait(0.01)
	end
end)

-- Nhấp nháy
task.spawn(function()
	while logo and logo.Parent do
		TweenService:Create(logo, TweenInfo.new(0.5), {ImageTransparency = 0.35}):Play()
		task.wait(0.5)
		TweenService:Create(logo, TweenInfo.new(0.5), {ImageTransparency = 0.05}):Play()
		task.wait(0.5)
	end
end)

-- Thanh nền loading
local barBG = Instance.new("Frame", main)
barBG.Size = UDim2.new(0, 360, 0, 25)
barBG.Position = UDim2.new(0, 140, 0.5, -12)
barBG.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
barBG.BorderSizePixel = 0
Instance.new("UICorner", barBG).CornerRadius = UDim.new(0, 12)

-- Thanh tiến trình
local bar = Instance.new("Frame", barBG)
bar.Size = UDim2.new(0, 0, 1, 0)
bar.Position = UDim2.new(0, 0, 0, 0)
bar.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
bar.BorderSizePixel = 0
Instance.new("UICorner", bar).CornerRadius = UDim.new(0, 12)
Instance.new("UIGradient", bar).Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 128, 255))
}

-- Dòng credit
local credit = Instance.new("TextLabel", main)
credit.Size = UDim2.new(1, -40, 0, 24)
credit.Position = UDim2.new(0, 9, 1, -75)
credit.BackgroundTransparency = 1
credit.Text = getgenv().CreditScript or "By: Chiriku Roblox"
credit.Font = Enum.Font.GothamSemibold
credit.TextColor3 = Color3.fromRGB(255, 255, 255)
credit.TextScaled = true
credit.TextXAlignment = Enum.TextXAlignment.Center

-- Loading giả
local steps = math.random(2, 4)
for i = 1, steps do
	local delayTime = math.random(0, 1)
	local percent = math.random(15, 25) / 100
	local targetSize = math.clamp(bar.Size.X.Scale + percent, 0, 1)
	local tweenTime = math.random(6, 12) / 10
	TweenService:Create(bar, TweenInfo.new(tweenTime, Enum.EasingStyle.Linear), {
		Size = UDim2.new(targetSize, 0, 1, 0)
	}):Play()
	task.wait(tweenTime + delayTime)
end

-- Tween đến 100%
TweenService:Create(bar, TweenInfo.new(0.8), {
	Size = UDim2.new(1, 0, 1, 0)
}):Play()
task.wait(0.9)

-- Xoá UI
_G.LoadingDone = true
pcall(function() gui:Destroy() end)
