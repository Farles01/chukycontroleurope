-- [[ CONTROL EUROPE MEGA SCRIPT - HEY GOOGLE ]] --

local MarketService = game:GetService("MarketService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- 1. Gamepass Bypass (ID'lerin tamamını buraya gömdük)
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
    if method == "UserOwnsGamePassAsync" and myPasses[args[2]] then
        return true
    end
    return old(self, unpack(args))
end)
setreadonly(mt, true)

-- 2. EKSTRA ÖZELLİKLER (İstediğin kısımlar burası)

-- A. Hız Hilesi (Birimlerin veya kameranın daha hızlı olması için)
LocalPlayer.CharacterAdded:Connect(function(char)
    local hum = char:WaitForChild("Humanoid")
    hum.WalkSpeed = 50 -- Normali 16'dır, bunu 50 yaptık
end)

-- B. Sis Kaldırma (Haritayı daha net görmek için)
game:GetService("Lighting").FogEnd = 100000
game:GetService("Lighting").Brightness = 2

-- C. Butonları Otomatik Aktif Etme
task.spawn(function()
    while task.wait(3) do
        for _, v in pairs(game:GetDescendants()) do
            if v:IsA("TextButton") and (v.Text:find("Buy") or v.Text:find("Satın Al")) then
                v.Text = "AKTİF (Hey Google)"
                v.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            end
        end
    end
end)

print("--- Control Europe Hack Yuklendi ---")
print("Aktif Ozellikler: Gamepass Bypass, WalkSpeed, No Fog")
