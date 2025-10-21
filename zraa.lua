-- Fish It Universal Auto Farm (Custom for Delta 2025)
-- Features: Auto Cast/Reel, Sell, TP | No External Load

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local isAutoFishing = false
local bobber = nil

-- GUI Setup (Simple ScreenGui)
local screenGui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0, 10, 0, 10)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.Parent = screenGui
screenGui.Parent = player:WaitForChild("PlayerGui")

local autoFishBtn = Instance.new("TextButton")
autoFishBtn.Size = UDim2.new(0, 120, 0, 30)
autoFishBtn.Position = UDim2.new(0, 10, 0, 10)
autoFishBtn.Text = "Auto Fish: OFF"
autoFishBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
autoFishBtn.Parent = frame

local autoSellBtn = Instance.new("TextButton")
autoSellBtn.Size = UDim2.new(0, 120, 0, 30)
autoSellBtn.Position = UDim2.new(0, 140, 0, 10)
autoSellBtn.Text = "Auto Sell: OFF"
autoSellBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
autoSellBtn.Parent = frame

local tpBtn = Instance.new("TextButton")
tpBtn.Size = UDim2.new(0, 280, 0, 30)
tpBtn.Position = UDim2.new(0, 10, 0, 50)
tpBtn.Text = "Teleport to Spawn"
tpBtn.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
tpBtn.Parent = frame

local infJumpBtn = Instance.new("TextButton")
infJumpBtn.Size = UDim2.new(0, 280, 0, 30)
infJumpBtn.Position = UDim2.new(0, 10, 0, 90)
infJumpBtn.Text = "Infinite Jump: OFF"
infJumpBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
infJumpBtn.Parent = frame

-- Functions
local function findRemote(name)
    for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
        if obj:IsA("RemoteEvent") and obj.Name:lower():find(name) then
            return obj
        end
    end
    return nil
end

local function castRod()
    local castRemote = findRemote("cast") or findRemote("fish")
    if castRemote then castRemote:FireServer() end
end

local function reelIn()
    local reelRemote = findRemote("reel") or findRemote("catch")
    if reelRemote then reelRemote:FireServer() end
end

local function sellFish()
    local sellRemote = findRemote("sell")
    if sellRemote then sellRemote:FireServer() end
end

local function teleport(pos)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
    end
end

-- Auto Fish Loop
spawn(function()
    while true do
        if isAutoFishing then
            castRod()
            wait(2)
            -- Simple bite detect (adjust based on game)
            bobber = workspace:FindFirstChild("Bobber") -- Sesuaikan nama
            if bobber then
                wait(3) -- Wait for bite
                reelIn()
                sellFish()
            end
            wait(1)
        else
            wait(1)
        end
    end
end)

-- Button Events
autoFishBtn.MouseButton1Click:Connect(function()
    isAutoFishing = not isAutoFishing
    autoFishBtn.Text = "Auto Fish: " .. (isAutoFishing and "ON" or "OFF")
    autoFishBtn.BackgroundColor3 = isAutoFishing and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
end)

autoSellBtn.MouseButton1Click:Connect(function()
    sellFish()
    autoSellBtn.Text = "Sold! (Click to repeat)"
    wait(1)
    autoSellBtn.Text = "Auto Sell: OFF"
end)

tpBtn.MouseButton1Click:Connect(function()
    teleport(Vector3.new(0, 10, 0)) -- Ganti pos sesuai spawn/island
end)

infJumpBtn.MouseButton1Click:Connect(function()
    local infJump = not _G.InfJump
    _G.InfJump = infJump
    infJumpBtn.Text = "Infinite Jump: " .. (infJump and "ON" or "OFF")
    infJumpBtn.BackgroundColor3 = infJump and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
end)

UserInputService.JumpRequest:Connect(function()
    if _G.InfJump then
        player.Character.Humanoid:ChangeState("Jumping")
    end
end)

print("Fish It Script Loaded! GUI muncul di pojok kiri atas.")
