local ccb = require("ccb")

ccb.content.define_item {
    id = "goblin_fruit_no_rotten_food",
    name = ccb.content.plural_text("translucent goblin fruit", "translucent goblin fruits"),
    description = ccb.content.text("This goblin fruit looks like a globe of water with seeds and a stem suspended within it.  Despite that, it feels like kiwi, with a slight fuzz and no moisture left on your fingers when you touch it.  It smells like roses."),
    copy_from = "goblin_fruit_abstract",
    color = "white",
    mass = "209 g",
    volume = "267 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_no_rotten_food" },
}
