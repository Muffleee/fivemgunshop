-- Commands (can be changed here)
local weatherCommand = "weather"
local timeCommand = "time"

-- Variables to sync time on join 
-- (server always starts at given time)
local oldTime = {hours = 12, minutes = 0}
local oldTimer = GetGameTimer()

-- Variable to sync weather on join
local currentWeather = "CLEAR"


-- Cmd to set time
RegisterCommand(timeCommand, function(source, args)
    -- Get hours and mins
    local hours = tonumber(args[1]) or nil
    local mins = tonumber(args[2]) or 0

    -- Send help if needed
    if hours == nil then
        SendPlayerMessage(source, ("/" .. timeCommand .. " ~r~[Stunden] [Minuten]"))
        return
    end

    -- Make number valid if its 0 > num > 23
    hours = hours % 24
    mins = mins % 60

    
    -- Get game timer and current hours
    oldTimer = GetGameTimer()
    oldTime.hours = hours
    oldTime.minutes = mins
    SyncTime(hours, mins)
    
end)

-- Cmd to set weather
RegisterCommand(weatherCommand, function(source, args)
    local weather = args[1] or "CLEAR"
    weather = string.upper(weather)

    -- loop through all possible weather types and compare to the
    -- given value
    for i, w in pairs(Config.WeatherTypes) do
        if w == weather then
            currentWeather = weather
            SyncWeather(weather)
            return
        end
    end

    SendPlayerMessage(source, weather .. " gibt es nicht!")
end)


-- Sync weather and time on server join
RegisterNetEvent("wc_syncjoin", function(player)
    -- Sync weather on clients
    SyncWeather(currentWeather)

    -- Find out how much time has passed since last time
    -- change in ms
    local timePassed = GetGameTimer() - oldTimer
    timePassed = math.floor(timePassed / 2000)  -- = all passed GTA mins since last time change

    -- Get the appropriate hours
    local newHour = math.floor(timePassed / 60) % 24
    if newHour == 0 then newHour = oldTime.hours end

    -- Get the appropriate minutes
    local newMinute = math.floor(timePassed) % 60
    if newMinute == 0 then newMinute = oldTime.minutes end

    -- Sync time on clients
    SyncTime(newHour, newMinute)
end)


-- Function to sync time on client(s)
function SyncTime(hours, minutes, target)
    if target == nil then target = -1 end
    TriggerClientEvent("wc_synctime", target, hours, minutes)
end

-- Function to sync weather on client(s)
function SyncWeather(weather, target)
    if target == nil then target = -1 end
    TriggerClientEvent("wc_syncweather", target, weather)
end

-- Function to send the player a message
function SendPlayerMessage(player, message)
    TriggerClientEvent("wc_sendmessage", player, message)
end