local ccb = require("ccb")
local content = ccb.content

-- Native map-extra collection definitions
do
local definition = content.MapExtraCollection {
    id = "forest",
    chance = 120,
}
definition:extra("mx_helicopter", 1)
definition:extra("mx_military", 8)
definition:extra("mx_science", 20)
definition:extra("mx_collegekids", 25)
definition:extra("mx_drugdeal", 8)
definition:extra("mx_supplydrop", 8)
definition:extra("mx_portal", 3)
definition:extra("mx_crater", 10)
definition:extra("mx_portal_in", 3)
definition:extra("mx_fallen_shed", 30)
definition:extra("mx_nest_wasp", 50)
definition:extra("mx_shrubbery", 500)
definition:extra("mx_clearcut", 125)
definition:extra("mx_clay_deposit", 125)
definition:extra("mx_casings", 30)
definition:extra("mx_corpses", 30)
definition:extra("mx_mass_grave", 5)
definition:extra("mx_exocrash_1", 1)
definition:extra("mx_exocrash_2", 1)
content.replace(definition)
end
do
local definition = content.MapExtraCollection {
    id = "forest_thick",
    chance = 120,
}
definition:extra("mx_clay_deposit", 6250)
definition:extra("mx_casings", 1500)
definition:extra("mx_corpses", 1500)
definition:extra("mx_collegekids", 1250)
definition:extra("mx_science", 1000)
definition:extra("mx_drugdeal", 1000)
definition:extra("mx_fallen_shed", 1000)
definition:extra("mx_supplydrop", 500)
definition:extra("mx_crater", 500)
definition:extra("mx_military", 400)
definition:extra("mx_mass_grave", 250)
definition:extra("mx_portal", 150)
definition:extra("mx_portal_in", 150)
definition:extra("mx_helicopter", 50)
definition:extra("mx_exocrash_1", 50)
definition:extra("mx_exocrash_2", 50)
definition:extra("mx_jabberwock", 1)
content.replace(definition)
end
do
local definition = content.MapExtraCollection {
    id = "forest_water",
    chance = 120,
}
definition:extra("mx_helicopter", 5)
definition:extra("mx_military", 25)
definition:extra("mx_science", 50)
definition:extra("mx_drugdeal", 20)
definition:extra("mx_supplydrop", 25)
definition:extra("mx_portal", 8)
definition:extra("mx_crater", 20)
definition:extra("mx_portal_in", 7)
definition:extra("mx_fallen_shed", 10)
definition:extra("mx_clay_deposit", 140)
definition:extra("mx_casings", 60)
definition:extra("mx_corpses", 80)
definition:extra("mx_exocrash_1", 1)
definition:extra("mx_exocrash_2", 1)
content.replace(definition)
end
do
local definition = content.MapExtraCollection {
    id = "field",
    chance = 140,
}
definition:extra("mx_helicopter", 2)
definition:extra("mx_military", 4)
definition:extra("mx_science", 10)
definition:extra("mx_collegekids", 30)
definition:extra("mx_drugdeal", 30)
definition:extra("mx_supplydrop", 40)
definition:extra("mx_portal", 10)
definition:extra("mx_crater", 150)
definition:extra("mx_portal_in", 10)
definition:extra("mx_fallen_shed", 200)
definition:extra("mx_casings", 200)
definition:extra("mx_corpses", 30)
definition:extra("mx_mass_grave", 50)
definition:extra("mx_grave", 50)
definition:extra("mx_exocrash_1", 5)
definition:extra("mx_exocrash_2", 5)
content.replace(definition)
end
do
local definition = content.MapExtraCollection {
    id = "road",
    chance = 75,
}
definition:extra("mx_helicopter", 10)
definition:extra("mx_military", 50)
definition:extra("mx_science", 400)
definition:extra("mx_collegekids", 500)
definition:extra("mx_roadblock", 830)
definition:extra("mx_roadblock_mil", 170)
definition:extra("mx_bandits_block", 800)
definition:extra("mx_drugdeal", 300)
definition:extra("mx_supplydrop", 100)
definition:extra("mx_portal", 50)
definition:extra("mx_crater", 100)
definition:extra("mx_portal_in", 40)
definition:extra("mx_roadworks", 1000)
definition:extra("mx_mayhem", 500)
definition:extra("mx_casings", 1000)
definition:extra("mx_corpses", 300)
definition:extra("mx_prison_bus", 150)
definition:extra("mx_prison_van", 10)
definition:extra("mx_exocrash_1", 5)
definition:extra("mx_exocrash_2", 5)
content.replace(definition)
end
do
local definition = content.MapExtraCollection {
    id = "road_nesw_manhole_desert",
    chance = 20,
}
definition:extra("mx_city_trap", 100)
content.add(definition)
end
do
local definition = content.MapExtraCollection {
    id = "build",
    chance = 90,
}
definition:extra("mx_bugout", 20)
definition:extra("mx_house_spider", 40)
definition:extra("mx_military", 5)
definition:extra("mx_science", 12)
definition:extra("mx_collegekids", 15)
definition:extra("mx_portal", 5)
definition:extra("mx_crater", 60)
definition:extra("mx_portal_in", 3)
definition:extra("mx_point_burned_ground", 5)
definition:extra("mx_casings", 30)
definition:extra("mx_looters", 10)
definition:extra("mx_corpses", 30)
content.replace(definition)
end
do
local definition = content.MapExtraCollection {
    id = "marloss",
    chance = 20,
}
definition:extra("mx_marloss_pilgrimage", 100)
content.replace(definition)
end
do
local definition = content.MapExtraCollection {
    id = "subway",
    chance = 75,
}
definition:extra("mx_military", 5)
definition:extra("mx_science", 12)
definition:extra("mx_drugdeal", 5)
definition:extra("mx_casings", 10)
content.replace(definition)
end
do
local definition = content.MapExtraCollection {
    id = "lab_subway",
    chance = 25,
}
definition:extra("mx_military", 5)
definition:extra("mx_science", 15)
definition:extra("mx_portal", 3)
definition:extra("mx_portal_in", 3)
content.replace(definition)
end
do
local definition = content.MapExtraCollection {
    id = "research_facility_lot",
    chance = 3,
}
definition:extra("mx_helicopter", 15)
definition:extra("mx_military", 65)
definition:extra("mx_collegekids", 1)
definition:extra("mx_portal", 200)
definition:extra("mx_crater", 180)
definition:extra("mx_portal_in", 30)
definition:extra("mx_point_burned_ground", 100)
definition:extra("mx_casings", 30)
definition:extra("mx_exocrash_1", 1)
definition:extra("mx_exocrash_2", 1)
content.replace(definition)
end
do
local definition = content.MapExtraCollection {
    id = "research_facility_interior",
    chance = 2,
}
definition:extra("mx_crater", 15000)
definition:extra("mx_portal", 5000)
definition:extra("mx_point_burned_ground", 6250)
definition:extra("mx_portal_in", 2000)
definition:extra("mx_casings", 1500)
definition:extra("mx_military", 250)
definition:extra("mx_jabberwock", 1)
content.replace(definition)
end
do
local definition = content.MapExtraCollection {
    id = "river",
    chance = 3,
}
definition:extra("mx_reed", 100)
content.replace(definition)
end
do
local definition = content.MapExtraCollection {
    id = "lake_shore",
    chance = 2,
}
definition:extra("mx_reed", 100)
content.replace(definition)
end
