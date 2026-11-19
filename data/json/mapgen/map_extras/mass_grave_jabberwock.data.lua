local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_mass_grave_jabberwock",
    layout = {
        nested = { { choices = { { id = "mass_grave_jabberwock_finished", weight = 10 } }, x = 0, y = 0 } },
    },
}

-- corpses
ccb.content.define_mapgen {
    kind = "nested",
    id = "mass_grave_jabberwock_finished",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "                        ",
            "   ##  ##  aa  #a  aa   ",
            "   ##  ##  aa  aa  aa   ",
            "   ##  ##  aa  aa  aa   ",
            "   ##  ##  aa  aa  DD   ",
            "   ##  ##  #a  aa  DD   ",
            "   ##  ##  DD  aa  DD   ",
            "   ##  ##  DD  aa  DD   ",
            "   ##  ##  DD  aa  DD   ",
            "   ##  ##  DD  aa  DD   ",
            "   ##  ##  DD  aa  DD   ",
            "   ##  ##  DD  aa  DD X ",
            "   ##  ##  DD  aa  DD   ",
            "   ##  ##  DD  aa  DD   ",
            "   ##  ##  DD  aa  DD   ",
            "   ##  ##  ##  a#  DD   ",
            "   ##  ##  ##  a#  DD   ",
            "   ##  ##  ##  ##  DD   ",
            "   ##  ##  ##  ##  DD   ",
            "   ##  ##  ##  ##  DD   ",
            "   ##  ##  ##  ##  DD   ",
            "   ##  ##  ##  ##  DD   ",
            "   ##  ##  ##  ##  DD   ",
            "                        ",
        },
        terrain = {
            a = { { id = "t_pit_corpsed_flesh" } },
            ["#"] = { { id = "t_dirt" } },
            D = { { id = "t_pit_corpsed_flesh", copies = 1 }, { id = "t_dirt", copies = 1 } },
        },
        furniture = { X = { { id = "f_null", copies = 3 }, { id = "f_battlefield_cross", copies = 1 } } },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        loot_placements = {
            {
                group = "mass_grave_casings",
                repetitions = { 10, 15 },
                x = { 2, 22 },
                y = { 18, 23 },
            },
            { group = "SUS_trash_floor", repetitions = { 5, 6 }, x = { 1, 23 }, y = { 18, 23 } },
        },
        monster_group_placements = { { group = "GROUP_MASS_GRAVE_JABBERWOCK", density = 0.8, x = { 1, 22 }, y = { 1, 22 } } },
    },
}
