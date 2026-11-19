local ccb = require("ccb")

ccb.content.define_item {
    id = "goblin_fruit_pain",
    name = ccb.content.plural_text("savory goblin fruit", "savory goblin fruits"),
    description = ccb.content.text("This round goblin fruit is a bluish color changing to red at the ends.  It smells like a freshly-roasted hunk of meat."),
    copy_from = "goblin_fruit_abstract",
    color = "blue",
    mass = "227 g",
    volume = "290 ml",
    comestible = { kind = "FOOD", fun = 2, on_consume = "consume_goblin_fruit_pain" },
}
