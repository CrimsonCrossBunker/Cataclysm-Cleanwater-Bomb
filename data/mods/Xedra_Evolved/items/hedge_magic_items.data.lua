local ccb = require("ccb")

ccb.content.define_item {
    id = "item_hedge_witchlight",
    name = "Witchlight",
    description = "A bobbing ball of blueish-green light, just bright enough to read by.",
    symbol = "x",
    color = "yellow",
    mass = "0 g",
    volume = "0 ml",
    price = "0 cent",
    light = 10,
    max_worn = 1,
    flags = {
        "SEMITANGIBLE",
        "AURA",
        "OVERSIZE",
        "PADDED",
        "ALLOWS_NATURAL_ATTACKS",
        "TRADER_AVOID",
        "NO_REPAIR",
        "NO_DROP",
        "ZERO_WEIGHT",
        "NONCONDUCTIVE",
    },
    armor = {},
    artifact = {
        enchantments = { "ITEM_ENCH_Xedra_Evolved_item_hedge_witchlight_0" },
    },
    subtype_order = { "armor", "artifact" },
}
