local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = {
        "iso_first_elevator", "iso_elevator", "iso_elevator_safe", "iso_next_level_elevator",
        "iso_elevator_microlab_embed", "iso_elevator_microlab_embed_next",
    },
    name = ccb.content.text("lab elevator"),
    color = "light_red",
    symbol = "L",
    see_cost = "high",
}

ccb.content.define_overmap_terrain {
    id = "mlb_generic_subhallway",
    copy_from = "microlab_generic",
    flags = { "RISK_EXTREME", "SOURCE_CHEMISTRY", "SOURCE_MEDICINE" },
}

ccb.content.define_overmap_terrain {
    id = { "iso_hallway_isolated" },
    name = ccb.content.text("lab entrance hallway"),
    symbol = "L",
    color = "light_red",
    see_cost = "high",
    flags = { "RISK_EXTREME" },
}

ccb.content.define_overmap_terrain {
    id = { "iso_hallway_safe" },
    name = ccb.content.text("lab safepoint"),
    symbol = "L",
    color = "light_red",
    see_cost = "high",
    flags = { "SOURCE_SAFETY" },
}

ccb.content.define_overmap_terrain {
    id = { "iso_nexus", "iso_nexus_1", "iso_nexus_2", "iso_nexus_3", "iso_nexus_4", "iso_nexus_5" },
    copy_from = "iso_hallway_safe",
    name = ccb.content.text("Balthazar Nexus"),
    flags = { "RISK_EXTREME", "SOURCE_CHEMISTRY", "SOURCE_MEDICINE" },
}

ccb.content.define_overmap_terrain {
    id = { "iso_office", "iso_elevator_office" },
    name = ccb.content.text("Lab administrative office"),
    symbol = "L",
    color = "white",
    see_cost = "high",
    spawns = { group = "GROUP_MICROLAB", population = { 0, 5 }, chance = 80 },
    flags = { "NO_ROTATE", "RISK_HIGH", "SOURCE_CHEMISTRY", "SOURCE_MEDICINE" },
}

ccb.content.define_overmap_terrain {
    id = "iso_elevator_office_next",
    name = ccb.content.text("Administrative elevator"),
    symbol = "L",
    color = "light_red",
    see_cost = "high",
    spawns = { group = "GROUP_MICROLAB", population = { 0, 5 }, chance = 80 },
    flags = { "NO_ROTATE", "RISK_HIGH", "SOURCE_CHEMISTRY", "SOURCE_MEDICINE" },
}
