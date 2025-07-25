--[[ Grow a Garden Script - Lucifuge Mariza Edition Secure Delta-Compatible Version with UI & Load Screen Made by: lucifuge ]]

repeat wait() until game:IsLoaded()

-- Services local RS = game:GetService("ReplicatedStorage") local Players = game:GetService("Players") local TweenService = game:GetService("TweenService") local LocalPlayer = Players.LocalPlayer local Remotes = RS:WaitForChild("RemoteEvents")

-- Safe UI Creation local function safeCreateGUI(name) local gui = Instance.new("ScreenGui") gui.Name = name gui.ResetOnSpawn = false gui.IgnoreGuiInset = true pcall(function() gui.Parent = LocalPlayer:WaitForChild("PlayerGui") end) return gui end

-- Loading Screen local loadingGui = safeCreateGUI("LucifugeLoading")

local loadingFrame = Instance.new("Frame", loadingGui) loadingFrame.Size = UDim2.new(0, 280, 0, 80) loadingFrame.Position = UDim2.new(0.5, -140, 0.4, 0) loadingFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) loadingFrame.BorderSizePixel = 0

local loadingText = Instance.new("TextLabel", loadingFrame) loadingText.Size = UDim2.new(1, 0, 1, 0) loadingText.Text = "🌱 Loading Lucifuge Garden Script..." loadingText.TextColor3 = Color3.new(1, 1, 1) loadingText.TextSize = 18 loadingText.Font = Enum.Font.GothamBold loadingText.BackgroundTransparency = 1

wait(2.5) loadingGui:Destroy()

-- Main UI Setup local ScreenGui = safeCreateGUI("LucifugeUI")

local Frame = Instance.new("Frame", ScreenGui) Frame.Size = UDim2.new(0, 250, 0, 250) Frame.Position = UDim2.new(0.01, 0, 0.1, 0) Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35) Frame.BorderSizePixel = 0 Frame.Active = true Frame.Draggable = true

local Title = Instance.new("TextLabel", Frame) Title.Text = "Lucifuge Garden Menu" Title.Font = Enum.Font.GothamBold Title.TextSize = 16 Title.Size = UDim2.new(1, 0, 0, 30) Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50) Title.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Toggle Settings local Toggle = { AutoCash = false, AutoSeeds = false, AutoEggs = false, AutoPets = false }

-- Create Buttons local function createToggle(name, yPos) local btn = Instance.new("TextButton", Frame) btn.Size = UDim2.new(1, -20, 0, 30) btn.Position = UDim2.new(0, 10, 0, yPos) btn.Text = "[OFF] " .. name btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45) btn.TextColor3 = Color3.new(1, 1, 1) btn.Font = Enum.Font.Gotham btn.TextSize = 14 btn.MouseButton1Click:Connect(function() Toggle[name] = not Toggle[name] btn.Text = (Toggle[name] and "[ON] " or "[OFF] ") .. name end) end

createToggle("AutoCash", 40) createToggle("AutoSeeds", 75) createToggle("AutoEggs", 110) createToggle("AutoPets", 145)

-- Random Delay local function randomDelay(min, max) return math.random(min * 100, max * 100) / 100 end

-- Cash Generator task.spawn(function() while true do if Toggle.AutoCash then pcall(function() Remotes:WaitForChild("AddCash"):FireServer(math.random(100000, 500000)) end) end task.wait(randomDelay(2.5, 5)) end end)

-- Seed Planter task.spawn(function() local seeds = {"Carrot", "Strawberry", "Blueberry", "Corn", "Cactus"} while true do if Toggle.AutoSeeds then for _, seed in ipairs(seeds) do pcall(function() Remotes:WaitForChild("AddSeed"):FireServer(seed) task.wait(0.25) Remotes:WaitForChild("PlantSeed"):FireServer(seed) end) task.wait(randomDelay(1.5, 2.8)) end end task.wait(2) end end)

-- Egg Hatcher task.spawn(function() local eggs = {"Common Egg", "Rare Egg", "Legendary Egg", "Bug Egg"} while true do if Toggle.AutoEggs then for _, egg in ipairs(eggs) do pcall(function() Remotes:WaitForChild("GiveEgg"):FireServer(egg) task.wait(0.4) Remotes:WaitForChild("HatchEgg"):FireServer(egg) end) task.wait(randomDelay(2, 4)) end end task.wait(1.5) end end)

-- Pet Generator task.spawn(function() local pets = { {Name = "Dog", Age = 25, Size = 3.5}, {Name = "Monkey", Age = 50, Size = 8.5}, {Name = "Frog", Age = 70, Size = 10.2} } while true do if Toggle.AutoPets then for _, pet in ipairs(pets) do pcall(function() Remotes:WaitForChild("AddPet"):FireServer(pet.Name, pet.Age, pet.Size, "Made by lucifuge") end) task.wait(randomDelay(5, 7)) end end task.wait(2) end end)

-- Anti-Cheat Ping task.spawn(function() while true do pcall(function() Remotes:WaitForChild("HeartbeatPing"):FireServer("lucf_" .. tostring(math.random(1000, 9999))) end) task.wait(randomDelay(20, 40)) end end)

-- Final Notification pcall(function() game.StarterGui:SetCore("SendNotification", { Title = "Lucifuge Script Ready", Text = "All systems online. UI Loaded.", Duration = 6 }) end)

