local ccb = require("ccb")

ccb.content.define_item {
    id = "egg_chicken",
    copy_from = "egg_chicken",
    name = ccb.content.text("chicken egg"),
    comestible = {},
    inheritance = { add = { rot_spawn = { group = "GROUP_EGG_CHICKEN", chance = 70 } } },
}

ccb.content.define_item {
    id = "egg_pigeon",
    name = ccb.content.text("feral pigeon egg"),
    copy_from = "egg_pigeon",
    comestible = {},
    inheritance = { add = { rot_spawn = { group = "GROUP_EGG_PIGEON" } } },
}

ccb.content.define_item {
    id = "panacea",
    name = ccb.content.plural_text("compound XV471 \"Panaceus\"", "doses of compound XV471 \"Panaceus\""),
    copy_from = "panacea",
    comestible = {},
}
