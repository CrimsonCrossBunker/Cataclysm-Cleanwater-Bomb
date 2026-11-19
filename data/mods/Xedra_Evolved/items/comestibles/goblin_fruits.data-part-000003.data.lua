local ccb = require("ccb")

ccb.content.define_item {
    id = "goblin_fruit_attack_speed",
    name = ccb.content.plural_text("silvery goblin fruit", "silvery goblin fruits"),
    description = ccb.content.text("This round goblin fruit looks like a metal sculpture but has the yielding texture of a peach.  It smells like the tang in the air before a storm."),
    copy_from = "goblin_fruit_abstract",
    color = "light_gray",
    mass = "218 g",
    volume = "278 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_attack_speed" },
}
