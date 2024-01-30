ESX = exports['es_extended']:getSharedObject()

lib.callback.register('pascold_radiolist:GetUsers', function()
    local players = exports['pma-voice']:getPlayersInRadioChannel(Player(source).state['radioChannel'])
    local list = {}
    for player, isTalking in pairs(players) do
        local list2 = {player = GetFrakcjeName(player), isTalking = isTalking, badge = GetPlayerBadge(player)}
        table.insert(list, list2)
    end
    return list
end)

lib.callback.register('pascold_radiolist:GetUsers2', function()
    local players = exports['pma-voice']:getPlayersInRadioChannel(Player(source).state['radioChannel'])
    local list = {}
    for player, isTalking in pairs(players) do
        local list2 = {player = GetCrimeName(player), isTalking = isTalking, badge = ''}
        table.insert(list, list2)
    end
    return list
end)

function GetFrakcjeName(player)
    local xPlayer = ESX.GetPlayerFromId(player)
    local fullname = xPlayer.getName()
    local grupa = ''

    MySQL.query('SELECT * FROM `users` WHERE `identifier` = @identifier', {
        ['@identifier'] = xPlayer.identifier
    }, function(result)
        if result then
            for i = 1, #result do
                local row = result[i]
                if row then
						xPlayer.set('firstname', row.firstname)
						xPlayer.set('lastname', row.lastname)
						xPlayer.set('dateofbirth', row.dateofbirth)
						xPlayer.set('sex', row.sex)
						xPlayer.set('height', row.height)
						xPlayer.set('ssn', row.ssn)
						xPlayer.set('job_id', row.job_id)
                        xPlayer.set('streamer', row.streamer)
                end
            end
        end
    end)

    Citizen.Wait(1)

    if xPlayer.get('streamer') == 1 then
        grupa = '<i style="color:#5a3e85;" class="fa-brands fa-twitch"></i>'
    end
    local nazwa = fullname .. ' ' .. grupa
    return nazwa
end

function GetCrimeName(player)
    local xPlayer = ESX.GetPlayerFromId(player)
    local fullname = xPlayer.get('firstname')
    local grupa = ''

    MySQL.query('SELECT * FROM `users` WHERE `identifier` = @identifier', {
        ['@identifier'] = xPlayer.identifier
    }, function(result)
        if result then
            for i = 1, #result do
                local row = result[i]
                if row then
						xPlayer.set('firstname', row.firstname)
						xPlayer.set('lastname', row.lastname)
						xPlayer.set('dateofbirth', row.dateofbirth)
						xPlayer.set('sex', row.sex)
						xPlayer.set('height', row.height)
						xPlayer.set('job_id', row.job_id)
                        xPlayer.set('streamer', row.streamer)
                end
            end
        end
    end)

    Citizen.Wait(1)

    if xPlayer.get('streamer') == 1 then
        grupa = '<i style="color:#5a3e85;" class="fa-brands fa-twitch"></i>'
    end
    local nazwa = fullname .. ' ' .. grupa
    return nazwa
end

ESX.RegisterCommand('setstreamer', {'superadmin', 'best'}, function(xPlayer, args)
    local hex = args.playerId.identifier

    if args.statusstreamera == 0 or args.statusstreamera == 1 then
        print('Przyznano')
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = @identifier", {
            ["@identifier"] = hex
        }, function(result)
            if result and result[1] and result[1].streamer ~= args.statusstreamera then
                MySQL.Async.execute("UPDATE `users` SET `streamer` = @streamer WHERE `identifier` = @identifier", {
                    ["@identifier"] = hex,
                    ["@streamer"] = args.statusstreamera
                })
            end
        end)

        args.playerId.set('streamer', args.statusstreamera)
    else
        print('Zły status')
    end

end, true, {
	help = 'Nadaj status streamera',
	validate = true,
	arguments = {
		{ name = 'playerId', help = 'Id Gracza', type = 'player' },
		{ name = 'statusstreamera',    help = 'Tak - 1, Nie - 0',  type = 'number' },
	}
})

function GetPlayerBadge(player)
    local xPlayer = ESX.GetPlayerFromId(player)
    MySQL.query('SELECT * FROM `users` WHERE `identifier` = @identifier', {
        ['@identifier'] = xPlayer.identifier
    }, function(result)
        if result then
            for i = 1, #result do
                local row = result[i]
                if row then
						xPlayer.set('firstname', row.firstname)
						xPlayer.set('lastname', row.lastname)
						xPlayer.set('dateofbirth', row.dateofbirth)
						xPlayer.set('sex', row.sex)
						xPlayer.set('height', row.height)
						xPlayer.set('job_id', row.job_id)
                        xPlayer.set('streamer', row.streamer)
                end
            end
        end
    end)
    local badge = '['..xPlayer.get('job_id')..']'
    if (badge == '') then 
        badge = ''
    end
    if (badge == nil) then 
        badge = ''
    end

    return badge
end