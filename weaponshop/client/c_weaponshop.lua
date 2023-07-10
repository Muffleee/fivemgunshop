-- Variables
local gunShopPed = nil
local gunshopPedLocation = nil
local buyableWeapon = GetHashKey("weapon_pistol")   -- Weapon to buy

local pedModel = GetHashKey("s_m_y_ammucity_01")    -- Weaponseller model
local pedPosition = vector3(22.3, -1105.0, 28.8)    -- Weaponseller position
local markerPos = vector3(21.3, -1107.0, 28.8)      -- Marker position
local pedHeading = 157.0

-- Spawn ped on resource start
AddEventHandler("onResourceStart", function()
    RequestModel(pedModel)

    -- Wait for model to load
    while not HasModelLoaded(pedModel) do
        Wait(10)
    end

    -- Place ped
    gunShopPed = CreatePed(0, pedModel, pedPosition.x, pedPosition.y, pedPosition.z,
                            pedHeading, true, true)

    SetModelAsNoLongerNeeded(pedModel)

    -- Ped settings
    FreezeEntityPosition(gunShopPed, true)
    SetEntityInvincible(gunShopPed, true)   -- nil (for some reason)
    SetBlockingOfNonTemporaryEvents(gunShopPed, true)
    TaskStartScenarioInPlace(gunShopPed, "WORLD_HUMAN_COP_IDLES", 0, true)
    SetBlockingOfNonTemporaryEvents(gunShopPed, true)

    gunshopPedLocation = GetEntityCoords(gunShopPed)
end)


-- Draw marker
CreateThread(function()
    while true do
        Wait(0)
        DrawMarker(
        1,
        markerPos.x,
        markerPos.y,
        markerPos.z,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        1.0,
        1.0,
        1.0,    -- Scale
        220,    -- R
        0,      -- G
        0,      -- B
        180,    -- RGB Alpha
        false, false, 2)
    end
end)

-- Show tooltip
CreateThread(function()
    while true do
        Wait(10)
        local playerLoc = GetEntityCoords(PlayerPedId())
        
        if Vdist(markerPos, playerLoc) < 1.2 then 
            ShowAlert("~w~Drücke ~INPUT_PICKUP~ um eine Pistole zu kaufen", true, 1)
        end
    end

end)

-- Register key to buy
RegisterKeyMapping("+buy_gun", "Interact with NPCs", "keyboard", "E")

-- Commadn to buy
RegisterCommand("+buy_gun", function()
    local player = PlayerPedId()
    local playerLoc = GetEntityCoords(player)
    if HasPedGotWeapon(player, buyableWeapon, false) then return end
    if Vdist(playerLoc, markerPos) > 1.2 then return end
    GiveWeaponToPed(player, buyableWeapon, 100, false, true)
end, false)

-- Function to show alerts
function ShowAlert(message, beep, duration)
    AddTextEntry("CH_ALERT", message)
    BeginTextCommandDisplayHelp("CH_ALERT")
    EndTextCommandDisplayHelp(0, false, beep, duration)
end

