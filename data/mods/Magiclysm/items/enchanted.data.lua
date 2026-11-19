local ccb = require("ccb")

ccb.content.define_item {
    id = "belt_str",
    copy_from = "leather_belt",
    survival_price = "1750 USD",
    name = ccb.content.plural_text("belt of strength +2", "belts of strength +2"),
    subtype_order = { "armor", "artifact" },
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_belt_str_0" } },
}

ccb.content.define_item {
    id = "belt_haste",
    copy_from = "leather_belt",
    survival_price = "3500 USD",
    name = ccb.content.plural_text("belt of haste", "belts of haste"),
    subtype_order = { "armor", "artifact" },
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_belt_haste_0" } },
}

ccb.content.define_item {
    id = "magi_staff_minor",
    symbol = "/",
    color = "brown",
    name = ccb.content.plural_text("minor staff of the magi", "minor staves of the magi"),
    description = ccb.content.text("A simple carved staff, made of wood.  It faintly glows with magic when you cast spells.  Wielding it slightly increases your mana regeneration"),
    price = "100 USD",
    materials = { "wood" },
    techniques = { "WBLOCK_2", "RAPID", "SWEEP" },
    weapon_categories = { "QUARTERSTAVES" },
    flags = { "SHEATH_SPEAR", "ALWAYS_TWOHAND", "MAGIC_FOCUS", "SPELLCASTING_AID" },
    mass = "1400 g",
    volume = "3 L",
    length = "170 cm",
    category = "weapons",
    accuracy = 3,
    melee_damage = { bash = 17 },
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_magi_staff_minor_0" } },
}

ccb.content.define_item {
    id = "magi_staff_lesser",
    symbol = "/",
    color = "brown",
    name = ccb.content.plural_text("lesser staff of the magi", "lesser staves of the magi"),
    description = ccb.content.text("A beautifully carved staff, made of enchanted wood.  It faintly glows with magic when you cast spells, but it is not a sturdy melee weapon.  Wielding it increases your mana regeneration."),
    price = "400 USD",
    materials = { "wood" },
    techniques = { "WBLOCK_2", "RAPID", "SWEEP" },
    weapon_categories = { "QUARTERSTAVES" },
    flags = { "SHEATH_SPEAR", "ALWAYS_TWOHAND", "FRAGILE_MELEE", "MAGIC_FOCUS", "SPELLCASTING_AID" },
    mass = "1400 g",
    volume = "3 L",
    length = "170 cm",
    category = "weapons",
    accuracy = 3,
    melee_damage = { bash = 17 },
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_magi_staff_lesser_0" } },
}

ccb.content.define_item {
    id = "magi_staff_greater",
    symbol = "/",
    color = "brown",
    name = ccb.content.plural_text("greater staff of the magi", "greater staves of the magi"),
    description = ccb.content.text("A beautifully carved staff, made of enchanted wood and mithril.  It faintly glows with magic when you cast spells, but it is not a sturdy melee weapon.  Wielding it greatly increases your mana regeneration."),
    price = "10 kUSD",
    materials = { "wood", "mithril_metal" },
    techniques = { "WBLOCK_2", "RAPID", "SWEEP" },
    weapon_categories = { "QUARTERSTAVES" },
    flags = { "SHEATH_SPEAR", "ALWAYS_TWOHAND", "FRAGILE_MELEE", "MAGIC_FOCUS", "SPELLCASTING_AID" },
    mass = "1400 g",
    volume = "3 L",
    length = "170 cm",
    category = "weapons",
    accuracy = 3,
    melee_damage = { bash = 17 },
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_magi_staff_greater_0" } },
}

ccb.content.define_item {
    id = "wizard_hat",
    name = ccb.content.plural_text("wizard hat", "wizard hats"),
    description = ccb.content.text("A blue pointed hat with stars stitched into it.  Wearing it increases your maximum mana."),
    mass = "390 g",
    volume = "2 L",
    price = "95 USD",
    survival_price = "1200 USD",
    materials = { "cotton" },
    symbol = "^",
    color = "light_blue",
    flags = { "VARSIZE" },
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 7,
        thickness = 2,
        environmental_protection = 2,
        portions = { { encumbrance = 12, coverage = 50, covers = { "head" } } },
    },
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_wizard_hat_0" } },
}

ccb.content.define_item {
    id = "debug_fireball_hammer",
    name = ccb.content.plural_text("fireball hammer", "fireball hammers"),
    copy_from = "magi_staff_minor",
    description = ccb.content.text("Use with caution!  Flammable!  Explosive!"),
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_debug_fireball_hammer_0" } },
}

ccb.content.define_item {
    id = "cloak_morthylla",
    copy_from = "cloak_wool",
    name = ccb.content.plural_text("Cloak of Morthylla the Lamia", "Cloaks of Morthylla the Lamia"),
    description = ccb.content.text("This cloak seems to absorb light except for the pinpricks of stars that move across its surface."),
    price = "15 kUSD",
    survival_price = "3 kUSD 600 USD",
    materials = { "black_dragon_hide" },
    symbol = "[",
    color = "dark_gray",
    flags = {
        "OVERSIZE",
        "HOOD",
        "OUTER",
        "NO_REPAIR",
        "STURDY",
        "TRADER_KEEP_EQUIPPED",
        "COSPLAY_COSTUME",
    },
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 30,
        thickness = 3,
        portions = {
            {
                encumbrance = 4,
                coverage = 85,
                covers = { "torso", "head", "arm_l", "arm_r", "leg_l", "leg_r" },
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_cloak_morthylla_0" } },
}

-- the bag itself gives +3 to throwing instead of knifes because of stupid code oogie woogie, that make effects (and enchantments, it seems) being apply in the very first move after the giving. ie if you give +3 to throwing for a knife, spawn it, and then throw it, it won't be applied
ccb.content.define_item {
    id = "magic_knife_bag",
    looks_like = "holster",
    name = ccb.content.plural_text("Bag of Infinite Throwing Knives", "Bags of Infinite Throwing Knives"),
    description = ccb.content.text("This bag conjures a magical throwing knife on activation.  Only refills when worn.  It also boosts your throwing abilities."),
    price = "8 kUSD",
    survival_price = "1800 USD",
    volume = "100 ml",
    mass = "62 g",
    materials = { "black_dragon_hide" },
    symbol = "[",
    color = "dark_gray",
    pockets = { { kind = "MAGAZINE", ammunition = { crystallized_mana = 8 } } },
    flags = { "OVERSIZE", "NO_REPAIR", "STURDY", "BELTED", "NO_UNLOAD", "NO_RELOAD" },
    subtype_order = { "armor", "tool", "artifact" },
    armor = {
        environmental_protection = 1,
        sided = true,
        portions = {
            {
                materials = { { id = "black_dragon_hide", coverage = 100, thickness = 1.0 } },
                encumbrance = 2,
                coverage = 5,
                covers = { "leg_l", "leg_r" },
            },
        },
    },
    tool = { charges_per_use = 1 },
    artifact = {
        charge = {
            recharge_condition = "worn",
            recharge_type = "periodic",
            interval = "5 h",
            regenerate_ammo = true,
        },
        enchantments = { "ITEM_ENCH_Magiclysm_magic_knife_bag_0" },
    },
    use_actions = {
        {
            kind = "cast_spell",
            spell = "conj_mag_throw_blade_group",
            no_fail = true,
            level = 1,
            need_worn = true,
        },
    },
}

ccb.content.define_item {
    id = "wolfshead_cufflinks",
    copy_from = "ruby_silver_cufflinks",
    mass = "20 g",
    survival_price = "1200 USD",
    name = ccb.content.plural_text("pair of wolfshead cufflinks", "pairs of wolfshead cufflinks"),
    description = ccb.content.text("A pair of silver cufflinks with a wolf's head engraved into them.  Each cufflink has a bright ruby eye and pearl teeth.  They appear to be growling.  There is an inscription, 'When the moon shines.  I become alive.'"),
    pockets = { { kind = "MAGAZINE", ammunition = { crystallized_mana = 1 } } },
    flags = { "NO_UNLOAD", "NO_RELOAD" },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 1 },
    armor = {},
    artifact = {
        charge = { recharge_type = "periodic", interval = "7 day", regenerate_ammo = true },
        enchantments = { "ITEM_ENCH_Magiclysm_wolfshead_cufflinks_0" },
    },
    use_actions = { { kind = "cast_spell", spell = "lupercalia", no_fail = true, level = 1, need_worn = true } },
}
