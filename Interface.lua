-- // Criado por SAMU HUB // --
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

-- Criar GUI principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SAMU_HUB_UI"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Cores principais
local MainColor = Color3.fromRGB(20, 20, 20)
local AccentColor = Color3.fromRGB(200, 0, 0)
local TextColor = Color3.fromRGB(255, 255, 255)
local BackgroundColor = Color3.fromRGB(30, 30, 30)

------------------------------------
-- BOTÃO FLUTUANTE ----------------
------------------------------------
local FloatButton = Instance.new("ImageButton")
FloatButton.Name = "FloatButton"
FloatButton.Parent = ScreenGui
FloatButton.BackgroundColor3 = MainColor
FloatButton.BorderColor3 = AccentColor
FloatButton.BorderSizePixel = 2
FloatButton.Position = UDim2.new(0.9, -30, 0.5, -30)
FloatButton.Size = UDim2.new(0, 60, 0, 60)
FloatButton.Image = "rbxassetid://128226597224894"
FloatButton.ScaleType = Enum.ScaleType.Fit

-- Canto arredondado no botão
local FloatCorner = Instance.new("UICorner", FloatButton)
FloatCorner.CornerRadius = UDim.new(1, 0)

------------------------------------
-- JANELA PRINCIPAL ----------------
------------------------------------
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = MainColor
MainFrame.BorderColor3 = AccentColor
MainFrame.BorderSizePixel = 3
MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 550, 0, 400)
MainFrame.Visible = false

local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 10)

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = BackgroundColor
TopBar.BorderSizePixel = 0
TopBar.Size = UDim2.new(1, 0, 0, 40)

local TopCorner = Instance.new("UICorner", TopBar)
TopCorner.CornerRadius = UDim.new(0, 10)

-- Título
local Title = Instance.new("TextLabel")
Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, -80, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Text = "SAMU HUB"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = TextColor
Title.TextSize = 20
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Botão minimizar
local MinButton = Instance.new("TextButton")
MinButton.Parent = TopBar
MinButton.BackgroundColor3 = AccentColor
MinButton.Size = UDim2.new(0, 30, 0, 30)
MinButton.Position = UDim2.new(1, -70, 0.5, -15)
MinButton.Text = "-"
MinButton.Font = Enum.Font.GothamBold
MinButton.TextColor3 = TextColor
MinButton.TextSize = 20

local MinCorner = Instance.new("UICorner", MinButton)
MinCorner.CornerRadius = UDim.new(1, 0)

-- Botão fechar
local CloseButton = Instance.new("TextButton")
CloseButton.Parent = TopBar
CloseButton.BackgroundColor3 = AccentColor
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0.5, -15)
CloseButton.Text = "X"
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextColor3 = TextColor
CloseButton.TextSize = 20

local CloseCorner = Instance.new("UICorner", CloseButton)
CloseCorner.CornerRadius = UDim.new(1, 0)

-- Aba lateral
local TabBar = Instance.new("Frame")
TabBar.Parent = MainFrame
TabBar.BackgroundColor3 = MainColor
TabBar.BorderColor3 = AccentColor
TabBar.BorderSizePixel = 2
TabBar.Position = UDim2.new(0, 0, 0, 40)
TabBar.Size = UDim2.new(0, 130, 1, -40)

local TabCorner = Instance.new("UICorner", TabBar)
TabCorner.CornerRadius = UDim.new(0, 10)

-- Área de conteúdo
local ContentFrame = Instance.new("Frame")
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundColor3 = BackgroundColor
ContentFrame.BorderColor3 = AccentColor
ContentFrame.BorderSizePixel = 2
ContentFrame.Position = UDim2.new(0, 135, 0, 45)
ContentFrame.Size = UDim2.new(1, -140, 1, -50)

local ContentCorner = Instance.new("UICorner", ContentFrame)
ContentCorner.CornerRadius = UDim.new(0, 10)

------------------------------------
-- TABS ---------------------------
------------------------------------
local Tabs = {}
local Contents = {}
local TabNames = {"Autofarm", "PVP", "Teleport", "Misc", "Config"}

for i, name in ipairs(TabNames) do
    -- Botão de aba
    local TabButton = Instance.new("TextButton")
    TabButton.Parent = TabBar
    TabButton.BackgroundColor3 = MainColor
    TabButton.BorderColor3 = AccentColor
    TabButton.BorderSizePixel = 2
    TabButton.Position = UDim2.new(0, 10, 0, (i - 1) * 50 + 10)
    TabButton.Size = UDim2.new(0, 110, 0, 40)
    TabButton.Text = name
    TabButton.Font = Enum.Font.GothamBold
    TabButton.TextColor3 = TextColor
    TabButton.TextSize = 16

    local TabUICorner = Instance.new("UICorner", TabButton)
    TabUICorner.CornerRadius = UDim.new(0, 8)

    -- Conteúdo da aba
    local Content = Instance.new("Frame")
    Content.Parent = ContentFrame
    Content.BackgroundTransparency = 1
    Content.Size = UDim2.new(1, 0, 1, 0)
    Content.Visible = i == 1

    Tabs[name] = TabButton
    Contents[name] = Content

    -- Texto placeholder dentro da aba
    local Label = Instance.new("TextLabel")
    Label.Parent = Content
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(1, 0, 0, 40)
    Label.Position = UDim2.new(0, 0, 0, 0)
    Label.Text = "Conteúdo da aba: " .. name
    Label.Font = Enum.Font.Gotham
    Label.TextColor3 = TextColor
    Label.TextSize = 18

    -- Clique da aba
    TabButton.MouseButton1Click:Connect(function()
        for _, v in pairs(Contents) do v.Visible = false end
        Content.Visible = true
    end)
end

------------------------------------
-- FUNÇÕES DE BOTÕES ---------------
------------------------------------
FloatButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
end)

CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

MinButton.MouseButton1Click:Connect(function()
    ContentFrame.Visible = not ContentFrame.Visible
    TabBar.Visible = not TabBar.Visible
end)

------------------------------------
-- DRAG (mover botão e janela) -----
------------------------------------
local UIS = game:GetService("UserInputService")
local dragging = false
local dragInput, dragStart, startPos

function dragify(Frame)
    Frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = Frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    Frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- Aplicar drag no botão e na janela
dragify(FloatButton)
dragify(MainFrame)
------------------------------------

