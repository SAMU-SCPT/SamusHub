local Interface = loadstring(game:HttpGet("https://raw.githubusercontent.com/SAMU-SCPT/SamusHub/refs/heads/main/Interface.lua"))()

local Window = Interface:CreateWindow("SAMU HUB")

local AutoFarmTab = Interface:AddTab("AutoFarm")
local FruitTab = Interface:AddTab("Frutas")
local PlayerTab = Interface:AddTab("Player")
local BountyTab = Interface:AddTab("Bounty")
local TeleportTab = Interface:AddTab("Teleport")
local ShopTab = Interface:AddTab("Shop")
local StatsTab = Interface:AddTab("Stats")

local function hideAllTabs()
	for _, tab in pairs({AutoFarmTab, FruitTab, PlayerTab, BountyTab, TeleportTab, ShopTab, StatsTab}) do
		tab.Visible = false
	end
end

local menu = {
	{"AutoFarm", AutoFarmTab},
	{"Frutas", FruitTab},
	{"Player", PlayerTab},
	{"Bounty", BountyTab},
	{"Teleport", TeleportTab},
	{"Shop", ShopTab},
	{"Stats", StatsTab}
}

for i, v in ipairs(menu) do
	local btn = Interface:CreateButton(v[1], Window.Main, function()
		hideAllTabs()
		v[2].Visible = true
	end)
	btn.Position = UDim2.new(0, 10, 0, 40 + (i - 1) * 35)
end

Interface:CreateButton("Start Auto Farm", AutoFarmTab, function()
	print("Auto Farm ativado")
end)

Interface:CreateButton("Auto Attack", AutoFarmTab, function()
	print("Auto Attack ativado")
end)

Interface:CreateButton("Auto Gun Attack", AutoFarmTab, function()
	print("Auto Gun Attack ativado")
end)

Interface:CreateButton("Coletar Frutas no Mapa", FruitTab, function()
	print("Buscando frutas no mapa")
end)

Interface:CreateButton("Rodar Fruta Aleatória", FruitTab, function()
	print("Rodando fruta")
end)

Interface:CreateButton("Armazenar Fruta", FruitTab, function()
	print("Armazenando fruta")
end)

Interface:CreateButton("Comer Fruta", FruitTab, function()
	print("Comendo fruta")
end)

Interface:CreateButton("Dropar Fruta", FruitTab, function()
	print("Dropando fruta")
end)

Interface:CreateButton("Teleportar para Jogador", PlayerTab, function()
	print("Teleportando para player")
end)

Interface:CreateButton("Atacar Jogador", PlayerTab, function()
	print("Atacando player")
end)

Interface:CreateButton("Start Bounty Hunt", BountyTab, function()
	print("Bounty Hunt iniciado")
end)

Interface:CreateButton("Teleport Sea 1", TeleportTab, function()
	print("Teleportando para Sea 1")
end)

Interface:CreateButton("Teleport Sea 2", TeleportTab, function()
	print("Teleportando para Sea 2")
end)

Interface:CreateButton("Teleport Sea 3", TeleportTab, function()
	print("Teleportando para Sea 3")
end)

Interface:CreateButton("Teleport Ilha 1", TeleportTab, function()
	print("Teleportando para Ilha 1")
end)

Interface:CreateButton("Teleport Ilha 2", TeleportTab, function()
	print("Teleportando para Ilha 2")
end)

Interface:CreateButton("Comprar Armas", ShopTab, function()
	print("Comprando armas")
end)

Interface:CreateButton("Comprar Estilo de Luta", ShopTab, function()
	print("Comprando estilo de luta")
end)

Interface:CreateButton("Comprar Fruta (Normal)", ShopTab, function()
	print("Comprando fruta normal")
end)

Interface:CreateButton("Comprar Fruta (Avançada)", ShopTab, function()
	print("Comprando fruta avançada")
end)

Interface:CreateButton("Auto Status - Fruta", StatsTab, function()
	print("Auto status em fruta")
end)

Interface:CreateButton("Auto Status - Espada", StatsTab, function()
	print("Auto status em espada")
end)

Interface:CreateButton("Auto Status - Arma", StatsTab, function()
	print("Auto status em arma")
end)

Interface:CreateButton("Auto Status - Defesa", StatsTab, function()
	print("Auto status em defesa")
end)

Interface:CreateButton("Auto Status - Soco", StatsTab, function()
	print("Auto status em soco")
end)

Interface:CreateButton("Auto Status - Balanceado", StatsTab, function()
	print("Distribuindo status igualmente")
end)
