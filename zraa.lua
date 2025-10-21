-- 🎣 FISH IT - ROD EQUIP + AUTO CAST (100% Work)
print("🎣 [ROD EQUIP AUTO] Loading...")

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local Player = Players.LocalPlayer

local AutoFish = false
local FishCount = 0

local function notify(title, text, duration)
    pcall(function()
        StarterGui:SetCore("SendNotification", {Title=title, Text=text, Duration=duration or 3})
    end)
end

-- GUI SIMPEL
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FishItFix"
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 280, 0, 220)
Frame.Position = UDim2.new(0, 10, 0.3, 0)
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
Title.Text = "🎣 FISH IT ROD FIX"
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = Frame

-- Status
local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, -20, 0, 35)
Status.Position = UDim2.new(0, 10, 0, 50)
Status.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
Status.Text = "⏳ Equip rod first..."
Status.TextColor3 = Color3.fromRGB(255, 193, 7)
Status.TextScaled = true
Status.Font = Enum.Font.Gotham
Status.Parent = Frame

local StatusCorner = Instance.new("UICorner")
StatusCorner.CornerRadius = UDim.new(0, 8)
StatusCorner.Parent = Status

-- Toggle Button
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(1, -20, 0, 45)
ToggleBtn.Position = UDim2.new(0, 10, 0, 95)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
ToggleBtn.Text = "🎣 EQUIP ROD & START"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextScaled = true
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.Parent = Frame

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 10)
BtnCorner.Parent = ToggleBtn

-- Stats
local Stats = Instance.new("TextLabel")
Stats.Size = UDim2.new(1, -20, 0, 30)
Stats.Position = UDim2.new(0, 10, 0, 150)
Stats.BackgroundTransparency = 1
Stats.Text = "🐟 Fish: 0"
Stats.TextColor3 = Color3.fromRGB(200, 200, 200)
Stats.TextScaled = true
Stats.Font = Enum.Font.Gotham
Stats.Parent = Frame

-- ROD EQUIP FUNCTION
local function equipRod()
    local character = Player.Character
    if not character then return false end
    
    -- Cek backpack
    local rod = Player.Backpack:FindFirstChild("Fishing Rod") or 
                Player.Backpack:FindFirstChild("Rod") or
                Player.Backpack:FindFirstChild("FishingRod")
    
    if rod then
        -- Equip rod
        rod.Parent = character
        Status.Text = "✅ Rod equipped!"
        Status.TextColor3 = Color3.fromRGB(76, 175, 80)
        notify("ROD", "Equipped fishing rod!", 2)
        return true
    else
        Status.Text = "❌ No rod in backpack!"
        Status.TextColor3 = Color3.fromRGB(244, 67, 54)
        notify("ERROR", "Get fishing rod first from shop!", 3)
        return false
    end
end

-- UNIVERSAL
