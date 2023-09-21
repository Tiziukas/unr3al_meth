print("Unr3al Meth by 1OSaft")
ESX = exports["es_extended"]:getSharedObject()

RegisterServerEvent('esx_methcar:start')
AddEventHandler('esx_methcar:start', function()
	local _source = source
	--if Config.Debug then
	--	print("Source: " .. _source)
	--end
	local xPlayer = ESX.GetPlayerFromId(_source)
	--if Config.Debug then
	--	print("xPlayer: " .. xPlayer)
	--end

	local pos = GetEntityCoords(GetPlayerPed(_source))

	DiscordLogs("start", "Started Cooking", "green", {

		{name = "Player Informations", value = " ", inline = false},
		{name = "ID", value = tostring(_source), inline = true},
		{name = "Name", value = tostring(xPlayer.getName()), inline = true},
		{name = "Identifier", value = tostring(xPlayer.getIdentifier()), inline = true},
		

		{name = "Cords", value = " ", inline = false},
		{name = "X", value = tostring(pos.x), inline = true},
		{name = "Y", value = tostring(pos.y), inline = true},
		{name = "Z", value = tostring(pos.z), inline = true},
	})

	if Config.Debug then
		print("Trying to remove Players Items")
	end
	if xPlayer.getInventoryItem(Config.Item.Acetone).count >= 5 and xPlayer.getInventoryItem(Config.Item.Lithium).count >= 2 and xPlayer.getInventoryItem('methlab').count >= 1 then
		if xPlayer.canCarryItem(Config.Item.Meth, 30) then
			TriggerClientEvent('esx_methcar:startprod', _source)
			xPlayer.removeInventoryItem(Config.Item.Acetone, 5)
			xPlayer.removeInventoryItem(Config.Item.Lithium, 2)
			if Config.Debug then
				print("Removed Starting Items")
			end
		end
	else
		TriggerClientEvent('esx_methcar:notify', _source, Config.Noti.error, "Not enough supplies to start producing Meth")
	end
end)

RegisterServerEvent('esx_methcar:stopf')
AddEventHandler('esx_methcar:stopf', function(id)
local _source = source
	local xPlayers = ESX.GetPlayers()
	local xPlayer = ESX.GetPlayerFromId(_source)
	for i=1, #xPlayers, 1 do
		TriggerClientEvent('esx_methcar:stopfreeze', xPlayers[i], id)
	end
	
end)

RegisterServerEvent('esx_methcar:make')
AddEventHandler('esx_methcar:make', function(posx,posy,posz)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer.getInventoryItem('methlab').count >= 1 then

		local xPlayers = ESX.GetPlayers()
		for i=1, #xPlayers, 1 do
			TriggerClientEvent('esx_methcar:smoke',xPlayers[i],posx,posy,posz, 'a') 
		end
	else
		TriggerClientEvent('esx_methcar:stop', _source)
	end
end)

RegisterServerEvent('esx_methcar:finish')
AddEventHandler('esx_methcar:finish', function(qualtiy)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	print(qualtiy)
	local rnd = math.random(Config.Item.Chance.Min, Config.Item.Chance.Max)
	local Amount = math.floor(qualtiy / 2) + rnd

	if xPlayer.canCarryItem(Config.Item.Meth, Amount) then
		xPlayer.addInventoryItem(Config.Item.Meth, Amount)
	else
		if Config.Inventory == 'ox_iventory' then
			local MaxWeight = exports.ox_inventory:GetPlayerMaxWeight()
			local CurrentWeight = exports.ox_inventory:GetPlayerWeight()
			local Freeweight = MaxWeight - CurrentWeight
			ItemsToAdd = Freeweight / Config.Item.MethWeight
		end
	end

	local pos = GetEntityCoords(GetPlayerPed(_source))

	DiscordLogs("finish", "Finished Cooking", "green", {

		{name = "Player Informations", value = " ", inline = false},
		{name = "ID", value = tostring(_source), inline = true},
		{name = "Name", value = tostring(xPlayer.getName()), inline = true},
		{name = "Identifier", value = tostring(xPlayer.getIdentifier()), inline = true},
		

		{name = " ", value = " ", inline = false},


		{name = "Meth", value = " ", inline = false},
		{name = "Amount", value = tostring(Amount), inline = true},


		{name = " ", value = " ", inline = false},


		{name = "Cords", value = " ", inline = false},
		{name = "X", value = tostring(pos.x), inline = true},
		{name = "Y", value = tostring(pos.y), inline = true},
		{name = "Z", value = tostring(pos.z), inline = true},
	})
end)

RegisterServerEvent('esx_methcar:blow')
AddEventHandler('esx_methcar:blow', function(posx, posy, posz)
	local _source = source
	local xPlayers = ESX.GetPlayers()
	local xPlayer = ESX.GetPlayerFromId(_source)
	for i=1, #xPlayers, 1 do
		TriggerClientEvent('esx_methcar:blowup', xPlayers[i],posx, posy, posz)
	end

	xPlayer.removeInventoryItem('methlab', 1)

	DiscordLogs("explosion", "Explosion", "red", {
		{name = "Player Informations", value = " ", inline = false},
		{name = "ID", value = _source, inline = true},
		{name = "Name", value = xPlayer.getName(), inline = true},
		{name = "Identifier", value = xPlayer.getIdentifier(), inline = true},
		{name = " ", value = " ", inline = false},
		{name = "Cords", value = " ", inline = false},
		{name = "X", value = tostring(posx), inline = true},
		{name = "Y", value = tostring(posy), inline = true},
		{name = "Z", value = tostring(posz), inline = true},
	})
end)

local Cops = ESX.GetExtendedPlayers('job', Config.Police)
ESX.RegisterServerCallback('esx_methcar:getcops', function(source, cb)
	cb(Cops)
end)

function DiscordLogs(name, title, color, fields)
	local webHook = Config.DiscordLogs.Webhooks[name]
	if not webHook == 'WEEBHOCKED' then
		local embedData = {{
			['title'] = title,
			['color'] = Config.DiscordLogs.Colors[color],
			['footer'] = {
				['text'] = "| Unr3al Meth | " .. os.date(),
				['icon_url'] = "https://cdn.discordapp.com/attachments/1091344078924435456/1091458999020425349/OSaft-Logo.png"
			},
			['fields'] = fields,
			['author'] = {
				['name'] = "Meth Car",
				['icon_url'] = "https://cdn.discordapp.com/attachments/1091344078924435456/1091458999020425349/OSaft-Logo.png"
			}
		}}
		PerformHttpRequest(webHook, nil, 'POST', json.encode({
			embeds = embedData
		}), {
			['Content-Type'] = 'application/json'
		})
	end
  end