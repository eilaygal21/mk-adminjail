local ped = PlayerPedId()
local count = 0
local injail = false
local MaxCount
local jailCoords = {Config.LocationJail.x, Config.LocationJail.y, Config.LocationJail.z}
local jailRadius = Config.Radius.radius
local stuckCoords = {Config.LocationDefault.x, Config.LocationDefault.y, Config.LocationDefault.z}
local initialCoords = nil
local player

local function DrawText3D(x,y,z, text, r,g,b) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
	scale = scale * 1.0
   
    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end
local function IsPedOutOfJail(currentPos)
	local distanceFromJail = GetDistanceBetweenCoords(jailCoords.x, jailCoords.y, jailCoords.z, currentPos.x, currentPos.y, currentPos.z, true)
	if distanceFromJail > jailRadius then
        return true
        
	else
        return false
        
	end
end

local function SetPedInJail()
	SetEntityInvincible(GetPlayerPed(-1), true)
	local newCoords = {x = jailCoords.x , y = jailCoords.y , z = jailCoords.z}
	SetEntityCoords(GetPlayerPed(-1), newCoords.x, newCoords.y, newCoords.z, 0, 0, 0, 0)
end

local function ExitJail()
	count = 0
	injail = false


	local distanceFromJail = GetDistanceBetweenCoords(jailCoords.x, jailCoords.y, jailCoords.z, initialCoords.x, initialCoords.y, initialCoords.z, true)
	if distanceFromJail < 50.0 then
		initialCoords = stuckCoords
	end

	SetEntityCoords(GetPlayerPed(-1), initialCoords.x, initialCoords.y, initialCoords.z, 0, 0, 0, 0)
	SetEntityInvincible(GetPlayerPed(-1), false)
end

--System

Citizen.CreateThread(
    function()
        while true do
            if injail then
                local currentPos = GetEntityCoords(GetPlayerPed(-1))
    
                if IsPedOutOfJail(currentPos) then
                    SetPedInJail()
                end
                
                Citizen.Wait(0)
                DrawText3D(1651.0552, 2569.8662, 45.564853, "You're now in admin jail ,Time Left: " .. count .. "", 255,255,255)
            else
                local currentPos = GetEntityCoords(GetPlayerPed(-1))
                if not IsPedOutOfJail(currentPos) then
                    TriggerEvent('eilay:adminjail', MaxCount)
            end

            Citizen.Wait(200)
           
        end
        
        
    end
end)

local MyCount
RegisterNetEvent('eilay:adminjail')
AddEventHandler('eilay:adminjail', function(timeInJail)
    count = timeInJail

    injail = true
    initialCoords = GetEntityCoords(GetPlayerPed(-1))
    SetPedInJail()
    Citizen.CreateThread(function()
        while injail do
            count = count - 1
            Citizen.Wait(1000)
            if count == 0 then
                ExitJail()
            end
        end
    end)
end)

RegisterNetEvent("eilay:unadminjail")
AddEventHandler("eilay:unadminjail", function()
    count = 0
    injail = false
    ExitJail()
end)
RegisterNetEvent("eilay:notify")
AddEventHandler("eilay:notify", function(message, duration)
	newNotif(message, duration)
end)
