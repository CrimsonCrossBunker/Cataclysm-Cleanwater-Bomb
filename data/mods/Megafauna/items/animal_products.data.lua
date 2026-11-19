local ccb = require("ccb")

ccb.content.define_item {
    id = "mammoth_tusk",
    category = "spare_parts",
    name = ccb.content.text("mammoth tusk"),
    mass = "45 kg",
    color = "white",
    symbol = ")",
    description = ccb.content.text("A huge curved tusk of a mammoth."),
    price = "0 cent",
    survival_price = "10 cent",
    materials = { "bone" },
    volume = "80 L",
    length = "250 cm",
    accuracy = { grip = "bad", length = "short", surface = "any", balance = "clumsy" },
    melee_damage = { bash = 45 },
    comestible = {
        kind = "FOOD",
        vitamins = { { id = "calcium", amount = 96 }, { id = "meat_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "egg_auk",
    name = ccb.content.text("great auk egg"),
    copy_from = "egg_chicken",
    description = ccb.content.text("An egg laid by a great auk.  Prized for its big, nutritious yolk."),
    volume = "90 ml",
    comestible = { quench = 9, calories = 140 },
    inheritance = { add = { rot_spawn = { group = "GROUP_EGG_AUK" } } },
}

ccb.content.define_item {
    id = "egg_titanis_walleri",
    name = ccb.content.text("titanis walleri egg"),
    copy_from = "egg_chicken",
    description = ccb.content.text("A large egg laid by a titanis walleri.  Prized for its big, nutritious yolk."),
    volume = "1800 ml",
    comestible = { quench = 14, calories = 2100 },
    inheritance = { add = { rot_spawn = { group = "GROUP_EGG_TITANIS_WALLERI" } } },
}

ccb.content.define_item {
    id = "glypto_shell",
    category = "spare_parts",
    name = ccb.content.text("glyptotherium shell"),
    mass = "110 kg",
    color = "brown",
    symbol = "O",
    description = ccb.content.text("A huge shell laboriously carved from a glyptotherium."),
    price = "0 cent",
    survival_price = "10 cent",
    materials = { "bone" },
    volume = "180 L",
    length = "200 cm",
    comestible = { kind = "FOOD", vitamins = { { id = "meat_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "large_bone",
    category = "spare_parts",
    name = ccb.content.text("large bone"),
    mass = "20 kg",
    color = "white",
    symbol = "I",
    description = ccb.content.text("A huge bone of a large creature."),
    price = "0 cent",
    survival_price = "10 cent",
    materials = { "bone" },
    volume = "36 L",
    length = "200 cm",
    accuracy = { grip = "bad", length = "short", surface = "any", balance = "clumsy" },
    melee_damage = { bash = 35 },
    comestible = {
        kind = "FOOD",
        vitamins = { { id = "calcium", amount = 96 }, { id = "meat_allergen", amount = 1 } },
    },
}
