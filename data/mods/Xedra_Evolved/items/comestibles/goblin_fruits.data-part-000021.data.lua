local ccb = require("ccb")

ccb.content.define_item {
    id = "goblin_fruit_stealth",
    name = ccb.content.plural_text("unnoticeable goblin fruit", "unnoticeable goblin fruits"),
    description = ccb.content.text("This goblin fruit is hard to perceive.  You think it's black, you believe it's small and you're certain it's near you, but all its other details slip from your memory the instant you stop looking at this fruit."),
    copy_from = "goblin_fruit_abstract",
    color = "black",
    mass = "61 g",
    volume = "56 ml",
    comestible = { kind = "FOOD", fun = 0, on_consume = "consume_goblin_fruit_stealth" },
}
