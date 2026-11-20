local ccb = require("ccb")

ccb.content.define_map_extra_collection {
    id = "backrooms",
    chance = 30,
    extras = {
        { extra = "mx_teleporter_node", weight = 5000 },
        { extra = "mx_casings", weight = 2500 },
        { extra = "mx_corpses", weight = 2500 },
        { extra = "mx_autodoc_room", weight = 1250 },
        { extra = "mx_collegekids", weight = 1250 },
        { extra = "mx_spider", weight = 1000 },
        { extra = "mx_nest_dermatik_backrooms", weight = 1000 },
        { extra = "mx_science", weight = 1000 },
        { extra = "mx_crater", weight = 500 },
        { extra = "mx_nest_wasp_backrooms", weight = 500 },
        { extra = "mx_house_wasp", weight = 500 },
        { extra = "mx_pond", weight = 500 },
        { extra = "mx_military", weight = 500 },
        { extra = "mx_drugdeal", weight = 500 },
        { extra = "mx_supplydrop", weight = 500 },
        { extra = "mx_portal", weight = 150 },
        { extra = "mx_portal_in", weight = 150 },
        { extra = "mx_helicopter", weight = 50 },
        { extra = "mx_jabberwock", weight = 1 },
    },
}
