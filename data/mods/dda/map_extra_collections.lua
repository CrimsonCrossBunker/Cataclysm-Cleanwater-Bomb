local ccb = require("ccb")
local content = ccb.content

-- Native map-extra collection definitions
do
local definition = content.MapExtraCollection {
    id = "default_portal_storm_dungeon_extras",
    chance = 15,
}
definition:extra("mx_portal_cracked_mirror", 1)
definition:extra("mx_portal_ingress", 1)
definition:extra("mx_portal_distortion_item", 1)
content.add(definition)
end
do
local definition = content.MapExtraCollection {
    id = "forest",
    chance = 40,
}
definition:extra("mx_blackberry_patch", 450)
definition:extra("mx_point_dead_vegetation", 500)
definition:extra("mx_point_burned_ground", 500)
definition:extra("mx_strawberry_patch", 180)
definition:extra("mx_blueberry_patch", 180)
definition:extra("mx_raspberry_patch", 180)
definition:extra("mx_huckleberry_patch", 180)
definition:extra("mx_hobblebush_patch", 180)
definition:extra("mx_autumn_olive_patch", 180)
definition:extra("mx_grove", 500)
definition:extra("mx_shrubbery", 500)
definition:extra("mx_spider", 200)
definition:extra("mx_clearcut", 125)
definition:extra("mx_pond", 125)
definition:extra("mx_pond_forest", 125)
definition:extra("mx_pond_forest_2", 125)
definition:extra("mx_clay_deposit", 125)
definition:extra("mx_knotweed_patch", 120)
definition:extra("mx_nest_wasp", 50)
definition:extra("mx_grass2", 40)
definition:extra("mx_casings", 30)
definition:extra("mx_fallen_shed", 30)
definition:extra("mx_corpses", 30)
definition:extra("mx_collegekids", 20)
definition:extra("mx_grass", 20)
definition:extra("mx_science", 5)
definition:extra("mx_toxic_waste", 10)
definition:extra("mx_military", 8)
definition:extra("mx_drugdeal", 8)
definition:extra("mx_mass_grave", 5)
definition:extra("mx_portal", 3)
definition:extra("mx_portal_in", 3)
definition:extra("mx_helicopter", 1)
definition:extra("mx_exocrash_1", 1)
definition:extra("mx_beehive_natural", 20)
definition:extra("mx_exocrash_2", 1)
content.add(definition)
end
do
local definition = content.MapExtraCollection {
    id = "forest_thick",
    chance = 30,
}
definition:extra("mx_blackberry_patch", 22500)
definition:extra("mx_grove", 25000)
definition:extra("mx_shrubbery", 25000)
definition:extra("mx_point_dead_vegetation", 25000)
definition:extra("mx_point_burned_ground", 25000)
definition:extra("mx_strawberry_patch", 7500)
definition:extra("mx_blueberry_patch", 7500)
definition:extra("mx_raspberry_patch", 7500)
definition:extra("mx_huckleberry_patch", 7500)
definition:extra("mx_hobblebush_patch", 7500)
definition:extra("mx_autumn_olive_patch", 7500)
definition:extra("mx_clearcut", 6250)
definition:extra("mx_pond", 6250)
definition:extra("mx_pond_forest", 6250)
definition:extra("mx_pond_forest_2", 6250)
definition:extra("mx_clay_deposit", 6250)
definition:extra("mx_knotweed_patch", 5000)
definition:extra("mx_casings", 1500)
definition:extra("mx_corpses", 1500)
definition:extra("mx_beehive_natural", 1500)
definition:extra("mx_nest_wasp", 1250)
definition:extra("mx_spider", 1000)
definition:extra("mx_collegekids", 1000)
definition:extra("mx_drugdeal", 1000)
definition:extra("mx_grass2", 1000)
definition:extra("mx_fallen_shed", 1000)
definition:extra("mx_toxic_waste", 750)
definition:extra("mx_grass", 500)
definition:extra("mx_military", 400)
definition:extra("mx_science", 250)
definition:extra("mx_mass_grave", 250)
definition:extra("mx_mass_grave_jabberwock", 5)
definition:extra("mx_portal", 150)
definition:extra("mx_portal_in", 150)
definition:extra("mx_exocrash_1", 50)
definition:extra("mx_helicopter", 50)
definition:extra("mx_exocrash_2", 50)
definition:extra("mx_jabberwock", 1)
content.add(definition)
end
do
local definition = content.MapExtraCollection {
    id = "forest_water",
    chance = 20,
}
definition:extra("mx_pond", 240)
definition:extra("mx_spider", 200)
definition:extra("mx_clay_deposit", 140)
definition:extra("mx_knotweed_patch", 140)
definition:extra("mx_nest_dermatik", 75)
definition:extra("mx_point_dead_vegetation", 60)
definition:extra("mx_science", 15)
definition:extra("mx_military", 25)
definition:extra("mx_drugdeal", 20)
definition:extra("mx_fallen_shed", 10)
definition:extra("mx_casings", 60)
definition:extra("mx_corpses", 80)
definition:extra("mx_grass2", 20)
definition:extra("mx_grass", 10)
definition:extra("mx_toxic_waste", 10)
definition:extra("mx_portal", 8)
definition:extra("mx_portal_in", 7)
definition:extra("mx_helicopter", 5)
definition:extra("mx_exocrash_1", 1)
definition:extra("mx_beehive_natural", 25)
definition:extra("mx_exocrash_2", 1)
content.add(definition)
end
do
local definition = content.MapExtraCollection {
    id = "field",
    chance = 6,
}
definition:extra("mx_grass", 3500)
definition:extra("mx_grass2", 3500)
definition:extra("mx_trees2", 800)
definition:extra("mx_point_burned_ground", 500)
definition:extra("mx_point_dead_vegetation", 500)
definition:extra("mx_trees", 500)
definition:extra("mx_knotweed_patch", 250)
definition:extra("mx_fallen_shed", 200)
definition:extra("mx_sand_patch", 200)
definition:extra("mx_casings", 200)
definition:extra("mx_pond", 150)
definition:extra("mx_nest_wasp", 50)
definition:extra("mx_mass_grave", 50)
definition:extra("mx_mass_grave_jabberwock", 1)
definition:extra("mx_grave", 50)
definition:extra("mx_supplydrop", 4)
definition:extra("mx_Trapdoor_spider_den", 40)
definition:extra("mx_collegekids", 30)
definition:extra("mx_drugdeal", 30)
definition:extra("mx_corpses", 30)
definition:extra("mx_finalshowdown", 20)
definition:extra("mx_dermatikvictim", 10)
definition:extra("mx_worm_sign", 20)
definition:extra("mx_toxic_waste", 10)
definition:extra("mx_portal", 10)
definition:extra("mx_portal_in", 10)
definition:extra("mx_science", 10)
definition:extra("mx_military", 4)
definition:extra("mx_exocrash_1", 5)
definition:extra("mx_exocrash_2", 5)
definition:extra("mx_golden_monoliths", 1)
content.add(definition)
end
do
local definition = content.MapExtraCollection {
    id = "ocean_bed",
    chance = 30,
}
definition:extra("mx_kelp_patch", 1)
content.add(definition)
end
do
local definition = content.MapExtraCollection {
    id = "ocean_shore",
    chance = 1,
}
definition:extra("mx_sandy_beach", 100)
definition:extra("mx_tidal_flat", 5)
content.add(definition)
end
do
local definition = content.MapExtraCollection {
    id = "road",
    chance = 100,
}
definition:extra("mx_helicopter", 1)
definition:extra("mx_military", 10)
definition:extra("mx_science", 10)
definition:extra("mx_collegekids", 500)
definition:extra("mx_roadblock", 830)
definition:extra("mx_roadblock_mil", 170)
definition:extra("mx_bandits_block", 400)
definition:extra("mx_drugdeal", 100)
definition:extra("mx_supplydrop", 5)
definition:extra("mx_portal", 50)
definition:extra("mx_portal_in", 40)
definition:extra("mx_roadworks", 1000)
definition:extra("mx_mayhem", 500)
definition:extra("mx_casings", 1000)
definition:extra("mx_corpses", 300)
definition:extra("mx_prison_bus", 150)
definition:extra("mx_prison_van", 10)
definition:extra("mx_exocrash_1", 5)
definition:extra("mx_exocrash_2", 5)
definition:extra("mx_XEDRA_serum_transport", 5)
content.add(definition)
end
do
local definition = content.MapExtraCollection {
    id = "park",
    chance = 600,
}
definition:extra("mx_fungal_zone", 100)
content.add(definition)
end
do
local definition = content.MapExtraCollection {
    id = "road_nesw_manhole",
    chance = 20,
}
definition:extra("mx_city_trap", 1)
definition:extra("mx_laststand", 1)
content.add(definition)
end
do
local definition = content.MapExtraCollection {
    id = "build",
    chance = 90,
}
definition:extra("mx_bugout", 10)
definition:extra("mx_house_spider", 40)
definition:extra("mx_house_wasp", 30)
definition:extra("mx_military", 5)
definition:extra("mx_science", 7)
definition:extra("mx_collegekids", 15)
definition:extra("mx_dormant", 30)
definition:extra("mx_portal", 5)
definition:extra("mx_portal_in", 3)
definition:extra("mx_point_burned_ground", 5)
definition:extra("mx_casings", 30)
definition:extra("mx_looters", 10)
definition:extra("mx_corpses", 30)
content.add(definition)
end
do
local definition = content.MapExtraCollection {
    id = "marloss",
    chance = 60,
}
definition:extra("mx_marloss_pilgrimage", 100)
content.add(definition)
end
do
local definition = content.MapExtraCollection {
    id = "subway",
    chance = 100,
}
definition:extra("mx_military", 5)
definition:extra("mx_science", 12)
definition:extra("mx_drugdeal", 5)
definition:extra("mx_casings", 10)
definition:extra("mx_dormant", 10)
content.add(definition)
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
content.add(definition)
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
definition:extra("mx_casings", 30)
definition:extra("mx_exocrash_1", 1)
definition:extra("mx_exocrash_2", 1)
content.add(definition)
end
do
local definition = content.MapExtraCollection {
    id = "research_facility_interior",
    chance = 2,
}
definition:extra("mx_crater", 15000)
definition:extra("mx_portal", 5000)
definition:extra("mx_portal_in", 2000)
definition:extra("mx_casings", 1500)
definition:extra("mx_military", 250)
definition:extra("mx_jabberwock", 1)
content.add(definition)
end
do
local definition = content.MapExtraCollection {
    id = "river",
    chance = 1,
}
definition:extra("mx_null", 66)
definition:extra("mx_riverside_boat", 1)
definition:extra("mx_riverside_jetski", 1)
definition:extra("mx_reed", 33)
content.add(definition)
end
do
local definition = content.MapExtraCollection {
    id = "lake_shore",
    chance = 2,
}
definition:extra("mx_reed", 100)
content.add(definition)
end
do
local definition = content.MapExtraCollection {
    id = "agricultural",
    chance = 38,
}
definition:extra("mx_point_burned_ground", 500)
definition:extra("mx_point_dead_vegetation", 500)
definition:extra("mx_casings", 200)
definition:extra("mx_nest_wasp", 50)
definition:extra("mx_mass_grave", 50)
definition:extra("mx_mass_grave_jabberwock", 2)
definition:extra("mx_grave", 50)
definition:extra("mx_supplydrop", 2)
definition:extra("mx_Trapdoor_spider_den", 40)
definition:extra("mx_collegekids", 30)
definition:extra("mx_drugdeal", 30)
definition:extra("mx_corpses", 30)
definition:extra("mx_portal", 10)
definition:extra("mx_portal_in", 10)
definition:extra("mx_science", 5)
definition:extra("mx_military", 4)
definition:extra("mx_exocrash_1", 5)
definition:extra("mx_exocrash_2", 5)
content.add(definition)
end
