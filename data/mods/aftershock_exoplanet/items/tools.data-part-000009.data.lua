local ccb = require("ccb")

-- Makes it look more sci-fi so it isn't out of place, not many actual changes otherwise.
ccb.content.define_item {
    id = "multi_cooker",
    copy_from = "multi_cooker",
    name = ccb.content.plural_text("micro-cooker", "micro-cookers"),
    description = ccb.content.text("A rugged kitchen in one tool, made for use within small spaceships or in the wilderness.  It can automatically prepare a variety of dishes while its owner focuses on other tasks."),
    mass = "5 kg",
    volume = "3 L",
    price = "1500 USD",
    survival_price = "1500 USD",
    accuracy = -3,
    materials = { "steel", "plastic" },
    symbol = ";",
    color = "red",
    flags = { "ELECTRONIC", "ALLOWS_REMOTE_USE", "BELT_CLIP" },
    faults = { { group = "electronic_general" } },
    qualities = {
        { id = "COOK", level = 3 },
        { id = "BOIL", level = 2 },
        { id = "CONTAIN", level = 1 },
        { id = "HOTPLATE", level = 2 },
        { id = "CHEM", level = 1 },
    },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_MEDIUM" },
            default_magazine = "medium_battery_cell",
        },
        {
            kind = "CONTAINER",
            watertight = true,
            rigid = true,
            capacity = "2 L",
            mass_limit = "4 kg",
            max_item_length = "35 cm",
            moves = 50,
        },
    },
    tool = { power_draw = "100 W", ammo_types = { "battery" } },
    use_actions = { "MULTICOOKER", { kind = "link_up", cable_length = 2, charge_rate = "1000 W" } },
    tick_actions = { "MULTICOOKER_TICK" },
}
