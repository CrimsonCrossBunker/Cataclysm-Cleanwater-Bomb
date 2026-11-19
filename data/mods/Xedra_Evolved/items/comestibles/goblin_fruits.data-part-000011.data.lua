local ccb = require("ccb")

ccb.content.define_item {
    id = "goblin_fruit_night_vision",
    name = ccb.content.plural_text("toroid goblin fruit", "toroid goblin fruits"),
    description = ccb.content.text("This yellow-green goblin fruit is shaped like a donut, with six reddish stems spaced equidistantly around its circumference.  You can't imagine what the plant that grew this one looks like."),
    copy_from = "goblin_fruit_abstract",
    color = "yellow",
    mass = "118 g",
    volume = "151 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_night_vision" },
}
