-- Author : Kazaa

local isHandcuffed = false

CreateThread(function()
    exports.ox_target:addGlobalPlayer({
        {
            icon = 'fas fa-user-lock',
            label = 'Menotter',
            canInteract = function(entity)
                return not isHandcuffed and not IsEntityDead(entity)
            end,
            onSelect = function(data)
                TriggerServerEvent('menottes:toggle', GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity)))
            end,
            items = { Config.ItemMenottes }
        },
        {
            icon = 'fas fa-key',
            label = 'Retirer les menottes',
            canInteract = function(entity)
                return not IsEntityDead(entity)
            end,
            onSelect = function(data)
                TriggerServerEvent('menottes:unrestrain', GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity)))
            end,
            items = { Config.ItemCle }
        }
    })
end)

RegisterNetEvent('menottes:apply', function(sourceId)
    local ped = PlayerPedId()
    isHandcuffed = true

    RequestAnimDict('mp_arresting')
    while not HasAnimDictLoaded('mp_arresting') do Wait(10) end

    TaskPlayAnim(ped, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
    SetEnableHandcuffs(ped, true)
    DisableAllActions(true)
    exports['ox_inventory']:disableInventory(true)

    TriggerEvent('ox_lib:notify', {
        title = "Menottes",
        description = "Tu es menotté, tu ne peux plus rien faire.",
        type = "info"
    })
end)

RegisterNetEvent('menottes:remove', function()
    local ped = PlayerPedId()
    ClearPedTasksImmediately(ped)
    isHandcuffed = false
    SetEnableHandcuffs(ped, false)
    DisableAllActions(false)
    exports['ox_inventory']:disableInventory(false)

    TriggerServerEvent('menottes:clearHandcuffStatus')

    TriggerEvent('ox_lib:notify', {
        title = "Menottes",
        description = "Tu n'es plus menotté.",
        type = "success"
    })
end)

CreateThread(function()
    while true do
        Wait(0)
        if isHandcuffed then
            DisableControlAction(0, 21, true) 
            DisableControlAction(0, 24, true) 
            DisableControlAction(0, 25, true)
            DisableControlAction(0, 47, true)
            DisableControlAction(0, 58, true)
            DisableControlAction(0, 263, true)
            DisableControlAction(0, 140, true)
            DisableControlAction(0, 142, true)
            DisableControlAction(0, 143, true)
            DisablePlayerFiring(PlayerPedId(), true)
        else
            Wait(500)
        end
    end
end)

print("kazaa#0001.")
