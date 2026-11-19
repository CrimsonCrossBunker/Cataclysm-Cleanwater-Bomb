local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_tanglevine_patch",
    layout = {
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        monster_placements = {
            {
                id = "mon_tanglevine",
                x = { 6, 18 },
                y = { 6, 18 },
                chance = 100,
                repetitions = { 3, 8 },
            },
        },
    },
}
