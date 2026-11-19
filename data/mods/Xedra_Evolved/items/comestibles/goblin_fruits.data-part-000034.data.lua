local ccb = require("ccb")

ccb.content.define_item {
    id = "goblin_fruit_heal_after_sleep",
    name = ccb.content.plural_text("recoloring goblin fruit", "recoloring goblin fruits"),
    description = ccb.content.text("This rectangle fruit smells of lavender and has a mushy texture.  Its colors grow more vibrant for a second when you blink."),
    copy_from = "goblin_fruit_abstract",
    color = "green_white",
    mass = "238 g",
    volume = "217 ml",
    flags = { "FREEZERBURN", "NO_AUTO_CONSUME", "MUSHY" },
    comestible = { kind = "FOOD", on_consume = "eat_restful_goblin_fruit" },
}

ccb.content.define_item {
    id = "goblin_fruit_teleport",
    name = ccb.content.plural_text("fractal goblin fruit", "fractal goblin fruits"),
    description = ccb.content.text("This spherical fruit is made of smaller versions of itself, which are also made of smaller versions of themselves.  Should you have a microscope, you could look at the fractal as it becomes smaller and smaller."),
    copy_from = "goblin_fruit_abstract",
    color = "blue",
    mass = "458 g",
    volume = "417 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_teleport" },
}
