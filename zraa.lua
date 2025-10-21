-- Fish It FULL SCRIPT | Delta Compatible | No External Load
-- Credits: Custom for @user | Oct 2025

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local AutoFarm = false
local FishingRod = nil

-- GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 250)
MainFrame.Position = UDim2.new(0, 10, 0, 10)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "🐟 FISH IT AUTO FARM"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

local AutoFishBtn = Instance.new("TextButton")
AutoFishBtn.Size = UDim2.new(0.45, 0, 0, 40)
AutoFishBtn.Position = UDim2.new(0, 10, 0, 50)
AutoFishBtn.Text = "Auto Fish: OFF"
AutoFishBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
AutoFishBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoFishBtn.TextScaled = true
AutoFishBtn.Font = Enum.Font.Gotham
AutoFishBtn.Parent = MainFrame

local AutoSellBtn = Instance.new("TextButton")
AutoSellBtn.Size = UDim2.new(0.45, 0, 0, 40)
AutoSellBtn.Position = UDim2.new(0.55, 0, 0, 50)
AutoSellBtn.Text = "Auto Sell: OFF"
AutoSellBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
AutoSellBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoSellBtn.TextScaled = true
AutoSellBtn.Font = Enum.Font.Gotham
AutoSellBtn.Parent = MainFrame

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -20, 0, 30)
StatusLabel.Position = UDim2.new(0, 10, 0, 100)
StatusLabel.Text = "Status: Ready"
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.TextScaled = true
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Parent = MainFrame

ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- Find Remotes
local function getRemote(name)
    for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
        if obj:IsA("RemoteEvent") and string.find(string.lower(obj.Name), name) then
            return obj
        end
    end
    return nil
end

local CastRemote = getRemote("cast") or getRemote("fish") or getRemote("throw")
local ReelRemote = getRemote("reel") or getRemote("catch") or getRemote("pull")
local SellRemote = getRemote("sell") or getRemote("shop")

-- Auto Fish Loop
spawn(function()
    while true do
        if AutoFarm then
            StatusLabel.Text = "Status: Casting..."
            
            -- Cast
            if CastRemote then
                CastRemote:FireServer()
                StatusLabel.Text = "Status: Waiting for bite..."
                wait(3) -- Wait for bobber
            end
            
            -- Reel after bite time
            wait(4) -- Adjust timing based on game
            if ReelRemote then
                ReelRemote:FireServer()
                StatusLabel.Text = "Status: Caught fish!"
            end
            
            -- Auto sell
            wait(1)
            if SellRemote then
                SellRemote:FireServer()
            end
            
            wait(2) -- Cycle delay
        else
            StatusLabel.Text = "Status: Auto Fish OFF"
            wait(1)
        end
    end
end)

-- Buttons
AutoFishBtn.MouseButton1Click:Connect(function()
    AutoFarm = not AutoFarm
    AutoFishBtn.Text = "Auto Fish: " .. (AutoFarm and "ON" or "OFF")
    AutoFishBtn.BackgroundColor3 = AutoFarm and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
end)

AutoSellBtn.MouseButton1Click:Connect(function()
    if SellRemote then
        SellRemote:FireServer()
        StatusLabel.Text = "Status: Sold all fish!"
        wait(1)
        StatusLabel.Text = "Status: Ready"
    else
        StatusLabel.Text = "Status: Sell remote not found!"
    end
end)

-- Notification
game.StarterGui:SetCore("SendNotification", {
    Title = "FISH IT SCRIPT LOADED";
    Text = "Toggle Auto Fish di GUI!";
    Duration = 5;
})

print("🐟 FISH IT SCRIPT FULLY LOADED!")
print("Cast Remote:", CastRemote and CastRemote.Name or "NOT FOUND")
print("Reel Remote:", ReelRemote and ReelRemote.Name or "NOT FOUND")
print("Sell Remote:", SellRemote and SellRemote.Name or "NOT FOUND")
