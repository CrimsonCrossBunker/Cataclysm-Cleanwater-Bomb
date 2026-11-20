local ccb = require("ccb")

ccb.content.define_trap {
    id = "tr_teeth",
    name = ccb.content.text("scattered monster teeth"),
    color = "light_cyan",
    memorial_male = ccb.content.text("Stepped on teeth.", "memorial_male"),
    memorial_female = ccb.content.text("Stepped on teeth.", "memorial_female"),
    symbol = "_",
    visibility = 6,
    avoidance = 8,
    difficulty = 0,
    action = "caltrops",
    drops = { "nm_teeth" },
    vehicle = { sound_volume = 10, sound = ccb.content.text("Crunch!") },
}

ccb.content.define_trap {
    id = "tr_caltrops_teeth",
    name = ccb.content.text("monster teeth caltrops"),
    color = "dark_gray",
    memorial_male = ccb.content.text("Stepped on a tooth caltrop.", "memorial_male"),
    memorial_female = ccb.content.text("Stepped on a tooth caltrop.", "memorial_female"),
    symbol = "_",
    visibility = 6,
    avoidance = 6,
    difficulty = 0,
    action = "caltrops",
    drops = { "caltrops_teeth" },
    vehicle = { damage = 600 },
}
