local ccb = require("ccb")

ccb.content.define_trap {
    id = "tr_bubblewrap",
    name = ccb.content.text("bubble wrap"),
    color = "light_cyan",
    memorial_male = ccb.content.text("Stepped on bubble wrap.", "memorial_male"),
    memorial_female = ccb.content.text("Stepped on bubble wrap.", "memorial_female"),
    symbol = "_",
    visibility = -1,
    avoidance = 8,
    difficulty = 0,
    action = "bubble",
    drops = { "bubblewrap" },
    vehicle = { sound_volume = 18, sound = ccb.content.text("Pop!") },
}

ccb.content.define_trap {
    id = "tr_glass",
    name = ccb.content.text("glass shards"),
    color = "light_cyan",
    memorial_male = ccb.content.text("Stepped on glass.", "memorial_male"),
    memorial_female = ccb.content.text("Stepped on glass.", "memorial_female"),
    symbol = "_",
    visibility = 6,
    avoidance = 8,
    difficulty = 0,
    action = "glass",
    drops = { "glass_shard" },
    vehicle = { sound_volume = 10, sound = ccb.content.text("Crunch!") },
}

ccb.content.define_trap {
    id = "tr_cot",
    name = ccb.content.text("cot"),
    color = "green",
    symbol = "#",
    visibility = -1,
    avoidance = 0,
    difficulty = 0,
    comfort = 4,
    floor_bedding_warmth = -500,
    action = "cot",
    drops = { "cot" },
    benign = true,
}

ccb.content.define_trap {
    id = "tr_funnel",
    name = ccb.content.text("funnel"),
    color = "yellow",
    symbol = "V",
    visibility = -1,
    avoidance = 0,
    difficulty = 0,
    action = "none",
    drops = { "funnel" },
    benign = true,
    funnel_radius_mm = 300,
}

ccb.content.define_trap {
    id = "tr_makeshift_funnel",
    name = ccb.content.text("makeshift funnel"),
    color = "yellow",
    symbol = "v",
    visibility = -1,
    avoidance = 0,
    difficulty = 0,
    action = "none",
    drops = { "makeshift_funnel" },
    benign = true,
    funnel_radius_mm = 200,
}

ccb.content.define_trap {
    id = "tr_mattress",
    name = ccb.content.text("mattress"),
    color = "white",
    symbol = "0",
    visibility = -1,
    avoidance = 0,
    difficulty = 0,
    comfort = 4,
    floor_bedding_warmth = 800,
    action = "none",
    drops = { "mattress" },
    benign = true,
}

ccb.content.define_trap {
    id = "tr_down_mattress",
    name = ccb.content.text("down mattress"),
    color = "white",
    symbol = "0",
    visibility = -1,
    avoidance = 0,
    difficulty = 0,
    comfort = 4,
    floor_bedding_warmth = 800,
    action = "none",
    drops = { "down_mattress" },
    benign = true,
}

ccb.content.define_trap {
    id = "tr_rollmat",
    name = ccb.content.text("roll mat"),
    color = "blue",
    symbol = "#",
    visibility = -1,
    avoidance = 0,
    difficulty = 0,
    comfort = 4,
    floor_bedding_warmth = -1000,
    action = "none",
    drops = { "rollmat" },
    benign = true,
}

ccb.content.define_trap {
    id = "tr_fur_rollmat",
    name = ccb.content.text("fur roll mat"),
    color = "brown",
    symbol = "#",
    visibility = -1,
    avoidance = 0,
    difficulty = 0,
    comfort = 4,
    floor_bedding_warmth = -1000,
    action = "none",
    drops = { "fur_rollmat" },
    benign = true,
}

ccb.content.define_trap {
    id = "tr_microlab_shifting_hall",
    name = ccb.content.text("microlab shifting hall"),
    color = "brown",
    memorial_male = ccb.content.text("Triggered a dimensional anomaly.", "memorial_male"),
    memorial_female = ccb.content.text("Triggered a dimensional anomaly.", "memorial_female"),
    symbol = ".",
    visibility = 99,
    avoidance = 99,
    difficulty = 99,
    action = "map_regen",
    map_regen = "microlab_shifting_hall",
    benign = false,
}

ccb.content.define_trap {
    id = "tr_microlab_shifting_hall_2",
    name = ccb.content.text("microlab shifting hall"),
    color = "brown",
    memorial_male = ccb.content.text("Triggered a dimensional anomaly.", "memorial_male"),
    memorial_female = ccb.content.text("Triggered a dimensional anomaly.", "memorial_female"),
    symbol = ".",
    visibility = 99,
    avoidance = 99,
    difficulty = 99,
    action = "map_regen",
    map_regen = "microlab_shifting_hall_2",
    benign = false,
}

ccb.content.define_trap {
    id = "tr_microlab_portal_elevator_physics_shift",
    name = ccb.content.text("microlab shifting elevator"),
    color = "magenta",
    memorial_male = ccb.content.text("Triggered a dimensional anomaly.", "memorial_male"),
    memorial_female = ccb.content.text("Triggered a dimensional anomaly.", "memorial_female"),
    symbol = ".",
    visibility = 99,
    avoidance = 99,
    difficulty = 99,
    action = "map_regen",
    map_regen = "microlab_portal_elevator_physics_shift",
    benign = false,
}
