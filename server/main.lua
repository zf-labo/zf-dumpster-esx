local entities = {}

RegisterNetEvent('zf-dumpster:server:ResetEntity', function(entity)
    entities[entity] = 0
end)

function EntityRespawn()
    if entities ~= nil or entities ~= {} then
        for _,t in pairs(entities) do
            entities[_] = t + 1
            if t >= 0 and t >= Config.ResetTime then
                entities[_] = -1
            end
        end
    end
    SetTimeout(60000, EntityRespawn)
end

if not Config.ResetOnReboot then
    EntityRespawn()
end

RegisterNetEvent('zf-dumpster:server:SetEntity', function(netId, isFinished)
    entities[netId] = 0
    DropItem(isFinished, netId, source)
end)

local function pGive(playerId, item, amount)
    local Player = ESX.GetPlayerFromId(playerId)
    if not Player then return end

    if type(item) == 'string' then
        Player.addInventoryItem(item, amount)
        if ESX.GetItemLabel(i.item) then
            local itemString = amount .. 'x ' .. ESX.GetItemLabel(i.item)
            TriggerClientEvent('esx:showNotification', playerId, _U('notifies_you_got', itemString))
        else
            TriggerClientEvent('esx:showNotification', playerId, _U('notifies_got_nothing'))
        end
    elseif type(item) == 'table' and amount == 10000 then
        local itemString = ''
        for _,i in pairs(item) do
            Player.addInventoryItem(i.item, i.amount)
            itemString = i.amount .. 'x ' .. ESX.GetItemLabel(i.item) .. ', ' .. itemString
        end

        if itemString ~= '' then
            TriggerClientEvent('esx:showNotification', playerId, _U('notifies_you_got', itemString))
        else
            TriggerClientEvent('esx:showNotification', playerId, _U('notifies_got_nothing'))
        end
    end
end

function DropItem(finished, netId, playerId)
    local Player = ESX.GetPlayerFromId(playerId)
    if not Player then return end
    if not netId then return end
    if not finished then return end
    
    if Config.CanLootMultiple then
        local itemTable = {}
        local itemAmount = math.random(1, Config.MaxLootItem)

        for i=1, itemAmount do
            local lootChance = math.random(1,100)
            local item = Config.Loottable[math.random(1, #Config.Loottable)]
            if lootChance >= item.chances then
                itemTable[#itemTable+1] = {item = item.item, amount = math.floor(math.random(item.min, item.max))}
            end
        end
        return pGive(playerId, itemTable, 10000)
    else
        local item = Config.Loottable[math.random(1, #Config.Loottable)]
        if lootChance >= item.chances then
            return pGive(playerId, item.item, math.random(item.min, item.max))
        end
    end
end

ESX.RegisterServerCallback('zf-dumpster:server:getEntityState', function(source, cb, netId)
    if entities[netId] == -1 or entities[netId] == nil then cb(false) else cb(true) end
end)

AddEventHandler('onResourceStop', function(resName)
    if resName ~= GetCurrentResourceName() then return end
    for _,v in pairs(entities) do
        if v == -1 then
            TriggerClientEvent('zf-dumpster:client:ResetEntity', -1, _)
        end
    end
end)