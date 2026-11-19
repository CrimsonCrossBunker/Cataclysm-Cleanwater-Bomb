local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "balthazar_bunker_solar_panel_row_1",
    layout = {
        size = { width = 21, height = 21 },
        rows = {
            "..PP....PP....PP....P",
            "..PP....PP....PP....P",
            "..PP....PP....PP....P",
            "..PP....PP....PP....P",
            "..PP....PP....PP....P",
            "..PP....PP....PP....P",
            "..PP....PP....PP....P",
            "..PP....PP....PP....P",
            "..PP....PP....PP....P",
            "..PP....PP....PP....P",
            "..PP....PP....PP....P",
            "..PP....PP....PP....P",
            "..PP....PP....PP....P",
            "..PP....PP....PP....P",
            "..PP....PP....PP....P",
            "..PP....PP....PP....P",
            "..PP....PP....PP....P",
            "..PP....PP....PP....P",
            "..PP....PP....PP....P",
            "..PP....PP....PP....P",
            "..PP....PP....PP....P",
        },
        furniture = { P = "f_solar_unit" },
        flags = { "ERASE_FURNITURE_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "balthazar_bunker_solar_panel_row_2",
    layout = {
        size = { width = 21, height = 21 },
        rows = {
            "P....PP....PP....PP..",
            "P....PP....PP....PP..",
            "P....PP....PP....PP..",
            "P....PP....PP....PP..",
            "P....PP....PP....PP..",
            "P....PP....PP....PP..",
            "P....PP....PP....PP..",
            "P....PP....PP....PP..",
            "P....PP....PP....PP..",
            "P....PP....PP....PP..",
            "P....PP....PP....PP..",
            "P....PP....PP....PP..",
            "P....PP....PP....PP..",
            "P....PP....PP....PP..",
            "P....PP....PP....PP..",
            "P....PP....PP....PP..",
            "P....PP....PP....PP..",
            "P....PP....PP....PP..",
            "P....PP....PP....PP..",
            "P....PP....PP....PP..",
            "P....PP....PP....PP..",
        },
        furniture = { P = "f_solar_unit" },
        flags = { "ERASE_FURNITURE_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "balthazar_bunker_solar_panel_row_l",
    layout = {
        nested = { { id = "balthazar_bunker_solar_panel_row_1", x = 3, y = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "balthazar_bunker_solar_panel_row_r",
    layout = {
        nested = { { id = "balthazar_bunker_solar_panel_row_2", x = 0, y = 1 } },
    },
}
