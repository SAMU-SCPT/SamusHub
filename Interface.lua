local Interface = {}

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "SAMU_HUB"
gui.Parent = game.CoreGui
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local floatButton = Instance.new("ImageButton")
floatButton.Name = "FloatButton"
floatButton.Parent = gui
floatButton.Size = UDim2.new(0, 50, 0, 50)
floatButton.Position = UDim2.new(0, 20, 0.5, -25)
floatButton.BackgroundTransparency = 1
floatButton.Image = "rbxassetid://128226597224894"

local dragging = false
local dragInput, dragStart, startPos

local function update(input)
	local delta = input.Position - dragStart
	floatButton.Position = UDim2.new(
		startPos.X.Scale,
		startPos.X.Offset + delta.X,
		startPos.Y.Scale,
		startPos.Y.Offset + delta.Y
	)
end

floatButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = floatButton.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

floatButton.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)

local main = Instance.new("Frame")
main.Name = "Main"
main.Parent = gui
main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
main.BorderSizePixel = 0
main.Position = UDim2.new(0.5, -300, 0.5, -200)
main.Size = UDim2.new(0, 600, 0, 400)
main.Visible = false

local topbar = Instance.new("Frame")
topbar.Parent = main
topbar.Size = UDim2.new(1, 0, 0, 30)
topbar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

local title = Instance.new("TextLabel")
title.Parent = topbar
title.Size = UDim2.new(1, -90, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "SAMU HUB"
title.TextColor3 = Color3.fromRGB(255, 0, 0)
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left

local close = Instance.new("TextButton")
close.Parent = topbar
close.Size = UDim2.new(0, 30, 1, 0)
close.Position = UDim2.new(1, -30, 0, 0)
close.Text = "X"
close.TextColor3 = Color3.fromRGB(255, 0, 0)
close.BackgroundTransparency = 1
close.Font = Enum.Font.GothamBold
close.TextSize = 14

local minimize = Instance.new("TextButton")
minimize.Parent = topbar
minimize.Size = UDim2.new(0, 30, 1, 0)
minimize.Position = UDim2.new(1, -60, 0, 0)
minimize.Text = "-"
minimize.TextColor3 = Color3.fromRGB(255, 0, 0)
minimize.BackgroundTransparency = 1
minimize.Font = Enum.Font.GothamBold
minimize.TextSize = 14

local content = Instance.new("Frame")
content.Parent = main
content.Size = UDim2.new(1, 0, 1, -30)
content.Position = UDim2.new(0, 0, 0, 30)
content.BackgroundColor3 = Color3.fromRGB(10, 10, 10)

local tabs = {}
function Interface:AddTab(name)
	local tab = Instance.new("Frame")
	tab.Name = name
	tab.Parent = content
	tab.Size = UDim2.new(1, 0, 1, 0)
	tab.Visible = false
	tab.BackgroundTransparency = 1
	tabs[name] = tab
	return tab
end

function Interface:CreateButton(text, parent, callback)
	local btn = Instance.new("TextButton")
	btn.Parent = parent
	btn.Size = UDim2.new(0, 200, 0, 30)
	btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	btn.Text = text
	btn.TextColor3 = Color3.fromRGB(255, 0, 0)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 12
	btn.BorderSizePixel = 0
	btn.MouseButton1Click:Connect(function()
		pcall(callback)
	end)
	return btn
end

floatButton.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
end)

close.MouseButton1Click:Connect(function()
	main.Visible = false
end)

local minimized = false
minimize.MouseButton1Click:Connect(function()
	minimized = not minimized
	if minimized then
		content.Visible = false
		minimize.Text = "+"
	else
		content.Visible = true
		minimize.Text = "-"
	end
end)

function Interface:CreateWindow(titleText)
	title.Text = titleText
	return Interface
end

return Interface
