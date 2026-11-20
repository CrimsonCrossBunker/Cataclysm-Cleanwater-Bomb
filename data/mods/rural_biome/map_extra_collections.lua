local ccb = require("ccb")
local content = ccb.content

-- Native map-extra collection definitions
do
local definition = content.MapExtraCollection {
    id = "forest_ruralbiome",
    chance = 20,
}
definition:extra("mx_helicopter", 4)
definition:extra("mx_portal", 3)
definition:extra("mx_crater", 10)
definition:extra("mx_portal_in", 3)
definition:extra("mx_grass", 20)
definition:extra("mx_grass2", 40)
definition:extra("mx_fallen_shed", 30)
definition:extra("mx_spider", 200)
definition:extra("mx_nest_wasp", 100)
definition:extra("mx_grove", 500)
definition:extra("mx_shrubbery", 500)
definition:extra("mx_clearcut", 125)
definition:extra("mx_pond", 125)
definition:extra("mx_pond_forest", 125)
definition:extra("mx_pond_forest_2", 125)
definition:extra("mx_clay_deposit", 125)
definition:extra("mx_point_dead_vegetation", 500)
definition:extra("mx_point_burned_ground", 500)
definition:extra("mx_mass_grave", 5)
content.add(definition)
end
do
local definition = content.MapExtraCollection {
    id = "forest_thick_ruralbiome",
    chance = 30,
}
definition:extra("mx_blackberry_patch", 65000)
definition:extra("mx_grove", 25000)
definition:extra("mx_shrubbery", 25000)
definition:extra("mx_point_dead_vegetation", 25000)
definition:extra("mx_point_burned_ground", 25000)
definition:extra("mx_clearcut", 6250)
definition:extra("mx_pond", 6250)
definition:extra("mx_pond_forest", 6250)
definition:extra("mx_pond_forest_2", 6250)
definition:extra("mx_clay_deposit", 6250)
definition:extra("mx_knotweed_patch", 5000)
definition:extra("mx_beehive_natural", 1500)
definition:extra("mx_nest_wasp", 1250)
definition:extra("mx_spider", 1000)
definition:extra("mx_grass2", 1000)
definition:extra("mx_grass", 500)
definition:extra("mx_fallen_shed", 200)
definition:extra("mx_portal", 150)
definition:extra("mx_portal_in", 150)
definition:extra("mx_helicopter", 50)
definition:extra("mx_jabberwock", 1)
content.add(definition)
end
do
local definition = content.MapExtraCollection {
    id = "forest_water_ruralbiome",
    chance = 22,
}
definition:extra("mx_helicopter", 4)
definition:extra("mx_portal", 3)
definition:extra("mx_crater", 10)
definition:extra("mx_portal_in", 3)
definition:extra("mx_fallen_shed", 5)
definition:extra("mx_spider", 200)
definition:extra("mx_grass", 20)
definition:extra("mx_grass2", 20)
definition:extra("mx_pond", 125)
definition:extra("mx_grove", 500)
definition:extra("mx_shrubbery", 500)
definition:extra("mx_clearcut", 125)
definition:extra("mx_clay_deposit", 125)
definition:extra("mx_point_dead_vegetation", 500)
definition:extra("mx_point_burned_ground", 500)
definition:extra("mx_nest_dermatik", 10)
content.add(definition)
end
do
local definition = content.MapExtraCollection {
    id = "field_ruralbiome",
    chance = 7,
}
definition:extra("mx_helicopter", 3)
definition:extra("mx_portal", 1)
definition:extra("mx_crater", 15)
definition:extra("mx_portal_in", 1)
definition:extra("mx_point_dead_vegetation", 50)
definition:extra("mx_grass", 700)
definition:extra("mx_grass2", 350)
definition:extra("mx_trees", 100)
definition:extra("mx_trees2", 80)
definition:extra("mx_Trapdoor_spider_den", 4)
definition:extra("mx_fallen_shed", 5)
definition:extra("mx_pond", 20)
definition:extra("mx_point_burned_ground", 50)
definition:extra("mx_nest_wasp", 2)
content.add(definition)
end
do
local definition = content.MapExtraCollection {
    id = "road_ruralbiome",
    chance = 75,
}
definition:extra("mx_helicopter", 25)
definition:extra("mx_roadblock", 15)
definition:extra("mx_roadblock_mil", 5)
definition:extra("mx_bandits_block", 80)
definition:extra("mx_supplydrop", 1)
definition:extra("mx_portal", 5)
definition:extra("mx_crater", 200)
definition:extra("mx_portal_in", 4)
definition:extra("mx_roadworks", 100)
definition:extra("mx_mayhem", 50)
definition:extra("mx_casings", 100)
definition:extra("mx_prison_bus", 5)
content.add(definition)
end
do
local definition = content.MapExtraCollection {
    id = "build_ruralbiome",
    chance = 90,
}
definition:extra("mx_house_spider", 40)
definition:extra("mx_house_wasp", 60)
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
content.add(definition)
end
do
local definition = content.MapExtraCollection {
    id = "marloss_ruralbiome",
    chance = 20,
}
definition:extra("mx_marloss_pilgrimage", 100)
content.add(definition)
end
do
local definition = content.MapExtraCollection {
    id = "subway_ruralbiome",
    chance = 75,
}
definition:extra("mx_portal", 7)
definition:extra("mx_portal_in", 3)
content.add(definition)
end
