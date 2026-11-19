local ccb = require("ccb")

ccb.content.define_item {
    id = "spring_lord_estoc",
    looks_like = "winter_lord_estoc",
    name = ccb.content.plural_text("greengrowth estoc", "greengrowth estocs"),
    copy_from = "mirror_march_estoc",
    description = ccb.content.text("Green shoots entwine around this sword and it seems to move of its own volition in your hands."),
    inheritance = { add = { flags = { "RELIC_PINK" } }, offset = { melee_damage = { biological = 9 } } },
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_spring_lord_estoc_0" } },
}

ccb.content.define_item {
    id = "summer_lord_estoc",
    looks_like = "winter_lord_estoc",
    name = ccb.content.plural_text("heathaze estoc", "heathaze estocs"),
    copy_from = "mirror_march_estoc",
    description = ccb.content.text("The air around this sword shimmers like the space over asphalt in summer and it seems to move of its own volition in your hands."),
    inheritance = { add = { flags = { "RELIC_PINK" } }, offset = { melee_damage = { heat = 9 } } },
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_summer_lord_estoc_0" } },
}

ccb.content.define_item {
    id = "autumn_lord_estoc",
    looks_like = "winter_lord_estoc",
    name = ccb.content.plural_text("leaf-fall estoc", "leaf-fall estocs"),
    copy_from = "mirror_march_estoc",
    description = ccb.content.text("This sword is surrounded by falling brown leaves and seems to move of its own volition in your hands."),
    inheritance = { add = { flags = { "RELIC_PINK" } }, offset = { melee_damage = { withering_damage = 9 } } },
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_autumn_lord_estoc_0" } },
}

ccb.content.define_item {
    id = "winter_lord_estoc",
    name = ccb.content.plural_text("frostrimed estoc", "frostrimed estocs"),
    copy_from = "mirror_march_estoc",
    description = ccb.content.text("This sword is covered in shifting frost and seems to move of its own volition in your hands."),
    inheritance = { add = { flags = { "RELIC_PINK" } }, offset = { melee_damage = { cold = 9 } } },
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_winter_lord_estoc_0" } },
}
