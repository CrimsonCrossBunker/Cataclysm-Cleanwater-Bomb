local ccb = require("ccb")

ccb.content.define_item {
    id = "goblin_fruit_healing",
    name = ccb.content.plural_text("sweet goblin fruit", "sweet goblin fruits"),
    description = ccb.content.text("This round goblin fruit is reddish-orange with a waxy texture.  It smells sweet with a hint of petrichor."),
    copy_from = "goblin_fruit_abstract",
    color = "red_yellow",
    mass = "210 g",
    volume = "273 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_healing" },
}
