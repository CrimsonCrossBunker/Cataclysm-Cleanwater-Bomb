local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "remove_robofac_intercom",
    layout = {
        npc_removals = { { id = "robofac_intercom", x = 19, y = 11 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "remove_robofac_mercs",
    layout = {
        npc_removals = {
            { id = "robofac_chop_shop_merc_1", x = { 0, 23 }, y = { 0, 23 } },
            { id = "robofac_chop_shop_merc_2", x = { 0, 23 }, y = { 0, 23 } },
            { id = "robofac_chop_shop_merc_3", x = { 0, 23 }, y = { 0, 23 } },
            { id = "robofac_chop_shop_merc_4", x = { 0, 23 }, y = { 0, 23 } },
            { id = "robofac_chop_shop_merc_5", x = { 0, 23 }, y = { 0, 23 } },
            { id = "robofac_chop_shop_merc_6", x = { 0, 23 }, y = { 0, 23 } },
        },
    },
}
