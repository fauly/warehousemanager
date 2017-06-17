function set_money( t,n,v )
	sql.Query( "INSERT INTO "..t.." ('"..n.."')VALUES ('"..v.."')" )
	return true
end

function tables_exist()
	if (sql.TableExists("player_flags") && sql.TableExists("player_skills") && sql.TableExists("player_info")) then
		Msg("Tables already exist.")
	else
		if (!sql.TableExists("player_info")) then
			query = "CREATE TABLE player_info ( unique_id varchar(255), mm int)"
			result = sql.Query(query)
			if (sql.TableExists("player_info")) then
				print("Player Info Table Queried.")
			else
				print("Error with the player_info query.")
				print( sql.LastError( result ))
			end	
		end
		if (!sql.TableExists("player_skills")) then
			query = "CREATE TABLE player_skills (unique_id varchar(255), packs int, packq int, tw int)"
			result = sql.Query(query)
			if (sql.TableExists("player_skills")) then
				print("Player Skills Table Queried.")
			else
				print("Error with the player_skills query.")
				print( sql.LastError( result ))
			end		
		end
		if (!sql.TableExists("player_flags")) then
			query = "CREATE TABLE player_flags ( unique_id varchar(255), hasteam bit, isboss bit)"
			result = sql.Query(query)
			if (sql.TableExists("player_flags")) then
				print("Player Flags Table Queried.")
			else
				print("Error with the player_flags query.")
				print( sql.LastError( result ))
			end	
		end
	end
 
end

function new_player( SteamID, ply )
		steamID = SteamID
		sql.Query( "INSERT INTO player_info (`unique_id`, `mm`)VALUES ('"..steamID.."', '175')" )
		result = sql.Query( "SELECT unique_id, money FROM player_info WHERE unique_id = '"..steamID.."'" )
		if (result) then
 
			sql.Query( "INSERT INTO player_skills (`unique_id`, `speech`, `fish`, `farm`)VALUES ('"..steamID.."', '1', '1', '1')" )
			result = sql.Query( "SELECT unique_id, speech, fish, farm FROM player_skills WHERE unique_id = '"..steamID.."'" )
			if (result) then
				Msg("Player account created !\n")
				sql_value_stats( ply )
				sql_value_skills( ply )
			else
				Msg("Something went wrong with creating a players skills !\n")
			end
 
		else
			Msg("Something went wrong with creating a players info !\n")
		end
end
 
function player_exists( ply )
 
	steamID = ply:GetNWString("SteamID")
 
	result = sql.Query("SELECT unique_id, money FROM player_info WHERE unique_id = '"..steamID.."'")
	if (result) then
			sql_value_stats( ply ) // We will call this to retrieve the stats
			sql_value_skills( ply ) // We will call this to retrieve the skills
	else
		new_player( steamID, ply ) // Create a new player
	end
end
 
function Initialize()
	tables_exist()
end
 
function sqlIS( ply )
 	timer.Create("Steam_id_delay", 1, 1, function()
		SteamID = ply:SteamID()
		ply:SetNWString("SteamID", SteamID)
		timer.Create("SaveStat", 10, 0, function() saveStat( ply ) end)
		player_exists( ply ) 
	end)
 
end
 
hook.Add( "PlayerInitialSpawn", "InitialSpawn", sqlIS)
hook.Add( "Initialize", "Initialize", Initialize) 
 