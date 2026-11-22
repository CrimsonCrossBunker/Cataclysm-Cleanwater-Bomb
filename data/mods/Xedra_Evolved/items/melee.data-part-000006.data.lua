local ccb = require("ccb")

ccb.content.define_item {
    id = "dreamdross_bo",
    copy_from = "bo",
    name = ccb.content.plural_text("dreamdrossed quarterstaff", "dreamdrossed quarterstaves"),
    description = "A long stick that's been covered with dreamdross, but lacks any magical properties.",
    symbol = "/",
    color = "light_gray",
    category = "weapons",
    volume = "1500 ml",
    length = "180 cm",
    survival_price = "10 USD",
    flags = { "DURABLE_MELEE", "SHEATH_SPEAR", "ALWAYS_TWOHAND", "WOODEN_WEAPON" },
    techniques = { "WBLOCK_2", "RAPID", "SWEEP", "MOUNTED_CHARGE" },
    weapon_categories = { "QUARTERSTAVES" },
    materials = { "wood", "dreamstuff" },
    accuracy = { grip = "weapon", length = "long", surface = "any", balance = "good" },
    inheritance = {
        scale = {
            mass = 0.5,
            melee_damage = { bash = 1.3 },
        },
    },
}

ccb.content.define_item {
    id = "dreamforged_q_staff",
    copy_from = "bo",
    name = ccb.content.plural_text("dreamforged quarterstaff", "dreamforged quarterstaves"),
    description = "A long quarterstaff, forged entirely from dreamdross.  Twice as heavy than a wooden one, but lot sturdier, and still useful as a weapon.  The dreamdross grants it some minor magical properties, but you can't control their effects.",
    replace_materials = { wood = "forged_dreamstuff" },
    inheritance = {
        scale = {
            mass = 0.8,
            melee_damage = { bash = 2.5 },
        },
    },
}

ccb.content.define_item {
    id = "dreamforged_glaive",
    copy_from = "glaive",
    name = "dreamforged glaive",
    description = "A two-handed glaive, forged entirely from dreamdross.  The dreamdross grants it some minor magical properties, but you can't control their effects.",
    replace_materials = { steel = "forged_dreamstuff", wood = "forged_dreamstuff" },
    inheritance = {
        scale = {
            mass = 0.8,
            melee_damage = { cut = 1.1 },
        },
    },
}

ccb.content.define_item {
    id = "dreamforged_naginata",
    copy_from = "naginata",
    name = ccb.content.plural_text("dreamforged naginata", "dreamforged naginata"),
    description = "A sturdy naginata, forged entirely from dreamdross.  The dreamdross grants it some minor magical properties, but you can't control their effects.",
    replace_materials = { steel = "forged_dreamstuff", wood = "forged_dreamstuff" },
    inheritance = {
        scale = {
            mass = 0.8,
            melee_damage = { cut = 1.1 },
        },
    },
}

ccb.content.define_item {
    id = "dreamforged_broadsword",
    copy_from = "broadsword",
    name = "dreamforged broadsword",
    description = "A broadsword, forged entirely from dreamdross.  So light that you can't properly apply any force on it.  The dreamdross grants it some minor magical properties, but you can't control their effects.",
    replace_materials = { mc_steel = "forged_dreamstuff", leather = "forged_dreamstuff" },
    inheritance = {
        scale = {
            mass = 0.8,
            melee_damage = { cut = 0.5 },
        },
    },
}

ccb.content.define_item {
    id = "dreamforged_knuckle",
    copy_from = "knuckle_impact",
    name = ccb.content.plural_text("dreamforged knuckles", "dreamforged knuckles"),
    description = "A pair of thick dreamdross plates covering your proximal phalange.  The dreamdross grants it some minor magical properties, but you can't control their effects.",
    replace_materials = { steel = "forged_dreamstuff" },
    armor = {},
    inheritance = {
        scale = {
            mass = 0.8,
            melee_damage = { bash = 0.7 },
        },
    },
}

ccb.content.define_item {
    id = "dreamforged_knuckle_berserk",
    copy_from = "dreamforged_knuckle",
    name = ccb.content.plural_text("berserker knuckles", "berserker knuckles"),
    description = "A pair of fiery-red knuckles with tiny blades on the end.  They are fed with your energy and the blood of your enemies, and will fuel different items with berserk properties.",
    melee_damage = { cut = 3 },
    armor = {
        portions = {
            {
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
                coverage = 80,
                encumbrance = 5,
            },
        },
    },
    artifact = {
        enchantments = { "BERSERKING" },
    },
    subtype_order = { "armor", "artifact" },
    inheritance = {
        scale = {
            mass = 0.8,
            melee_damage = { bash = 0.5 },
        },
    },
}
