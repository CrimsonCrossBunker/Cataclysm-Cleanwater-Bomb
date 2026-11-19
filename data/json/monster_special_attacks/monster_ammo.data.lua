local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "boomer_bile",
    name = ccb.content.text_without_extraction("boomer bile"),
    description = ccb.content.text_without_extraction("Boomer bile, if you see this it's a bug."),
    mass = "3 g",
    volume = "250 ml",
    materials = { "water" },
    symbol = "=",
    color = "pink",
    phase = "liquid",
    ammunition = { type = "bile", range = 4, count = 1, effects = { "BILE_JET", "BILE_STINK", "BILE_BLIND" } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "boomer_bile_adv",
    name = ccb.content.text_without_extraction("advanced boomer bile"),
    description = ccb.content.text_without_extraction("Boomer bile, if you see this it's a bug."),
    mass = "3 g",
    volume = "250 ml",
    materials = { "water" },
    symbol = "=",
    color = "pink",
    phase = "liquid",
    ammunition = {
        type = "bile",
        range = 4,
        count = 1,
        effects = {
            "BILE_JET_ADV",
            "BILE_GLOW",
            "BILE_BOMB_ADV",
            "BILE_STINK",
            "BILE_IRRITATE",
            "BILE_BLIND",
        },
    },
}

ccb.content.define_item {
    id = "bone_dart",
    copy_from = "rock",
    looks_like = "bee_sting",
    color = "white",
    name = ccb.content.text("bone dart"),
    description = ccb.content.text("A naturally fletched projectile made of bone and cartilage.  It feels denser than you'd expect."),
    materials = { "cyber_bone" },
    mass = "250 g",
    inheritance = { remove = { flags = { "SLING_PROJECTILE" } } },
    ammunition = { type = "bone_dart" },
}
