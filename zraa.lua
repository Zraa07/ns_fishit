-- ========================================
-- 🎣 FISH IT UNIVERSAL SPAM SCRIPT 2025
-- No Remote Detection | Tool Activate | Auto Cast/Reel/Sell
-- Fixed for Oct 21 Update - Delta Compatible
-- ========================================

print("🎣 [UNIVERSAL SPAM] Loading... No remotes needed!")

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

local AutoFishEnabled = false
local FishCount = 0
local isRodEquipped = false

-- NOTIFICATION
local function notify(title, text, duration)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title;
            Text = text;
            Duration = duration or 3;
        })
    end)
end

notify("🎣 UNIVERSAL SCRIPT", "Loading... Equip rod first!", 3)

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UniversalFishIt"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 1000
ScreenGui.Parent = Player.PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 250)
MainFrame.Position = UDim2.new(0, 10, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Text = "🎣 FISH IT UNIVERSAL FIX"
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

-- Status
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -20, 0, 40)
StatusLabel.Position = UDim2.new(0, 10, 0, 60)
StatusLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
StatusLabel.Text = "⏳ Check rod..."
StatusLabel.TextColor3 = Color3.fromRGB(255, 193, 7)
StatusLabel.TextScaled = true
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Parent = MainFrame

local StatusCorner = Instance.new("UICorner")
StatusCorner.CornerRadius = UDim.new(0, 8)
StatusCorner.Parent = StatusLabel

-- Start Button
local StartBtn = Instance.new("TextButton")
StartBtn.Size = UDim2.new(1, -20, 0, 50)
StartBtn.Position = UDim2.new(0, 10, 0, 110)
StartBtn.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
StartBtn.Text = "▶️ START AUTO FISH"
StartBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
StartBtn.TextScaled = true
StartBtn.Font = Enum.Font.GothamBold
StartBtn.Parent = MainFrame

local StartCorner = Instance.new("UICorner")
StartCorner.CornerRadius = UDim.new(0, 10)
StartCorner.Parent = StartBtn

-- Stats
local StatsLabel = Instance.new("TextLabel")
StatsLabel.Size = UDim2.new(1, -20, 0, 30)
StatsLabel.Position = UDim2.new(0, 10, 0, 170)
StatsLabel.BackgroundTransparency = 1
StatsLabel.Text = "🐟 Fish: 0"
StatsLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
StatsLabel.TextScaled = true
StatsLabel.Font = Enum.Font.Gotham
StatsLabel.Parent = MainFrame

-- Check & Equip Rod
local function checkRod()
    local backpackRod = Players.LocalPlayer.Backpack:FindFirstChild("Fishing Rod") or Players.LocalPlayer.Backpack:FindFirstChild("Rod")
    local charRod = Character:FindFirstChild("Fishing Rod") or Character:FindFirstChild("Rod")
    
    if backpackRod then
        backpackRod.Parent = Character
        isRodEquipped = true
        StatusLabel.Text = "✅ Rod equipped!"
        StatusLabel.TextColor3 = Color3.fromRGB(76, 175, 80)
        notify("ROD", "Auto equipped!", 2)
        return true
    elseif charRod then
        isRodEquipped = true
        StatusLabel.Text = "✅ Rod ready!"
        StatusLabel.TextColor3 = Color3.fromRGB(76, 175, 80)
        return true
    else
        StatusLabel.Text = "❌ No rod! Buy from shop."
        StatusLabel.TextColor3 = Color3.fromRGB(244, 67, 54)
        notify("ERROR", "Buy Fishing Rod first!", 4)
        return false
    end
end

-- Spam All Fishing Remotes + Tool Activate
local function castRod()
    -- Activate tool (pancingan keluar)
    local tool = Character:FindFirstChildOfClass("Tool")
    if tool then
        pcall(function() tool:Activate() end)
    end
    
    -- Spam all possible remotes
    local allArgs = {"CastRod", "Cast", "Fish", "StartFishing", "ThrowRod", "BeginFishing", true}
    for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
        if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") then
            local name = remote.Name:lower()
            if name:find("fish") or name:find("cast") or name:find("rod") or name:find("hook") or name:find("start") then
                for _, arg in pairs(allArgs) do
                    pcall(function()
                        if type(arg) == "table" then
                            remote:FireServer(unpack(arg))
                        else
                            remote:FireServer(arg)
                        end
                    end)
                end
            end
        end
    end
    StatusLabel.Text = "🎣 Casting..."
    StatusLabel.TextColor3 = Color3.fromRGB(66, 165, 245)
end

local function reelIn()
    -- Deactivate tool + reel
    local tool = Character:FindFirstChildOfClass("Tool")
    if tool then
        pcall(function() tool.Deactivate() end)
    end
    
    local allReelArgs = {"ReelIn", "Reel", "Catch", "EndFishing", "Pull", "Harvest", "StopFishing", false}
    for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
        if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") then
            local name = remote.Name:lower()
            if name:find("reel") or name:find("catch") or name:find("end") or name:find("pull") or name:find("stop") then
                for _, arg in pairs(allReelArgs) do
                    pcall(function()
                        if type(arg) == "table" then
                            remote:FireServer(unpack(arg))
                        else
                            remote:FireServer(arg)
                        end
                    end)
                end
            end
        end
    end
    StatusLabel.Text = "🎯 Reeling in!"
    StatusLabel.TextColor3 = Color3.fromRGB(76, 175, 80)
end

local function autoSell()
    local sellArgs = {"SellAll", "SellFish", "Sell", true}
    for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
        if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") then
            local name = remote.Name:lower()
            if name:find("sell") or name:find("shop") then
                for _, arg in pairs(sellArgs) do
                    pcall(function() remote:FireServer(arg) end)
                end
            end
        end
    end
    notify("💰", "Sold all fish!", 2)
end

-- Toggle Button
StartBtn.MouseButton1Click:Connect(function()
    if not checkRod() then return end  -- Check rod first
    
    AutoFishEnabled = not AutoFishEnabled
    StartBtn.Text = AutoFishEnabled and "⏹️ STOP AUTO" or "▶️ START AUTO"
    StartBtn.BackgroundColor3 = AutoFishEnabled and Color3.fromRGB(244, 67, 54) or Color3.fromRGB(76, 175, 80)
    
    if AutoFishEnabled then
        notify("AUTO FISH", "Started! Pancingan should appear.", 3)
        spawn(function()
            while AutoFishEnabled do
                -- Cast
                castRod()
                wait(math.random(40, 60)/10)  -- 4-6s wait for bite
                
                -- Reel (perfect timing)
                reelIn()
                FishCount = FishCount + 1
                StatsLabel.Text = "🐟 Fish: " .. FishCount
                notify("🐟", "Caught +1! Total: " .. FishCount, 1)
                
                wait(math.random(20, 40)/10)  -- 2-4s cooldown
                
                -- Sell every 5 fish
                if FishCount % 5 == 0 then
                    autoSell()
                end
            end
        end)
    else
        notify("AUTO FISH", "Stopped!", 2)
        StatusLabel.Text = "⏹️ Stopped"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
    end
end)

-- Auto check rod on start
checkRod()

-- Update character
Player.CharacterAdded:Connect(function(newChar)
    Character = newChar
    HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
end)

-- Anti AFK
spawn(function()
    while wait(math.random(50, 80)) do
        pcall(function()
            local vu = game:GetService("VirtualUser")
            vu:CaptureController()
            vu:ClickButton2(Vector2.new(math.random(10, 90), math.random(10, 90)))
        end)
    end
end)

notify("🎉 SCRIPT READY", "Equip rod & click START! (Spam method works)", 5)
print("🎣 Universal Spam Script Loaded - Pancingan via Tool Activate!")
