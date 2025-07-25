--[[ 
   🔰 Lucifuge Mariza Grow a Garden Script 🔰
   Made by: lucifuge
   Enhanced Edition: UI + AntiBan + AutoFarm
--]]

repeat wait() until game:IsLoaded()

--// Services
local RS = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Remotes = RS:WaitForChild("RemoteEvents")

--// Obfuscate Identifier Ping
task.spawn(function()
	while true do
		pcall(function()
			Remotes:WaitForChild("HeartbeatPing"):FireServer("lcfg_" .. tostring(math.random(10000,99999)))
		end)
		task.wait(math.random(25,40))
	end
end)

--// GUI Setup
local function safeCreateGUI(name)
	local gui = Instance.new("ScreenGui")
	gui.Name = name
	gui.IgnoreGuiInset = true
	gui.ResetOnSpawn = false
	pcall(function()
		gui.Parent = LocalPlayer:WaitForChild("PlayerGui")
	end)
	return gui
end

--// Intro Animation
local logoGui = safeCreateGUI("LucifugeIntro")
local logoFrame = Instance.new("Frame", logoGui)
logoFrame.Size = UDim2.new(0, 0, 0, 0)
logoFrame.Position = UDim2.new(0.5, -150, 0.5, -50)
logoFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
logoFrame.BorderSizePixel = 0

local logoText = Instance.new("TextLabel", logoFrame)
logoText.Size = UDim2.new(1, 0, 1, 0)
logoText.Text = "🌌 Lucifuge Garden Loader 🌌"
logoText.Font = Enum.Font.GothamBlack
logoText.TextSize = 24
logoText.TextColor3 = Color3.fromRGB(0, 170, 255)
logoText.BackgroundTransparency = 1

TweenService:Create(logoFrame, TweenInfo.new(1, Enum.EasingStyle.Bounce), {Size = UDim2.new(0, 300, 0, 100)}):Play()
wait(3)
logoGui:Destroy()

--// UI Creation
local mainGui = safeCreateGUI("LucifugeUI")
local frame = Instance.new("Frame", mainGui)
frame.Size = UDim2.new(0, 250, 0, 250)
frame.Position = UDim2.new(0.02, 0, 0.1, 0)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
frame.BorderSizePixel = 0
frame.Draggable = true
frame.Active = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "🌿 Lucifuge AutoGarden"
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.BackgroundColor3 = Color3.fromRGB(0, 80, 160)
title.TextColor3 = Color3.new(1, 1, 1)

--// Toggle Storage
local Toggles = {
	AutoFarm = false,
	AutoSeeds = false,
	AutoEggs = false,
	AutoPets = false
}

--// Button Creator
local function makeButton(text, yPos, toggleKey)
	local btn = Instance.new("TextButton", frame)
	btn.Size = UDim2.new(1, -20, 0, 30)
	btn.Position = UDim2.new(0, 10, 0, yPos)
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 70)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	btn.Text = "[OFF] " .. text

	btn.MouseButton1Click:Connect(function()
		Toggles[toggleKey] = not Toggles[toggleKey]
		btn.Text = (Toggles[toggleKey] and "[ON] " or "[OFF] ") .. text
	end)
end

makeButton("Auto Cash", 40, "AutoFarm")
makeButton("Auto Seeds", 75, "AutoSeeds")
makeButton("Auto Eggs", 110, "AutoEggs")
makeButton("Auto Pets", 145, "AutoPets")

--// Random Delay Utility
local function randomDelay(min, max)
	return math.random(min * 100, max * 100) / 100
end

--// AutoFarm: Add Cash
task.spawn(function()
	while true do
		if Toggles.AutoFarm then
			pcall(function()
				Remotes:WaitForChild("AddCash"):FireServer(math.random(250000, 500000))
			end)
		end
		task.wait(randomDelay(3, 5.5))
	end
end)

--// AutoFarm: Seeds
task.spawn(function()
	local seedList = {"Carrot", "Strawberry", "Blueberry", "Corn", "Cactus"}
	while true do
		if Toggles.AutoSeeds then
			for _, seed in ipairs(seedList) do
				pcall(function()
					Remotes:WaitForChild("AddSeed"):FireServer(seed)
					task.wait(0.25)
					Remotes:WaitForChild("PlantSeed"):FireServer(seed)
				end)
				task.wait(randomDelay(1.2, 2.5))
			end
		end
		task.wait(2)
	end
end)

--// AutoFarm: Eggs
task.spawn(function()
	local eggList = {"Common Egg", "Rare Egg", "Legendary Egg", "Bug Egg"}
	while true do
		if Toggles.AutoEggs then
			for _, egg in ipairs(eggList) do
				pcall(function()
					Remotes:WaitForChild("GiveEgg"):FireServer(egg)
					task.wait(0.4)
					Remotes:WaitForChild("HatchEgg"):FireServer(egg)
				end)
				task.wait(randomDelay(2, 3.8))
			end
		end
		task.wait(1.5)
	end
end)

--// AutoFarm: Pets
task.spawn(function()
	local pets = {
		{Name = "Dog", Age = 20, Size = 4.0},
		{Name = "Monkey", Age = 40, Size = 7.5},
		{Name = "Frog", Age = 60, Size = 10}
	}
	while true do
		if Toggles.AutoPets then
			for _, pet in ipairs(pets) do
				pcall(function()
					Remotes:WaitForChild("AddPet"):FireServer(pet.Name, pet.Age, pet.Size, "Made by lucifuge")
				end)
				task.wait(randomDelay(5, 8))
			end
		end
		task.wait(2)
	end
end)

--// Final Notification
pcall(function()
	game.StarterGui:SetCore("SendNotification", {
		Title = "Lucifuge Activated",
		Text = "Grow a Garden Enhanced Script Loaded!",
		Duration = 5
	})
end)
