local ccb = require("ccb")

ccb.content.define_item {
    id = "crystallized_mana",
    category = "spare_parts",
    price = "10 USD",
    name = ccb.content.plural_text("crystallized mana", "crystallized mana"),
    symbol = "=",
    color = "yellow",
    description = ccb.content.text("Some crystallized mana.  This can be reloaded into rechargeable mana crystals, but can never be unloaded."),
    flags = { "TRADER_AVOID" },
    mass = "1 mg",
    volume = "100 ml",
    materials = { "crystallized_mana" },
    looks_like = "battery",
    ammunition = { type = "crystallized_mana", count = 10 },
}

ccb.content.define_item {
    id = "small_mana_crystal",
    category = "spare_parts",
    name = ccb.content.text("small mana crystal"),
    description = ccb.content.text("This is a small mana crystal specifically designed to be attached to wand tips."),
    mass = "5 g",
    volume = "250 ml",
    price = "15 USD",
    symbol = "=",
    color = "yellow",
    looks_like = "battery",
    flags = { "NO_SALVAGE", "NO_UNLOAD" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { crystallized_mana = 50 } } },
    magazine = { ammunition = { "crystallized_mana" }, capacity = 50 },
}
