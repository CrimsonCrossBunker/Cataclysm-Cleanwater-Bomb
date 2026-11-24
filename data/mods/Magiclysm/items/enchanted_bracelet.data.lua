local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "platinum_bracelet_magic",
    abstract = true,
    name = ccb.content.text_without_extraction("platinum bracelet"),
    description = ccb.content.text_without_extraction("A bracelet, completely covered with a large amount of runes from both sides."),
    mass = "50 g",
    volume = "25 ml",
    materials = { "platinum", "crystallized_mana" },
    symbol = "[",
    color = "white",
    flags = {
        "BELTED", "NO_WEAR_EFFECT", "STURDY", "ONE_PER_LAYER", "WATER_FRIENDLY",
        "ALLOWS_NATURAL_ATTACKS", "OVERSIZE",
    },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        sided = true,
        portions = {
            {
                coverage = 50,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_wrist_l", "hand_wrist_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "missile_volley_bracelet",
    copy_from = "platinum_bracelet_magic",
    name = ccb.content.plural_text("missile volley bracelet", "missile volley bracelets"),
    description = ccb.content.text("A bracelet, completely covered with a large amount of runes from both sides.  Wizards love to name it \"Ultima Ratio\", describing its colossal might.  Require almost a whole week to restore its charge."),
    survival_price = "6900 USD",
    pockets = { { kind = "MAGAZINE", holster = true, ammunition = { crystallized_mana = 1 } } },
    inheritance = { add = { flags = { "NO_UNLOAD", "NO_RELOAD" } }, remove = { flags = { "NO_WEAR_EFFECT" } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 1 },
    armor = {},
    artifact = { charge = { recharge_type = "periodic", interval = "7 d", regenerate_ammo = true } },
    use_actions = {
        {
            kind = "cast_spell",
            spell = "missile_volley",
            no_fail = true,
            level = 0,
            need_worn = true,
        },
    },
}

ccb.content.define_item {
    id = "gorgon_bracelet",
    copy_from = "platinum_bracelet_magic",
    name = ccb.content.plural_text("petrification bracelet", "petrification bracelets"),
    description = ccb.content.text("A bracelet, completely covered with a large amount of runes from both sides.  You don't really know how it works, but after use enemies literally freeze in the middle of their movement.  Require almost 7 days to restore its charge."),
    survival_price = "6500 USD",
    pockets = { { kind = "MAGAZINE", holster = true, ammunition = { crystallized_mana = 1 } } },
    inheritance = { add = { flags = { "NO_UNLOAD", "NO_RELOAD" } }, remove = { flags = { "NO_WEAR_EFFECT" } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 1 },
    armor = {},
    artifact = { charge = { recharge_type = "periodic", interval = "7 d", regenerate_ammo = true } },
    use_actions = { { kind = "cast_spell", spell = "gorgon_spell", no_fail = true, level = 0, need_worn = true } },
}

ccb.content.define_item {
    id = "disorientation_bracelet",
    copy_from = "platinum_bracelet_magic",
    name = ccb.content.plural_text("disorientation bracelet", "disorientation bracelets"),
    description = ccb.content.text("Known as \"a worse version of petrification bracelet\", this tool casts a spell that temporarily breaks the whole movement system of a creature, disabling its movement for a short time.  Require almost a week to restore its charge."),
    survival_price = "5600 USD",
    pockets = { { kind = "MAGAZINE", holster = true, ammunition = { crystallized_mana = 2 } } },
    inheritance = { add = { flags = { "NO_UNLOAD", "NO_RELOAD" } }, remove = { flags = { "NO_WEAR_EFFECT" } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 1 },
    armor = {},
    artifact = { charge = { recharge_type = "periodic", interval = "7 d", regenerate_ammo = true } },
    use_actions = {
        {
            kind = "cast_spell",
            spell = "disorient_spell",
            no_fail = true,
            level = 0,
            need_worn = true,
        },
    },
}

ccb.content.define_item {
    id = "super_hot_bracelet",
    copy_from = "platinum_bracelet_magic",
    name = ccb.content.plural_text("propulsion bracelet", "propulsion bracelets"),
    description = ccb.content.text("It feels like the world around you just stops.  That's not true, that's just a combination of really fast speed and some mana tricks you can't understand.  Requires a whole week to restore its charge."),
    survival_price = "8500 USD",
    pockets = { { kind = "MAGAZINE", holster = true, ammunition = { crystallized_mana = 1 } } },
    inheritance = { add = { flags = { "NO_UNLOAD", "NO_RELOAD" } }, remove = { flags = { "NO_WEAR_EFFECT" } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 1 },
    armor = {},
    artifact = { charge = { recharge_type = "periodic", interval = "7 d", regenerate_ammo = true } },
    use_actions = {
        {
            kind = "cast_spell",
            spell = "super_hot_spell",
            no_fail = true,
            level = 0,
            need_worn = true,
        },
    },
}

ccb.content.define_item {
    id = "mana_leech_shackle_unlocked",
    name = ccb.content.plural_text("inert mana-leech shackle", "inert mana-leech shackles"),
    description = ccb.content.text("A platinum bracelet covered in runes.  If it was active, it would keep its wearer from casting spells.  Now it's just another useless trinket as you do not know the spells it requires to be activated again."),
    mass = "50 g",
    volume = "25 ml",
    materials = { "platinum" },
    symbol = "[",
    color = "white",
    flags = { "STURDY", "ONE_PER_LAYER", "WATER_FRIENDLY", "TRADER_AVOID", "ALLOWS_NATURAL_ATTACKS" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        sided = true,
        portions = {
            {
                coverage = 50,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_wrist_l", "hand_wrist_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "mana_leech_shackle",
    copy_from = "mana_leech_shackle_unlocked",
    name = ccb.content.plural_text("mana-leech shackle", "mana-leech shackles"),
    description = ccb.content.text("A platinum bracelet covered in runes.  It cannot be removed without the appropriate spell and it constantly drains the wearer's mana, preventing them from casting any spell until they get rid of it."),
    mass = "50 g",
    volume = "25 ml",
    materials = { "platinum" },
    symbol = "[",
    color = "white",
    flags = {
        "MORPHIC", "NO_TAKEOFF", "STURDY", "ONE_PER_LAYER", "WATER_FRIENDLY", "TRADER_AVOID",
        "ALLOWS_NATURAL_ATTACKS",
    },
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {
        sided = true,
        portions = {
            {
                coverage = 50,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_wrist_l", "hand_wrist_r" },
            },
        },
    },
    artifact = {
        enchantments = { "ITEM_ENCH_Magiclysm_mana_leech_shackle_0", "ITEM_ENCH_Magiclysm_mana_leech_shackle_1" },
    },
}
