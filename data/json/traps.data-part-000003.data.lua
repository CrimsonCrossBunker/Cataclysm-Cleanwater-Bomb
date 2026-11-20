local ccb = require("ccb")

ccb.content.define_trap {
    id = "tr_boobytrap",
    trigger_weight = "200 g",
    name = ccb.content.text("booby trap"),
    color = "light_cyan",
    memorial_male = ccb.content.text("Triggered a booby trap.", "memorial_male"),
    memorial_female = ccb.content.text("Triggered a booby trap.", "memorial_female"),
    symbol = "^",
    flags = { "ECHOLOCATION_DETECTABLE" },
    visibility = 5,
    avoidance = 4,
    difficulty = 0,
    action = "boobytrap",
    drops = { "boobytrap" },
    vehicle = {
        explosion = true,
        damage = 1000,
        shrapnel = 12,
        sound_volume = 18,
        sound = ccb.content.text("Boom!"),
        sound_type = "explosion",
        sound_variant = "default",
    },
}

ccb.content.define_trap {
    id = "tr_temple_flood",
    name = ccb.content.text("ledge"),
    color = "light_gray",
    memorial_male = ccb.content.text("Triggered a flood trap.", "memorial_male"),
    memorial_female = ccb.content.text("Triggered a flood trap.", "memorial_female"),
    flags = { "ECHOLOCATION_DETECTABLE" },
    symbol = "^",
    visibility = 9,
    avoidance = 20,
    difficulty = 99,
    action = "temple_flood",
}

ccb.content.define_trap {
    id = "tr_temple_toggle",
    name = "",
    color = "white",
    symbol = "^",
    visibility = 99,
    avoidance = 99,
    difficulty = 99,
    action = "temple_toggle",
    always_invisible = true,
}

ccb.content.define_trap {
    id = "tr_glow",
    name = "",
    color = "white",
    symbol = "^",
    visibility = 99,
    avoidance = 99,
    difficulty = 99,
    action = "glow",
    always_invisible = true,
}

ccb.content.define_trap {
    id = "tr_hum",
    name = "",
    color = "white",
    symbol = "^",
    visibility = 99,
    avoidance = 99,
    difficulty = 99,
    action = "hum",
    always_invisible = true,
}

ccb.content.define_trap {
    id = "tr_shadow",
    name = "",
    color = "white",
    memorial_male = ccb.content.text("Triggered a shadow trap.", "memorial_male"),
    memorial_female = ccb.content.text("Triggered a shadow trap.", "memorial_female"),
    symbol = "^",
    visibility = 99,
    avoidance = 99,
    difficulty = 99,
    action = "shadow",
    always_invisible = true,
}

ccb.content.define_trap {
    id = "tr_drain",
    name = "",
    color = "white",
    memorial_male = ccb.content.text("Triggered a life-draining trap.", "memorial_male"),
    memorial_female = ccb.content.text("Triggered a life-draining trap.", "memorial_female"),
    symbol = "^",
    visibility = 99,
    avoidance = 99,
    difficulty = 99,
    action = "drain",
    always_invisible = true,
}

ccb.content.define_trap {
    id = "tr_snake",
    name = "",
    color = "white",
    memorial_male = ccb.content.text("Triggered a shadow snake trap.", "memorial_male"),
    memorial_female = ccb.content.text("Triggered a shadow snake trap.", "memorial_female"),
    symbol = "^",
    visibility = 99,
    avoidance = 99,
    difficulty = 99,
    action = "snake",
    always_invisible = true,
}
