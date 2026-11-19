local ccb = require("ccb")

-- a very mild toxicant, inducing nausea.
ccb.content.define_furniture {
    id = "f_swamp_gas",
    name = ccb.content.text("swamp gas"),
    description = ccb.content.text("A pool of murky water that occasionally bubbles, releasing a mildly toxic gas."),
    looks_like = "t_water_sh",
    symbol = "~",
    color = "blue",
    move_cost_mod = 1,
    coverage = 0,
    required_strength = -1,
    flags = { "TRANSPARENT" },
    emissions = { "emit_swamp_gas_leak" },
    bash = {
        minimum_strength = 30,
        maximum_strength = 60,
        sound = ccb.content.text("splash!"),
        failure_sound = ccb.content.text("splash!"),
        furniture = "f_swamp_gas",
    },
}

ccb.content.define_furniture {
    id = "f_fog",
    name = ccb.content.text("fog"),
    description = ccb.content.text("A misty cloud of fog."),
    looks_like = "t_moss",
    symbol = "^",
    color = "light_gray",
    move_cost_mod = 2,
    coverage = 0,
    required_strength = -1,
    flags = { "TRANSPARENT" },
    emissions = { "emit_fog_plume" },
}

ccb.content.define_furniture {
    id = "f_vent_cold_air2_stream",
    name = ccb.content.text("metal grate"),
    description = ccb.content.text("A metal vent.  You can feel cool air seeping out of it."),
    looks_like = "t_grate",
    symbol = "~",
    color = "blue",
    move_cost_mod = 0,
    coverage = 0,
    required_strength = -1,
    flags = { "TRANSPARENT" },
    emissions = { "emit_cold_air2_stream" },
}

ccb.content.define_furniture {
    id = "f_vent_cold_air2_blast",
    description = ccb.content.text("A metal vent.  You can feel cold air blasting out of it."),
    copy_from = "f_vent_cold_air2_stream",
    symbol = "~",
    color = "blue",
    emissions = { "emit_cold_air2_blast" },
}

ccb.content.define_furniture {
    id = "f_vent_hot_air2_stream",
    description = ccb.content.text("A metal vent.  You can feel hot air seeping out of it."),
    copy_from = "f_vent_cold_air2_stream",
    symbol = "~",
    color = "red",
    emissions = { "emit_hot_air2_stream" },
}

ccb.content.define_furniture {
    id = "f_vent_hot_air2_blast",
    copy_from = "f_vent_cold_air2_stream",
    description = ccb.content.text("A metal vent.  You can feel hot air seeping out of it."),
    symbol = "~",
    color = "red",
    emissions = { "emit_hot_air2_blast" },
}

ccb.content.define_furniture {
    id = "f_vent_toxic_leak",
    description = ccb.content.text("A metal vent.  Toxic-looking clouds seep from it."),
    copy_from = "f_vent_cold_air2_stream",
    symbol = "~",
    color = "green",
    emissions = { "emit_toxic_leak" },
}

ccb.content.define_furniture {
    id = "f_vent_toxic_belch",
    description = ccb.content.text("A metal vent.  Toxic-looking clouds stream from it."),
    copy_from = "f_vent_cold_air2_stream",
    symbol = "~",
    color = "green",
    emissions = { "emit_toxic_belch" },
}

ccb.content.define_furniture {
    id = "f_vent_rad_leak",
    description = ccb.content.text("A metal vent."),
    copy_from = "f_vent_cold_air2_stream",
    symbol = "~",
    color = "green",
    emissions = { "emit_rad_leak" },
}

ccb.content.define_furniture {
    id = "f_fog_breather",
    description = ccb.content.text("A misty cloud of water vapor."),
    copy_from = "f_fog",
    looks_like = "t_gelatinous_groundcover",
    symbol = "~",
    color = "pink",
    emissions = { "emit_fog_plume" },
}
