RegisterCommand("timer", function(source, args)
    if args[1] == "hud" then
        TriggerClientEvent("cartimer:toggleHud", source)
        return
    end
    local topSpeed = tonumber(args[1]) or 0

    if topSpeed < 1 then
        TriggerClientEvent("cartimer:sendAlert", source, "Die Geschwindigkeit muss größer als 0 sein.")
        return
    end
    TriggerClientEvent("cartimer:setSpeed", source, topSpeed)
end)