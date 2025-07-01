--stolen from cryptid mod :(
local player_fallback = 23792 -- isaac player count on 2025-07-01 at 14:22:52 UTC (happy canada day)
local succ, https = pcall(require, "SMODS.https")
isaac.player_count = player_fallback
if not succ then
	sendErrorMessage("HTTP module could not be loaded. " .. tostring(https), "TBOB")
end

local function apply_players(code, body, headers)
	if body then
        print(string.match(body, '"player_count"%s*:%s*(%d+)'))
		isaac.player_count = tonumber(string.match(body, '"player_count"%s*:%s*(%d+)')) or isaac.player_count
	end
end
function isaac.update_member_count()
	if https and https.asyncRequest then
			https.asyncRequest(
				"http://api.steampowered.com/ISteamUserStats/GetNumberOfCurrentPlayers/v1/?appid=250900", -- cryptid discord thing uses time or smth idk steam is just a get request with no headers
				apply_players
			)
	end
end

isaac.update_member_count()