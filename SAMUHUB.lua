local VERSION = "5.0"
local SCRIPT_NAME = "SAMU HUB"
local AUTHOR = "SAMU"

if not game:IsLoaded() then
    game.Loaded:Wait()
end

if game.PlaceId ~= 2753915549 and game.PlaceId ~= 4442272183 and game.PlaceId ~= 7449423635 then
    game:GetService("Players").LocalPlayer:Kick("Script só funciona em Blox Fruits!")
    return
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Camera = workspace.CurrentCamera

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib(SCRIPT_NAME .. " v" .. VERSION, "DarkTheme")

local function SafeCheck()
    if not Player or not Character or not Humanoid or not HumanoidRootPart then
        return false
    end
    return true
end

local MainTab = Window:NewTab("Principal")
local CombatTab = Window:NewTab("Combate")
local FarmingTab = Window:NewTab("Farm")
local TeleportTab = Window:NewTab("Teleportes")
local MiscTab = Window:NewTab("Misc")
local SettingsTab = Window:NewTab("Config")

local FarmingSection = FarmingTab:NewSection("Farm Automático")

FarmingSection:NewToggle("Farm Automático", "Farma NPCs automaticamente", function(state)
    getgenv().AutoFarm = state
    if state then
        spawn(function()
            while AutoFarm and SafeCheck() do
                local target = FindNearestNPC()
                if target then
                    FarmTarget(target)
                end
                task.wait()
            end
        end)
    end
end)

FarmingSection:NewToggle("Farm de Frutas", "Farma frutas automaticamente", function(state)
    getgenv().AutoFarmFruits = state
end)

FarmingSection:NewDropdown("Selecionar NPC", "Escolha qual NPC farmar", {"Bandido [Lv. 5]", "Ladrão [Lv. 10]", "Gorila [Lv. 20]"}, function(selected)
    getgenv().SelectedNPC = selected
end)

FarmingSection:NewSlider("Distância de Farm", "Distância para ficar do NPC", 100, 5, 20, function(value)
    getgenv().FarmDistance = value
end)

local CombatSection = CombatTab:NewSection("Combate")

CombatSection:NewToggle("Aimbot", "Mira automaticamente nos NPCs", function(state)
    getgenv().Aimbot = state
end)

CombatSection:NewToggle("Auto Click", "Ataca automaticamente", function(state)
    getgenv().AutoClick = state
    if state then
        spawn(function()
            while AutoClick do
                VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                task.wait()
                VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
                task.wait(0.1)
            end
        end)
    end
end)

CombatSection:NewToggle("Dodge Automático", "Esquiva automaticamente", function(state)
    getgenv().AutoDodge = state
end)

CombatSection:NewToggle("Haki Automático", "Ativa Haki automaticamente", function(state)
    getgenv().AutoHaki = state
end)

local TeleportSection = TeleportTab:NewSection("Teleportes")

TeleportSection:NewDropdown("Ilhas", "Teleportar para ilhas", {"Ilha inicial", "Ilha intermediária", "Ilha avançada"}, function(selected)
    TeleportToIsland(selected)
end)

TeleportSection:NewButton("Teleportar para NPC", function()
    local target = FindNearestNPC()
    if target then
        TeleportTo(target.HumanoidRootPart.Position)
    end
end)

TeleportSection:NewButton("Voltar para posição salva", function()
    if getgenv().SavedPosition then
        TeleportTo(getgenv().SavedPosition)
    end
end)

TeleportSection:NewButton("Salvar posição", function()
    if SafeCheck() then
        getgenv().SavedPosition = HumanoidRootPart.Position
    end
end)

local MiscSection = MiscTab:NewSection("Misc")

MiscSection:NewToggle("Noclip", "Atravessa paredes", function(state)
    getgenv().Noclip = state
    if state then
        spawn(function()
            while Noclip do
                if SafeCheck() then
                    for _, part in pairs(Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
                task.wait()
            end
        end)
    end
end)

MiscSection:NewToggle("Bunny Hop", "Pula automaticamente", function(state)
    getgenv().BunnyHop = state
    if state then
        spawn(function()
            while BunnyHop do
                if SafeCheck() and Humanoid:GetState() ~= Enum.HumanoidStateType.Freefall then
                    Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
                task.wait(0.1)
            end
        end)
    end
end)

MiscSection:NewToggle("Coletar itens", function(state)
    getgenv().AutoCollect = state
end)

MiscSection:NewToggle("Anti-AFK", function(state)
    getgenv().AntiAFK = state
    if state then
        spawn(function()
            local VirtualUser = game:GetService("VirtualUser")
            while AntiAFK do
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
                task.wait(60)
            end
        end)
    end
end)

local SettingsSection = SettingsTab:NewSection("Config")

SettingsSection:NewKeybind("Toggle UI", "Mostra/esconde o menu", Enum.KeyCode.RightControl, function()
    Library:ToggleUI()
end)

SettingsSection:NewButton("Discord", function()
    setclipboard("discord.gg/exemplo")
end)

SettingsSection:NewButton("Atualizar", function()
end)

SettingsSection:NewLabel("By: " .. AUTHOR)
SettingsSection:NewLabel("Versão: " .. VERSION)

function FindNearestNPC()
    local nearest, shortestDistance = nil, math.huge
    for _, v in pairs(workspace.Enemies:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            if SelectedNPC and string.find(v.Name, SelectedNPC) then
                local distance = (v.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    nearest = v
                end
            end
        end
    end
    return nearest
end

function FarmTarget(target)
    repeat
        task.wait()
        if not target or target.Humanoid.Health <= 0 then break end

        local targetPosition = target.HumanoidRootPart.Position + (HumanoidRootPart.CFrame.LookVector * -FarmDistance)
        HumanoidRootPart.CFrame = CFrame.new(targetPosition, target.HumanoidRootPart.Position)

        if AutoHaki then
            local args = {[1] = "Buso"}
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
        end
    
        if AutoClick then
            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
            task.wait()
            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
            task.wait(0.1)
        end

    until not AutoFarm or not target or target.Humanoid.Health <= 0
end
function TeleportTo(position)
    if SafeCheck() then
        HumanoidRootPart.CFrame = CFrame.new(position)
    end
end

local IslandPositions = {
    ["Ilha inicial"] = Vector3.new(0, 10, 0), -- Troque para coordenadas reais
    ["Ilha intermediária"] = Vector3.new(1000, 10, 1000),
    ["Ilha avançada"] = Vector3.new(2000, 10, 2000),
}

function TeleportToIsland(island)
    local pos = IslandPositions[island]
    if pos then
        TeleportTo(pos)
    end
end

local ScreenGui = Instance.new("ScreenGui")
local DragButton = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "SAMU_HUB_Floating"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

DragButton.Name = "DragButton"
DragButton.Parent = ScreenGui
DragButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
DragButton.BorderColor3 = Color3.fromRGB(0, 255, 255)
DragButton.BorderSizePixel = 2
DragButton.Position = UDim2.new(0.8, 0, 0.5, 0)
DragButton.Size = UDim2.new(0, 50, 0, 50)
DragButton.Font = Enum.Font.SourceSans
DragButton.Text = "SAMU"
DragButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DragButton.TextSize = 14.000
DragButton.TextWrapped = true
DragButton.Draggable = true
DragButton.Active = true
DragButton.Selectable = true

DragButton.MouseButton1Click:Connect(function()
    Library:ToggleUI()
end)

local function updateInput(input)
    local delta = input.Position - dragStart
    local pos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    DragButton.Position = pos
end

DragButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragStart = input.Position
        startPos = DragButton.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragStart = nil
            end
        end)
    end
end)

DragButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        updateInput(input)
    end
end)

Player.CharacterAdded:Connect(function(newChar)
    Character = newChar
    Humanoid = newChar:WaitForChild("Humanoid")
    HumanoidRootPart = newChar:WaitForChild("HumanoidRootPart")
end)

RunService.Heartbeat:Connect(function()
end)

Library:Notify(SCRIPT_NAME .. " carregado! Bem-vindo " .. Player.Name, 5)

spawn(function()
    while true do
        for i = 0, 1, 0.01 do
            if Library then
                Library:ChangeColor(Color3.fromHSV(i, 1, 1))
            end
            task.wait(0.1)
        end
    end
end)
