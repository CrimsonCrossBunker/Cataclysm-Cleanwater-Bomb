local ccb = require("ccb")

ccb.content.define_item {
    id = "goblin_fruit_thorns",
    name = ccb.content.plural_text("spicy goblin fruit", "spicy goblin fruits"),
    description = ccb.content.text("This long, thin goblin fruit is a subdued green color but has a smell that burns your nostrils."),
    copy_from = "goblin_fruit_abstract",
    color = "light_green",
    mass = "173 g",
    volume = "209 ml",
    comestible = { kind = "FOOD", fun = -2, on_consume = "consume_goblin_fruit_thorns" },
}
