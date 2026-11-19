local ccb = require("ccb")

ccb.content.define_item {
    id = "goblin_fruit_map",
    name = ccb.content.plural_text("rotating goblin fruit", "rotating goblin fruits"),
    description = ccb.content.text("This spiraled fruit ceaselessly spins on itself.  No matter how tight your grasp, you cannot stop its spinning."),
    copy_from = "goblin_fruit_abstract",
    color = "blue",
    mass = "224 g",
    volume = "244 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_map" },
}
