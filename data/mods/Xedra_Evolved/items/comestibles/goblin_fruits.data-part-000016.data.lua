local ccb = require("ccb")

ccb.content.define_item {
    id = "goblin_fruit_feather_fall",
    name = ccb.content.plural_text("inconspicuous goblin fruit", "inconspicuous goblin fruits"),
    description = ccb.content.text("This goblin fruit looks like a pear and feels like a pear and smells exactly like a pear.  You have no idea how it tastes because the instant you put your tongue to it, your entire mouth goes numb."),
    copy_from = "goblin_fruit_abstract",
    color = "green_yellow",
    mass = "146 g",
    volume = "187 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_feather_fall" },
}
