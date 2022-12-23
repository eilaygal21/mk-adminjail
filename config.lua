Config = {}

Config.Enable = { -- True if you want the max time feature, false if other wise
    enable = true
}

Config.Time = {
    time = 240 -- The max amount of minutes you can put an player in, btw its about 4 hours
}

Config.Command = {
    command = "adminjail" --The command that the admin uses to put someone in jail
}

Config.Radius = {
    radius = 12.0 --The amount of distance you to be from the jail for you to be teleported back
}

Config.LocationJail = { --The location of the jail, you can change it if you want
    x = 1651.3516, y = 2569.9245, z = 45.564857
}

Config.LocationDefault = { --The default location for the player to teleport if you bugged the player (just in case)
    x = 223.7026, y = -790.25, z = 30.72
}