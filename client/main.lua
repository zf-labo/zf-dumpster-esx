CreateThread(function()
    exports.ox_target:addModel(Config.Props, {
        {
            label = _U('target_label'),
            icon = 'fas fa-dumpster',
            onSelect = function(data)
                ESX.TriggerServerCallback('zf-dumpster:server:getEntityState', function(wasDived)
                    if not wasDived then
                        isBusy = true
                        PoliceAlert()
    
                        if not Config.Minigame then
                            ProgressBar(data.entity)
                        else
                            local success = MiniGame()
                            if success then
                                ProgressBar(data.entity)
                            else
                                ESX.ShowNotification(_U('notifies_failed_minigame'), 'error', 5000)
                                isBusy = false
                            end
                        end
                    else
                        ESX.ShowNotification(_U('notifies_already_dived'), 'error', 5000)
                    end
                end, ObjToNet(data.entity))
            end,
            canInteract = function(entity, distance)
                return not isBusy and distance < 1.5
            end
        }
    })
end)

RegisterNetEvent('zf-dumpster:client:ResetEntity', function(netId)
    if NetworkGetEntityIsNetworked(netId) then NetworkUnregisterNetworkedEntity(netId) end
end)