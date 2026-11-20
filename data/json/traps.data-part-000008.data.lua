local ccb = require("ccb")

ccb.content.define_trap {
    id = "tr_dermatik",
    name = ccb.content.text("burrowed dermatik"),
    color = "green",
    symbol = "#",
    visibility = 99,
    avoidance = 99,
    difficulty = 99,
    trap_radius = 4,
    action = "none",
    always_invisible = true,
    avatar_message = ccb.content.text("Something burrows out of the ground at your feet!"),
    npc_message = ccb.content.text("Something burrows out of the ground at the feet of <npcname>! "),
    flags = { "CONSUME_ON_TRIGGER" },
    trigger_handler = "disturb_dermatik_trap",
}

ccb.content.define_trap {
    id = "tr_glass_pit",
    name = ccb.content.text("glass pit"),
    color = "cyan",
    memorial_male = ccb.content.text("Fell into a pit filled with glass shards.", "memorial_male"),
    memorial_female = ccb.content.text("Fell into a pit filled with glass shards.", "memorial_female"),
    symbol = "0",
    visibility = 0,
    avoidance = 8,
    difficulty = 99,
    flags = { "PIT", "ECHOLOCATION_DETECTABLE" },
    action = "pit_glass",
    vehicle = { damage = 500 },
}

ccb.content.define_trap {
    id = "tr_leather_funnel",
    name = ccb.content.text("leather funnel"),
    color = "brown",
    symbol = "v",
    visibility = -1,
    avoidance = 0,
    difficulty = 0,
    action = "none",
    drops = { "leather_funnel" },
    benign = true,
    funnel_radius_mm = 200,
}

ccb.content.define_trap {
    id = "tr_birchbark_funnel",
    name = ccb.content.text("birchbark funnel"),
    color = "white",
    symbol = "v",
    visibility = -1,
    avoidance = 0,
    difficulty = 0,
    action = "none",
    drops = { "birchbark_funnel" },
    benign = true,
    funnel_radius_mm = 200,
}

ccb.content.define_trap {
    id = "tr_downspout_funnel",
    name = ccb.content.text("downspout funnel"),
    color = "brown",
    symbol = "v",
    visibility = 999,
    avoidance = 0,
    difficulty = 0,
    action = "none",
    benign = true,
    funnel_radius_mm = 1200,
}

ccb.content.define_trap {
    id = "tr_metal_funnel",
    name = ccb.content.text("metal funnel"),
    color = "dark_gray",
    symbol = "V",
    visibility = -1,
    avoidance = 0,
    difficulty = 0,
    action = "none",
    drops = { "metal_funnel" },
    benign = true,
    funnel_radius_mm = 400,
}

ccb.content.define_trap {
    id = "tr_firewood_source",
    name = ccb.content.text("firewood source"),
    color = "green",
    symbol = "x",
    visibility = -1,
    avoidance = 0,
    difficulty = 0,
    action = "none",
    benign = true,
}

ccb.content.define_trap {
    id = "tr_practice_target",
    name = ccb.content.text("practice target"),
    color = "red",
    symbol = "x",
    visibility = -1,
    avoidance = 0,
    difficulty = 0,
    action = "none",
    benign = true,
}

ccb.content.define_trap {
    id = "tr_target_spinner",
    name = ccb.content.text("spinner target"),
    color = "light_gray",
    symbol = "%",
    visibility = -1,
    avoidance = 0,
    difficulty = 0,
    action = "none",
    drops = { "target_spinner" },
    benign = true,
}

ccb.content.define_trap {
    id = "tr_unfinished_construction",
    name = ccb.content.text("unfinished construction"),
    color = "white",
    symbol = "U",
    visibility = -1,
    avoidance = 0,
    difficulty = 0,
    action = "none",
    benign = true,
}

ccb.content.define_trap {
    id = "tr_raincatcher",
    name = ccb.content.text("raincatcher"),
    color = "blue",
    symbol = "V",
    visibility = -1,
    avoidance = 0,
    difficulty = 0,
    action = "none",
    drops = { "tarp_raincatcher" },
    benign = true,
    funnel_radius_mm = 342,
}
