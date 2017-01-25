GM.Name = "Warehouse Manager"
GM.Author = "Fauly"
GM.Email = "faulyfaux@gmail.com"
GM.Website = "N/A"
GM.Version = "2016-12-04"

team.SetUp(0, "Citizen", Color(76.5, 76.5, 76.5))
team.SetUp(1, "Luthex", Color(195, 144, 212))
team.SetUp(2, "Carnabi", Color(161, 212, 144))
team.SetUp(3, "Richmond", Color(144, 195, 212))
team.SetUp(4, "Renelead", Color(212, 161, 144))

AddCSLuaFile("sql_database.lua")
include("sql_database.lua")

function GM:Initialize()
	self.BaseClass.Initialize( self )
end