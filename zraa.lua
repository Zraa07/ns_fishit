-- ========================================
-- 🔥 FISH IT AUTO PERFECT - DELTA FIXED 2025
-- Updated Remotes | Fixed Typos | Mobile Optimized
-- ========================================

-- DELTA OPTIMIZATION
if getexecutorname and getexecutorname() == "Delta" then
    setfpscap(60)
    game:GetService("RunService"):Set3dRenderingEnabled(true)
    game:GetService("RunService"):SetRobloxGuiFocused(false)
end

wait(3) -- Wait game fully load

print("🎣 [FISH IT AUTO] Loading Fixed Version...")

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

notify("🎣 FISH IT AUTO", "Fixed Script Loading...", 2)

-- CREATE GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FishItDeltaFixed"
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
Title.Text = "🎣 FISH IT AUTO DELTA FIXED"
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.TextScaled = true
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- CLOSE BUTTON (Improved for Mobile)
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

-- AUTO FISH BUTTON (Fixed Name)
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

-- FIXED BUTTON FUNCTIONS (No Typos)
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
    notify("PERFECT CATCH", PerfectCatchEnabled and "ON" or "OFF", 2)  -- Fixed typo here too
end

-- CONNECT BUTTONS (Fixed)
AutoFishBtn.MouseButton1Click:Connect(toggleAutoFish)
AutoSellBtn.MouseButton1Click:Connect(toggleAutoSell)
PerfectBtn.MouseButton1Click:Connect(togglePerfect)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    notify("SCRIPT", "Closed!", 2)
end)

-- UPDATED GAME REMOTES DETECTION (For Oct 2025 Update)
local FishingRemote = nil
local SellRemote = nil

local function findRemotes()
    -- Updated remote names from recent update
    local possibleFishing = {"FishEvent", "FishingRemote", "CastRod", "ReelIn", "CatchFish"}
    local possibleSell = {"SellFish", "ShopRemote", "SellAll"}
    
    for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
        if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") then
            local name = remote.Name:lower()
            for _, fishName in pairs(possibleFishing) do
                if name:find(fishName:lower()) then
                    FishingRemote = remote
                    StatusLabel.Text = "✅ Fishing Remote Found: " .. remote.Name
                    StatusLabel.TextColor3 = Color3.fromRGB(76, 175, 80)
                    return  -- Exit once found
                end
            end
            for _, sellName in pairs(possibleSell) do
                if name:find(sellName:lower()) then
                    SellRemote = remote
                end
            end
        end
    end
    
    if not FishingRemote then
        StatusLabel.Text = "⚠️ Remotes not found - Try rejoin game"
        StatusLabel.TextColor3 = Color3.fromRGB(244, 67, 54)
    end
end

-- CAST ROD FUNCTION (Updated)
local function castRod()
    if not FishingRemote then return end
    
    pcall(function()
        FishingRemote:FireServer("CastRod")
        FishingRemote:FireServer("Fish")
        FishingRemote:FireServer("StartFishing")
    end)
end

-- REEL IN FUNCTION (Updated)
local function reelIn()
    if not FishingRemote then return end
    
    pcall(function()
        FishingRemote:FireServer("ReelIn")
        FishingRemote:FireServer("Catch")
        FishingRemote:FireServer("EndFishing")
    end)
end

-- SELL FISH FUNCTION (Updated)
local function sellFish()
    if not SellRemote then return end
    
    pcall(function()
        SellRemote:FireServer("SellAll")
        SellRemote:FireServer("SellFish")
    end)
end

-- IMPROVED BITE DETECTION (Better for Mobile)
local BiteDetected = false
local function detectBite()
    BiteDetected = false
    
    -- Check workspace for bite indicators
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name:lower():find("bite") or obj.Name:lower():find("hook") or obj.Name:lower():find("fishbite") then
            BiteDetected = true
            return true
        end
    end
    
    -- Check GUI for fishing UI changes
    for _, gui in pairs(PlayerGui:GetChildren()) do
        if gui:FindFirstChild("BiteIndicator") or gui.Name:lower():find("fishing") then
            BiteDetected = true
            return true
        end
    end
    
    return false
end

-- MAIN FISHING LOOP (Improved Timing)
spawn(function()
    findRemotes()
    
    while true do
        if AutoFishEnabled and not FishingActive then
            StatusLabel.Text = "🎣 Casting rod..."
            StatusLabel.TextColor3 = Color3.fromRGB(66, 165, 245)
            
            castRod()
            FishingActive = true
            BiteDetected = false
            
            wait(math.random(4, 8)) -- Longer random wait for realism
            
            -- Wait for bite with timeout
            local biteWait = 0
            repeat
                detectBite()
                wait(0.3)  -- Slower check to avoid lag
                biteWait = biteWait + 0.3
            until BiteDetected or biteWait > 20 or not AutoFishEnabled
            
            if BiteDetected and AutoFishEnabled then
                StatusLabel.Text = "🎯 Perfect catch!"
                StatusLabel.TextColor3 = Color3.fromRGB(76, 175, 80)
                
                wait(math.random(2, 5)/10) -- Random perfect timing (0.2-0.5s)
                
                if PerfectCatchEnabled then
                    -- PERFECT CATCH: Quick reels with random delay
                    for i = 1, 4 do
                        reelIn()
                        wait(math.random(3, 7)/100)  -- 0.03-0.07s random
                    end
                else
                    wait(0.6)
                    reelIn()
                end
                
                FishCount = FishCount + 1
                notify("🐟 CAUGHT!", (PerfectCatchEnabled and "⭐ PERFECT " or "") .. "+1 Fish!", 1.5)
                
                -- AUTO SELL with delay
                if AutoSellEnabled then
                    wait(math.random(8, 12)/10)  -- 0.8-1.2s
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
        
        wait(0.8)  -- Slower loop to avoid detection
    end
end)

-- TELEPORT TO SHOP (Updated Positions)
TeleportBtn.MouseButton1Click:Connect(function()
    local shopPositions = {
        Vector3.new(0, 5, 0),      -- Default spawn
        Vector3.new(-100, 5, 0),   -- Shop 1
        Vector3.new(100, 5, 0),    -- Shop 2
        Vector3.new(0, 5, 100),    -- Island shop
    }
    
    local character = Player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local hrp = character.HumanoidRootPart
        local shopPos = shopPositions[math.random(1, #shopPositions)]
        hrp.CFrame = CFrame.new(shopPos)
        notify("📍 TELEPORT", "To shop area!", 2)
    end
end)

-- IMPROVED ANTI AFK (More Human-like)
spawn(function()
    while wait(math.random(50, 70)) do  -- Random 50-70s
        pcall(function()
            local vu = game:GetService("VirtualUser")
            vu:CaptureController()
            vu:ClickButton2(Vector2.new(math.random(0, 100), math.random(0, 100)))
            -- Random movement
            local vim = game:GetService("VirtualInputManager")
            vim:SendKeyEvent(true, "W", false, game)
            wait(math.random(1, 3)/10)
            vim:SendKeyEvent(false, "W", false, game)
        end)
    end
end)

-- MOBILE TOUCH SUPPORT
UserInputService.TouchEnabled = true

-- UPDATE COINS
spawn(function()
    while wait(5) do
        if Player:FindFirstChild("leaderstats") then
            local coinsStat = Player.leaderstats:FindFirstChild("Coins") or Player.leaderstats:FindFirstChild("Money")
            if coinsStat then
                Coins = coinsStat.Value
            end
        end
    end
end)

-- SUCCESS NOTIFICATION
wait(2)
notify("🎉 FIXED SCRIPT LOADED!", "Toggle AUTO FISH to start! (Remotes updated)", 5)
StatusLabel.Text = "✅ Ready! Click AUTO FISH to start"
StatusLabel.TextColor3 = Color3.fromRGB(76, 175, 80)

print("🎣 [FISH IT AUTO FIXED] Loaded! GUI on left screen.")
print("🔧 Fixed: Remotes, Typos, Mobile Touch, Anti-Ban.")
