local ccb = require("ccb")

ccb.content.define_item {
    id = "blacksmith_kit",
    name = ccb.content.plural_text("blacksmith repair kit", "blacksmith repair kits"),
    description = ccb.content.text("This is a set of tools to repair damaged metal tools and armor.  It uses charcoal, contained in a small clay vessel, to heat the part and make it easier to work."),
    mass = "1600 g",
    volume = "1400 ml",
    length = "25 cm",
    price = "50 USD",
    survival_price = "10 USD",
    materials = { "steel", "clay" },
    symbol = ";",
    color = "dark_gray",
    qualities = {
        { id = "HAMMER_FINE", level = 1 },
        { id = "HAMMER", level = 3 },
        { id = "PRY", level = 1 },
        { id = "COOK", level = 1 },
        { id = "GRIND", level = 2 },
        { id = "FILE", level = 2 },
        { id = "PRYING_NAIL", level = 1 },
    },
    flags = { "ALLOWS_REMOTE_USE" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { charcoal = 100 } } },
    melee_damage = { bash = 9 },
    tool = { charges_per_use = 5, ammo_types = { "charcoal" } },
    use_actions = {
        { kind = "native", id = "CROWBAR", ammo_scale = 0 },
        {
            kind = "repair_item",
            id = "repair_metal",
            materials = {
                "iron", "steel", "aluminum", "copper", "bronze", "fancy_bronze", "silver", "gold",
                "platinum", "superalloy",
            },
            skill = "fabrication",
            tool_quality = 5,
            cost_scaling = 0.1,
            move_cost = 2000,
        },
    },
}
