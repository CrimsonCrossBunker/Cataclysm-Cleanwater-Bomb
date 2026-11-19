local ccb = require("ccb")

ccb.content.define_item {
    id = "goblin_fruit_no_drunk",
    name = ccb.content.plural_text("sanguine goblin fruit", "sanguine goblin fruits"),
    description = ccb.content.text("A dark red goblin fruit with a heavy iron smell.  It feels warm to the touch."),
    copy_from = "goblin_fruit_abstract",
    color = "dark_gray_red",
    mass = "146 g",
    volume = "186 ml",
    comestible = { kind = "FOOD", fun = -3, on_consume = "consume_goblin_fruit_no_drunk" },
}
