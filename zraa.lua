-- ========================================
-- FISH IT TEST SCRIPT - PASTI MUNCUL GUI
-- ========================================

print("🔍 Loading Fish It Test Script...")

local Players = game:GetService("Players")
local Player = Players.LocalPlayer

-- NOTIFICATION DULU
game.StarterGui:SetCore("SendNotification", {
    Title = "🎣 Fish It Script";
    Text = "Script loaded successfully!";
    Duration = 5;
})

-- GUI SIMPEL
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FishItTest"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 300, 0, 150)
Frame.Position = UDim2.new(0.5, -150, 0.5, -75)
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

-- CORNER
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 15)
Corner.Parent = Frame

-- TITLE
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
Title.BorderSizePixel = 0
Title.Font = Enum.Font.GothamBold
Title.Text = "🎣 FISH IT AUTO TEST"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.Parent = Frame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 15)
TitleCorner.Parent = Title

-- STATUS
local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, -20, 0, 30)
Status.Position = UDim2.new(0, 10, 0, 60)
Status.BackgroundTransparency = 1
Status.Font = Enum.Font.Gotham
Status.Text = "✅ SCRIPT BERHASIL LOADING!"
Status.TextColor3 = Color3.fromRGB(76, 175, 80)
Status.TextScaled = true
Status.TextXAlignment = Enum.TextXAlignment.Left
Status.Parent = Frame

-- AUTO FISH BUTTON
local AutoFishBtn = Instance.new("TextButton")
AutoFishBtn.Size = UDim2.new(1, -20, 0, 40)
AutoFishBtn.Position = UDim2.new(0, 10, 0, 100)
AutoFishBtn.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
AutoFishBtn.BorderSizePixel = 0
AutoFishBtn.Font = Enum.Font.GothamBold
AutoFishBtn.Text = "🚀 START AUTO FISH"
AutoFishBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoFishBtn.TextScaled = true
AutoFishBtn.Parent = Frame

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 8)
BtnCorner.Parent = AutoFishBtn

-- BUTTON CLICK
local autoFishEnabled = false
AutoFishBtn.MouseButton1Click:Connect(function()
    autoFishEnabled = not autoFishEnabled
    AutoFishBtn.Text = autoFishEnabled and "✅ AUTO FISH ON" or "🚫 AUTO FISH OFF"
    AutoFishBtn.BackgroundColor3 = autoFishEnabled and Color3.fromRGB(46, 125, 50) or Color3.fromRGB(244, 67, 54)
    
    if autoFishEnabled then
        Status.Text = "🔄 AUTO FISHING ACTIVE..."
        Status.TextColor3 = Color3.fromRGB(255, 193, 7)
    else
        Status.Text = "⏹️ AUTO FISH STOPPED"
        Status.TextColor3 = Color3.fromRGB(244, 67, 54)
    end
end)

-- ANTI AFK
spawn(function()
    while true do
        if autoFishEnabled then
            local vu = game:GetService("VirtualUser")
            vu:CaptureController()
            vu:ClickButton2(Vector2.new())
        end
        wait(30)
    end
end)

print("✅ FISH IT TEST SCRIPT LOADED SUCCESSFULLY!")
game.StarterGui:SetCore("SendNotification", {
    Title = "🎣 SUCCESS";
    Text = "GUI sudah muncul! Cek layar tengah.";
    Duration = 5;
})
