-- [[ CONTROL EUROPE MEGA SCRIPT - FIX V1 ]] --

local MarketplaceService = game:GetService("MarketplaceService") -- Hata buradaydı, düzeltildi.
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- 1. Gamepass Bypass
local myPasses = {
    [1447409462] = true, [1234071941] = true, 
    [1233950071] = true, [1234384769] = true
}

local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    -- MarketplaceService üzerinden gelen tüm satın alma kontrollerini yakala
    if (method == "UserOwnsGamePassAsync" or method == "PlayerOwnsAsset") and myPasses[args[2]] then
        return true
    end
    return old(self, unpack(args))
end)
setreadonly(mt, true)

-- 2. EKSTRA ÖZELLİKLER

-- Karakter Hızı (Öldüğünde gitmemesi için döngüye aldım)
task.spawn(function()
    while task.wait(2) do
        pcall(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = 50
            end
        end)
    end
end)

-- Görsel Düzeltmeler (Sis Kaldırma ve Aydınlık)
game:GetService("Lighting").FogEnd = 100000
game:GetService("Lighting").Brightness = 3
game:GetService("Lighting").GlobalShadows = false

-- Butonları Aktif Etme
task.spawn(function()
    while task.wait(5) do
        for _, v in pairs(game:GetDescendants()) do
            if v:IsA("TextButton") and (v.Text:find("SATIN AL") or v.Text:find("Buy")) then
                v.Text = "AKTİF"
                v.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            end
        end
    end
end)

warn("--- Control Europe Fix Calisti! F9 Konsolunu Temizle. ---")
