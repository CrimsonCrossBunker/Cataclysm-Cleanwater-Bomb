local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "fabric_store_pallete",
    layout = {
        item_groups = {
            C = { group = "SUS_fur_tailoring_materials", chance = 30 },
            J = { group = "SUS_janitors_closet", chance = 60 },
            L = {
                { group = "SUS_fur_tailoring_materials", chance = 50 },
                { group = "SUS_tailoring_fasteners", chance = 50 },
            },
            Q = { group = "SUS_tailoring_tool_drawer", chance = 80 },
            ["["] = { group = "SUS_tailoring_tool_drawer", chance = 30 },
            c = {
                { group = "SUS_tailoring_materials", chance = 50 },
                { group = "SUS_tailoring_materials", chance = 50 },
            },
            d = { group = "SUS_office_desk", chance = 60 },
            l = {
                { group = "SUS_tailoring_materials", chance = 30 },
                { group = "SUS_tailoring_fasteners", chance = 50 },
            },
        },
        terrain = {
            [";"] = { { id = "t_door_locked" }, { id = "t_door_elocked_alarm" } },
            i = "t_door_locked_interior",
            ["0"] = "t_window_alarm",
            z = "t_region_shrub_decorative",
            p = "t_region_groundcover_urban",
        },
        furniture = {
            ["%"] = "f_console_broken",
            c = "f_rack",
            C = "f_rack",
            Q = "f_rack",
            s = "f_stool",
            d = "f_desk",
            ["["] = "f_table",
            p = "f_region_flower",
            L = "f_locker",
            l = "f_locker",
            J = "f_locker",
        },
    },
}
