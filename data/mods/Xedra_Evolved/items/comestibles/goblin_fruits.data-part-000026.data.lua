local ccb = require("ccb")

ccb.content.define_item {
    id = "goblin_fruit_immovable",
    name = ccb.content.plural_text("bitter goblin fruit", "bitter goblin fruits"),
    description = ccb.content.text("This fruit wrapped in barbed vines fills you with bitterness as you hold it.  It slightly resists inertia as you move it, as if it moved through molasses."),
    copy_from = "goblin_fruit_abstract",
    color = "light_gray",
    mass = "202 g",
    volume = "284 ml",
    comestible = { kind = "FOOD", fun = -10, on_consume = "consume_goblin_fruit_immovable" },
}
