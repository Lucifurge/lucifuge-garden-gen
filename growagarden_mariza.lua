--[[ 
💠 Grow a Garden Hack UI
🎮 Made by Lucifuge - Delta Optimized
🛡️ Secure | No WaitForChild | Instant UI
]]

--// SERVICES
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local plr = Players.LocalPlayer

--// REMOTE EVENTS (Safe Grabs)
local function safeRemote(name)
    for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
        if obj:IsA("RemoteEvent") and obj.Name:lower():find(name:lower()) then
            return obj
        end
    end
    return nil
end

local Remotes = {
    AddCash = safeRemote("datastrem") or safeRemote("addcash"),
    SpawnSeed = safeRemote("buyseedstock"),
    SpawnPet = safeRemote("buypetegg"),
    SpawnEgg = safeRemote("buyeasterstock"),
    Sell = safeRemote("sell_item") or safeRemote("sellitem"),
    Water = safeRemote("Water_RE") or safeRemote("Water"),
    Sprinkle = safeRemote("Sprinkler_RE") or safeRemote("Sprinkle")
}

--// UI
local ScreenGui = Instance.new("ScreenGui", plr.PlayerGui)
ScreenGui.Name = "LucifugeMenu"
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 240, 0, 320)
Frame.Position = UDim2.new(0.02, 0, 0.2, 0)
Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Frame.BorderColor3 = Color3.fromRGB(0, 200, 255)
Frame.BorderSizePixel = 2
Frame.Active = true
Frame.Draggable = true

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "🌱 Lucifuge - Garden Panel"
Title.TextColor3 = Color3.fromRGB(0, 200, 255)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 16
Title.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Title.BorderSizePixel = 0

local function addButton(text, yPos, callback)
    local btn = Instance.new("TextButton", Frame)
    btn.Size = UDim2.new(0.9, 0, 0, 30)
    btn.Position = UDim2.new(0.05, 0, 0, yPos)
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    btn.BorderColor3 = Color3.fromRGB(0, 200, 255)
    btn.TextColor3 = Color3.fromRGB(200, 255, 255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.MouseButton1Click:Connect(function()
        pcall(callback)
    end)
end

--// BUTTONS
addButton("💰 Add Cash", 40, function()
    if Remotes.AddCash then
        Remotes.AddCash:FireServer()
    end
end)

addButton("🌾 Spawn Seed", 80, function()
    if Remotes.SpawnSeed then
        Remotes.SpawnSeed:FireServer()
    end
end)

addButton("🥚 Spawn Egg", 120, function()
    if Remotes.SpawnEgg then
        Remotes.SpawnEgg:FireServer()
    end
end)

addButton("🐾 Spawn Pet", 160, function()
    if Remotes.SpawnPet then
        Remotes.SpawnPet:FireServer()
    end
end)

addButton("🚿 Water Garden", 200, function()
    if Remotes.Water then
        Remotes.Water:FireServer()
    end
end)

addButton("💦 Sprinkle Garden", 240, function()
    if Remotes.Sprinkle then
        Remotes.Sprinkle:FireServer()
    end
end)

addButton("🪙 Sell All", 280, function()
    if Remotes.Sell then
        Remotes.Sell:FireServer()
    end
end)

--// END
