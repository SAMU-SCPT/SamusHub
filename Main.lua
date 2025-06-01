local Interface = loadstring(game:HttpGet("https://raw.githubusercontent.com/SAMU-SCPT/SamusHub/refs/heads/main/Interface.lua"))()

local win = Interface:CreateWindow("SAMU HUB - Blox Fruits")

local farmTab = win:AddTab("AutoFarm")

local farmEnabled = false
local function toggleAutoFarm()
    farmEnabled = not farmEnabled
    if farmEnabled then
        print("AutoFarm ativado")
    else
        print("AutoFarm desativado")
    end
end

Interface:CreateButton("Ativar/Desativar AutoFarm", farmTab, toggleAutoFarm)

local fruitTab = win:AddTab("Frutas")

local pickFruits = false
local autoEat = false
local autoDrop = false

local function togglePickFruits()
    pickFruits = not pickFruits
    print("Pegar frutas soltas:", pickFruits)
end

local function toggleAutoEat()
    autoEat = not autoEat
    print("Comer frutas automaticamente:", autoEat)
end

local function toggleAutoDrop()
    autoDrop = not autoDrop
    print("Dropar frutas automaticamente:", autoDrop)
end

Interface:CreateButton("Pegar frutas soltas", fruitTab, togglePickFruits)
Interface:CreateButton("Comer frutas automaticamente", fruitTab, toggleAutoEat)
Interface:CreateButton("Dropar frutas automaticamente", fruitTab, toggleAutoDrop)

print("Interface carregada, pronto para rodar as funções básicas.")
