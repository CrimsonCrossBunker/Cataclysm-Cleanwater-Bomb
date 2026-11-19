local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "darryl_place_coop",
    layout = {
        nested = { { id = "darryl_coop", x = 10, y = 10 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "place_solar_farm",
    layout = {
        nested = { { id = "solar_farm_spawn", x = 22, y = 6 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "place_herb_garden",
    layout = {
        nested = { { id = "kostas_herb_garden", x = 0, y = 9 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "olwen_radio_adapter",
    layout = {
        nested = { { id = "olwen_radio_adapter", x = 1, y = 18 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "place_left_corner_wall",
    layout = {
        nested = { { id = "godco_wall_left_corner", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "place_right_corner_wall",
    layout = {
        nested = { { id = "godco_wall_right_corner", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "place_right_corner_wall_bottom",
    layout = {
        nested = { { id = "godco_wall_right_corner_bottom", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "place_left_corner_wall_bottom",
    layout = {
        nested = { { id = "godco_wall_left_corner_bottom", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "place_straight_up_wall_left",
    layout = {
        nested = { { id = "godco_wall_up_straight_left", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "place_straight_up_wall_right",
    layout = {
        nested = { { id = "godco_wall_up_straight_right", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "place_straight_bottom_wall",
    layout = {
        nested = { { id = "godco_wall_bottom_straight", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "place_straight_top_wall",
    layout = {
        nested = { { id = "godco_wall_top_straight", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "place_gate_wall",
    layout = {
        nested = { { id = "godco_wall_gate", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "place_food_warehouse",
    layout = {
        nested = { { id = "eddie_food_storage", x = 6, y = 6 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "helena_planer",
    layout = {
        nested = { { id = "spawn_planer", x = 6, y = 11 }, { id = "spawn_planer", x = 11, y = 11 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "godco_permanent_trader_change",
    layout = {
        nested = { { id = "godco_permanent_trader_predatory_remove", x = 1, y = 8 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "godco_permanent_trader_predatory_add",
    layout = {
        nested = { { id = "godco_permanent_trader_predatory", x = 1, y = 8 } },
    },
}
