local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_roadblock_mil",
    layout = {
        rows = {
            "----------------------  ",
            "----------------------  ",
            "----------------------  ",
            "----bbbbbbb--bbbbbbb--  ",
            "----------------------  ",
            "----------------------  ",
            "------------t---------  ",
            "------------ssss------  ",
            "-------------Lg-------  ",
            "------------ssss------  ",
            "----------------------  ",
            "----------------------  ",
            "----------------------  ",
            "----------------------  ",
            "----------------------  ",
            "----------------------  ",
            "----------------------  ",
            "----------------------  ",
            "----------------------  ",
            "-----------t----------  ",
            "----------------------  ",
            "----bbbbbbb--bbbbbbb--  ",
            "                        ",
            "                        ",
        },
        furniture = { s = "f_sandbag_half", g = "f_active_backup_generator", b = "f_barricade_road" },
        nested_glyphs = {
            ["-"] = { choices = { { id = "soldier_guns_3x3", weight = 1 }, { id = "null", weight = 50 } } },
        },
        monster_glyphs = { t = { id = "mon_feral_soldier" }, L = { id = "mon_turret_searchlight" } },
        vehicle_placements = {
            { id = "armored_car", x = 6, y = 7, status = 1, rotation = 270 },
            { id = "military_cargo_truck", x = 7, y = 17, status = 1, rotation = 180 },
            { id = "armored_car", x = 18, y = 17, status = 1 },
        },
    },
}
