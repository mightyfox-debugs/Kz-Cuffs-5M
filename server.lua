-- Author : Kazaa

local ESX = exports['es_extended']:getSharedObject()
local handcuffedPlayers = {}

local function isNearby(src, target, dist)
    local srcPed = GetPlayerPed(src)
    local targetPed = GetPlayerPed(target)
    if not srcPed or not targetPed then return false end
    local srcCoords = GetEntityCoords(srcPed)
    local targetCoords = GetEntityCoords(targetPed)
    return #(srcCoords - targetCoords) <= dist
end

RegisterNetEvent('menottes:toggle', function(target)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end

    local hasItem = exports.ox_inventory:Search(src, 'count', Config.ItemMenottes)
    if not hasItem or hasItem < 1 then
        DropPlayer(src, "KzAC : Tentative de triche.")
        return
    end

    if not isNearby(src, target, 3.0) then
        DropPlayer(src, "KzAC : Tentative de triche.")
        return
    end

    exports.ox_inventory:RemoveItem(src, Config.ItemMenottes, 1)
    handcuffedPlayers[target] = true
    TriggerClientEvent('menottes:apply', target, src)

    TriggerClientEvent('ox_lib:notify', src, {
        title = 'Menottes',
        description = 'Tu as menotté la personne.',
        type = 'success'
    })
end)

RegisterNetEvent('menottes:unrestrain', function(target)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end

    local hasCle = exports.ox_inventory:Search(src, 'count', Config.ItemCle)
    if not hasCle or hasCle < 1 then
        DropPlayer(src, "KzAC : Tentative de triche.")
        return
    end

    if not handcuffedPlayers[target] then
        DropPlayer(src, "KzAC : Tentative de triche.")
        return
    end

    if not isNearby(src, target, 3.0) then
        DropPlayer(src, "KzAC : Tentative de triche.")
        return
    end

    handcuffedPlayers[target] = nil
    TriggerClientEvent('menottes:remove', target)
    exports.ox_inventory:AddItem(src, Config.ItemMenottes, 1)

    TriggerClientEvent('ox_lib:notify', src, {
        title = 'Clé de menottes',
        description = 'Tu as retiré les menottes et récupéré la paire de menottes.',
        type = 'success'
    })
end)

RegisterNetEvent('menottes:clearHandcuffStatus', function()
    handcuffedPlayers[source] = nil
end)

AddEventHandler('playerDropped', function()
    handcuffedPlayers[source] = nil
end)

print("kazaa#0001.")