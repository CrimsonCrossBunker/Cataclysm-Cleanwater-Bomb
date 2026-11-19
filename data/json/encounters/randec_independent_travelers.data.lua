local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "nest_RandEnc_campervan_traveler_add",
    layout = {
        vehicle_placements = {
            {
                id = "traveler_van_motorhome",
                fuel = 85,
                rotation = 270,
                faction = "no_faction",
                x = { 1 },
                y = { 2 },
            },
        },
        npc_placements = { { id = "traveler_camper_van", x = 1, y = 2, unique_id = "TRAVELER" } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "nest_RandEnc_campervan_traveler_remove",
    layout = {
        npc_removals = { { id = "traveler_camper_van", x = { 0, 23 }, y = { 0, 23 } } },
        vehicle_removals = { { prototypes = { "traveler_van_motorhome" }, x = { 0, 23 }, y = { 0, 23 } } },
    },
}
