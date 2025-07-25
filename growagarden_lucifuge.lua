--[[ Grow a Garden Script - Enhanced Secure Version
     Made by: lucifuge ]]--

repeat wait() until game:IsLoaded()

-- Services
local RS = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Remotes = RS:WaitForChild("RemoteEvents")

-- UI Setup
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "LucifugeUI"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 250, 0, 250)
Frame.Position = UDim2.new(0.01, 0, 0.1, 0)
Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

local Title = Instance.new("TextLabel", Frame)
Title.Text = "Lucifuge Garden"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Settings Table
local Toggle = {
    AutoCash = false,
    AutoSeeds = false,
    AutoEggs = false,
    AutoPets = false
}

-- Create Toggle Buttons
local function createToggle(name, yPos)
    local btn = Instance.new("TextButton", Frame)
    btn.Size = UDim2.new(1, -20, 0, 30)
    btn.Position = UDim2.new(0, 10, 0, yPos)
    btn.Text = "[OFF] " .. name
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.MouseButton1Click:Connect(function()
        Toggle[name] = not Toggle[name]
        btn.Text = (Toggle[name] and "[ON] " or "[OFF] ") .. name
    end)
end

-- Create toggle buttons
createToggle("AutoCash", 40)
createToggle("AutoSeeds", 75)
createToggle("AutoEggs", 110)
createToggle("AutoPets", 145)

-- Secure random delay
local function randomDelay(min, max)
    return math.random(min * 100, max * 100) / 100
end

-- Cash Generator
task.spawn(function()
    while true do
        if Toggle.AutoCash then
            local amt = math.random(100000, 500000)
            pcall(function()
                Remotes:WaitForChild("AddCash"):FireServer(amt)
            end)
        end
        task.wait(randomDelay(3, 6))
    end
end)

-- Seed Planter
task.spawn(function()
    local seeds = {"Carrot", "Strawberry", "Blueberry", "Corn", "Cactus"}
    while true do
        if Toggle.AutoSeeds then
            for _, seed in ipairs(seeds) do
                pcall(function()
                    Remotes:WaitForChild("AddSeed"):FireServer(seed)
                    task.wait(0.25)
                    Remotes:WaitForChild("PlantSeed"):FireServer(seed)
                end)
                task.wait(randomDelay(1.5, 3))
            end
        end
        task.wait(2)
    end
end)

-- Egg Hatcher
task.spawn(function()
    local eggs = {"Common Egg", "Rare Egg", "Legendary Egg", "Bug Egg"}
    while true do
        if Toggle.AutoEggs then
            for _, egg in ipairs(eggs) do
                pcall(function()
                    Remotes:WaitForChild("GiveEgg"):FireServer(egg)
                    task.wait(0.4)
                    Remotes:WaitForChild("HatchEgg"):FireServer(egg)
                end)
                task.wait(randomDelay(3, 5))
            end
        end
        task.wait(1)
    end
end)

-- Pet Generator
task.spawn(function()
    local pets = {
        {Name = "Dog", Age = 25, Size = 3.5},
        {Name = "Monkey", Age = 50, Size = 8.5},
        {Name = "Frog", Age = 70, Size = 10.2}
    }

    while true do
        if Toggle.AutoPets then
            for _, pet in ipairs(pets) do
                pcall(function()
                    Remotes:WaitForChild("AddPet"):FireServer(pet.Name, pet.Age, pet.Size, "Made by lucifuge")
                end)
                task.wait(randomDelay(5, 7))
            end
        end
        task.wait(1)
    end
end)

-- Heartbeat Ping (anti-detection)
task.spawn(function()
    while true do
        pcall(function()
            Remotes:WaitForChild("HeartbeatPing"):FireServer("lucf_" .. tostring(math.random(1000, 9999)))
        end)
        task.wait(randomDelay(25, 40))
    end
end)

-- Final UI Notification
pcall(function()
    game.StarterGui:SetCore("SendNotification", {
        Title = "Lucifuge Script Ready",
        Text = "All systems online. UI Loaded.",
        Duration = 6
    })
end)
