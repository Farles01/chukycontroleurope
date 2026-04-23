-- [[ CONTROL EUROPE SPECIFIC GAMEPASS BYPASS ]] --

local MarketService = game:GetService("MarketService")

-- Senin topladığın ID'leri buraya bir liste olarak ekledik
local myGamepasses = {
    [1447409462] = true,
    [1234071941] = true,
    [1233950071] = true,
    [1234384769] = true
}

-- Metatable Hooking: Oyunun soru sorma yöntemini ele geçiriyoruz
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    -- Eğer oyun "Bu ID'ye sahip mi?" diye sorarsa (UserOwnsGamePassAsync)
    if method == "UserOwnsGamePassAsync" then
        local requestedID = args[2] -- Sorgulanan ID
        
        -- Eğer sorgulanan ID bizim listemizdeyse, her zaman TRUE (Evet) döndür
        if myGamepasses[requestedID] then
            return true
        end
    end
    
    return oldNamecall(self, unpack(args))
end)

setreadonly(mt, true)

-- Görsel Geri Bildirim: Konsola hangi ID'lerin bypass edildiğini yazar
print("--- Control Europe Bypass Aktif ---")
for id, _ in pairs(myGamepasses) do
    print("Bypass Edilen ID: " .. tostring(id))
end