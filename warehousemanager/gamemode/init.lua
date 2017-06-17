AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("sql_database.lua")

include("shared.lua")
include("sql_database.lua")
include("player.lua")

function GM:PlayerConnect( name, ip )
	print(name .. " has joined the game.")
end

function GM:PlayerInitialSpawn( ply )
	print(ply:Nick() .. " has joined " .. team.GetName( Entity( 1 ):Team() ) .. ".")
	ply:SetSpawnTeam()
end

function GM:PlayerSpawn( ply )
	local n = math.Round(math.Rand(1,4))
	ply:SetGamemodeTeam(n)
//	ply:GiveWeapons()
	ply:SetupHands()
end

function GM:PlayerSetHandsModel( ply, ent )
	local simplemodel = player_manager.TranslateToPlayerModelName( ply:GetModel() )
	local info = player_manager.TranslatePlayerHands( simplemodel )
	if ( info ) then
		ent:SetModel( info.model )
		ent:SetSkin( info.skin )
		ent:SetBodyGroups( info.body )
	end
end

function GM:PlayerAuthed( ply, steamID, uniqueID )
	print(ply:Nick() .. " was authenticated.")
end
