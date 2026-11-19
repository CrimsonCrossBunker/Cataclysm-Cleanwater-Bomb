local ccb = require("ccb")

-- Assuming the metal walls aren't supposed to have roofs
ccb.content.define_mapgen {
    kind = "overmap",
    id = "smallscrapyard_ocu_roof",
    layout = {
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "   RRRRRRR              ",
            "   RRRRRRR              ",
            "   RRRRRRR              ",
            "   RRRRRRR              ",
            "   RRRRRRR              ",
            "   RRRRRRR              ",
            "   RRRRRRR              ",
            "   RRRRRRR              ",
            "   RRRRRRR              ",
            "   RRRRRRR              ",
            "                        ",
            "   rrrrr                ",
            "   rrrrr                ",
            "   rrrrr                ",
            "   rrrrr                ",
            "   rrrrr                ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        terrain = { r = "t_wood_treated_roof", R = "t_flat_roof" },
        furniture = {},
        fill_terrain = "t_open_air",
    },
}
