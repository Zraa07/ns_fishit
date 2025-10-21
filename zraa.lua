-- ========================================
-- FISH IT AUTO MANCING PERFECT - NO KEY
-- Made by Grok AI - October 2025
-- ========================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local AutoFishBtn = Instance.new("TextButton")
local AutoSellBtn = Instance.new("TextButton")
local PerfectCatchBtn = Instance.new("TextButton")
local StatusLabel = Instance.new("TextLabel")

-- Variables
local AutoFishEnabled = false
local AutoSellEnabled = false
local PerfectCatchEnabled = false
local Fishing = false
local FishCaught = 0

-- GUI Setup
ScreenGui.Name = "FishItAuto"
ScreenGui.Parent = Player:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.02, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 250, 0, 300)
MainFrame.Active = true
MainFrame.Draggable = true

-- Corner Radius
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = MainFrame

-- Title
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Title.BorderSizePixel = 0
Title.Position = UDim2.new(0, 0, 0, 0)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Font = Enum.Font.GothamBold
Title.Text = "🎣 FISH IT AUTO"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = Title

-- Status
StatusLabel.Name = "StatusLabel"
StatusLabel.Parent = MainFrame
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0, 10, 0, 60)
StatusLabel.Size = UDim2.new(1, -20, 0, 30)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = "Status: Ready | Fish: 0"
StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
StatusLabel.TextScaled = true
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Auto Fish Button
AutoFishBtn.Name = "AutoFishBtn"
AutoFishBtn.Parent = MainFrame
AutoFishBtn.BackgroundColor3 = Color3.fromRGB(46, 125, 50)
AutoFishBtn.BorderSizePixel = 0
AutoFishBtn.Position = UDim2.new(0, 10, 0, 100)
AutoFishBtn.Size = UDim2.new(1, -20, 0, 40)
AutoFishBtn.Font = Enum.Font.GothamBold
AutoFishBtn.Text = "🚫 AUTO FISH: OFF"
AutoFishBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoFishBtn.TextScaled = true

local AFCorner = Instance.new("UICorner")
AFCorner.CornerRadius = UDim.new(0, 8)
AFCorner.Parent = AutoFishBtn

-- Auto Sell Button
AutoSellBtn.Name = "AutoSellBtn"
AutoSellBtn.Parent = MainFrame
AutoSellBtn.BackgroundColor3 = Color3.fromRGB(46, 125, 50)
AutoSellBtn.BorderSizePixel = 0
AutoSellBtn.Position = UDim2.new(0, 10, 0, 150)
AutoSellBtn.Size = UDim2.new(1, -20, 0, 40)
AutoSellBtn.Font = Enum.Font.GothamBold
AutoSellBtn.Text = "🚫 AUTO SELL: OFF"
AutoSellBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoSellBtn.TextScaled = true

local ASCorner = Instance.new("UICorner")
ASCorner.CornerRadius = UDim.new(0, 8)
ASCorner.Parent = AutoSellBtn

-- Perfect Catch Button
PerfectCatchBtn.Name = "PerfectCatchBtn"
PerfectCatchBtn.Parent = MainFrame
PerfectCatchBtn.BackgroundColor3 = Color3.fromRGB(46, 125, 50)
PerfectCatchBtn.BorderSizePixel = 0
PerfectCatchBtn.Position = UDim2.new(0, 10, 0, 200)
PerfectCatchBtn.Size = UDim2.new(1, -20, 0, 40)
PerfectCatchBtn.Font = Enum.Font.GothamBold
PerfectCatchBtn.Text = "🚫 PERFECT CATCH: OFF"
PerfectCatchBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
PerfectCatchBtn.TextScaled = true

local PCCorner = Instance.new("UICorner")
PCCorner.CornerRadius = UDim.new(0, 8)
PCCorner.Parent = PerfectCatchBtn

-- Button Functions
local function toggleAutoFish()
    AutoFishEnabled = not AutoFishEnabled
    AutoFishBtn.Text = AutoFishEnabled and "✅ AUTO FISH: ON" or "🚫 AUTO FISH: OFF"
    AutoFishBtn.BackgroundColor3 = AutoFishEnabled and Color3.fromRGB(76, 175, 80) or Color3.fromRGB(244, 67, 54)
end

local function toggleAutoSell()
    AutoSellEnabled = not AutoSellEnabled
    AutoSellBtn.Text = AutoSellEnabled and "✅ AUTO SELL: ON" or "🚫 AUTO SELL: OFF"
    AutoSellBtn.BackgroundColor3 = AutoSellEnabled and Color3.fromRGB(76, 175, 80) or Color3.fromRGB(244, 67, 54)
end

local function togglePerfectCatch()
    PerfectCatchEnabled = not PerfectCatchEnabled
    PerfectCatchBtn.Text = PerfectCatchEnabled and "✅ PERFECT CATCH: ON" or "🚫 PERFECT CATCH: OFF"
    PerfectCatchBtn.BackgroundColor3 = PerfectCatchEnabled and Color3.fromRGB(76, 175, 80) or Color3.fromRGB(244, 67, 54)
end

AutoFishBtn.MouseButton1Click:Connect(toggleAutoFish)
AutoSellBtn.MouseButton1Click:Connect(toggleAutoSell)
PerfectCatchBtn.MouseButton1Click:Connect(togglePerfectCatch)

-- Fishing Functions
local function castRod()
    -- Simulate casting rod (adjust based on game)
    local args = {
        [1] = "CastRod",
        [2] = {}
    }
    ReplicatedStorage.Remotes.FishingRemote:FireServer(unpack(args))
end

local function reelIn()
    local args = {
        [1] = "ReelIn",
        [2] = {}
    }
    ReplicatedStorage.Remotes.FishingRemote:FireServer(unpack(args))
end

local function sellFish()
    local args = {
        [1] = "SellFish",
        [2] = {}
    }
    ReplicatedStorage.Remotes.ShopRemote:FireServer(unpack(args))
end

-- Auto Perfect Catch Detection
local PerfectTiming = false
local BiteDetected = false

local function detectBite()
    -- Monitor for bite indicator (adjust for Fish It)
    for _, v in pairs(workspace:GetChildren()) do
        if v.Name:find("Bite") or v.Name:find("Fish") then
            BiteDetected = true
            break
        end
    end
end

-- Main Fishing Loop
spawn(function()
    while true do
        if AutoFishEnabled and not Fishing then
            StatusLabel.Text = "Status: Casting... | Fish: " .. FishCaught
            castRod()
            Fishing = true
            wait(2) -- Wait for cast animation
            
            -- Wait for bite
            repeat
                detectBite()
                wait(0.1)
            until BiteDetected or not AutoFishEnabled
            
            if BiteDetected and AutoFishEnabled then
                StatusLabel.Text = "Status: Perfect Catch! | Fish: " .. FishCaught
                wait(0.5) -- Perfect timing delay
                
                if PerfectCatchEnabled then
                    -- Perfect catch timing
                    reelIn()
                    wait(0.1)
                    -- Multiple quick reels for perfect
                    for i = 1, 3 do
                        reelIn()
                        wait(0.05)
                    end
                else
                    reelIn()
                end
                
                FishCaught = FishCaught + 1
                Fishing = false
                BiteDetected = false
                
                -- Auto sell
                if AutoSellEnabled then
                    wait(1)
                    sellFish()
                end
            else
                Fishing = false
                BiteDetected = false
            end
        end
        
        -- Anti AFK
        if AutoFishEnabled then
            local vu = game:GetService("VirtualUser")
            vu:CaptureController()
            vu:ClickButton2(Vector2.new())
        end
        
        wait(0.5)
    end
end)

-- Update Status
spawn(function()
    while true do
        if Fishing then
            StatusLabel.TextColor3 = Color3.fromRGB(255, 193, 7)
        elseif AutoFishEnabled then
            StatusLabel.TextColor3 = Color3.fromRGB(76, 175, 80)
        else
            StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
        wait(1)
    end
end)

-- Handle Character Respawn
Player.CharacterAdded:Connect(function(newChar)
    Character = newChar
    Humanoid = Character:WaitForChild("Humanoid")
end)

print("🎣 Fish It Auto Script Loaded! No Key Required!")
StatusLabel.Text = "Status: Script Loaded! | Fish: 0"