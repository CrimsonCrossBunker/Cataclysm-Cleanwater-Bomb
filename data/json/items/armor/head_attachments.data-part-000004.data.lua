local ccb = require("ccb")

ccb.content.define_item {
    id = "advanced_gpnvg",
    category = "armor",
    name = ccb.content.plural_text("panoramic night vision goggles", "panoramic night vision goggles"),
    description = ccb.content.text("Advanced GPNVG with four image intensifier tubes, allowing for a large field of view at night, designed to be mounted on a compatible helmet.  Currently raised up and out of the way."),
    mass = "765 g",
    volume = "1600 ml",
    price = "47000 USD",
    survival_price = "30 USD",
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
                encumbrance = 12,
                coverage = 80,
                subparts = { "head_forehead", "head_crown" },
            },
        },
    },
    artifact = { enchantments = { "nvg_good" } },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You activate your %s."),
            target = "advanced_gpnvg_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}
