local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SAMU_HUB_UI"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Cores
local MainColor = Color3.fromRGB(20, 20, 20)
local AccentColor = Color3.fromRGB(200, 0, 0)
local TextColor = Color3.fromRGB(255, 255, 255)

-- Botão Flutuante
local FloatButton = Instance.new("ImageButton")
FloatButton.Name = "FloatButton"
FloatButton.Parent = ScreenGui
FloatButton.BackgroundColor3 = MainColor
FloatButton.BorderColor3 = AccentColor
FloatButton.BorderSizePixel = 3
FloatButton.Position = UDim2.new(0.85, 0, 0.5, -25)
FloatButton.Size = UDim2.new(0, 50, 0, 50)
FloatButton.Image = "rbxassetid://128226597224894"
FloatButton.ScaleType = Enum.ScaleType.Fit
FloatButton.Draggable = true

-- Janela Principal
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = MainColor
MainFrame.BorderColor3 = AccentColor
MainFrame.BorderSizePixel = 4
MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 500, 0, 350)
MainFrame.Visible = false

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 8)

-- Título
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 0)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "SAMU HUB"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = TextColor
Title.TextSize = 24

local Line = Instance.new("Frame")
Line.Parent = MainFrame
Line.BackgroundColor3 = AccentColor
Line.BorderSizePixel = 0
Line.Position = UDim2.new(0, 0, 0, 40)
Line.Size = UDim2.new(1, 0, 0, 2)

-- Aba lateral
local TabBar = Instance.new("Frame")
TabBar.Parent = MainFrame
TabBar.BackgroundColor3 = MainColor
TabBar.BorderColor3 = AccentColor
TabBar.BorderSizePixel = 2
TabBar.Position = UDim2.new(0, 0, 0, 42)
TabBar.Size = UDim2.new(0, 120, 1, -42)

local UICorner2 = Instance.new("UICorner", TabBar)
UICorner2.CornerRadius = UDim.new(0, 8)

-- Área de conteúdo
local ContentFrame = Instance.new("Frame")
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ContentFrame.BorderColor3 = AccentColor
ContentFrame.BorderSizePixel = 2
ContentFrame.Position = UDim2.new(0, 125, 0, 45)
ContentFrame.Size = UDim2.new(1, -130, 1, -50)

local UICorner3 = Instance.new("UICorner", ContentFrame)
UICorner3.CornerRadius = UDim.new(0, 8)

-- Tabelas das abas e conteúdos
local Tabs = {}
local Contents = {}

local TabNames = {"Autofarm", "PVP", "Teleport", "Misc", "Config"}

for i, name in ipairs(TabNames) do
    -- Botão da aba
    local TabButton = Instance.new("TextButton")
    TabButton.Parent = TabBar
    TabButton.BackgroundColor3 = MainColor
    TabButton.BorderColor3 = AccentColor
    TabButton.BorderSizePixel = 2
    TabButton.Position = UDim2.new(0, 5, 0, (i - 1) * 50 + 5)
    TabButton.Size = UDim2.new(0, 110, 0, 40)
    TabButton.Text = name
    TabButton.Font = Enum.Font.GothamBold
    TabButton.TextColor3 = TextColor
    TabButton.TextSize = 16

    local UICornerTab = Instance.new("UICorner", TabButton)
    UICornerTab.CornerRadius = UDim.new(0, 6)

    -- Frame de conteúdo da aba
    local Content = Instance.new("Frame")
    Content.Parent = ContentFrame
    Content.BackgroundTransparency = 1
    Content.Size = UDim2.new(1, 0, 1, 0)
    Content.Visible = i == 1 -- Primeira aba ativa

    Tabs[name] = TabButton
    Contents[name] = Content

    -- Conectar clique
    TabButton.MouseButton1Click:Connect(function()
        for _, v in pairs(Contents) do v.Visible = false end
        Content.Visible = true
    end)

    -- Label de exemplo dentro de cada aba
    local Label = Instance.new("TextLabel")
    Label.Parent = Content
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(1, 0, 0, 40)
    Label.Position = UDim2.new(0, 0, 0, 0)
    Label.Text = "Conteúdo da aba: " .. name
    Label.Font = Enum.Font.Gotham
    Label.TextColor3 = TextColor
    Label.TextSize = 18
end

-- Alternar menu
FloatButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Arrastar no mobile (Input)
local UIS = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    FloatButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

FloatButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = FloatButton.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

FloatButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)
