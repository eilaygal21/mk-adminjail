UNCore = nil
TriggerEvent('UNCore:GetObject', function(obj) UNCore = obj end)
local MaxTime = Config.Time.time * 60

UNCore.Commands.Add(Config.Command.command, "Puts a player in admin jail", {{name = "id", help = "player id"}, {name = "time", help = "min"}}, false, function(source, args)
    if not args[1] or not args[2] then
        TriggerClientEvent("eilay:notify", source, "~r~Error :~w~\n the right command is /adminjail player id and then amount of time", 3000)
        else
            local otherPlayerID = tonumber(args[1])
            local Amount = tonumber (args[2]) * 60
            if Config.Enable.enable then
                if Amount > MaxTime then Amount = MaxTime end
            end

            -- TriggerClientEvent("eilay:adminjail", otherPlayerID, Amount)
            MySQL.Async.fetchAll("INSERT INTO admin_jail (name, time, jailedby) VALUES(@name, @time, @jailedby)",
            {["@name"] = GetPlayerName(otherPlayerID), ["@time"] = Amount,  ["@jailedby"] = GetPlayerName(source)},
            function(result)
                TriggerClientEvent("eilay:adminjail", otherPlayerID, Amount)
            end
        )
    end
end, "admin")



