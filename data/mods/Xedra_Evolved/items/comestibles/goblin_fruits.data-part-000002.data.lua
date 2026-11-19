local ccb = require("ccb")

ccb.content.define_item {
    id = "goblin_fruit_illness",
    name = ccb.content.plural_text("iridescent goblin fruit", "iridescent goblin fruits"),
    description = ccb.content.text("This oblong goblin fruit shimmers slightly in a rainbow of colors.  It smells like a mix of peach and freshly-baked bread."),
    copy_from = "goblin_fruit_abstract",
    color = "white",
    mass = "155 g",
    volume = "174 ml",
    comestible = { kind = "FOOD", fun = 3, on_consume = "consume_goblin_fruit_illness" },
}
