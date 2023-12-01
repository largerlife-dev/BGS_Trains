local eastTrain = nil
local westTrain = nil
local tram = nil

local eastBartender = nil
local westBartender = nil

local players = {}

RegisterServerEvent("BGS_Trains:StoreServerTram")
AddEventHandler("BGS_Trains:StoreServerTram", function(clientTram)
	tram = clientTram
end)

RegisterServerEvent("BGS_Trains:StoreServerTrainEast")
AddEventHandler("BGS_Trains:StoreServerTrainEast", function(clientTrain, bartender)
	eastTrain = clientTrain
	eastBartender = bartender
end)

RegisterServerEvent("BGS_Trains:StoreServerTrainWest")
AddEventHandler("BGS_Trains:StoreServerTrainEast", function(clientTrain, bartender)
	westTrain = clientTrain
	westBartender = bartender
end)

RegisterServerEvent("BGS_Trains:ReturnServerTrains")
AddEventHandler("BGS_Trains:ReturnServerTrains", function(addToList)
	local _source = source
	if addToList then
		table.insert(players, _source)
	end
	TriggerClientEvent("BGS_Trains:GetServerTrains", _source, eastTrain, westTrain, tram, eastBartender, westBartender)
end)

RegisterServerEvent("BGS_Trains:UpdateTrainsAllPlayers", function ()
	local peds = GetAllPeds()
	for index, ped in ipairs(peds) do
		if IsPedAPlayer(ped) then
			TriggerClientEvent("BGS_Trains:GetServerTrains", ped, eastTrain, westTrain, tram, eastBartender, westBartender)
		end
	end
end)

AddEventHandler("playerDropped", function(reason)
	local _source = source
	for index, player in ipairs(players) do
		if player == _source then
			table.remove(players, index)
			break
		end
	end
	if #players < 1 then
		eastTrain = nil
		westTrain = nil
		eastBartender = nil
		westBartender = nil
		tram = nil
	end
end)