local ccb = require("ccb")

ccb.content.define_item {
    id = "goblin_fruit_warmth",
    name = ccb.content.plural_text("rinded goblin fruit", "rinded goblin fruits"),
    description = ccb.content.text("This round goblin fruit has a thick red rind with a leaf still attached to the stem.  The leaf seems to move occasionally even when there is no wind."),
    copy_from = "goblin_fruit_abstract",
    color = "red",
    mass = "136 g",
    volume = "174 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_warmth" },
}
