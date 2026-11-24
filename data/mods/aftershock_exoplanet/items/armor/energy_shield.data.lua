local ccb = require("ccb")

ccb.content.define_spell {
    id = "spawn_shield",
    name = ccb.content.text("Spawn Riemann Shield"),
    description = ccb.content.text("Creates a shield."),
    valid_targets = { "self" },
    flags = { "VERBAL", "NO_FAIL", "CONCENTRATE", "SOMATIC", "PERMANENT_ALL_LEVELS", "NO_EXPLOSION_SFX" },
    min_range = 0,
    max_range = 0,
    min_damage = 1,
    max_damage = 1,
    effect = "spawn_item",
    effect_data = "afs_energy_shield",
    shape = "blast",
    max_level = 1,
}

ccb.content.define_item {
    id = "afs_energy_shield",
    name = "Riemann shell",
    description = "A thin shell of altered reality containing enormous electromagnetic potential, such that it might behave as a solid object under certain conditions.  A Riemann shell can defend against a wide variety of physical and energy attacks, but can be overwhelmed and forced to collapse into deadly radiation with prolonged assault.",
    symbol = "o",
    color = "blue",
    mass = "1 g",
    volume = "1 ml",
    max_worn = 1,
    max_energy_shield_hp = 1200,
    flags = {
        "AURA",
        "ENERGY_SHIELD",
        "OVERSIZE",
        "TRADER_AVOID",
        "NO_TAKEOFF",
        "NONCONDUCTIVE",
        "SPAWN_ACTIVE",
        "ALLOWS_NATURAL_ATTACKS",
        "SEMITANGIBLE",
        "POWERARMOR_COMPATIBLE",
        "UNRESTRICTED",
    },
    materials = { "riemann_space" },
    tool = {},
    armor = {
        thickness = 5.0,
        environmental_protection = 20,
        portions = {
            { coverage = 100, covers_all = true, encumbrance = 0 },
        },
    },
    subtype_order = { "tool", "armor" },
}

ccb.content.define_item {
    id = "afs_backpack_shieldgen",
    name = "SHD-1k Riemann Shield Generator",
    description = "A backpack mounted shield generator for infantry use, capable of fully protecting its user during prolonged bursts of kinetic and energy attacks.  Standard issue for UICA breaching teams.\n\nIts high energy consumption and weight make it unsuitable for long-term use.  Powered with energy cartridges.",
    symbol = "[",
    color = "brown",
    looks_like = "backpack",
    mass = "10 kg",
    volume = "18000 ml",
    price = "120 kUSD",
    survival_price = "120 kUSD",
    max_worn = 1,
    flags = { "BELTED", "WATERPROOF", "POWERARMOR_COMPATIBLE" },
    materials = { "nylon", "aluminum" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            capacity = "20 L",
            mass_limit = "20 kg",
            magazine_well = "75 ml",
            allowed_items = { "afs_cartridge", "afs_bootleg_cartridge", "afs_archeotech_cartridge" },
        },
    },
    tool = {
        charges_per_use = 400,
        ammo_types = { "battery" },
    },
    armor = {
        thickness = 2,
        warmth = 10,
        portions = {
            {
                covers = { "torso" },
                subparts = { "torso_hanging_back", "torso_waist" },
                coverage = 100,
                volume_encumbrance = 0,
                encumbrance = { 3, 12 },
            },
        },
    },
    subtype_order = { "tool", "armor" },
}

ccb.content.define_item {
    id = "afs_backpack_shieldgen_on",
    copy_from = "afs_backpack_shieldgen",
    name = ccb.content.plural_text("SHD-1k Riemann Shield Generator (active)", "SHD-1k Riemann Shield Generators (active)"),
    description = "This shield generator is active and maintaining a Riemann shield around its user.  It is capable of fully protecting its user during prolonged bursts of kinetic and energy attacks.  Standard issue for UICA breaching teams.\n\nIts high energy consumption and weight make it unsuitable for long-term use.  Powered with energy cartridges.",
    revert_to = "afs_backpack_shieldgen",
    tool = { charges_per_use = 0, power_draw = "1 kW" },
    armor = {},
    subtype_order = { "tool", "armor" },
    inheritance = {
        add = {
            flags = { "SHIELD_GENERATOR" },
        },
    },
}
