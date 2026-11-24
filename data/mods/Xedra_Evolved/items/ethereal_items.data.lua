local ccb = require("ccb")

ccb.content.define_item {
    id = "blurred_aura",
    name = ccb.content.plural_text("blurred aura", "blurred auras"),
    description = ccb.content.text("Your edges blur and expand and contract in ways that don't reflect reality.  Allows you to dodge two extra attacks in a given turn."),
    mass = "1g",
    volume = "1ml",
    price = "36 USD 46 cent",
    symbol = "o",
    color = "white",
    materials = { "dreamstuff" },
    flags = {
        "AURA", "SEMITANGIBLE", "OVERSIZE", "TRADER_AVOID", "NO_TAKEOFF", "NONCONDUCTIVE", "UNBREAKABLE",
        "ALLOWS_NATURAL_ATTACKS",
    },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {
        portions = {
            {
                encumbrance = 0,
                coverage = 100,
                covers = {
                    "leg_l", "leg_r", "torso", "arm_l", "arm_r", "hand_l", "hand_r", "head", "foot_l",
                    "foot_r", "mouth", "eyes",
                },
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_blurred_aura_0" } },
}

ccb.content.define_item {
    id = "aura_futuresight",
    category = "armor",
    name = ccb.content.plural_text("precognitive aura", "precognitive aura"),
    description = ccb.content.text("A precognitive aura that allows you to dodge things you didn't see coming."),
    mass = "100 g",
    volume = "25 L",
    materials = { "dreamstuff" },
    symbol = "[",
    color = "light_gray",
    flags = {
        "AURA", "SEMITANGIBLE", "OVERSIZE", "TRADER_AVOID", "NO_TAKEOFF", "NONCONDUCTIVE", "UNBREAKABLE",
        "ALLOWS_NATURAL_ATTACKS",
    },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 5,
        portions = {
            {
                encumbrance = 0,
                coverage = 100,
                covers = {
                    "leg_l", "leg_r", "torso", "arm_l", "arm_r", "hand_l", "hand_r", "head", "foot_l",
                    "foot_r", "mouth", "eyes",
                },
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_aura_futuresight_0" } },
}

ccb.content.define_item {
    id = "dagger_dreamdross",
    name = ccb.content.plural_text("dreamer dagger", "dreamer daggers"),
    description = ccb.content.text("This ephemeral dagger is 15 inches long from the hilt to the tip, the double-edged blade itself is a pearly white color and extremely sharp."),
    mass = "145 g",
    volume = "250 ml",
    length = "38 cm",
    price = "40 USD",
    survival_price = "7 USD 50 cent",
    accuracy = { grip = "weapon", length = "hand", surface = "point", balance = "good" },
    materials = { "dreamstuff" },
    symbol = "/",
    color = "light_gray",
    looks_like = "knife_combat",
    techniques = { "RAPID", "WBLOCK_1", "PRECISE" },
    qualities = { { id = "CUT", level = 2 }, { id = "CUT_FINE", level = 1 }, { id = "BUTCHER", level = 5 } },
    flags = {
        "UNBREAKABLE_MELEE", "NONCONDUCTIVE", "NO_REPAIR", "NO_SALVAGE", "MAGIC_FOCUS", "TRADER_AVOID",
        "SHEATH_KNIFE",
    },
    weapon_categories = { "KNIVES" },
    category = "weapons",
    melee_damage = { stab = 16 },
    subtype_order = { "tool", "artifact" },
    tool = {},
    artifact = { enchantments = { "DREAM_DAGGER" } },
}

ccb.content.define_item {
    id = "armor_dreamdross",
    category = "armor",
    copy_from = "armor_lc_lightplate",
    name = ccb.content.plural_text("dream armor", "dream armor"),
    description = ccb.content.text("A summoned medieval armor made from dreamdross.  It shimmers in the light and provides some protection."),
    materials = { "dreamstuff" },
    flags = { "OVERSIZE", "PERSONAL", "PADDED", "STURDY", "NO_REPAIR", "NO_SALVAGE", "TRADER_AVOID" },
    max_worn = 1,
    armor = {
        warmth = 0,
        thickness = 5,
        portions = {
            {
                encumbrance = 5,
                coverage = 100,
                covers = {
                    "head", "mouth", "eyes", "torso", "arm_l", "arm_r", "hand_l", "hand_r", "leg_l",
                    "leg_r", "foot_l", "foot_r",
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "aura_drunken_master",
    name = ccb.content.plural_text("Drunken Master aura", "Drunken Master auras"),
    description = ccb.content.text("Hey I thought this was America…"),
    mass = "1 g",
    volume = "1 ml",
    price = "36 USD 46 cent",
    symbol = "o",
    color = "white",
    materials = { "dreamstuff" },
    flags = { "PERSONAL", "SEMITANGIBLE", "OVERSIZE", "TRADER_AVOID", "NO_TAKEOFF", "NONCONDUCTIVE" },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_aura_drunken_master_0" } },
}

ccb.content.define_item {
    id = "magic_light",
    category = "tools",
    name = ccb.content.text("magic light"),
    description = ccb.content.text("A magical light source that will light up a small area."),
    mass = "1 g",
    materials = { "dreamstuff" },
    volume = "250 ml",
    price = "1 cent",
    symbol = ",",
    color = "light_green",
    light = 300,
    flags = { "AURA", "SEMITANGIBLE", "UNBREAKABLE", "ALLOWS_NATURAL_ATTACKS" },
    melee_damage = { bash = 8 },
    armor = { portions = { { covers = { "head" } } } },
}

ccb.content.define_item {
    id = "water_pocket",
    name = ccb.content.text("water pocket"),
    description = ccb.content.text("A large pouch of churning water on your back, containing a sealed air bubble.  It shifts and adjusts itself to minimize encumbrance."),
    mass = "0 kg",
    volume = "0 L",
    price = "0 cent",
    materials = { "water" },
    symbol = "[",
    color = "green",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "25 L",
            mass_limit = "75 kg",
            moves = 60,
            watertight = true,
            airtight = true,
        },
    },
    flags = {
        "BELTED", "TRADER_AVOID", "WATERPROOF", "STURDY", "OVERSIZE", "NO_TAKEOFF", "NO_REPAIR",
        "NO_SALVAGE", "ZERO_WEIGHT",
    },
    max_worn = 1,
    armor = {
        thickness = 0.1,
        portions = { { encumbrance = { 5, 10 }, coverage = 40, covers = { "torso" } } },
    },
}

ccb.content.define_item {
    id = "xe_oneiric_hammer",
    name = "Oneiric Hammer",
    description = "The platonic embodiment of a blacksmiths hammer.  This hammer is necessary to forge or repair items made of forged dreamstuff.",
    symbol = "/",
    color = "brown",
    mass = "1337 g",
    volume = "1250 ml",
    price = "0 cent",
    flags = {
        "NONCONDUCTIVE",
        "BELT_CLIP",
        "TRADER_AVOID",
        "UNBREAKABLE_MELEE",
        "NO_REPAIR",
        "NO_SALVAGE",
        "MAGIC_FOCUS",
    },
    materials = { "dreamstuff" },
    melee_damage = { bash = 30 },
    pockets = {
        {
            kind = "MAGAZINE",
            ammunition = { scrap_dreamdross = 100 },
        },
    },
    qualities = {
        { id = "DREAM_HAMMER", level = 1 },
    },
    use_actions = {
        {
            kind = "repair_item",
            id = "repair_metal",
            skill = "deduction",
            tool_quality = 0,
            move_cost = 100,
            cost_scaling = 0.1,
            materials = { "forged_dreamstuff", "moon_tears", "moon_tears_fine_chain" },
        },
    },
    tool = { charges_per_use = 1 },
    artifact = {
        enchantments = { "ITEM_ENCH_Xedra_Evolved_xe_oneiric_hammer_0" },
    },
    subtype_order = { "tool", "artifact" },
}

ccb.content.define_item {
    id = "winch_stone",
    name = ccb.content.plural_text("constructed winch", "constructed winches"),
    description = "A small token that floats near your right hand.  It pulls you to determined coordinates when you command it.",
    symbol = "*",
    color = "dark_gray",
    mass = "1 g",
    volume = "1 ml",
    max_worn = 1,
    flags = {
        "SINGLE_USE",
        "TRADER_AVOID",
        "AURA",
        "SEMITANGIBLE",
        "OVERSIZE",
        "NO_TAKEOFF",
        "NONCONDUCTIVE",
        "UNBREAKABLE",
        "ALLOWS_NATURAL_ATTACKS",
    },
    materials = { "dreamstuff" },
    armor = {
        portions = {
            {
                covers = { "hand_r" },
                coverage = 0,
                encumbrance = 0,
            },
        },
    },
}

ccb.content.define_item {
    id = "salamander_flaming_summon_whip",
    category = "weapons",
    symbol = "/",
    color = "red",
    name = ccb.content.plural_text("Tongues of Flame", "Tongues of Flames"),
    description = ccb.content.text("A long whip made of red-hot fire.  It crackles menacingly and casts a flickering red glow."),
    mass = "60 g",
    volume = "1500 ml",
    length = "40 cm",
    accuracy = { grip = "weapon", length = "long", surface = "point", balance = "neutral" },
    melee_damage = { cut = 6 },
    techniques = { "PRECISE", "WIDE", "SWEEP" },
    light = 15,
    flags = {
        "REACH_ATTACK", "REACH3", "WHIP", "STURDY", "TRADER_AVOID", "UNBREAKABLE_MELEE", "NO_REPAIR",
        "NO_SALVAGE", "FIRESTARTER", "FLAMING", "FIRE",
    },
    weapon_categories = { "WHIPS" },
    artifact = { enchantments = { "SALAMANDER_SUMMON_WHIP" } },
}

ccb.content.define_item {
    id = "item_ierde_iron_armor",
    category = "armor",
    name = ccb.content.plural_text("invulnerable iron skin", "invulnerable iron skin"),
    description = ccb.content.text("Fae iron essence."),
    mass = "0 g",
    volume = "0 L",
    materials = { "moon_tears" },
    symbol = "[",
    color = "dark_gray",
    flags = { "OVERSIZE", "PERSONAL", "ZERO_WEIGHT", "NO_DROP", "STURDY", "PADDED" },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 5,
        thickness = 0.6,
        environmental_protection = 2,
        portions = {
            {
                encumbrance = 20,
                coverage = 100,
                covers = {
                    "head", "mouth", "eyes", "torso", "arm_l", "arm_r", "hand_l", "hand_r", "leg_l",
                    "leg_r", "foot_l", "foot_r",
                },
            },
        },
    },
    artifact = {
        enchantments = {
            "ITEM_ENCH_Xedra_Evolved_item_ierde_iron_armor_0",
            "ITEM_ENCH_Xedra_Evolved_item_ierde_iron_armor_1",
        },
    },
}
