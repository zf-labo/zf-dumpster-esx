isBusy = false

if Config.Minigame == 'memorygame' then
    function MiniGame()
        exports['memorygame']:thermiteminigame(5, 3, 3, 15, function()
            return true
        end, function()
            return false
        end)
        return false
    end
elseif Config.Minigame == 'ox_lib' then
    function MiniGame()
        local success = lib.skillCheck({'easy', 'easy', 'medium'})
        return success or false
    end
elseif Config.Minigame and Config.Minigame ~= 'none' then
    print('[zf-dumpster] Invalid minigame specified in config.lua')
end

function PoliceAlert()
    if Config.Illegal then
        if math.random(1,100) >= Config.AlertChance then return end
        if Config.Dispatch == 'linden_outlaw' then
            local data = {displayCode = _U('police_code'), description = _U('police_message'), isImportant = 0, recipientList = Config.PoliceJobs, length = '10000', infoM = 'fa-info-circle', info = _U('police_bliptitle')}
            local dispatchData = {dispatchData = data, caller = _U('police_citizen'), coords = GetEntityCoords(PlayerPedId())}
            TriggerEvent('wf-alerts:svNotify', dispatchData)
        elseif Config.Dispatch == 'cd_dispatch' then
            local data = exports['cd_dispatch']:GetPlayerInfo()
            TriggerServerEvent('cd_dispatch:AddNotification', {
                job_table = Config.PoliceJobs, 
                coords = GetEntityCoords(PlayerPedId()),
                title =  _U('police_code') .. ' - ' .. _U('police_bliptitle'),
                message = _U('police_bliptitle'), 
                flash = 0,
                unique_id = tostring(math.random(0000000,9999999)),
                blip = {
                    sprite = 431, 
                    scale = 1.2, 
                    colour = 3,
                    flashes = false, 
                    text = _U('police_code') .. ' - ' .. _U('police_bliptitle'),
                    time = (5*60*1000),
                    sound = 1,
                }
            })
        else
            print('[zf-dumpster] Config.Dispatch does not have a valid argument')
        end
    end
end

function ProgressBar(ent)
    local progress = false
    
    if Config.ProgressType == 'circle' then
        progress = lib.progressCircle({
            duration = Config.ProgressTime * 1000,
            position = 'bottom',
            label = _U('progress_diving'),
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
            },
            anim = {
                dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
                clip = 'machinic_loop_mechandplayer' 
            }
        })
    elseif Config.ProgressType == 'regular' then
        progress = lib.progressBar({
            duration = Config.ProgressTime * 1000,
            position = 'bottom',
            label = _U('progress_diving'),
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
            },
            anim = {
                dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
                clip = 'machinic_loop_mechandplayer' 
            }
        })
    else
        print('[zf-dumpster] Invalid Config.ProgressType argument')
    end
    
    if progress then
        if not NetworkGetEntityIsNetworked(ent) then NetworkRegisterEntityAsNetworked(ent) end
        TriggerServerEvent('zf-dumpster:server:SetEntity', ObjToNet(ent), progress)
        if not Config.ResetOnReboot then TriggerServerEvent('zf-dumpster:server:ResetEntity', ObjToNet(ent)) end
        isBusy = false
        ClearPedTasks(PlayerPedId())
    else
        isBusy = false
        HurtPlayer(true)
        ClearPedTasks(PlayerPedId())
    end
end

function HurtPlayer(cancelled)
    local doubled = 0.5
    if cancelled then doubled = 1.5 end

    if Config.Hurting then
        if math.random(1,100) >= Config.HurtChance * doubled then return end

        local health = GetEntityHealth(PlayerPedId())
        local newHealth = health - math.random(Config.HurtDamage.min, Config.HurtDamage.max)
        SetEntityHealth(PlayerPedId(), newHealth)
    end
end