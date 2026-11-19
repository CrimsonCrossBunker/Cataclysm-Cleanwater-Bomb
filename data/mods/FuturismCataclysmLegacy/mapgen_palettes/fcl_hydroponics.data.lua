local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "fcl_hydroponics_lab_palette",
    layout = {
        sealed_item_glyphs = {
            H = {
                item_group = { group = "farming_seeds", chance = 100 },
                furniture = "f_fcl_hydroponics_harvest",
            },
        },
        terrain = { H = "t_thconc_floor" },
    },
}
