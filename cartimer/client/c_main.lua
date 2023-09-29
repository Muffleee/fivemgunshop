local hud = true
local waitForTimer = false
local currentTopSpeed = 0
local currentTime = 0
local speed = 0
local speedType = "km/h"

CreateThread(function()
    if not Config.kmph then
        speedType = "mph"
    end
    while true do
        Wait(0)
        if IsPedInAnyVehicle(GetPlayerPed(-1), false) and hud then
            SetCurrentSpeed()
            local currentTimeFormatted = currentTime/1000
            ShowText(speed.." "..speedType.." \n"..currentTimeFormatted.." s \nTopSpeed: "..currentTopSpeed.." "..speedType)
        end
    end
end)

RegisterNetEvent("cartimer:setSpeed", function(setSpeed)
    currentTime = 0
    currentTopSpeed = setSpeed
    waitForTimer = true
    ShowAlert("Timer mit "..setSpeed.." "..speedType.." gestartet.")
    WaitForTimer()
end)

RegisterNetEvent("cartimer:sendAlert", function(message)
    ShowAlert(message, false, Config.messageDuration)
end)

RegisterNetEvent("cartimer:toggleHud", function()
    hud = not hud
end)

function WaitForTimer()
    CreateThread(function()
        while waitForTimer do      
            SetCurrentSpeed()
            
            if speed > 0 then 
                StartTimer() 
                waitForTimer = false
            end
            Wait(0)
        end
    end)
end

function StartTimer()
    CreateThread(function()
        while speed < currentTopSpeed do
            currentTime = currentTime + 10
            Wait(1)
        end
    end)
end

function SetCurrentSpeed()
    if not VehicleCheck() then return end
    local localSpeed = speed
    localSpeed = GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false))
    if Config.kmph then
        localSpeed = localSpeed*3.6
    else
        localSpeed = localSpeed*2.2369
    end
    speed = math.floor(localSpeed+0.5)
end

function VehicleCheck()
    if not IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
        ShowAlert("Fahrzeug verlassen, stoppe Timer.", false, Config.messageDuration)
        return false
    end
    return true
end

function ShowText(text)
    SetTextFont(Config.textFont)
    SetTextProportional(0)
    SetTextScale(Config.textSize, Config.textSize)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(Config.textLocationX, Config.textLocationY)
end

function ShowAlert(message, beep, duration)
    AddTextEntry("CH_ALERT", message)
    BeginTextCommandDisplayHelp("CH_ALERT")
    EndTextCommandDisplayHelp(0, false, beep, duration) -- _ | _ | boolean (make sound) | duration (int) 
end