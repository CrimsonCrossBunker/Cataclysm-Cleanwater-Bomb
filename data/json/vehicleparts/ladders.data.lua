local ccb = require("ccb")

ccb.content.define_vehicle_part {
    abstract = "ladder",
    location = "under",
    color = "brown",
    categories = { "utility" },
    looks_like = "f_rope_up",
    variants = { { symbols = "<", broken_symbols = "O" } },
    flags = { "LADDER", "SHOCK_IMMUNE", "BOARDABLE" },
    description = ccb.content.text("A ladder that lets you down from heights."),
}

ccb.content.define_vehicle_part {
    id = "ladder_3",
    copy_from = "ladder",
    name = ccb.content.text("3-story rope ladder"),
    item = "rope_30",
    categories = { "utility" },
    ladder_length = 3,
    requirements = {
        removal = { skills = { { "mechanics", 2 } }, duration = "60 m", using_requirements = {} },
    },
    durability = 60,
    damage_modifier = 80,
    breaks_into = { { item = "string_6", count = { 10, 20 } } },
    damage_reduction = { bash = 10 },
}
