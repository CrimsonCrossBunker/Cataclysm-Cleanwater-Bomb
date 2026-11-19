local ccb = require("ccb")

ccb.content.define_item {
    id = "goblin_fruit_cold_resist",
    name = ccb.content.plural_text("sapphire goblin fruit", "sapphire goblin fruits"),
    description = ccb.content.text("This fruit is easily mistakable for a fist-sized sapphire.  Its color, rigidity and facets bring to mind a gemstone, unlike its green stem."),
    copy_from = "goblin_fruit_abstract",
    color = "blue",
    mass = "259 g",
    volume = "266 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_cold_resist" },
}
