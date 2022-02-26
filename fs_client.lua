


--Updating all
-- I'm disable this for best opt
-- Citizen.CreateThread(function()
--     while true do
--         ped = PlayerPedId()
--         coords = GetEntityCoords(ped)
--         Wait(0)
--     end
-- end)

-- When spawn player ped --
AddEventHandler('playerSpawned', function()
    TriggerServerEvent('FW:SpawnPlayer')
end)

-- Setup player position --
RegisterNetEvent('FW:lastPosition')
AddEventHandler('FW:lastPosition', function(PosX, PosY, PosZ)
    local ped = PlayerPedId()
    Citizen.Wait(1)

    local defaulModel = GetHashKey('mp_m_freemode_01')
    RequestModel(defaulModel)
    while not HasModelLoaded(defaulModel) do
        Citizen.Wait(1)
    end
    SetPlayerModel(PlayerId(), defaulModel)
    SetPedDefaultComponentVariation(ped)
    SetModelAsNoLongerNeeded(defaulModel)

    SetEntityCoords(ped, PosX, PosY, PosZ, 1, 0, 0, 1)
end)

-- Update player position 
Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(5000)
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        lastX, lastY, lastZ = table.unpack(coords, true))
        TriggerServerEvent('FW:SavePlayerPosition', lastX, lastY, lastZ)
    end
end)