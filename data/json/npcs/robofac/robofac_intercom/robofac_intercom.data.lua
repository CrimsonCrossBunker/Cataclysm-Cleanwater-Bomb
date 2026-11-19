local ccb = require("ccb")

-- migration from older saved games - remove existing NPCs
ccb.content.define_mapgen {
    kind = "update",
    id = "nest_robofac_add_free_merchant_camp",
    layout = {
        nested = { { x = 0, y = 0, id = "robofac_hq_surface_freemerchant_camp" } },
        npc_removals = {
            { id = "roabofac_free_merchant", x = 0, y = 0 },
            { id = "guard", x = 0, y = 0 },
            { id = "NC_ROBOFAC_FREE_MERCHANT", x = 0, y = 0 },
            { id = "NC_BOUNTY_HUNTER", x = 0, y = 0 },
        },
    },
}
