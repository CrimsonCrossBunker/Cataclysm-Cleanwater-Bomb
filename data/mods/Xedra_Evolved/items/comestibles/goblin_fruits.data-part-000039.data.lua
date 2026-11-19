local ccb = require("ccb")

ccb.content.define_item {
    id = "goblin_fruit_slowing_armor",
    name = ccb.content.plural_text("cavernous goblin fruit", "cavernous goblin fruits"),
    description = ccb.content.text("This fruit has the shape of a hollow cylinder.  It has a notable smell of freshly-upturned earth."),
    copy_from = "goblin_fruit_abstract",
    color = "brown",
    mass = "304 g",
    volume = "377 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_slowing_armor" },
}
