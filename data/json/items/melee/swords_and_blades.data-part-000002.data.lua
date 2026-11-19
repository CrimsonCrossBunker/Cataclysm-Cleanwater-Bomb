local ccb = require("ccb")

ccb.content.define_item {
    id = "sword_xiphos",
    category = "weapons",
    name = ccb.content.plural_text("xiphos", "xiphe"),
    description = ccb.content.text("A bronze sword of ancient Greek origin, wielded as a sidearm to the dory spear."),
    mass = "800 g",
    volume = "2 L",
    length = "50 cm",
    price = "120 USD",
    survival_price = "25 USD",
    accuracy = { grip = "weapon", length = "short", surface = "line", balance = "good" },
    materials = { "bronze" },
    symbol = "!",
    color = "yellow",
    techniques = { "WBLOCK_2" },
    qualities = { { id = "CUT", level = 1 }, { id = "BUTCHER", level = 8 } },
    flags = { "SHEATH_SWORD", "DURABLE_MELEE" },
    weapon_categories = { "SHORT_SWORDS" },
    faults = { { group = "handle_short" }, { group = "blade_general", weight_multiplier = 5 } },
    melee_damage = { bash = 6, cut = 28 },
    tool = {},
}
