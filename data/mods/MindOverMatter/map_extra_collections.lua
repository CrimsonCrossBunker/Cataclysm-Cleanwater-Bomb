local ccb = require("ccb")
local content = ccb.content

-- Native map-extra collection definitions
do
local definition = content.MapExtraCollection {
    id = "phavian_lab_lot",
    chance = 3,
}
definition:extra("mx_helicopter", 15)
definition:extra("mx_military", 65)
definition:extra("mx_collegekids", 1)
definition:extra("mx_portal", 150)
definition:extra("mx_crater", 180)
definition:extra("mx_alien_grass", 25)
definition:extra("mx_alien_grass_2", 25)
definition:extra("mx_alien_grass_3", 25)
definition:extra("mx_alien_grass_4", 25)
definition:extra("mx_alien_grass_5", 25)
definition:extra("mx_alien_grove", 25)
definition:extra("mx_nether_pond", 50)
definition:extra("mx_portal_in", 30)
definition:extra("mx_point_burned_ground", 100)
definition:extra("mx_casings", 30)
definition:extra("mx_exocrash_1", 1)
definition:extra("mx_exocrash_2", 1)
content.add(definition)
end
do
local definition = content.MapExtraCollection {
    id = "phavian_lab_interior",
    chance = 2,
}
definition:extra("mx_crater", 15000)
definition:extra("mx_point_burned_ground", 6250)
definition:extra("mx_portal", 3750)
definition:extra("mx_glass_and_crystal", 2500)
definition:extra("mx_nether_pond", 2500)
definition:extra("mx_portal_in", 2000)
definition:extra("mx_casings", 1500)
definition:extra("mx_alien_grass", 1250)
definition:extra("mx_alien_grass_2", 1250)
definition:extra("mx_alien_grass_3", 1250)
definition:extra("mx_alien_grass_4", 1250)
definition:extra("mx_alien_grass_5", 1250)
definition:extra("mx_military", 250)
definition:extra("mx_jabberwock", 1)
content.add(definition)
end
