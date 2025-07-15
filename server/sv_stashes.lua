local ox_inventory = exports.ox_inventory

RegisterNetEvent('donk-stashes:server:loadStashes', function (stashName, stashLabel, slots, maxWeight, coords)
    ox_inventory:RegisterStash(stashName, stashLabel, slots, maxWeight, false, false, coords)
end)