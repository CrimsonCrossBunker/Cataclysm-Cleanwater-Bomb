local ccb = require("ccb")

ccb.content.define_item {
    id = "goblin_fruit_climb",
    name = ccb.content.plural_text("sticky goblin fruit", "sticky goblin fruits"),
    description = ccb.content.text("Reeking of glass cleaner, this disk-shaped fruit sticks to anything it touches.  Despite this, you have no issue removing any dust sticking to it."),
    copy_from = "goblin_fruit_abstract",
    color = "light_blue",
    mass = "359 g",
    volume = "327 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_climb" },
}
