local ccb = require("ccb")

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
