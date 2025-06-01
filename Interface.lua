local library = {}

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

function library:MakeDraggable(topbarobject, object)
    local Dragging, DragInput, DragStart, StartPosition
    local function Update(input)
        local Delta = input.Position - DragStart
        local pos = UDim2.new(
            StartPosition.X.Scale, StartPosition.X.Offset + Delta.X,
            StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y
        )
        TweenService:Create(object, TweenInfo.new(0.2), {Position = pos}):Play()
    end
    topbarobject.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            DragStart = input.Position
            StartPosition = object.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then Dragging = false end
            end)
        end
    end)
    topbarobject.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            DragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == DragInput and Dragging then Update(input) end
    end)
end

function library:CreateButton(text, parent, callback)
    local btn = Instance.new("TextButton")
    btn.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
    btn.BorderColor3 = Color3.fromRGB(150, 0, 0)
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.Position = UDim2.new(0, 5, 0, 0)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextColor3 = Color3.fromRGB(255, 50, 50)
    btn.TextSize = 18
    btn.Text = text
    btn.AutoButtonColor = true
    btn.Parent = parent
    btn.MouseButton1Click:Connect(callback)
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(90, 0, 0)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
    end)
    return btn
end

function library:CreateWindow(title)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "SAMU_HUB_GUI"
    screenGui.Parent = game.CoreGui
    screenGui.ResetOnSpawn = false

    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "Main"
    mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    mainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
    mainFrame.Size = UDim2.new(0, 600, 0, 400)
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    mainFrame.Parent = screenGui

    local topBar = Instance.new("Frame")
    topBar.Name = "TopBar"
    topBar.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
    topBar.BorderSizePixel = 0
    topBar.Size = UDim2.new(1, 0, 0, 30)
    topBar.Parent = mainFrame

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Text = title
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
    titleLabel.TextSize = 20
    titleLabel.BackgroundTransparency = 1
    titleLabel.Size = UDim2.new(0.8, 0, 1, 0)
    titleLabel.Position = UDim2.new(0.05, 0, 0, 0)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = topBar

    local btnClose = Instance.new("TextButton")
    btnClose.Text = "X"
    btnClose.Font = Enum.Font.GothamBold
    btnClose.TextColor3 = Color3.fromRGB(255, 0, 0)
    btnClose.BackgroundTransparency = 1
    btnClose.Size = UDim2.new(0, 30, 1, 0)
    btnClose.Position = UDim2.new(1, -35, 0, 0)
    btnClose.Parent = topBar

    local btnMinimize = Instance.new("TextButton")
    btnMinimize.Text = "-"
    btnMinimize.Font = Enum.Font.GothamBold
    btnMinimize.TextColor3 = Color3.fromRGB(255, 0, 0)
    btnMinimize.BackgroundTransparency = 1
    btnMinimize.Size = UDim2.new(0, 30, 1, 0)
    btnMinimize.Position = UDim2.new(1, -70, 0, 0)
    btnMinimize.Parent = topBar

    local tabFrame = Instance.new("Frame")
    tabFrame.Name = "TabFrame"
    tabFrame.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
    tabFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
    tabFrame.Size = UDim2.new(0, 130, 1, -30)
    tabFrame.Position = UDim2.new(0, 0, 0, 30)
    tabFrame.Parent = mainFrame

    local contentFrame = Instance.new("Frame")
    contentFrame.Name = "ContentFrame"
    contentFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    contentFrame.BorderSizePixel = 0
    contentFrame.Size = UDim2.new(1, -130, 1, -30)
    contentFrame.Position = UDim2.new(0, 130, 0, 30)
    contentFrame.Parent = mainFrame

    self:MakeDraggable(topBar, mainFrame)

    local tabs = {}
    local currentTab = nil

    local function addTab(name)
        local btn = Instance.new("TextButton")
        btn.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
        btn.BorderColor3 = Color3.fromRGB(150, 0, 0)
        btn.Size = UDim2.new(1, -10, 0, 40)
        btn.Position = UDim2.new(0, 5, 0, (#tabs * 45) + 5)
        btn.Font = Enum.Font.GothamSemibold
        btn.TextColor3 = Color3.fromRGB(255, 50, 50)
        btn.TextSize = 18
        btn.Text = name
        btn.Parent = tabFrame
        btn.AutoButtonColor = true
        btn.MouseEnter:Connect(function()
            btn.BackgroundColor3 = Color3.fromRGB(90, 0, 0)
        end)
        btn.MouseLeave:Connect(function()
            if currentTab ~= name then
                btn.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
            end
        end)

        local page = Instance.new("Frame")
        page.Size = UDim2.new(1, 0, 1, 0)
        page.BackgroundTransparency = 1
        page.Visible = false
        page.Parent = contentFrame

        btn.MouseButton1Click:Connect(function()
            if currentTab then
                tabs[currentTab].button.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
                tabs[currentTab].page.Visible = false
            end
            currentTab = name
            page.Visible = true
            btn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        end)

        tabs[name] = {button = btn, page = page}
        return page
    end

    btnClose.MouseButton1Click:Connect(function()
        screenGui.Enabled = false
    end)

    local minimized = false
    btnMinimize.MouseButton1Click:Connect(function()
        if minimized then
            contentFrame.Visible = true
            tabFrame.Visible = true
            btnMinimize.Text = "-"
            minimized = false
        else
            contentFrame.Visible = false
            tabFrame.Visible = false
            btnMinimize.Text = "+"
            minimized = true
        end
    end)

    local floatingBtn = Instance.new("ImageButton")
    floatingBtn.Size = UDim2.new(0, 50, 0, 50)
    floatingBtn.Position = UDim2.new(0, 20, 0.5, -25)
    floatingBtn.BackgroundTransparency = 1
    floatingBtn.Image = "rbxassetid://128226597224894"
    floatingBtn.Parent = screenGui
    floatingBtn.ZIndex = 1000

    local dragging, dragInput, dragStart, startPos

    local function update(input)
        local delta = input.Position - dragStart
        floatingBtn.Position = UDim2.new(
            startPos.X.Scale,
            math.clamp(startPos.X.Offset + delta.X, 0, workspace.CurrentCamera.ViewportSize.X - floatingBtn.AbsoluteSize.X),
            startPos.Y.Scale,
            math.clamp(startPos.Y.Offset + delta.Y, 0, workspace.CurrentCamera.ViewportSize.Y - floatingBtn.AbsoluteSize.Y)
        )
    end

    floatingBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = floatingBtn.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    floatingBtn.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)

    floatingBtn.MouseButton1Click:Connect(function()
        screenGui.Enabled = not screenGui.Enabled
    end)

    local win = {}

    win.ScreenGui = screenGui
    win.MainFrame = mainFrame
    win.AddTab = addTab

    return win
end

return library
