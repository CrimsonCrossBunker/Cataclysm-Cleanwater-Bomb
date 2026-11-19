local ccb = require("ccb")

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
