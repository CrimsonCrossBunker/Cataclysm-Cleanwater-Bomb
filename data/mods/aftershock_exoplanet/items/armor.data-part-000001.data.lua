local ccb = require("ccb")

-- Change charges and charge_regen only
ccb.content.define_item {
    id = "afs_holo_cloak_mk2",
    copy_from = "afs_sentinel_cloak",
    name = ccb.content.plural_text("hologram cloak Mk. II", "hologram cloaks Mk. II"),
    description = ccb.content.text("When activated, creates a holographic decoy of its wearer.  Powered by an experimental n-space energy generator, it slowly recharges itself for free, probably by siphoning excess energy from some unknown hyperdimensional space."),
    pockets = { { kind = "MAGAZINE", ammunition = { battery = 15 } } },
    flags = { "OVERSIZE", "HOOD", "WATERPROOF", "STURDY", "OUTER", "NO_UNLOAD", "NO_RELOAD" },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 1 },
    armor = {},
    artifact = { charge = { recharge_type = "periodic", interval = "1 h", regenerate_ammo = true } },
    use_actions = { "DIRECTIONAL_HOLOGRAM" },
}

ccb.content.define_item {
    id = "afs_sentinel_cloak",
    copy_from = "jedi_cloak",
    name = ccb.content.plural_text("Sentinel-lx cloak", "Sentinel-lx cloaks"),
    description = ccb.content.text("The vantablack cloak of Sentinel-lx hangs around ones shoulders as a solid, unnatural shadow.  Made from woven graphene, it's lightweight and resistant, but cannot be repaired."),
    price = "15 kUSD",
    materials = { "graphene_weave" },
    symbol = "[",
    color = "dark_gray",
    flags = { "OVERSIZE", "HOOD", "OUTER", "NO_REPAIR", "STURDY", "COSPLAY_COSTUME" },
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 30,
        thickness = 1,
        portions = {
            {
                encumbrance = 4,
                coverage = 85,
                covers = { "torso", "head", "arm_l", "arm_r", "leg_l", "leg_r" },
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_aftershock_exoplanet_afs_sentinel_cloak_0" } },
}
