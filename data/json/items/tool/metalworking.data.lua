local ccb = require("ccb")

ccb.content.define_item {
    id = "casting_mold_small",
    copy_from = "casting_mold",
    name = ccb.content.plural_text("small sandcasting mold", "small sandcasting molds"),
    description = ccb.content.text("A small mold for casting molten metals into different shapes."),
    volume = "8 L",
    mass = "6000 g",
    length = "20 cm",
    tool = { crafting_subtype = "" },
}

ccb.content.define_item {
    id = "casting_mold",
    name = ccb.content.plural_text("sandcasting mold", "sandcasting molds"),
    description = ccb.content.text("A medium mold for casting molten metals into different shapes."),
    mass = "19200 g",
    volume = "36 L",
    length = "40 cm",
    accuracy = { grip = "bad", length = "long", surface = "any", balance = "clumsy" },
    price = "8 USD",
    survival_price = "10 cent",
    materials = { "sand", "clay", "wood" },
    symbol = ";",
    color = "brown",
    melee_damage = { bash = 10 },
    tool = { crafting_subtype = "casting_mold_small" },
}
