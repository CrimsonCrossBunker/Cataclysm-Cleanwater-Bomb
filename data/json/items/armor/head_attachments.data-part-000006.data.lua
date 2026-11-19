local ccb = require("ccb")

ccb.content.define_item {
    id = "enhanced_nvg",
    category = "armor",
    name = ccb.content.plural_text("enhanced night vision goggles", "enhanced night vision goggles"),
    description = ccb.content.text("New and rare high-resolution thermal NVG device, designed to be mounted on a compatible helmet.  Lets you see in the dark, and detects heat signatures emitted by (un)living organisms.  Currently raised up and out of the way."),
    mass = "720 g",
    volume = "1400 ml",
    price = "10000 USD",
    survival_price = "35 USD",
    materials = { "plastic", "steel", "glass" },
    symbol = "[",
    color = "dark_gray",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_MEDIUM" },
            default_magazine = "medium_battery_cell",
        },
    },
    flags = { "HELMET_FRONT_ATTACHMENT", "CANT_WEAR", "OUTER", "ELECTRONIC", "MUNDANE" },
    faults = { { group = "electronic_general" } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 1, ammo_types = "battery" },
    armor = {
        thickness = 1,
        portions = {
            { covers = { "eyes" }, coverage = 10, encumbrance = 0, rigid_only = true },
            {
                covers = { "head" },
                encumbrance = 10,
                coverage = 70,
                subparts = { "head_forehead", "head_crown" },
            },
        },
    },
    artifact = { enchantments = { "nvg_good", "THERMAL_VISION_GOOD" } },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You activate your %s."),
            target = "enhanced_nvg_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}
