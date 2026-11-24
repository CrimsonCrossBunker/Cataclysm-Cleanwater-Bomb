local ccb = require("ccb")

ccb.content.define_item {
    id = "aura_druid_waterwalk",
    name = ccb.content.plural_text("Waterstrider's Walk", "Waterstrider's Walks"),
    description = ccb.content.text("You can easily walk on the surface of the water."),
    mass = "0 g",
    volume = "0 ml",
    price = "0 cent",
    materials = { "concentrated_mana" },
    symbol = "O",
    color = "blue",
    flags = {
        "AURA", "SEMITANGIBLE", "PADDED", "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "TRADER_AVOID",
        "WATER_FRIENDLY", "NO_REPAIR", "NO_TAKEOFF", "ZERO_WEIGHT", "NONCONDUCTIVE", "FLOTATION",
    },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_aura_druid_waterwalk_0" } },
}

ccb.content.define_item {
    id = "aura_caustic",
    name = ccb.content.plural_text("acid aura", "acid auras"),
    description = ccb.content.text("An aura of thin acid, swirling around your body ready to corrode when struck or while striking."),
    mass = "500 mg",
    volume = "1 ml",
    symbol = "o",
    color = "blue",
    materials = { "magical_material" },
    flags = {
        "AURA",
        "TRADER_AVOID",
        "NO_TAKEOFF",
        "NONCONDUCTIVE",
        "OVERSIZE",
        "UNBREAKABLE",
        "ALLOWS_NATURAL_ATTACKS",
    },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {},
    artifact = { enchantments = { "ench_aura_caustic" } },
}

-- Recharge time is 2 seconds due to bug #48019, making it actually 1 second. Reduce to 1 second if that ever gets fixed.
ccb.content.define_item {
    id = "technomancer_summoned_ups_2",
    name = ccb.content.plural_text("technomantic power supply", "technomantic power supplies"),
    description = ccb.content.text("A smoothly-curved conglomeration of mana, humming softly as it provides power."),
    copy_from = "technomancer_summoned_ups",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 2000 } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { charge = { recharge_type = "periodic", interval = "2 s", regenerate_ammo = true } },
}

-- Recharge time is 2 seconds due to bug #48019, making it actually 1 second. Reduce to 1 second if that ever gets fixed.
ccb.content.define_item {
    id = "technomancer_summoned_ups_3",
    name = ccb.content.plural_text("technomantic power supply", "technomantic power supplies"),
    description = ccb.content.text("A smoothly-curved conglomeration of mana, humming softly as it provides power."),
    copy_from = "technomancer_summoned_ups",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 4000 } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { charge = { recharge_type = "periodic", interval = "2 s", regenerate_ammo = true } },
}

-- Recharge time is 2 seconds due to bug #48019, making it actually 1 second. Reduce to 1 second if that ever gets fixed.
ccb.content.define_item {
    id = "technomancer_summoned_ups_4",
    name = ccb.content.plural_text("technomantic power supply", "technomantic power supplies"),
    description = ccb.content.text("A smoothly-curved conglomeration of mana, humming softly as it provides power."),
    copy_from = "technomancer_summoned_ups",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 8000 } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { charge = { recharge_type = "periodic", interval = "2 s", regenerate_ammo = true } },
}

-- Recharge time is 2 seconds due to bug #48019, making it actually 1 second. Reduce to 1 second if that ever gets fixed.
ccb.content.define_item {
    id = "technomancer_summoned_ups_5",
    name = ccb.content.plural_text("technomantic power supply", "technomantic power supplies"),
    description = ccb.content.text("A smoothly-curved conglomeration of mana, humming softly as it provides power."),
    copy_from = "technomancer_summoned_ups",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 16000 } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { charge = { recharge_type = "periodic", interval = "2 s", regenerate_ammo = true } },
}

-- Recharge time is 2 seconds due to bug #48019, making it actually 1 second. Reduce to 1 second if that ever gets fixed.
ccb.content.define_item {
    id = "technomancer_summoned_ups_6",
    name = ccb.content.plural_text("technomantic power supply", "technomantic power supplies"),
    description = ccb.content.text("A smoothly-curved conglomeration of mana, humming softly as it provides power."),
    copy_from = "technomancer_summoned_ups",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 32000 } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { charge = { recharge_type = "periodic", interval = "2 s", regenerate_ammo = true } },
}

ccb.content.define_item {
    id = "shotcestus",
    copy_from = "gun_base_shotgun_manual",
    name = ccb.content.plural_text("shotcestus", "shotcestuses"),
    description = ccb.content.text("A sawn-off double-barrel shotgun mounted on a metal cestus.  The lack of a stock to absorb recoil means some strength is required to fire."),
    mass = "1566 g",
    volume = "1500 ml",
    price = "200 USD",
    materials = { "steel" },
    techniques = { "WBLOCK_1", "BRUTAL" },
    min_strength = 7,
    flags = { "DURABLE_MELEE", "NEVER_JAMS", "RELOAD_EJECT", "RELOAD_ONE", "OBSOLETE" },
    pockets = { { kind = "MAGAZINE", ammunition = { shot = 2 } } },
    melee_damage = { bash = 12 },
    armor = { portions = { { encumbrance = 5, coverage = 20, covers = { "hand_r" } } } },
}

ccb.content.define_item {
    id = "obfuscating_aura",
    name = ccb.content.plural_text("obfuscating aura", "obfuscating auras"),
    description = ccb.content.text("An all-encompassing, invisible layer of magic distorts light around your body.  Allows you to dodge two extra attacks in a given turn."),
    mass = "500 mg",
    volume = "1ml",
    price = "36 USD 46 cent",
    symbol = "o",
    color = "white",
    materials = { "magical_material" },
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
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_obfuscating_aura_0" } },
}

ccb.content.define_item {
    id = "shape_of_dust",
    name = ccb.content.plural_text("dust cloak", "dust cloaks"),
    description = ccb.content.text("You are unseen in between of the sand that cover you."),
    mass = "500 mg",
    volume = "1 ml",
    symbol = "o",
    color = "brown",
    looks_like = "cloak",
    materials = { "magical_material" },
    flags = {
        "AURA",
        "TRADER_AVOID",
        "NO_TAKEOFF",
        "NONCONDUCTIVE",
        "OVERSIZE",
        "UNBREAKABLE",
        "ALLOWS_NATURAL_ATTACKS",
    },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_shape_of_dust_0" } },
}

ccb.content.define_item {
    id = "acid_res_aura",
    name = ccb.content.text("acid resistance aura"),
    description = ccb.content.text("An all-encompassing, invisible layer of protection against acid."),
    mass = "500 mg",
    volume = "1ml",
    price = "36 USD 46 cent",
    symbol = "o",
    color = "green",
    materials = { "magical_material" },
    flags = {
        "AURA", "SEMITANGIBLE", "OVERSIZE", "TRADER_AVOID", "NO_TAKEOFF", "NONCONDUCTIVE", "UNBREAKABLE",
        "ALLOWS_NATURAL_ATTACKS",
    },
    max_worn = 1,
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
}

ccb.content.define_item {
    id = "acid_res_aura_greater",
    name = ccb.content.text("greater acid resistance aura"),
    description = ccb.content.text("An all-encompassing, invisible layer of protection against acid."),
    mass = "500 mg",
    volume = "1ml",
    price = "36 USD 46 cent",
    symbol = "o",
    color = "green",
    materials = { "magical_material" },
    flags = {
        "AURA", "SEMITANGIBLE", "OVERSIZE", "TRADER_AVOID", "NO_TAKEOFF", "NONCONDUCTIVE", "UNBREAKABLE",
        "ALLOWS_NATURAL_ATTACKS",
    },
    max_worn = 1,
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
}

ccb.content.define_item {
    id = "thorns_electric",
    name = ccb.content.plural_text("aura of repelling arc", "auras of repelling arc"),
    description = ccb.content.text("An invisible aura that strikes melee attackers with arcs of electricity."),
    mass = "500 mg",
    volume = "1 ml",
    symbol = "o",
    color = "blue",
    materials = { "magical_material" },
    flags = {
        "AURA",
        "TRADER_AVOID",
        "NO_TAKEOFF",
        "NONCONDUCTIVE",
        "OVERSIZE",
        "UNBREAKABLE",
        "ALLOWS_NATURAL_ATTACKS",
    },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_thorns_electric_0" } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "warg_food",
    copy_from = "cattlefodder_medium",
    name = ccb.content.text_without_extraction("warg food"),
    description = ccb.content.text_without_extraction("A food that doesn't exist but is necessary for technical reasons."),
    flags = { "INEDIBLE" },
    comestible = { kind = "FOOD", pet_food = { "WARG_FOOD" } },
    use_actions = { "PETFOOD" },
}

ccb.content.define_item {
    id = "impactsling",
    looks_like = "sling",
    symbol = "(",
    color = "brown",
    name = ccb.content.text("impact sling"),
    description = ccb.content.text("A leather sling, quivering with energy when in your palm to the point of almost tearing.  A pebble appears when you begin spinning it."),
    price = "1 USD 50 cent",
    materials = { "leather" },
    flags = {
        "NEVER_JAMS", "PRIMITIVE_RANGED_WEAPON", "BELT_CLIP", "FIRE_TWOHAND", "TRADER_AVOID",
        "NO_UNLOAD", "NO_REPAIR", "NO_TURRET", "WATERPROOF_GUN",
    },
    mass = "86 g",
    volume = "250 ml",
    length = "25 cm",
    survival_price = "2 USD 50 cent",
    accuracy = -1,
    melee_damage = { bash = 4 },
    gun = {
        skill = "throw",
        damage = { type = "bash", amount = 20 },
        range = 20,
        dispersion = 135,
        durability = 7,
        reload_noise_volume = 3,
        loudness = 6,
    },
}

-- Remove after 0.J
ccb.content.define_item {
    id = "magic_light",
    category = "tools",
    name = ccb.content.text("magic light"),
    description = ccb.content.text("A small magical light that you can read by."),
    mass = "0 kg",
    volume = "0 L",
    price = "0 cent",
    symbol = ",",
    color = "light_green",
    materials = { "magical_material" },
    light = 8,
    flags = { "AURA", "SEMITANGIBLE", "UNBREAKABLE", "ALLOWS_NATURAL_ATTACKS" },
    armor = { portions = { { covers = { "head" } } } },
}

-- Remove after 0.J
ccb.content.define_item {
    id = "druid_fertilizer",
    name = ccb.content.plural_text("seed of growth", "seed of growth"),
    mass = "27 g",
    color = "white",
    flags = { "TRADER_AVOID", "FERTILIZER" },
    symbol = "°",
    description = ccb.content.text("A magical powder that can be scattered on growing crops to make them grow faster."),
    materials = { "powder" },
    volume = "33 ml",
    category = "chems",
    comestible = { kind = "FOOD", quench = -10, healthy = -2, fun = -15 },
}

-- Remove after 0.J
ccb.content.define_item {
    id = "item_kelvinist_frozen_heart",
    name = ccb.content.plural_text("Rime-Frozen Heart", "Rime-Frozen Hearts"),
    description = ccb.content.text("You don't feel anything."),
    mass = "0 g",
    volume = "0 ml",
    price = "36 USD 46 cent",
    symbol = "o",
    color = "white",
    materials = { "magical_material" },
    flags = {
        "PERSONAL", "SEMITANGIBLE", "ZERO_WEIGHT", "OVERSIZE", "TRADER_AVOID", "NO_TAKEOFF",
        "NONCONDUCTIVE", "PADDED", "INTEGRATED",
    },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_item_kelvinist_frozen_heart_0" } },
}
