local ccb = require("ccb")

ccb.content.define_item {
    id = "goblin_fruit_craft_speed_boost",
    name = ccb.content.plural_text("shy goblin fruit", "shy goblin fruits"),
    description = ccb.content.text("This fruit shaped akin to a chunk torn from a beehive is warm, but becomes cold as long as anyone is looking at it.  It has a strong odor, between maple and oak, but only when unobserved."),
    copy_from = "goblin_fruit_abstract",
    color = "green",
    mass = "302 g",
    volume = "375 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_craft_speed_boost" },
}
