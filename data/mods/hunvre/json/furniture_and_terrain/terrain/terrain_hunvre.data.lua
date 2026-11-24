local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_concrete_light",
    copy_from = "t_concrete",
    name = ccb.content.text("Concrete light"),
    description = ccb.content.text("Concrete light"),
    extend = { flags = { "TRANSPARENT_FLOOR" } },
}

ccb.content.define_terrain {
    id = "t_floor_container",
    copy_from = "t_concrete_light",
    name = ccb.content.text("Container"),
    description = ccb.content.text("Container"),
    extend = { flags = { "CONTAINER" } },
}

ccb.content.define_terrain {
    id = "t_wall_control",
    copy_from = "t_concrete",
    name = ccb.content.text("wall controls"),
    description = ccb.content.text("Wall controls."),
    examine_handler = "examine_retractable_furniture",
}

ccb.content.define_terrain {
    id = "t_ret_furn_target",
    copy_from = "t_sidewalk",
    name = ccb.content.text("Target"),
    description = ccb.content.text("Target"),
}

ccb.content.define_terrain {
    id = "t_airlock_control",
    copy_from = "t_concrete",
    name = ccb.content.text("airlock controls"),
    description = ccb.content.text("Airlock controls."),
}

ccb.content.define_terrain {
    id = "t_contraband_scanner",
    name = ccb.content.text("contraband scanner"),
    description = ccb.content.text("An advanced device capable of scanning objects passing through it for contraband, often compared to the metal detectors of old.  This one is still functioning and might trigger an alarm."),
    symbol = "M",
    color = "light_blue",
    trap = "tr_contraband_scanner",
    max_volume = "800 L",
    move_cost = 2,
    flags = { "INDOORS", "PERMEABLE", "THIN_OBSTACLE", "TRANSPARENT" },
    bash = {
        minimum_strength = 20,
        maximum_strength = 55,
        terrain = "t_concrete_light",
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        drops = {
            { item = "scrap", count = { 1, 6 } },
            { item = "plastic_chunk", count = { 4, 8 } },
            { item = "cable", count = { 1, 2 } },
            { item = "e_scrap", count = { 8, 12 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_central_elevator",
    copy_from = "t_elevator",
    name = ccb.content.text("central elevator"),
}

ccb.content.define_terrain {
    id = "t_central_elevator_closed",
    copy_from = "t_elevator",
    name = ccb.content.text("closed central elevator hatch"),
    delete = { flags = { "ELEVATOR" } },
}
