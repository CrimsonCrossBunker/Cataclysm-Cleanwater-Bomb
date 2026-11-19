local ccb = require("ccb")

ccb.content.define_item {
    id = "arrow_fire_hardened_fletched",
    copy_from = "arrow_field_point_fletched",
    price = "0 cent",
    survival_price = "10 cent",
    name = ccb.content.text("crude wooden arrow"),
    symbol = "=",
    color = "green",
    description = ccb.content.text("A crude pointed wooden shaft with a notch at the back."),
    materials = { "wood" },
    inheritance = { offset = { dispersion = 100 } },
    ammunition = { damage = { type = "stab", constant_damage_multiplier = 0.75 }, recovery_chance = 50 },
}

ccb.content.define_item {
    id = "arrow_field_point_fletched",
    name = ccb.content.text("wooden bodkin arrow"),
    symbol = "=",
    color = "green",
    looks_like = "arrow_fire_hardened_fletched",
    description = ccb.content.text("A fletched wooden arrow shaft with a pointed tip."),
    materials = { { id = "wood", portions = 81 }, { id = "steel", portions = 19 } },
    flags = { "NONCONDUCTIVE" },
    volume = "90 ml",
    price = "10 USD",
    survival_price = "30 cent",
    mass = "32 g",
    length = "76 cm",
    melee_damage = { bash = 3 },
    ammunition = {
        type = "arrow",
        damage = { type = "stab", penetration = 3 },
        dispersion = 150,
        loudness = 0,
        critical_multiplier = 10,
        recovery_chance = 97,
    },
}

ccb.content.define_item {
    id = "arrow_plastic",
    symbol = "=",
    color = "green",
    name = ccb.content.text("wooden rubber blunt arrow"),
    description = ccb.content.text("A fletched wooden arrow shaft with a blunt rubber tip.  Can stun weaker enemies."),
    copy_from = "arrow_field_point_fletched",
    price = "5 USD",
    survival_price = "2 cent",
    materials = { { id = "wood", portions = 81 }, { id = "rubber", portions = 19 } },
    inheritance = { offset = { dispersion = 100 } },
    ammunition = {
        damage = { type = "stab", constant_damage_multiplier = 0.2 },
        critical_multiplier = 1,
        recovery_chance = 97,
        effects = { "BEANBAG" },
    },
}

ccb.content.define_item {
    id = "arrow_small_game_fletched",
    name = ccb.content.text("simple wooden small game arrow"),
    symbol = "=",
    color = "green",
    description = ccb.content.text("A simple fletched wooden arrow shaft with a blunted tip.  Useful for hunting small woodland creatures without splattering them all over the ground."),
    materials = { "wood" },
    copy_from = "arrow_field_point_fletched",
    survival_price = "15 cent",
    ammunition = {
        damage = { type = "stab", constant_damage_multiplier = 0.5 },
        recovery_chance = 90,
        effects = { "NOGIB" },
    },
}

ccb.content.define_item {
    id = "arrow_wood",
    name = ccb.content.text("wooden broadhead arrow"),
    symbol = "=",
    color = "green",
    description = ccb.content.text("A fletched wooden arrow shaft with a bladed tip."),
    copy_from = "arrow_field_point_fletched",
    price = "20 USD",
    melee_damage = { bash = 2, cut = 1 },
    inheritance = { offset = { dispersion = -40 } },
    ammunition = {
        damage = { type = "stab", penetration = 1, constant_damage_multiplier = 1.5 },
        recovery_chance = 96,
    },
}

ccb.content.define_item {
    id = "arrow_heavy_fire_hardened_fletched",
    price = "3 USD",
    name = ccb.content.text("simple wooden arrow"),
    symbol = "=",
    color = "green",
    description = ccb.content.text("A simple fletched wooden arrow shaft with a fire-hardened and sharpened tip."),
    materials = { "wood" },
    copy_from = "arrow_field_point_fletched",
    ammunition = { damage = { type = "stab", constant_damage_multiplier = 0.75 }, recovery_chance = 83 },
}

ccb.content.define_item {
    id = "arrow_heavy_field_point_fletched",
    price = "10 USD",
    name = ccb.content.text("wooden small game arrow"),
    symbol = "=",
    color = "green",
    description = ccb.content.text("A fletched wooden arrow shaft with a blunt tip.  Useful for hunting small woodland creatures without splattering them all over the ground."),
    copy_from = "arrow_field_point_fletched",
    survival_price = "25 cent",
    ammunition = {
        damage = { type = "stab", constant_damage_multiplier = 0.5 },
        recovery_chance = 97,
        effects = { "NOGIB" },
    },
}

ccb.content.define_item {
    id = "arrow_wood_heavy",
    name = ccb.content.text("makeshift wooden arrow"),
    symbol = "=",
    color = "green",
    description = ccb.content.text("A simple fletched wooden arrow shaft with a makeshift arrowhead."),
    materials = { "wood" },
    copy_from = "arrow_field_point_fletched",
    price = "0 cent",
    survival_price = "15 cent",
    ammunition = {
        damage = { type = "stab", constant_damage_multiplier = 1.25 },
        show_stats = true,
        recovery_chance = 87,
    },
}

ccb.content.define_item {
    id = "arrow_metal_sharpened_fletched",
    name = ccb.content.text("makeshift metal arrow"),
    symbol = "=",
    color = "green",
    description = ccb.content.text("A simple fletched wooden arrow shaft with a sharpened makeshift tip."),
    copy_from = "arrow_field_point_fletched",
    price = "0 cent",
    survival_price = "20 cent",
    melee_damage = { bash = 2 },
    ammunition = { damage = { type = "stab", penetration = 1 }, show_stats = true, recovery_chance = 95 },
}

ccb.content.define_item {
    id = "arrow_metal",
    name = ccb.content.text("aluminum broadhead arrow"),
    symbol = "=",
    color = "green",
    description = ccb.content.text("A fletched aluminum arrow shaft with a bladed tip.  Useful for maximizing damage to the target."),
    materials = { { id = "aluminum", portions = 81 }, { id = "steel", portions = 19 } },
    copy_from = "arrow_field_point_fletched",
    survival_price = "40 cent",
    melee_damage = { bash = 3, cut = 2 },
    inheritance = { remove = { flags = { "NONCONDUCTIVE" } }, offset = { dispersion = -75 } },
    ammunition = {
        damage = { type = "stab", penetration = 1, constant_damage_multiplier = 1.5 },
        range = 2,
        recovery_chance = 97,
    },
}

ccb.content.define_item {
    id = "arrow_metal_bodkin",
    name = ccb.content.text("aluminum field point arrow"),
    symbol = "=",
    color = "green",
    description = ccb.content.text("A fletched aluminum arrow shaft with a pointed tip.  Useful for piercing armor."),
    materials = { { id = "aluminum", portions = 81 }, { id = "steel", portions = 19 } },
    copy_from = "arrow_field_point_fletched",
    survival_price = "40 cent",
    melee_damage = { bash = 3, cut = 2 },
    inheritance = { remove = { flags = { "NONCONDUCTIVE" } }, offset = { dispersion = -75 } },
    ammunition = { damage = { type = "stab", penetration = 3 }, range = 2, recovery_chance = 97 },
}

ccb.content.define_item {
    id = "arrow_metal_target",
    price = "12 USD",
    name = ccb.content.text("aluminum small game arrow"),
    symbol = "=",
    color = "green",
    looks_like = "arrow_fire_hardened_fletched",
    description = ccb.content.text("A fletched aluminum arrow shaft with a blunt tip.  Useful for hunting small woodland creatures without splattering them all over the ground."),
    materials = { { id = "aluminum", portions = 81 }, { id = "steel", portions = 19 } },
    copy_from = "arrow_field_point_fletched",
    inheritance = { remove = { flags = { "NONCONDUCTIVE" } }, offset = { dispersion = -75 } },
    ammunition = {
        damage = { type = "stab", constant_damage_multiplier = 0.5 },
        range = 2,
        recovery_chance = 98,
        effects = { "NOGIB" },
    },
}

ccb.content.define_item {
    id = "arrow_cf",
    name = ccb.content.text("carbon fiber hunting arrow"),
    symbol = "=",
    color = "green",
    description = ccb.content.text("A fletched carbon fiber arrow shaft with an expanding broadhead tip.  Deals impressive damage to targets."),
    materials = { { id = "kevlar_rigid", portions = 81 }, { id = "steel", portions = 19 } },
    copy_from = "arrow_field_point_fletched",
    price = "16 USD",
    survival_price = "50 cent",
    melee_damage = { bash = 1 },
    inheritance = { remove = { flags = { "NONCONDUCTIVE" } }, offset = { dispersion = -100 } },
    ammunition = {
        damage = { type = "stab", constant_damage_multiplier = 1.75 },
        range = 4,
        recovery_chance = 97,
    },
}

ccb.content.define_item {
    id = "arrow_meteor",
    price = "20 USD",
    name = ccb.content.text("emerald arrow"),
    symbol = "=",
    color = "light_green",
    looks_like = "arrow_fire_hardened_fletched",
    description = ccb.content.text("A fletched lance carved from inscrutable green stone.  Impractically heavy, its difficult to imagine who or what could have fired it from a bow."),
    materials = { "monolith_heavy" },
    volume = "100 ml",
    survival_price = "10 USD",
    mass = "27 kg",
    length = "105 cm",
    accuracy = { grip = "solid", length = "long", surface = "point", balance = "good" },
    flags = { "UNBREAKABLE_MELEE", "NONCONDUCTIVE" },
    melee_damage = { bash = 10, stab = 26 },
    ammunition = {
        type = "strange_arrow",
        damage = { type = "stab", constant_damage_multiplier = 2.25, penetration = 55 },
        range = 4,
        dispersion = 120,
        loudness = 0,
        critical_multiplier = 6,
        recovery_chance = 100,
    },
}
