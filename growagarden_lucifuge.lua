--[[ Grow a Garden Script - Ultimate Secure Version
     Made by: lucifuge ]]--

--// Anti-Detection Utilities
local function randomDelay(min, max)
    return math.random(min * 100, max * 100) / 100
end

local function safeWait(t)
    task.wait(randomDelay(t - 0.3, t + 0.3))
end

local function notify(txt)
    pcall(function()
        game.StarterGui:SetCore("SendNotification", {
            Title = "Lucifuge Garden Script",
            Text = txt,
            Duration = 5
        })
    end)
end

notify("Loading Lucifuge Secure Script...")
repeat task.wait() until game:IsLoaded()

--// Remote Setup
local success, RS = pcall(function() return game:GetService("ReplicatedStorage") end)
if not success then return end
local Remotes = RS:WaitForChild("RemoteEvents", 10)
if not Remotes then return notify("❌ RemoteEvents not found") end

--// Toggle Table
local Toggle = {
    AutoCash = true,
    AutoSeeds = true,
    AutoEggs = true,
    AutoPets = true,
    AutoFarm = true,
    HideGUI = false
}

--// Simple GUI
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
ScreenGui.Name = "LucifugeUI"
local Frame = Instance.new("Frame", ScreenGui)
Frame.Position = UDim2.new(0.02, 0, 0.3, 0)
Frame.Size = UDim2.new(0, 170, 0, 240)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BackgroundTransparency = 0.1
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

local function createToggle(name, yPos, toggleVar)
    local btn = Instance.new("TextButton", Frame)
    btn.Position = UDim2.new(0, 10, 0, yPos)
    btn.Size = UDim2.new(0, 150, 0, 30)
    btn.Text = name .. ": ON"
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.MouseButton1Click:Connect(function()
        Toggle[toggleVar] = not Toggle[toggleVar]
        btn.Text = name .. ": " .. (Toggle[toggleVar] and "ON" or "OFF")
    end)
end

createToggle("AutoCash", 10, "AutoCash")
createToggle("AutoSeeds", 50, "AutoSeeds")
createToggle("AutoEggs", 90, "AutoEggs")
createToggle("AutoPets", 130, "AutoPets")
createToggle("AutoFarm", 170, "AutoFarm")

--// Autofarm Simulation
spawn(function()
    while Toggle.AutoFarm do
        pcall(function()
            Remotes:WaitForChild("CollectAllPlants"):FireServer()
            Remotes:WaitForChild("WaterAllPlants"):FireServer()
        end)
        safeWait(10)
    end
end)

--// Auto Systems
spawn(function()
    while Toggle.AutoCash do
        local amount = math.random(500000, 1000000)
        pcall(function()
            Remotes:WaitForChild("AddCash"):FireServer(amount)
        end)
        safeWait(5)
    end
end)

spawn(function()
    local seeds = {"Carrot", "Strawberry", "Blueberry", "Corn", "Cactus"}
    while Toggle.AutoSeeds do
        for _, seed in pairs(seeds) do
            pcall(function()
                Remotes:WaitForChild("AddSeed"):FireServer(seed)
                safeWait(0.5)
                Remotes:WaitForChild("PlantSeed"):FireServer(seed)
            end)
            safeWait(3)
        end
    end
end)

spawn(function()
    local eggs = {"Common Egg", "Rare Egg", "Legendary Egg", "Bug Egg"}
    while Toggle.AutoEggs do
        for _, egg in ipairs(eggs) do
            pcall(function()
                Remotes:WaitForChild("GiveEgg"):FireServer(egg)
                safeWait(0.5)
                Remotes:WaitForChild("HatchEgg"):FireServer(egg)
            end)
            safeWait(5)
        end
    end
end)

spawn(function()
    local pets = {
        {Name = "Dog", Age = 25, Size = 3.5},
        {Name = "Monkey", Age = 50, Size = 8.5},
        {Name = "Frog", Age = 70, Size = 10.2}
    }

    while Toggle.AutoPets do
        for _, pet in pairs(pets) do
            pcall(function()
                local args = {
                    [1] = pet.Name,
                    [2] = pet.Age,
                    [3] = pet.Size,
                    [4] = "Made by lucifuge"
                }
                Remotes:WaitForChild("AddPet"):FireServer(unpack(args))
            end)
            safeWait(6)
        end
    end
end)

--// Keepalive Ping
spawn(function()
    while true do
        pcall(function()
            Remotes:WaitForChild("HeartbeatPing"):FireServer("lucifuge_keepalive_" .. tostring(math.random(1000,9999)))
        end)
        wait(math.random(30, 45))
    end
end)

notify("✅ Lucifuge Script Running Successfully")
