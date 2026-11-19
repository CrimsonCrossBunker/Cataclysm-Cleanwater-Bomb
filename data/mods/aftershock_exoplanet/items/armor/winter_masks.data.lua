local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_magellan_suit_helmet",
    category = "armor",
    looks_like = "helmet_motor",
    name = ccb.content.plural_text("Magellan helmet CA.", "Magellan helmets CA."),
    description = ccb.content.text("The high quality helmet of a Magellan exosuit, adapted to handle the freezing but breathable air of Salus IV.  In addition to its life support functionality, it features a minor augmented reality UI overlay and a retractable gold-plated visor to protect against glare and UV light.  Although not armored as such, it's strong enough to handle minor blunt impacts."),
    mass = "2500 g",
    volume = "2250 ml",
    price = "750 USD",
    accuracy = -1,
    materials = { "plastic", "titanium" },
    symbol = "[",
    color = "dark_gray",
    flags = {
        "VARSIZE", "WATERPROOF", "RAINPROOF", "STURDY", "SUN_GLASSES", "RAD_RESIST", "OUTER",
        "SWIM_GOGGLES", "RECHARGE", "NO_RELOAD", "NO_UNLOAD", "GAS_PROOF", "WATCH", "ALARMCLOCK",
        "THERMOMETER", "HYGROMETER", "PARTIAL_DEAF", "SOFT",
    },
    melee_damage = { bash = 7 },
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {
        portions = {
            { covers = { "head" }, coverage = 100, encumbrance = 25 },
            { covers = { "eyes" }, rigid_only = true, coverage = 100, encumbrance = 5 },
            { covers = { "mouth" }, rigid_only = true, coverage = 100, encumbrance = 15 },
        },
        warmth = 50,
        thickness = 1,
        environmental_protection = 16,
    },
    artifact = { enchantments = { "afs_ench_climate_control_warm_helmet" } },
}

ccb.content.define_item {
    id = "afs_frontier_cryomask",
    category = "armor",
    looks_like = "helmet_motor",
    name = ccb.content.plural_text("frontier cryomask", "frontier cryomasks"),
    description = ccb.content.text("A common, industrially printed respirator cleverly retrofitted into a wearable air heater.  While it adequately protects against the cold, most of its original functions have been discarded and it offers no noticeable protection against noxious fumes or other environmental hazards."),
    mass = "2500 g",
    volume = "2250 ml",
    price = "750 USD",
    accuracy = -1,
    materials = { "plastic", "nomex" },
    symbol = "[",
    color = "dark_gray",
    flags = { "VARSIZE", "WATERPROOF", "RAINPROOF", "STURDY", "SUN_GLASSES", "OUTER", "SOFT" },
    melee_damage = { bash = 7 },
    subtype_order = { "armor", "artifact" },
    armor = {
        portions = {
            { covers = { "eyes" }, rigid_only = true, coverage = 100, encumbrance = 15 },
            { covers = { "head" }, coverage = 100, encumbrance = 20 },
            { covers = { "mouth" }, rigid_only = true, coverage = 100, encumbrance = 20 },
        },
        warmth = 50,
        thickness = 2,
        environmental_protection = 2,
    },
    artifact = { enchantments = { "afs_ench_climate_control_warm_helmet" } },
}

ccb.content.define_item {
    id = "afs_frontier_cryomask_xl",
    category = "armor",
    name = ccb.content.plural_text("frontier cryomask", "frontier cryomasks"),
    copy_from = "afs_frontier_cryomask",
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.13, price = 1.5 },
    },
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = {},
}
