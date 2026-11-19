local ccb = require("ccb")

ccb.content.define_item {
    id = "goblin_fruit_dodge",
    name = ccb.content.plural_text("inky goblin fruit", "inky goblin fruits"),
    description = ccb.content.text("This large goblin fruit is such a deep black color you can't actually tell exactly what shape it is.  It's roundish, but when you hold it, it seems more like you're holding a hole in the fabric of the world.  It smells like an apple."),
    copy_from = "goblin_fruit_abstract",
    color = "black",
    mass = "273 g",
    volume = "348 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_dodge" },
}
