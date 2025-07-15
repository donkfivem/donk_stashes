local QBCore = exports['qb-core']:GetCoreObject()
local ox_inventory = exports.ox_inventory

Citizen.CreateThread(function()
    local alreadyEnteredZone = false
    local text = '[E] Open Stash'
    while true do
    wait = 5
    local ped = PlayerPedId()
    local inZone = false
    for k, v in pairs(Config.Stashes) do
        local dist = #(GetEntityCoords(ped)-vector3(Config.Stashes[k].coords.x, Config.Stashes[k].coords.y, Config.Stashes[k].coords.z))
        if dist <= 3.0 then
        wait = 5
        inZone  = true
        if IsControlJustReleased(0, 38) then
            TriggerEvent('qb-business:client:openStash', k, Config.Stashes[k].stashName)
        end
        break
        else
        wait = 2000
        end
    end
    if inZone and not alreadyEnteredZone then
        alreadyEnteredZone = true
        lib.showTextUI(text, {icon = 'box'})
    end
    if not inZone and alreadyEnteredZone then
        alreadyEnteredZone = false
        lib.hideTextUI()
    end
    Citizen.Wait(wait)
    end
end)

RegisterNetEvent('qb-business:client:openStash', function(currentstash, stash)
    local PlayerData = QBCore.Functions.GetPlayerData()
    local PlayerJob = PlayerData.job.name
    local PlayerJobGrade = PlayerData.job.grade.level
    local PlayerGang = PlayerData.gang.name
    local PlayerGangGrade = PlayerData.gang.grade.level
    local canOpen = false
    if Config.PoliceOpen and not Config.Stashes[currentstash].jobrequired then 
        if PlayerData.job.type and PlayerData.job.type == "leo" then
            canOpen = true
        end
    end
    if Config.Stashes[currentstash].jobrequired then 
        if (PlayerJob == Config.Stashes[currentstash].job) and (PlayerJobGrade >= Config.Stashes[currentstash].grade) then
            canOpen = true
        end
    end
    if Config.Stashes[currentstash].requirecid then
        for k, v in pairs (Config.Stashes[currentstash].cid) do 
            if QBCore.Functions.GetPlayerData().citizenid == v then
                canOpen = true
            end
        end
    end
    if Config.Stashes[currentstash].gangrequired then
        local gang = exports['av_gangs']:getGang()
        if (((PlayerGang == Config.Stashes[currentstash].gang) and (PlayerGangGrade >= Config.Stashes[currentstash].grade)) or (gang and gang.name == Config.Stashes[currentstash].gang)) then
            canOpen = true
        end
    end
    if canOpen then 
        if ox_inventory:openInventory('stash', Config.Stashes[currentstash].stashName) == false then
            TriggerServerEvent('donk-stashes:server:loadStashes', Config.Stashes[currentstash].stashName, Config.Stashes[currentstash].stashName, Config.Stashes[currentstash].stashSlots, Config.Stashes[currentstash].stashSize, Config.Stashes[currentstash].coords)
            ox_inventory:openInventory('stash', Config.Stashes[currentstash].stashName)
        end
    else
        QBCore.Functions.Notify('You cannot open this', 'error')
    end
end)