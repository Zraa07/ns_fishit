-- DIAGNOSTIC SCRIPT - Paste di executor dan lihat output
print("=== FISHING GAME DIAGNOSTIC ===")

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- 1. Cari semua RemoteEvents
print("\n🔍 REMOTE EVENTS DITEMUKAN:")
for _, obj in pairs(game:GetDescendants()) do
    if obj:IsA("RemoteEvent") and (obj.Name:lower():find("fish") or obj.Name:lower():find("cast") or obj.Name:lower():find("reel")) then
        print("  →", obj:GetFullName())
    end
end

-- 2. Cari Bobber Objects
print("\n🎣 POTENTIAL BOBBERS:")
for _, obj in pairs(workspace:GetDescendants()) do
    if obj.Name:lower():find("bobber") or obj.Name:lower():find("float") or obj.Name:lower():find("buoy") then
        print("  →", obj:GetFullName(), "Parent:", obj.Parent.Name)
    end
end

-- 3. Cari di Player Character
if player.Character then
    print("\n👤 PLAYER CHARACTER CHILDREN:")
    for _, obj in pairs(player.Character:GetChildren()) do
        print("  →", obj.Name, obj.ClassName)
    end
end

print("\n=== DIAGNOSTIC COMPLETE ===")
print("Copy semua output ini dan kirim ke saya!")
