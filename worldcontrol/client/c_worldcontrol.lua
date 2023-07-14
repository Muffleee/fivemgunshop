-- Message settings
local makeSound = false
local duration = 3000

-- Time to transition to new weather
local transitionTime = 10


-- Called by the server when time is changed
RegisterNetEvent("wc_synctime", function(hours, minutes)
    -- Set time
    NetworkOverrideClockTime(hours, minutes, 0)
end)

-- Called by the server when weather is changed
RegisterNetEvent("wc_syncweather", function(weather)
    -- Set weather
    SetWeatherTypeOvertimePersist(weather, transitionTime)

    -- Activate trails if there is snow
    -- Deactivate if there isn't
    if weather == 'XMAS' then
        SetForceVehicleTrails(true)
        SetForcePedFootstepsTracks(true)
        return
    end
    
    SetForceVehicleTrails(false)
    SetForcePedFootstepsTracks(false)
end)

-- Function to send a message to a client
RegisterNetEvent("wc_sendmessage", function(message)
    AddTextEntry("CH_ALERT", message)
    BeginTextCommandDisplayHelp("CH_ALERT")
    EndTextCommandDisplayHelp(0, false, makeSound, duration)
end)


-- Called when player spawns
-- Used to sync time and weather
AddEventHandler('playerSpawned', function()
    TriggerServerEvent("wc_syncjoin")
end)
