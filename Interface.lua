local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local MainUI = Instance.new("ScreenGui")
MainUI.Name = "BloxFruitsUltimateUI"
MainUI.ResetOnSpawn = false
MainUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
MainUI.Parent = PlayerGui

local Theme = {
    Primary = Color3.fromRGB(44, 44, 44),
    Secondary = Color3.fromRGB(30, 30, 30),
    Accent = Color3.fromRGB(255, 85, 0),
    Text = Color3.fromRGB(255, 255, 255),
    Success = Color3.fromRGB(85, 255, 0),
    Warning = Color3.fromRGB(255, 170, 0),
    Error = Color3.fromRGB(255, 50, 50)
}

local Settings = {
    Position = UDim2.new(0.8, 0, 0.8, 0),
    Minimized = false,
    CurrentTab = "Farm",
    Theme = "Dark"
}

local function SaveSettings()
    local success, err = pcall(function()
        local data = HttpService:JSONEncode(Settings)
        -- Implementar DataStore aqui
    end)
    if not success then
        warn("Failed to save settings:", err)
    end
end

local function LoadSettings()
    local success, data = pcall(function()
        -- Implementar DataStore aqui
        return "{}"
    end)
    if success and data then
        Settings = HttpService:JSONDecode(data)
    end
end

local FloatingButton = Instance.new("ImageButton")
FloatingButton.Name = "FloatingButton"
FloatingButton.Size = UDim2.new(0, 60, 0, 60)
FloatingButton.Position = Settings.Position
FloatingButton.AnchorPoint = Vector2.new(0.5, 0.5)
FloatingButton.BackgroundColor3 = Theme.Accent
FloatingButton.AutoButtonColor = false
FloatingButton.Image = "rbxassetid://130801091480234"
FloatingButton.ScaleType = Enum.ScaleType.Fit
FloatingButton.Parent = MainUI

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 450, 0, 600)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -300)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Theme.Primary
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = MainUI

local Shadow = Instance.new("ImageLabel")
Shadow.Name = "Shadow"
Shadow.Image = "rbxassetid://1316045217"
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(10, 10, 118, 118)
Shadow.Size = UDim2.new(1, 20, 1, 20)
Shadow.Position = UDim2.new(0, -10, 0, -10)
Shadow.BackgroundTransparency = 1
Shadow.ImageTransparency = 0.7
Shadow.ZIndex = -1
Shadow.Parent = MainFrame

local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundTransparency = 1
Header.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(0.6, 0, 1, 0)
Title.Position = UDim2.new(0.2, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "BLOX FRUITS ULTIMATE"
Title.TextColor3 = Theme.Text
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = Header

local MinimizeButton = Instance.new("ImageButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -70, 0.5, -15)
MinimizeButton.AnchorPoint = Vector2.new(0, 0.5)
MinimizeButton.BackgroundTransparency = 1
MinimizeButton.Image = "rbxassetid://3926305904"
MinimizeButton.ImageRectOffset = Vector2.new(124, 364)
MinimizeButton.ImageRectSize = Vector2.new(36, 36)
MinimizeButton.Parent = Header

local CloseButton = Instance.new("ImageButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -30, 0.5, -15)
CloseButton.AnchorPoint = Vector2.new(0, 0.5)
CloseButton.BackgroundTransparency = 1
CloseButton.Image = "rbxassetid://3926305904"
CloseButton.ImageRectOffset = Vector2.new(284, 4)
CloseButton.ImageRectSize = Vector2.new(24, 24)
CloseButton.Parent = Header

local SideBar = Instance.new("Frame")
SideBar.Name = "SideBar"
SideBar.Size = UDim2.new(0.25, 0, 1, -40)
SideBar.Position = UDim2.new(0, 0, 0, 40)
SideBar.BackgroundColor3 = Theme.Secondary
SideBar.BorderSizePixel = 0
SideBar.Parent = MainFrame

local TabContent = Instance.new("Frame")
TabContent.Name = "TabContent"
TabContent.Size = UDim2.new(0.75, 0, 1, -40)
TabContent.Position = UDim2.new(0.25, 0, 0, 40)
TabContent.BackgroundTransparency = 1
TabContent.Parent = MainFrame

local Tabs = {
    Farm = {Icon = "rbxassetid://3926305904", ImageRectOffset = Vector2.new(964, 324)},
    PvP = {Icon = "rbxassetid://3926305904", ImageRectOffset = Vector2.new(324, 124)},
    Teleport = {Icon = "rbxassetid://3926305904", ImageRectOffset = Vector2.new(84, 44)},
    Misc = {Icon = "rbxassetid://3926305904", ImageRectOffset = Vector2.new(644, 204)},
    Config = {Icon = "rbxassetid://3926305904", ImageRectOffset = Vector2.new(964, 204)},
    ["Raids/Boss"] = {Icon = "rbxassetid://3926305904", ImageRectOffset = Vector2.new(244, 364)},
    Fruits = {Icon = "rbxassetid://3926305904", ImageRectOffset = Vector2.new(164, 124)},
    Shop = {Icon = "rbxassetid://3926305904", ImageRectOffset = Vector2.new(44, 204)},
    ["Crew/Guild"] = {Icon = "rbxassetid://3926305904", ImageRectOffset = Vector2.new(4, 124)},
    Stats = {Icon = "rbxassetid://3926305904", ImageRectOffset = Vector2.new(884, 124)},
    ["Island Finder"] = {Icon = "rbxassetid://3926305904", ImageRectOffset = Vector2.new(324, 364)},
    ESP = {Icon = "rbxassetid://3926305904", ImageRectOffset = Vector2.new(644, 284)}
}

local TabButtons = {}
for name, data in pairs(Tabs) do
    local TabButton = Instance.new("ImageButton")
    TabButton.Name = name
    TabButton.Size = UDim2.new(1, -10, 0, 40)
    TabButton.Position = UDim2.new(0, 5, 0, 45 * #TabButtons)
    TabButton.BackgroundColor3 = Theme.Primary
    TabButton.AutoButtonColor = false
    TabButton.Image = data.Icon
    TabButton.ImageRectOffset = data.ImageRectOffset
    TabButton.ImageRectSize = Vector2.new(36, 36)
    TabButton.Parent = SideBar
    
    local TabText = Instance.new("TextLabel")
    TabText.Name = "Text"
    TabText.Size = UDim2.new(1, -40, 1, 0)
    TabText.Position = UDim2.new(0, 40, 0, 0)
    TabText.BackgroundTransparency = 1
    TabText.Text = name
    TabText.TextColor3 = Theme.Text
    TabText.Font = Enum.Font.Gotham
    TabText.TextSize = 14
    TabText.TextXAlignment = Enum.TextXAlignment.Left
    TabText.Parent = TabButton
    
    TabButtons[name] = TabButton
end

local function CreateTabContent(tabName)
    local Content = Instance.new("Frame")
    Content.Name = tabName
    Content.Size = UDim2.new(1, 0, 1, 0)
    Content.BackgroundTransparency = 1
    Content.Visible = false
    Content.Parent = TabContent
    
    local Scroll = Instance.new("ScrollingFrame")
    Scroll.Name = "Scroll"
    Scroll.Size = UDim2.new(1, 0, 1, 0)
    Scroll.BackgroundTransparency = 1
    Scroll.ScrollBarThickness = 5
    Scroll.Parent = Content
    
    local Layout = Instance.new("UIListLayout")
    Layout.Name = "Layout"
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Padding = UDim.new(0, 5)
    Layout.Parent = Scroll
    
    return Scroll
end

local TabContents = {}
for name in pairs(Tabs) do
    TabContents[name] = CreateTabContent(name)
end

local function ShowNotification(message, notifType)
    local Notification = Instance.new("Frame")
    Notification.Name = "Notification"
    Notification.Size = UDim2.new(0, 300, 0, 60)
    Notification.Position = UDim2.new(1, 10, 1, -70)
    Notification.AnchorPoint = Vector2.new(1, 1)
    Notification.BackgroundColor3 = Theme.Primary
    Notification.BackgroundTransparency = 0.2
    Notification.Parent = MainUI
    
    local Color = Instance.new("Frame")
    Color.Name = "Color"
    Color.Size = UDim2.new(0, 5, 1, 0)
    Color.BackgroundColor3 = notifType == "Success" and Theme.Success or notifType == "Warning" and Theme.Warning or Theme.Error
    Color.BorderSizePixel = 0
    Color.Parent = Notification
    
    local Text = Instance.new("TextLabel")
    Text.Name = "Text"
    Text.Size = UDim2.new(1, -20, 1, 0)
    Text.Position = UDim2.new(0, 15, 0, 0)
    Text.BackgroundTransparency = 1
    Text.Text = message
    Text.TextColor3 = Theme.Text
    Text.Font = Enum.Font.Gotham
    Text.TextSize = 14
    Text.TextXAlignment = Enum.TextXAlignment.Left
    Text.Parent = Notification
    
    local TweenIn = TweenService:Create(Notification, TweenInfo.new(0.3), {Position = UDim2.new(1, -10, 1, -70)})
    TweenIn:Play()
    
    task.delay(3, function()
        local TweenOut = TweenService:Create(Notification, TweenInfo.new(0.3), {Position = UDim2.new(1, 10, 1, -70)})
        TweenOut:Play()
        TweenOut.Completed:Connect(function()
            Notification:Destroy()
        end)
    end)
end

local function ToggleUI()
    if MainFrame.Visible then
        local TweenOut = TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)})
        TweenOut:Play()
        TweenOut.Completed:Connect(function()
            MainFrame.Visible = false
        end)
    else
        MainFrame.Visible = true
        MainFrame.Size = UDim2.new(0, 0, 0, 0)
        local TweenIn = TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 450, 0, 600), Position = UDim2.new(0.5, -225, 0.5, -300)})
        TweenIn:Play()
    end
end

local function MinimizeUI()
    if Settings.Minimized then
        local TweenIn = TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 450, 0, 600)})
        TweenIn:Play()
        Settings.Minimized = false
    else
        local TweenOut = TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 450, 0, 40)})
        TweenOut:Play()
        Settings.Minimized = true
    end
    SaveSettings()
end

local function SwitchTab(tabName)
    for name, content in pairs(TabContents) do
        content.Parent.Visible = name == tabName
    end
    Settings.CurrentTab = tabName
    SaveSettings()
end

local function InitFarmTab()
    local FarmContent = TabContents["Farm"]
    
    local AutoFarmToggle = Instance.new("TextButton")
    AutoFarmToggle.Name = "AutoFarmToggle"
    AutoFarmToggle.Size = UDim2.new(1, -20, 0, 40)
    AutoFarmToggle.Position = UDim2.new(0, 10, 0, 10)
    AutoFarmToggle.BackgroundColor3 = Theme.Accent
    AutoFarmToggle.Text = "START AUTOFARM"
    AutoFarmToggle.TextColor3 = Theme.Text
    AutoFarmToggle.Font = Enum.Font.GothamBold
    AutoFarmToggle.TextSize = 14
    AutoFarmToggle.Parent = FarmContent
    
    -- Adicionar mais elementos do Farm aqui
end

local Dragging, DragInput, DragStart, StartPos
local function UpdateInput(input)
    local Delta = input.Position - DragStart
    local NewPos = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + Delta.X, StartPos.Y.Scale, StartPos.Y.Offset + Delta.Y)
    
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        if Dragging == MainFrame then
            MainFrame.Position = NewPos
        elseif Dragging == FloatingButton then
            FloatingButton.Position = NewPos
            Settings.Position = NewPos
            SaveSettings()
        end
    end
end

FloatingButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        Dragging = FloatingButton
        DragStart = input.Position
        StartPos = FloatingButton.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                Dragging = nil
            end
        end)
    end
end)

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        Dragging = MainFrame
        DragStart = input.Position
        StartPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                Dragging = nil
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if Dragging then
        UpdateInput(input)
    end
end)

FloatingButton.MouseButton1Click:Connect(ToggleUI)
MinimizeButton.MouseButton1Click:Connect(MinimizeUI)
CloseButton.MouseButton1Click:Connect(ToggleUI)

for name, button in pairs(TabButtons) do
    button.MouseButton1Click:Connect(function()
        SwitchTab(name)
    end)
end

InitFarmTab()
SwitchTab(Settings.CurrentTab)

LoadSettings()
FloatingButton.Position = Settings.Position
if Settings.Minimized then
    MainFrame.Size = UDim2.new(0, 450, 0, 40)
end

ShowNotification("Blox Fruits Ultimate loaded!", "Success")
