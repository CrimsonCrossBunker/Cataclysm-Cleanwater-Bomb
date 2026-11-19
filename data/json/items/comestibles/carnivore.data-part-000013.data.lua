local ccb = require("ccb")

ccb.content.define_item {
    id = "blood_tainted",
    copy_from = "meat_tainted",
    name = ccb.content.plural_text("tainted blood", "tainted blood"),
    description = ccb.content.text("Blood that's obviously unhealthy.  You could drink it, but it will poison you."),
    display_type = "BY_VOLUME",
    mass = "262 g",
    volume = "250 ml",
    looks_like = "blood",
    symbol = "~",
    materials = { "blood" },
    phase = "liquid",
    comestible = { kind = "DRINK", servings = 1, smoking_result = "null" },
}

ccb.content.define_item {
    id = "blood_tainted_human",
    copy_from = "meat_tainted_human",
    name = ccb.content.plural_text("tainted human blood", "tainted human blood"),
    description = ccb.content.text("Blood that's obviously unhealthy, and from a human to boot.  You could drink it, but it will poison you."),
    display_type = "BY_VOLUME",
    mass = "262 g",
    volume = "250 ml",
    looks_like = "blood",
    symbol = "~",
    materials = { "hblood" },
    phase = "liquid",
    comestible = { kind = "DRINK", servings = 1, smoking_result = "null" },
}
