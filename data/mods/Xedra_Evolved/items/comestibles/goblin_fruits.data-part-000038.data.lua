local ccb = require("ccb")

ccb.content.define_item {
    id = "goblin_fruit_wild_travel_boost",
    name = ccb.content.plural_text("mud-covered goblin fruit", "mud-covered goblin fruits"),
    description = ccb.content.text("This fruit is always covered in fresh mud.  You try to wipe it away, but it always come back."),
    copy_from = "goblin_fruit_abstract",
    color = "brown",
    mass = "304 g",
    volume = "377 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_wild_travel_boost" },
}
