local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "afs_caster",
    abstract = true,
    name = ccb.content.text_without_extraction("caster"),
    description = ccb.content.text_without_extraction("A generic techno doodad used to cast spells."),
    mass = "100 g",
    volume = "250 ml",
    price = "50 USD",
    materials = { "superalloy" },
    symbol = "[",
    color = "light_red",
    flags = { "WATER_FRIENDLY", "ALLOWS_NATURAL_ATTACKS", "NO_UNLOAD", "NO_RELOAD" },
    max_worn = 1,
    subtype_order = { "tool", "armor" },
    tool = { charges_per_use = 1 },
    armor = { warmth = 0, portions = { { coverage = 0, covers = { "torso" } } } },
}

ccb.content.define_item {
    id = "afs_holo_transposition_caster",
    name = ccb.content.plural_text("hologram transposition caster", "hologram transposition casters"),
    copy_from = "afs_caster",
    description = ccb.content.text("A small metallic sphere with a recessed bottom up top.  When activated it will allow you to swap positions with an existing hologram."),
    pockets = { { kind = "MAGAZINE", ammunition = { battery = 15 } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { charge = { regenerate_ammo = true, recharge_type = "periodic", interval = "1 h" } },
    use_actions = { { kind = "cast_spell", spell = "afs_holo_transposition", no_fail = true, level = 1 } },
}

ccb.content.define_item {
    id = "afs_holo_flare_caster",
    copy_from = "afs_caster",
    name = ccb.content.plural_text("hologram flare caster", "hologram flare casters"),
    description = ccb.content.text("A small metallic sphere with a recessed bottom up top.  When activated it will allow you to select a hologram, which will explode in a blinding flash, stunning anything nearby."),
    pockets = { { kind = "MAGAZINE", ammunition = { battery = 15 } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { charge = { regenerate_ammo = true, recharge_type = "periodic", interval = "1 h" } },
    use_actions = { { kind = "cast_spell", spell = "afs_holo_flare", no_fail = true, level = 1 } },
}

ccb.content.define_item {
    id = "afs_holo_decoy_caster",
    copy_from = "afs_caster",
    name = ccb.content.plural_text("decoy caster", "decoy casters"),
    description = ccb.content.text("A small metallic sphere with a recessed bottom up top.  When activated it will a holographic decoy in a location of your choosing."),
    pockets = { { kind = "MAGAZINE", ammunition = { battery = 2 } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { charge = { regenerate_ammo = true, recharge_type = "periodic", interval = "1 h" } },
    use_actions = { { kind = "cast_spell", spell = "afs_holo_decoy", no_fail = true, level = 1 } },
}

ccb.content.define_item {
    id = "afs_holo_field_caster",
    copy_from = "afs_caster",
    name = ccb.content.plural_text("decoy field caster", "decoy field casters"),
    description = ccb.content.text("A small metallic sphere with a recessed bottom up top.  When activated it will create several holographic decoys around you."),
    pockets = { { kind = "MAGAZINE", ammunition = { battery = 1 } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { charge = { regenerate_ammo = true, recharge_type = "periodic", interval = "1 h" } },
    use_actions = { { kind = "cast_spell", spell = "afs_holo_field", no_fail = true, level = 1 } },
}

ccb.content.define_item {
    id = "afs_recall_rig",
    copy_from = "dimensional_anchor",
    name = ccb.content.plural_text("recall rig", "recall rigs"),
    description = ccb.content.text("A complex antennae assembly worn around the upper torso that allows its user to home and teleport towards previously configured teleport pads.  Although relatively functional, it's much inferior to the translocation systems of old, and a successful teleport requires standing perfectly still for several minutes."),
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            magazine_well = "75 ml",
            allowed_flags = { "BATTERY_HEAVY" },
            default_magazine = "heavy_atomic_battery_cell",
        },
    },
    subtype_order = { "tool", "armor" },
    tool = { charges_per_use = 1000 },
    armor = {},
    use_actions = { { kind = "cast_spell", spell = "afs_translocation_slow", no_fail = true, level = 1 } },
}

ccb.content.define_item {
    id = "afs_translocation_device",
    copy_from = "afs_wrist_computer",
    name = "translocator",
    description = "An arcane device from the late Hyperspace Era, vaguely resembling a wrist computer made from malleable glass.  It can be activated to quickly deploy a translocator buoy or to teleport to previously activated buoys.",
    price = "100 kUSD",
    materials = { "diamond" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            capacity = "20 L",
            mass_limit = "20 kg",
            magazine_well = "75 ml",
            allowed_items = { "afs_archeotech_cartridge" },
        },
    },
    use_actions = {
        {
            kind = "cast_spell",
            spell = "afs_translocation",
            level = 1,
            no_fail = true,
            need_worn = true,
            mundane = true,
        },
        "AFS_TRANSLOCATOR",
    },
    tool = {
        charges_per_use = 1000,
        ammo_types = { "battery" },
    },
    armor = {},
    subtype_order = { "tool", "armor" },
}
