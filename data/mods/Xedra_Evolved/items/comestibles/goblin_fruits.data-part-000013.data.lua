local ccb = require("ccb")

ccb.content.define_item {
    id = "goblin_fruit_perception",
    name = ccb.content.plural_text("spikey goblin fruit", "spikey goblin fruits"),
    description = ccb.content.text("This dark-colored goblin fruit is covered in spikes like a pineapple.  Unlike a pineapple, the spikes are yielding and seem part of the fruit, not a rind.  It smells of freshly-cut grass."),
    copy_from = "goblin_fruit_abstract",
    color = "dark_gray",
    mass = "182 g",
    volume = "232 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_perception" },
}
