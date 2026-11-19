local ccb = require("ccb")

ccb.content.define_item {
    id = "goblin_fruit_mood_clear",
    name = ccb.content.plural_text("boring goblin fruit", "boring goblin fruits"),
    description = ccb.content.text("This fruit is the most boring thing you've ever seen.  Everything about it is boring: its drab dark brown color, its smell, its lack of feature, even its taste is boring.  It's not a good fruit.  It's not a bad fruit.  It's just boring."),
    copy_from = "goblin_fruit_abstract",
    color = "brown",
    mass = "255 g",
    volume = "262 ml",
    comestible = { kind = "FOOD", fun = 0, on_consume = "eat_boring_goblin_fruit" },
}

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
