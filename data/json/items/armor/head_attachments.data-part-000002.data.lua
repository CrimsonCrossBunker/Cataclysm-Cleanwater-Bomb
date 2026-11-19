local ccb = require("ccb")

ccb.content.define_item {
    id = "military_nvg",
    category = "armor",
    name = ccb.content.plural_text("night vision goggles", "night vision goggles"),
    description = ccb.content.text("Last generation double-tube night vision device, designed to be mounted on a compatible helmet.  Currently raised up and out of the way."),
    mass = "680 g",
    volume = "1200 ml",
    price = "10000 USD",
    survival_price = "15 USD",
    materials = { "plastic", "steel", "glass" },
    symbol = "[",
    color = "dark_gray",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_LIGHT" },
            default_magazine = "light_battery_cell",
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
            { covers = { "head" }, encumbrance = 8, coverage = 70, subparts = { "head_forehead" } },
        },
    },
    artifact = { enchantments = { "nvg_normal" } },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You activate your %s."),
            target = "military_nvg_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}
