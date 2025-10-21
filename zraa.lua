-- ========================================
-- 🔥 FISH IT AUTO PERFECT - DELTA ANDROID
-- Optimized for Delta Executor | October 2025
-- ========================================

-- DELTA OPTIMIZATION
if getexecutorname and getexecutorname() == "Delta" then
    setfpscap(60)
    game:GetService("RunService"):Set3dRenderingEnabled(true)
    game:GetService("RunService"):SetRobloxGuiFocused(false)
end

wait(3) -- Wait game fully load

print("🎣 [FISH IT AUTO] Loading...")

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- VARIABLES
local AutoFishEnabled = false
local AutoSellEnabled = false
local PerfectCatchEnabled = false
local FishingActive = false
local FishCount = 0
local Coins = 0

-- NOTIFICATION SYSTEM
local function notify(title, text, duration)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title;
            Text = text;
            Duration = duration or 3;
        })
    end)
end

notify("🎣 FISH IT AUTO", "Script Loading...", 2)

-- CREATE GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FishItDelta"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 1000
ScreenGui.Parent = PlayerGui

-- MAIN FRAME
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 320, 0, 380)
MainFrame.Position = UDim2.new(0, 10, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- CORNERS
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame

-- SHADOW
local Shadow = Instance.new("Frame")
Shadow.Size = UDim2.new(1, 10, 1, 10)
Shadow.Position = UDim2.new(0, -5, 0, -5)
Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Shadow.BackgroundTransparency = 0.7
Shadow.ZIndex = MainFrame.ZIndex - 1
Shadow.Parent = MainFrame

local ShadowCorner = Instance.new("UICorner")
ShadowCorner.CornerRadius = UDim.new(0, 16)
ShadowCorner.Parent = Shadow

-- TITLE BAR
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 60)
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 16)
TitleCorner.Parent = TitleBar

-- TITLE TEXT
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -80, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.Text = "🎣 FISH IT AUTO DELTA"
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.TextScaled = true
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- CLOSE BUTTON
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -45, 0, 10)
CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
CloseBtn.BorderSizePixel = 0
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextScaled = true
CloseBtn.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseBtn

-- STATUS LABEL
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -20, 0, 35)
StatusLabel.Position = UDim2.new(0, 10, 0, 70)
StatusLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
StatusLabel.BorderSizePixel = 0
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = "⏳ Loading game remotes..."
StatusLabel.TextColor3 = Color3.fromRGB(255, 193, 7)
StatusLabel.TextScaled = true
StatusLabel.Parent = MainFrame

local StatusCorner = Instance.new("UICorner")
StatusCorner.CornerRadius = UDim.new(0, 8)
StatusCorner.Parent = StatusLabel

-- STATS LABEL
local StatsLabel = Instance.new("TextLabel")
StatsLabel.Size = UDim2.new(1, -20, 0, 30)
StatsLabel.Position = UDim2.new(0, 10, 0, 115)
StatsLabel.BackgroundTransparency = 1
StatsLabel.Font = Enum.Font.Gotham
StatsLabel.Text = "🐟 Fish: 0 | 💰 Coins: 0"
StatsLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
StatsLabel.TextScaled = true
StatsLabel.TextXAlignment = Enum.TextXAlignment.Left
StatsLabel.Parent = MainFrame

-- AUTO FISH BUTTON
local AutoFishBtn = Instance.new("TextButton")
AutoFishBtn.Size = UDim2.new(1, -20, 0, 45)
AutoFishBtn.Position = UDim2.new(0, 10, 0, 155)
AutoFishBtn.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
AutoFishBtn.BorderSizePixel = 0
AutoFishBtn.Font = Enum.Font.GothamBold
AutoFishBtn.Text = "🚫 AUTO FISH: OFF"
AutoFishBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoFishBtn.TextScaled = true
AutoFishBtn.Parent = MainFrame

local AFBtnCorner = Instance.new("UICorner")
AFBtnCorner.CornerRadius = UDim.new(0, 10)
AFBtnCorner.Parent = AutoFishBtn

-- AUTO SELL BUTTON
local AutoSellBtn = Instance.new("TextButton")
AutoSellBtn.Size = UDim2.new(1, -20, 0, 45)
AutoSellBtn.Position = UDim2.new(0, 10, 0, 210)
AutoSellBtn.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
AutoSellBtn.BorderSizePixel = 0
AutoSellBtn.Font = Enum.Font.GothamBold
AutoSellBtn.Text = "🚫 AUTO SELL: OFF"
AutoSellBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoSellBtn.TextScaled = true
AutoSellBtn.Parent = MainFrame

local ASBtnCorner = Instance.new("UICorner")
ASBtnCorner.CornerRadius = UDim.new(0, 10)
ASBtnCorner.Parent = AutoSellBtn

-- PERFECT CATCH BUTTON
local PerfectBtn = Instance.new("TextButton")
PerfectBtn.Size = UDim2.new(1, -20, 0, 45)
PerfectBtn.Position = UDim2.new(0, 10, 0, 265)
PerfectBtn.BackgroundColor3 = Color3.fromRGB(156, 39, 176)
PerfectBtn.BorderSizePixel = 0
PerfectBtn.Font = Enum.Font.GothamBold
PerfectBtn.Text = "🚫 PERFECT CATCH: OFF"
PerfectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
PerfectBtn.TextScaled = true
PerfectBtn.Parent = MainFrame

local PBtnCorner = Instance.new("UICorner")
PBtnCorner.CornerRadius = UDim.new(0, 10)
PBtnCorner.Parent = PerfectBtn

-- TELEPORT BUTTON
local TeleportBtn = Instance.new("TextButton")
TeleportBtn.Size = UDim2.new(1, -20, 0, 45)
TeleportBtn.Position = UDim2.new(0, 10, 0, 320)
TeleportBtn.BackgroundColor3 = Color3.fromRGB(33, 150, 243)
TeleportBtn.BorderSizePixel = 0
TeleportBtn.Font = Enum.Font.GothamBold
TeleportBtn.Text = "📍 TELEPORT SHOP"
TeleportBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportBtn.TextScaled = true
TeleportBtn.Parent = MainFrame

local TBtnCorner = Instance.new("UICorner")
TBtnCorner.CornerRadius = UDim.new(0, 10)
TBtnCorner.Parent = TeleportBtn

-- BUTTON FUNCTIONS
local function toggleAutoFish()
    AutoFishEnabled = not AutoFishEnabled
    AutoFishBtn.Text = AutoFishEnabled and "✅ AUTO FISH: ON" or "🚫 AUTO FISH: OFF"
    AutoFishBtn.BackgroundColor3 = AutoFishEnabled and Color3.fromRGB(46, 125, 50) or Color3.fromRGB(244, 67, 54)
    notify("AUTO FISH", AutoFishEnabled and "ON" or "OFF", 2)
end

local function toggleAutoSell()
    AutoSellEnabled = not AutoSellEnabled
    AutoSellBtn.Text = AutoSellEnabled and "✅ AUTO SELL: ON" or "🚫 AUTO SELL: OFF"
    AutoSellBtn.BackgroundColor3 = AutoSellEnabled and Color3.fromRGB(46, 125, 50) or Color3.fromRGB(244, 67, 54)
    notify("AUTO SELL", AutoSellEnabled and "ON" or "OFF", 2)
end

local function togglePerfect()
    PerfectCatchEnabled = not PerfectCatchEnabled
    PerfectBtn.Text = PerfectCatchEnabled and "✅ PERFECT CATCH: ON" or "🚫 PERFECT CATCH: OFF"
    PerfectBtn.BackgroundColor3 = PerfectCatchEnabled and Color3.fromRGB(156, 39, 176) or Color3.fromRGB(108, 29, 123)
    notify("PERFECT CATCH", PerfectCatchEnabled and "ON" or "OFF", 2)
end

-- CONNECT BUTTONS
AutoFishBtn.MouseButton1Click:Connect(toggleAutoFish)
AutoSellBtn.MouseButton1Click:Connect(toggleAutoSell)
PerfectBtn.MouseButton1Click:Connect(togglePerfect)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    notify("SCRIPT", "Closed!", 2)
end)

-- GAME REMOTES DETECTION
local FishingRemote = nil
local SellRemote = nil

local function findRemotes()
    for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
        if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") then
            local name = remote.Name:lower()
            if name:find("fish") or name:find("cast") or name:find("reel") then
                FishingRemote = remote
                StatusLabel.Text = "✅ Fishing Remote: " .. remote.Name
                StatusLabel.TextColor3 = Color3.fromRGB(76, 175, 80)
            elseif name:find("sell") or name:find("shop") then
                SellRemote = remote
            end
        end
    end
    
    if not FishingRemote then
        StatusLabel.Text = "⚠️ Auto searching remotes..."
        StatusLabel.TextColor3 = Color3.fromRGB(255, 193, 7)
    end
end

-- CAST ROD FUNCTION
local function castRod()
    if not FishingRemote then return end
    
    pcall(function()
        FishingRemote:FireServer("CastRod", {})
        -- Alternative methods
        FishingRemote:FireServer("Cast", {})
        FishingRemote:FireServer("Fish", {})
    end)
end

-- REEL IN FUNCTION
local function reelIn()
    if not FishingRemote then return end
    
    pcall(function()
        FishingRemote:FireServer("ReelIn", {})
        FishingRemote:FireServer("Reel", {})
        FishingRemote:FireServer("Catch", {})
    end)
end

-- SELL FISH FUNCTION
local function sellFish()
    if not SellRemote then return end
    
    pcall(function()
        SellRemote:FireServer("SellAll", {})
        SellRemote:FireServer("Sell", {})
    end)
end

-- PERFECT CATCH DETECTION
local BiteDetected = false
local function detectBite()
    -- Method 1: Check workspace objects
    for _, obj in pairs(workspace:GetChildren()) do
        if obj.Name:lower():find("bite") or obj.Name:lower():find("fish") then
            BiteDetected = true
            return true
        end
    end
    
    -- Method 2: Check player GUI
    for _, gui in pairs(PlayerGui:GetChildren()) do
        if gui.Name:lower():find("bite") or gui.Name:lower():find("fishing") then
            BiteDetected = true
            return true
        end
    end
    
    return false
end

-- MAIN FISHING LOOP
spawn(function()
    findRemotes()
    
    while true do
        if AutoFishEnabled and not FishingActive then
            StatusLabel.Text = "🎣 Casting rod..."
            StatusLabel.TextColor3 = Color3.fromRGB(66, 165, 245)
            
            castRod()
            FishingActive = true
            BiteDetected = false
            
            wait(math.random(3, 7)) -- Random wait for bite
            
            -- Wait for bite
            local biteWait = 0
            repeat
                detectBite()
                wait(0.2)
                biteWait = biteWait + 0.2
            until BiteDetected or biteWait > 15 or not AutoFishEnabled
            
            if BiteDetected and AutoFishEnabled then
                StatusLabel.Text = "🎯 Perfect catch!"
                StatusLabel.TextColor3 = Color3.fromRGB(76, 175, 80)
                
                wait(0.3) -- Perfect timing
                
                if PerfectCatchEnabled then
                    -- PERFECT CATCH: Multiple quick reels
                    for i = 1, 5 do
                        reelIn()
                        wait(0.05)
                    end
                else
                    -- NORMAL CATCH
                    wait(0.5)
                    reelIn()
                end
                
                FishCount = FishCount + 1
                notify("🐟 CAUGHT!", "+" .. (PerfectCatchEnabled and "PERFECT " or "") .. "Fish!", 1.5)
                
                -- AUTO SELL
                if AutoSellEnabled then
                    wait(1)
                    sellFish()
                end
            else
                StatusLabel.Text = "❌ No bite, recasting..."
                StatusLabel.TextColor3 = Color3.fromRGB(244, 67, 54)
            end
            
            FishingActive = false
            BiteDetected = false
        end
        
        -- Update stats
        StatsLabel.Text = "🐟 Fish: " .. FishCount .. " | 💰 Coins: " .. Coins
        
        wait(0.5)
    end
end)

-- TELEPORT TO SHOP
TeleportBtn.MouseButton1Click:Connect(function()
    -- Common shop positions
    local shopPositions = {
        Vector3.new(0, 10, 0),
        Vector3.new(-50, 10, 0),
        Vector3.new(50, 10, 0),
        Vector3.new(0, 10, 50),
    }
    
    local character = Player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local hrp = character.HumanoidRootPart
        local shopPos = shopPositions[math.random(1, #shopPositions)]
        hrp.CFrame = CFrame.new(shopPos)
        notify("📍 TELEPORT", "Shop area!", 2)
    end
end)

-- ANTI AFK SYSTEM
spawn(function()
    while wait(60) do
        pcall(function()
            local vu = game:GetService("VirtualUser")
            vu:CaptureController()
            vu:ClickButton2(Vector2.new())
            game:GetService("VirtualInputManager"):SendKeyEvent(true, "W", false, game)
            wait(0.1)
            game:GetService("VirtualInputManager"):SendKeyEvent(false, "W", false, game)
        end)
    end
end)

-- MOBILE TOUCH SUPPORT
UserInputService.TouchEnabled = true

-- UPDATE COINS (WIP)
spawn(function()
    while wait(5) do
        -- Try to get coin count from leaderstats
        if Player:FindFirstChild("leaderstats") then
            local coinsStat = Player.leaderstats:FindFirstChild("Coins")
            if coinsStat then
                Coins = coinsStat.Value
            end
        end
    end
end)

-- SUCCESS NOTIFICATION
wait(2)
notify("🎉 SCRIPT LOADED!", "Tap AUTO FISH to start!", 5)
StatusLabel.Text = "✅ Ready! Tap AUTO FISH to start"
StatusLabel.TextColor3 = Color3.fromRGB(76, 175, 80)

print("🎣 [FISH IT AUTO] Script loaded successfully!")
print("📱 GUI: Left side of screen")
print("🔧 Features: Auto Fish, Auto Sell, Perfect Catch, Teleport")
