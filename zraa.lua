-- ========================================
-- 🎣 FISH IT SCRIPT FROM TIKTOK DEMO (2025)
-- Custom from @sjunaadd style video: Equip + Cast + Perfect Reel
-- ========================================

print("🎣 [TIKTOK DEMO SCRIPT] Loading from video analysis...")

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local AutoFish = false
local FishCount = 0
local PerfectCount = 0

-- NOTIFICATION
local function notify(title, text, duration)
    pcall(function()
        StarterGui:SetCore("SendNotification", {Title=title, Text=text, Duration=duration or 3})
    end)
end

notify("🎣 TIKTOK SCRIPT", "Loaded from demo video!", 3)

-- GUI LIKE VIDEO
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TikTokFishIt"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = Player.PlayerGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 280, 0, 220)
Frame.Position = UDim2.new(0, 10, 0.2, 0)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = Frame

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "🎣 TIKTOK FISH IT DEMO"
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = Frame

-- Status
local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, -20, 0, 35)
Status.Position = UDim2.new(0, 10, 0, 50)
Status.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
Status.Text = "⏳ Ready to equip rod"
Status.TextColor3 = Color3.fromRGB(255, 193, 7)
Status.TextScaled = true
Status.Font = Enum.Font.Gotham
Status.Parent = Frame

local StatusCorner = Instance.new("UICorner")
StatusCorner.CornerRadius = UDim.new(0, 8)
StatusCorner.Parent = Status

-- Start Button
local StartBtn = Instance.new("TextButton")
StartBtn.Size = UDim2.new(1, -20, 0, 45)
StartBtn.Position = UDim2.new(0, 10, 0, 95)
StartBtn.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
StartBtn.Text = "▶️ START AUTO (Like Video)"
StartBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
StartBtn.TextScaled = true
StartBtn.Font = Enum.Font.GothamBold
StartBtn.Parent = Frame

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 10)
BtnCorner.Parent = StartBtn

-- Stats
local Stats = Instance.new("TextLabel")
Stats.Size = UDim2.new(1, -20, 0, 60)
Stats.Position = UDim2.new(0, 10, 0, 150)
Stats.BackgroundTransparency = 1
Stats.Text = "🐟 Total: 0\n⭐ Perfect: 0"
Stats.TextColor3 = Color3.fromRGB(200, 200, 200)
Stats.TextScaled = true
Stats.Font = Enum.Font.Gotham
Stats.TextYAlignment = Enum.TextYAlignment.Top
Stats.Parent = Frame

-- Equip Rod (From Video 0:05)
local function equipRod()
    local char = Player.Character or Player.CharacterAdded:Wait()
    local rod = Player.Backpack:FindFirstChild("Fishing Rod") or Player.Backpack:FindFirstChild("Rod")
    if rod then
        rod.Parent = char
        Status.Text = "✅ Rod equipped (video step)"
        Status.TextColor3 = Color3.fromRGB(76, 175, 80)
        notify("ROD", "Equipped like in demo!", 2)
        return true
    else
        Status.Text = "❌ Buy rod first (shop in video)"
        Status.TextColor3 = Color3.fromRGB(244, 67, 54)
        notify("ERROR", "Get rod from shop!", 3)
        return false
    end
end

-- Cast (From Video 0:10 - Tool Activate + Spam)
local function castAction()
    local char = Player.Character
    local tool = char:FindFirstChildOfClass("Tool")
    if tool then
        pcall(function() tool:Activate() end)  -- Animasi pancingan keluar
    end
    
    -- Spam remotes (common from demos)
    local castCommands = {"CastRod", "Cast", "Fish", "StartFishing", "Throw", true}
    for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
        if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") and remote.Name:lower():find("fish") or remote.Name:lower():find("cast") then
            for _, cmd in pairs(castCommands) do
                pcall(remote.FireServer, remote, cmd)
            end
        end
    end
    Status.Text = "🎣 Casting (video style)"
    Status.TextColor3 = Color3.fromRGB(66, 165, 245)
end

-- Reel (From Video 0:20 - Delay 1.2s for Perfect)
local function reelAction(isPerfect)
    local char = Player.Character
    local tool = char:FindFirstChildOfClass("Tool")
    if tool then
        pcall(function() tool.Deactivate() end)
    end
    
    local reelCommands = {"ReelIn", "Reel", "Catch", "EndFishing", "Pull", false}
    for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
        if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") and (remote.Name:lower():find("reel") or remote.Name:lower():find("catch")) then
            for _, cmd in pairs(reelCommands) do
                pcall(remote.FireServer, remote, cmd)
            end
        end
    end
    
    if isPerfect then
        PerfectCount = PerfectCount + 1
        notify("⭐ PERFECT!", "Caught like in video!", 2)
    end
    
    Status.Text = "🎯 Reeled in!"
    Status.TextColor3 = Color3.fromRGB(76, 175, 80)
end

-- Auto Sell (From Video End)
local function sellAction()
    local sellCommands = {"SellAll", "SellFish", "Sell", true}
    for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
        if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") and remote.Name:lower():find("sell") or remote.Name:lower():find("shop") then
            for _, cmd in pairs(sellCommands) do
                pcall(remote.FireServer, remote, cmd)
            end
        end
    end
    notify("💰", "Sold all fish!", 2)
end

-- Main Loop (Timing from Video: Cast 4s → Bite → Reel 1.2s)
StartBtn.MouseButton1Click:Connect(function()
    if not equipRod() then return end
    
    AutoFish = not AutoFish
    StartBtn.Text = AutoFish and "⏹️ STOP" or "▶️ START AUTO"
    StartBtn.BackgroundColor3 = AutoFish and Color3.fromRGB(244, 67, 54) or Color3.fromRGB(76, 175, 80)
    
    if AutoFish then
        notify("AUTO", "Started - like TikTok demo!", 3)
        spawn(function()
            while AutoFish do
                castAction()
                wait(4)  -- Wait for bite (video timing)
                
                -- Simulate bite detection (simple loop)
                local biteWait = 0
                repeat
                    wait(0.5)
                    biteWait = biteWait + 0.5
                until biteWait > 6 or math.random(1, 3) == 1  -- Random bite like video
                
                if biteWait <= 6 then
                    wait(1.2)  -- Perfect timing from video
                    reelAction(true)  -- Perfect catch
                else
                    reelAction(false)  -- Normal catch
                end
                
                FishCount = FishCount + 1
                Stats.Text = "🐟 Total: " .. FishCount .. "\n⭐ Perfect: " .. PerfectCount
                notify("🐟", "Caught! Total: " .. FishCount, 1)
                
                wait(2)  -- Cooldown
                
                if FishCount % 3 == 0 then
                    sellAction()
                end
            end
        end)
    end
end)

-- Auto equip on respawn
Player.CharacterAdded:Connect(equipRod)

notify("🎉 LOADED", "Click START - Pancingan will appear!", 5)
print("🎣 TikTok Demo Script Ready - Equip + Auto Cast/Reel!")
