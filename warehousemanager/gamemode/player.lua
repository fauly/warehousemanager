local ply = FindMetaTable("Player")

local teams = {}

teams[0] = {
			name ="Citizen", 
			color = Vector(0.3,0.3,0.3), 
			weapons = {},
			model = {
					"models/player/Group01/Female_01.mdl",
					"models/player/Group01/Female_02.mdl",
					"models/player/Group01/Female_03.mdl",
					"models/player/Group01/Female_04.mdl",
					"models/player/Group01/Female_06.mdl",
					"models/player/Group01/Female_07.mdl",
					"models/player/Group01/Male_01.mdl",
					"models/player/Group01/Male_02.mdl",
					"models/player/Group01/Male_03.mdl",
					"models/player/Group01/Male_04.mdl",
					"models/player/Group01/Male_06.mdl",
					"models/player/Group01/Male_07.mdl"
			}
}

teams[1] = {
			name ="Luthex", 
			color = Vector(0.764, 0.564, 0.831), 
			weapons = {"weapon_crowbar"}, 
			modelstaff = {}, 
			modelboss = ""
}

teams[2] = {
			name ="Carnabi", 
			color = Vector(0.631, 0.831, 0.564), 
			weapons = {"weapon_pistol"}, 
			modelstaff = {},
			modelboss = ""
}

teams[3] = {
			name ="Richmond", 
			color = Vector(0.564, 0.764, 0.831), 
			weapons = {"weapon_physcannon"}, 
			modelstaff = {}, 
			modelboss = ""
}

teams[4] = {
			name ="Renelead", 
			color = Vector(0.764, 0.564, 0.831), 
			weapons = {"weapon_physgun"}, 
			modelstaff = {}, 
			modelboss = ""
}

function ply:SetSpawnTeam()
	self:SetTeam(0)
	self:StripWeapons()
	
	local n = math.Round(math.Rand(0,11))
	self:SetModel(teams[0].model[n])
	self:SetPlayerColor(teams[0].color)
	return true
end

function ply:SetGamemodeTeam( n )
	if not teams[n] then return end
	
	self:SetTeam( n )
	self:SetPlayerColor( teams[n].color )
	self:StripWeapons()
	
//	print(Player:Nick() .. " has joined " .. teams[n].name .. ".")
	
	for k, wep in pairs(teams[n].weapons) do
		self:Give(wep)
	end
	
	return true
end

function ply:GiveWeapons()
	local n = self:Team()
	self:StripWeapons()
	
	for k, wep in pairs(teams[n].weapons) do
		self:Give(wep)
	end
end