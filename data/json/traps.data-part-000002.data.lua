local ccb = require("ccb")

ccb.content.define_trap {
    id = "tr_goo",
    name = ccb.content.text("goo pit"),
    color = "dark_gray",
    memorial_male = ccb.content.text("Stepped into thick goo.", "memorial_male"),
    memorial_female = ccb.content.text("Stepped into thick goo.", "memorial_female"),
    symbol = "_",
    visibility = 0,
    avoidance = 15,
    difficulty = 15,
    action = "goo",
}

ccb.content.define_trap {
    id = "tr_dissector",
    name = ccb.content.text("exposed high-energy conduit"),
    color = "cyan",
    memorial_male = ccb.content.text("Stepped into an exposed high-energy conduit.", "memorial_male"),
    memorial_female = ccb.content.text("Stepped into an exposed high-energy conduit.", "memorial_female"),
    flags = { "ECHOLOCATION_DETECTABLE" },
    symbol = "7",
    visibility = 2,
    avoidance = 20,
    difficulty = 99,
    action = "dissector",
    vehicle = {
        damage = 500,
        sound_volume = 10,
        sound = ccb.content.text("BRZZZAP!"),
        sound_type = "trap",
        sound_variant = "dissector",
    },
}

ccb.content.define_trap {
    id = "tr_sinkhole",
    name = ccb.content.text("sinkhole"),
    color = "brown",
    memorial_male = ccb.content.text("Stepped into a sinkhole.", "memorial_male"),
    memorial_female = ccb.content.text("Stepped into a sinkhole.", "memorial_female"),
    symbol = "_",
    visibility = 10,
    avoidance = 14,
    difficulty = 99,
    action = "sinkhole",
    flags = { "SONAR_DETECTABLE" },
    vehicle = { damage = 500 },
}

ccb.content.define_trap {
    id = "tr_pit",
    name = ccb.content.text("pit"),
    color = "brown",
    memorial_male = ccb.content.text("Fell in a pit.", "memorial_male"),
    memorial_female = ccb.content.text("Fell in a pit.", "memorial_female"),
    flags = { "ECHOLOCATION_DETECTABLE", "PIT" },
    symbol = "0",
    visibility = 0,
    avoidance = 8,
    difficulty = 99,
    action = "pit",
    vehicle = { damage = 500 },
}

ccb.content.define_trap {
    id = "tr_thin_ice",
    name = ccb.content.text("thin ice"),
    color = "light_cyan",
    memorial_male = ccb.content.text("Fell through thin ice into water.", "memorial_male"),
    memorial_female = ccb.content.text("Fell through thin ice into water.", "memorial_female"),
    flags = { "ECHOLOCATION_DETECTABLE" },
    symbol = "/",
    visibility = 0,
    avoidance = 12,
    difficulty = 99,
    action = "thin_ice",
    avatar_message = ccb.content.text("The ice cracks beneath you!"),
    vehicle = { chance = 80, damage = 30, remove_trap = true },
}

ccb.content.define_trap {
    id = "tr_thick_ice",
    name = ccb.content.text("thick ice"),
    color = "cyan",
    memorial_male = ccb.content.text("Stumbled on ice.", "memorial_male"),
    memorial_female = ccb.content.text("Stumbled on ice.", "memorial_female"),
    flags = { "ECHOLOCATION_DETECTABLE" },
    symbol = "/",
    visibility = 0,
    avoidance = 4,
    difficulty = 99,
    action = "thick_ice",
    avatar_message = ccb.content.text("You stumbled on the ice!"),
}

ccb.content.define_trap {
    id = "tr_spike_pit",
    name = ccb.content.text("spiked pit"),
    color = "blue",
    memorial_male = ccb.content.text("Fell into a spiked pit.", "memorial_male"),
    memorial_female = ccb.content.text("Fell into a spiked pit.", "memorial_female"),
    flags = { "ECHOLOCATION_DETECTABLE", "PIT" },
    symbol = "0",
    visibility = 0,
    avoidance = 8,
    difficulty = 99,
    action = "pit_spikes",
    vehicle = { damage = 500 },
}

ccb.content.define_trap {
    id = "tr_lava",
    name = ccb.content.text("lava"),
    color = "red",
    memorial_male = ccb.content.text("Stepped into lava.", "memorial_male"),
    memorial_female = ccb.content.text("Stepped into lava.", "memorial_female"),
    symbol = "~",
    visibility = 0,
    avoidance = 99,
    difficulty = 99,
    action = "lava",
    flags = { "CONVECTS_TEMPERATURE" },
    vehicle = { damage = 500 },
    avatar_message = ccb.content.text("You stepped into lava!"),
    npc_message = ccb.content.text("<npcname> stepped into lava!"),
}
