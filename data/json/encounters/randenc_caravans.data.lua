local ccb = require("ccb")

-- Adds a random encounter at this roadstop
ccb.content.define_mapgen {
    kind = "update",
    id = "nest_RandEnc_roadstop_a_add",
    layout = {
        npc_placements = {
            { id = "FM_caravan_merchant_random", x = 5, y = 4 },
            { id = "FM_caravan_guard_A", x = 4, y = 1 },
            { id = "FM_caravan_guard_B", x = 4, y = 2 },
        },
        vehicle_placements = { { id = "FM_early_pickup", fuel = 50, faction = "free_merchants", x = { 4 }, y = { 1 } } },
    },
}

-- removes a random encounter at this roadstop
ccb.content.define_mapgen {
    kind = "update",
    id = "nest_RandEnc_roadstop_a_remove",
    layout = {
        npc_removals = {
            { id = "FM_caravan_merchant_random", x = 0, y = 0 },
            { id = "FM_caravan_guard_A", x = 0, y = 0 },
            { id = "FM_caravan_guard_B", x = 0, y = 0 },
        },
        vehicle_removals = { { prototypes = { "FM_early_pickup" }, x = { 1, 15 }, y = { 1, 10 } } },
    },
}

-- Adds refugee random encounter at this roadstop
ccb.content.define_mapgen {
    kind = "update",
    id = "nest_RandEnc_roadstop_a_refugee_add",
    layout = {
        npc_placements = {
            { id = "NC_caravan_refugee_A", x = 5, y = 4 },
            { id = "NC_caravan_refugee_B", x = 4, y = 1 },
            { id = "NC_caravan_refugee_C", x = 4, y = 2 },
        },
    },
}

-- removes refugee random encounter at this roadstop
ccb.content.define_mapgen {
    kind = "update",
    id = "nest_RandEnc_roadstop_a_refugee_remove",
    layout = {
        npc_removals = {
            { id = "NC_caravan_refugee_A", x = 0, y = 0 },
            { id = "NC_caravan_refugee_B", x = 0, y = 0 },
            { id = "NC_caravan_refugee_C", x = 0, y = 0 },
        },
    },
}
