local ccb = require("ccb")

ccb.content.define_item {
    id = "corpsefire_cap",
    name = ccb.content.plural_text("corpsefire cap", "corpsefire caps"),
    description = ccb.content.text("The cap of a corpsefire mushroom.  It still has a faint glow about it."),
    mass = "70 g",
    volume = "200 ml",
    color = "white",
    symbol = ",",
    materials = { "veggy" },
    flags = { "RAW" },
    light = 2,
    comestible = { kind = "FOOD", calories = 10, shelf_life = "8 days 16 hours", fun = 0 },
    use_actions = { "BLECH" },
}
