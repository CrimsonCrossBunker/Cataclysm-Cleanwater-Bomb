local ccb = require("ccb")

ccb.content.define_item {
    id = "exo_flame_thrower",
    category = "exosuit",
    name = ccb.content.plural_text("exosuit heavy flamethrower", "exosuit heavy flamethrowers"),
    description = ccb.content.text("A bulky flamethrower unit mounted on the shoulder of an exosuit.  An internal compressor adds extra range and spread to the flame compared to most handheld flame units."),
    mass = "7300 g",
    volume = "10 L",
    length = "100 cm",
    materials = { "qt_steel", "ceramic" },
    symbol = "f",
    color = "light_gray",
    flags = { "EXO_LARGE_GADGET", "CANT_WEAR" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_items = { "pressurized_tank", "pressurized_tank_modern" },
        },
    },
    subtype_order = { "tool", "armor" },
    tool = { charges_per_use = 30, ammo_types = "flammable" },
    armor = {},
    use_actions = { { kind = "cast_spell", spell = "exo_flamethrower", no_fail = true, level = 1 } },
}

ccb.content.define_item {
    id = "exo_sonic_unit",
    category = "exosuit",
    name = ccb.content.plural_text("exosuit sonic cannon", "exosuit sonic cannons"),
    description = ccb.content.text("A 'less-lethal' weapon mounted on the shoulder of an exosuit, it emits an extremely loud high-frequency pulse in a wide arc.  Useful for discouraging crowds, less useful for stealthy operations."),
    mass = "6000 g",
    volume = "10 L",
    length = "100 cm",
    materials = { "qt_steel", "ceramic" },
    symbol = "f",
    color = "light_gray",
    flags = { "EXO_LARGE_GADGET", "CANT_WEAR" },
    max_worn = 1,
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            holster = true,
            allowed_items = {
                "afs_cartridge",
                "afs_compact_cartridge",
                "afs_bootleg_cartridge",
                "afs_archeotech_cartridge",
            },
        },
    },
    subtype_order = { "tool", "armor" },
    tool = { charges_per_use = 80, ammo_types = "battery" },
    armor = {},
    use_actions = { { kind = "cast_spell", spell = "exo_sonic", no_fail = true, level = 1 } },
}

ccb.content.define_item {
    id = "exo_microwave_cannon",
    category = "exosuit",
    name = ccb.content.plural_text("exosuit microwave cannon", "exosuit microwave cannons"),
    description = ccb.content.text("A 'less-lethal' weapon mounted on the shoulder of an exosuit.  Causes a painful burning sensation as water molecules are turned to high temperature vapor.  Infamous for it's use by UICA forces used it to break up protests, the effectiveness can be hard to predict due to variables like the moisture in the air and protective layers on the target."),
    mass = "7500 g",
    volume = "10 L",
    length = "100 cm",
    materials = { "qt_steel", "ceramic" },
    symbol = "f",
    color = "light_gray",
    flags = { "EXO_LARGE_GADGET", "CANT_WEAR" },
    max_worn = 1,
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            holster = true,
            allowed_items = {
                "afs_cartridge",
                "afs_compact_cartridge",
                "afs_bootleg_cartridge",
                "afs_archeotech_cartridge",
            },
        },
    },
    subtype_order = { "tool", "armor" },
    tool = { charges_per_use = 100, ammo_types = "battery" },
    armor = {},
    use_actions = { { kind = "cast_spell", spell = "exo_microwave", no_fail = true, level = 1 } },
}

ccb.content.define_item {
    id = "exo_electrolaser",
    category = "exosuit",
    name = ccb.content.plural_text("exosuit electrolaser", "exosuit electrolasers"),
    description = ccb.content.text("An extremely dangerous weapon only deployed for heavy combat, this is mounted on the shoulder of an exosuit.  A laser creates a channel of ionized plasma which acts as a conduit for the follow-up massive energy charge.  The result is a powerful explosion that can impact a large area.  Requires significant energy reserves, draining a standard power cartridge per shot."),
    mass = "9900 g",
    volume = "10 L",
    length = "100 cm",
    materials = { "qt_steel", "superalloy", "ceramic" },
    symbol = "f",
    color = "light_gray",
    flags = { "EXO_LARGE_GADGET", "CANT_WEAR" },
    max_worn = 1,
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            holster = true,
            allowed_items = { "afs_cartridge", "afs_archeotech_cartridge" },
        },
    },
    subtype_order = { "tool", "armor" },
    tool = { charges_per_use = 1500, ammo_types = "battery" },
    armor = {},
    use_actions = { { kind = "cast_spell", spell = "exosuit_electrolaser", no_fail = true, level = 1 } },
}
