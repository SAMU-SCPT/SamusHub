local Player = game:GetService("Players").LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local GuiService = game:GetService("GuiService")

local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "SAMU_HUB_UI"
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Botão flutuante
local floatButton = Instance.new("ImageButton")
floatButton.Name = "SAMU_FloatButton"
floatButton.Size = UDim2.new(0, 60, 0, 60)
floatButton.Position = UDim2.new(0.85, 0, 0.5, 0)
floatButton.BackgroundTransparency = 1
floatButton.Image = "rbxassetid://128226597224894"
floatButton.Parent = screenGui
floatButton.AnchorPoint = Vector2.new(0.5, 0.5)

-- Drag do botão
local dragging, dragInput, dragStart, startPos

floatButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = floatButton.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
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
        local delta = input.Position - dragStart
        floatButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Janela principal
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 500, 0, 320)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -160)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Parent = screenGui
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.ClipsDescendants = true

-- Sombra
local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.Size = mainFrame.Size + UDim2.new(0, 10, 0, 10)
shadow.Position = mainFrame.Position + UDim2.new(0, 5, 0, 5)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://1316045217"
shadow.ImageTransparency = 0.5
shadow.ZIndex = 0
shadow.Parent = screenGui
shadow.Visible = false

-- Header (barra superior)
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 35)
header.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
header.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -70, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.Text = "SAMU HUB 5.0\nby: SAMU"
title.TextColor3 = Color3.fromRGB(255, 50, 50)
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextYAlignment = Enum.TextYAlignment.Center
title.TextSize = 16
title.Font = Enum.Font.GothamBold
title.BackgroundTransparency = 1
title.Parent = header

-- Minimizar
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 25, 0, 25)
minimizeBtn.Position = UDim2.new(1, -60, 0.5, -12)
minimizeBtn.Text = "-"
minimizeBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
minimizeBtn.Parent = header

-- Fechar
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Position = UDim2.new(1, -30, 0.5, -12)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
closeBtn.Parent = header

-- Drag da janela
header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragStart = input.Position
        startPos = mainFrame.Position
        dragging = true
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        shadow.Position = mainFrame.Position + UDim2.new(0, 5, 0, 5)
    end
end)

-- Sidebar (Abas)
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 120, 1, -35)
sidebar.Position = UDim2.new(0, 0, 0, 35)
sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
sidebar.Parent = mainFrame

local tabs = {"Farm", "PvP", "Teleport", "Misc", "Config"}
for i, name in ipairs(tabs) do
    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(1, 0, 0, 35)
    tabBtn.Position = UDim2.new(0, 0, 0, (i - 1) * 36)
    tabBtn.Text = name
    tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    tabBtn.Font = Enum.Font.Gotham
    tabBtn.TextSize = 14
    tabBtn.Parent = sidebar
end

-- Abrir/fechar janela com botão flutuante
floatButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
    shadow.Visible = mainFrame.Visible
end)

-- Minimizar e fechar
minimizeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    shadow.Visible = false
end)

closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    shadow.Visible = false
end)
