local maxClients = GetConvarInt('sv_maxclients', 64)

local function OnPlayerConnecting(name, setKickReason, deferrals)
	if GetNumPlayerIndices() < maxClients then
		deferrals.defer()
		local identifiers = GetPlayerIdentifiers(source)
		local cname = string.gsub(name, "%s+", "")
		deferrals.update(string.format("Tvé jméno je kontrolováno.", name))

		-- Use this for logging and / or banning purposes!
		local ids = ''
		for _, v in pairs(identifiers) do
			local ids = ids..' '..v
		end

		if string.find(cname, "<http") then
			deferrals.done("Tvé jméno je velice krásné, ale bylo by dobrý si ho změnit jinak se nepřipojíš :D")
			logPlayer(name, ids)
		else
			deferrals.done()
		end
	end
end

AddEventHandler("playerConnecting", OnPlayerConnecting)

-- logging here, you can add your own ban system or what not
local function logPlayer(name, ids)
	local string = "Logged User -> "..name..", IDs: "..ids.."."
	local file = io.open('resources/'.. GetCurrentResourceName() .. '/Logs/log.txt', "a")
	print(string)
	io.output(file)
	io.write(string)
	io.close(file)
end
