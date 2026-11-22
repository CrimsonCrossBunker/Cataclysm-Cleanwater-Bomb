local ccb = require("ccb")

ccb.content.define_item {
    id = "integrated_bio_robofac_xmback",
    name = "Hub 01 BACK exoskeleton",
    description = "The Hub 01 Biomechanical Assisted Carrying Kinetoframe, or BACK.  This powered exoskeleton anchors the Hub 01 ARM and LEG systems to each other, improving their function.  The metal frame crosses the shoulders, spine, and upper waist, with specialized clips for attaching it to compatible ARM and LEG exoskeletons.  When powered, the frame adapts to effectively distribute force, increasing carrying capacity by 35%, and modestly improving your ability to throw and absorb recoil.  If left unpowered, or if equipped without an ARM and a LEG, it is a significant burden.  Activate it to toggle power.",
    symbol = ",",
    color = "dark_gray",
    category = "armor",
    mass = "1600 g",
    volume = "5000 ml",
    price = "400000 USD",
    survival_price = "450 USD",
    flags = {
        "BELTED",
        "CAN_USE_IN_DARK",
        "COMBAT_TOGGLEABLE",
        "STURDY",
        "WATER_FRIENDLY",
        "MUNDANE",
        "PADDED",
        "ROBOFAC_BACK",
    },
    materials = { "qt_steel" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            default_magazine = "heavy_battery_cell",
            rigid = true,
            allowed_flags = { "BATTERY_HEAVY" },
        },
    },
    armor = {
        thickness = 4,
        warmth = 5,
        environmental_protection = 0,
        portions = {
            {
                covers = { "torso" },
                coverage = 5,
                encumbrance = 40,
            },
        },
    },
    tool = {
        ammo_types = { "battery" },
    },
    artifact = {
        enchantments = { "robofac_XM_BACK_on" },
    },
    subtype_order = { "armor", "tool", "artifact" },
}
