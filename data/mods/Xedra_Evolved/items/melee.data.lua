local ccb = require("ccb")

ccb.content.define_item {
    id = "mirror_march_estoc",
    symbol = "/",
    color = "light_gray",
    name = ccb.content.plural_text("mirrored estoc", "mirrored estocs"),
    description = ccb.content.text("A thin piercing sword no wider than two fingers side by side, it's mirrored surface reflects the world back at it's wielders opponents and is difficult to see to parry.  You've never felt a sword like this before."),
    price = "1 kUSD 350 USD",
    survival_price = "500 USD",
    materials = { "moon_tears" },
    techniques = { "WBLOCK_2", "PRECISE" },
    flags = { "DURABLE_MELEE", "SHEATH_SWORD" },
    weapon_categories = { "LONG_SWORDS", "FENCING_WEAPONRY" },
    mass = "1214 g",
    volume = "2750 ml",
    length = "130 cm",
    accuracy = { grip = "weapon", length = "long", surface = "line", balance = "good" },
    category = "weapons",
    qualities = { { id = "CUT", level = 1 }, { id = "BUTCHER", level = 8 } },
    melee_damage = { bash = 8, stab = 42 },
}

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

ccb.content.define_item {
    id = "redcap_club",
    name = ccb.content.plural_text("redcap club", "redcap clubs"),
    copy_from = "mace",
    description = ccb.content.text("A giant bloodstained club, barely human wieldable with two hands.  You see shadowy tendrils of blood whenever it connects with an enemy, sticking to whatever it hits and burning like acid."),
    flags = { "DURABLE_MELEE", "NONCONDUCTIVE", "BELT_CLIP", "ALWAYS_TWOHAND" },
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_redcap_club_0" } },
}

ccb.content.define_item {
    id = "wild_huntsman_hunting_blade",
    copy_from = "ch_arming_sword",
    name = "witchwood sword",
    description = "This sword is made all of a single piece of wood and so black any details are lost.  Some kind of shimmering leather is wrapped around the grip.",
    looks_like = "bokken",
    price = "1 kUSD 350 USD",
    survival_price = "500 USD",
    materials = {
        { id = "wood", portions = 1 },
    },
    artifact = {
        enchantments = {
            "ITEM_ENCH_Xedra_Evolved_wild_huntsman_hunting_blade_0",
        },
    },
    inheritance = {
        add = {
            flags = { "WOODEN_WEAPON", "NO_REPAIR", "RELIC_PINK" },
        },
        remove = { flags = "CONDUCTIVE" },
        scale = {
            melee_damage = { stab = 0.9 },
        },
        offset = {
            melee_damage = { biological = 5 },
        },
    },
}

ccb.content.define_spell {
    id = "blood_tendrils",
    name = ccb.content.text("Blood Tendrils"),
    description = ccb.content.text("Brownish reddish tendrils connect from the club to your enemies."),
    valid_targets = { "hostile" },
    flags = { "NO_HANDS", "NO_LEGS" },
    damage_type = "biological",
    min_damage = 8,
    min_range = 2,
    shape = "blast",
    effect = "attack",
}

ccb.content.define_item {
    id = "pooka_gladius",
    name = ccb.content.plural_text("pooka gladius", "pooka gladii"),
    copy_from = "wakizashi",
    description = ccb.content.text("A gladius covered in the whorls of Celtic knots.  Sparks seems to pop off the edge of the blade."),
    flags = { "DURABLE_MELEE", "SHEATH_SWORD" },
    length = "60 cm",
    materials = { "moon_tears" },
    weapon_categories = { "SHORT_SWORDS" },
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_pooka_gladius_0" } },
}

ccb.content.define_spell {
    id = "distant_thunder",
    name = ccb.content.text("Distant Thunder"),
    description = ccb.content.text("Sparks zap at your opponent."),
    valid_targets = { "hostile" },
    flags = { "NO_HANDS", "NO_LEGS" },
    damage_type = "electric",
    min_damage = 8,
    min_range = 1,
    shape = "blast",
    effect = "attack",
}

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

ccb.content.define_item {
    id = "dreamforged_glaive_healing",
    copy_from = "dreamforged_glaive",
    name = ccb.content.plural_text("glaive of life", "glaives of life"),
    description = ccb.content.text("A two-handed glaive, forged entirely from dreamdross.  It can steal life from creatures it attacks, healing you a bit."),
    artifact = { enchantments = { "ENCHANTMENT_VAMPIRISM" } },
}

ccb.content.define_item {
    id = "dreamforged_tsurugi_speed",
    copy_from = "dreamforged_broadsword",
    name = ccb.content.plural_text("tsurugi of speed", "tsurugi of speed"),
    description = ccb.content.text("A classic Japanese tsurugi sword with a razor sharp blade.  You start to think you need to move faster, and the effect intensifies when you are surrounded."),
    artifact = { enchantments = { "MON_NEARBY_SPEED" } },
}

ccb.content.define_item {
    id = "dreamforged_q_staff_exp",
    copy_from = "dreamforged_q_staff",
    name = ccb.content.plural_text("bō of practice", "bō of practice"),
    description = ccb.content.text("A long, straight stick.  A simple weapon empowered by your experience in fighting against dreadful creatures."),
    artifact = { enchantments = { "EXP_BASH" } },
}

ccb.content.define_item {
    id = "heartvine_whip",
    category = "weapons",
    looks_like = "bullwhip_razor",
    name = ccb.content.plural_text("heartvine whip", "heartvine whips"),
    description = ccb.content.text("A lengthy vine, growing out of your arm and wrapping around your wrist.  It has a series of long, sharp thorns on the parts away from your body."),
    mass = "216 g",
    volume = "360 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "dry_plant" },
    symbol = ",",
    color = "light_green",
    techniques = { "WHIP_DISARM" },
    flags = {
        "WOODEN_WEAPON", "UNBREAKABLE_MELEE", "NONCONDUCTIVE", "MAGIC_FOCUS", "TRADER_AVOID",
        "NO_REPAIR", "NO_SALVAGE", "UNRESTRICTED", "REACH_ATTACK", "REACH3", "WHIP",
    },
    accuracy = { grip = "weapon", length = "long", surface = "line", balance = "good" },
    melee_damage = { cut = 13 },
    weapon_categories = { "WHIPS" },
    artifact = { enchantments = { "BLOODTHORNE_DRUID_HEARTWHIP" } },
}
