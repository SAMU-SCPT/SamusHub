local Interface = {}

local UserInputService = game:GetService("UserInputService")
local gui = Instance.new("ScreenGui")
gui.Name = "SAMU_HUB"
gui.Parent = game.CoreGui
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local floatButton = Instance.new("ImageButton")
floatButton.Name = "FloatButton"
floatButton.Parent = gui
floatButton.Size = UDim2.new(0, 50, 0, 50)
floatButton.Position = UDim2.new(0, 20, 0.5, -25)
floatButton.BackgroundTransparency = 0.5
floatButton.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"

floatButton.MouseButton1Click:Connect(function()
	print("Botão flutuante clicado")
end)

function Interface:CreateWindow(titleText)
	print("Interface carregada: "..titleText)
	return Interface
end

return Interface
