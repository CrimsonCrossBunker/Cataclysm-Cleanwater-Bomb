local ccb = require("ccb")

ccb.content.define_item {
    id = "goblin_fruit_water_breathing",
    name = ccb.content.plural_text("star-shaped goblin fruit", "star-shaped goblin fruits"),
    description = ccb.content.text("This greenish-white goblin fruit is shaped like a star in a much more literal way than a starfruit.  It's almost like if a starfish was an apple.  It smells like freshly-laundered clothing."),
    copy_from = "goblin_fruit_abstract",
    color = "green_white",
    mass = "210 g",
    volume = "240 ml",
    comestible = { kind = "FOOD", fun = -3, on_consume = "consume_goblin_fruit_water_breathing" },
}
