local ccb = require("ccb")
local content = ccb.content

-- Native map-extra collection definitions
do
local definition = content.MapExtraCollection {
    id = "backrooms",
    chance = 30,
}
definition:extra("mx_teleporter_node", 5000)
definition:extra("mx_casings", 2500)
definition:extra("mx_corpses", 2500)
definition:extra("mx_autodoc_room", 1250)
definition:extra("mx_collegekids", 1250)
definition:extra("mx_spider", 1000)
definition:extra("mx_nest_dermatik_backrooms", 1000)
definition:extra("mx_science", 1000)
definition:extra("mx_crater", 500)
definition:extra("mx_nest_wasp_backrooms", 500)
definition:extra("mx_house_wasp", 500)
definition:extra("mx_pond", 500)
definition:extra("mx_military", 500)
definition:extra("mx_drugdeal", 500)
definition:extra("mx_supplydrop", 500)
definition:extra("mx_portal", 150)
definition:extra("mx_portal_in", 150)
definition:extra("mx_helicopter", 50)
definition:extra("mx_jabberwock", 1)
content.add(definition)
end
