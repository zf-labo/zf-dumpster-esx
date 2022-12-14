CreateThread(function()
    if Config.Target == 'ox_target' then
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
    elseif Config.Target == 'qtarget' then
        exports.qtarget:AddTargetModel(Config.Props, {
            options = {
                {
                    label = _U('target_label'),
                    icon = 'fas fa-dumpster',
                    action = function(entity)
                        ESX.TriggerServerCallback('zf-dumpster:server:getEntityState', function(wasDived)
                            if not wasDived then
                                isBusy = true
                                PoliceAlert()
            
                                if not Config.Minigame then
                                    ProgressBar(entity)
                                else
                                    local success = MiniGame()
                                    if success then
                                        ProgressBar(entity)
                                    else
                                        ESX.ShowNotification(_U('notifies_failed_minigame'), 'error', 5000)
                                        isBusy = false
                                    end
                                end
                            else
                                ESX.ShowNotification(_U('notifies_already_dived'), 'error', 5000)
                            end
                        end, ObjToNet(entity))
                    end,
                    canInteract = function(entity)
                        return not isBusy
                    end
                }
            },
            distance = 1.5
        })
    else
        print('[zf-dumpster] Invalid Config.Target argument')
    end
end)

RegisterNetEvent('zf-dumpster:client:ResetEntity', function(netId)
    if NetworkGetEntityIsNetworked(netId) then NetworkUnregisterNetworkedEntity(netId) end
end)