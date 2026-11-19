local ccb = require("ccb")

ccb.content.define_item {
    id = "goblin_fruit_call_rain",
    name = ccb.content.plural_text("weeping goblin fruit", "weeping goblin fruits"),
    description = ccb.content.text("This blue tear-shaped fruit drips with water.  You try to collect it, but it fades away before touching the container."),
    copy_from = "goblin_fruit_abstract",
    color = "blue",
    mass = "259 g",
    volume = "276 ml",
    comestible = { kind = "FOOD", on_consume = "eat_weeping_goblin_fruit" },
}

ccb.content.define_item {
    id = "goblin_fruit_animal_ignore",
    name = ccb.content.plural_text("furry goblin fruit", "furry goblin fruits"),
    description = ccb.content.text("This fruit what a kiwi would be if kiwi had decimeter-long beige fur.  It smells of steel and lilies."),
    copy_from = "goblin_fruit_abstract",
    color = "brown",
    mass = "314 g",
    volume = "386 ml",
    comestible = { kind = "FOOD", fun = -3, on_consume = "eat_furry_goblin_fruit" },
}

ccb.content.define_item {
    id = "goblin_fruit_mend_bone",
    name = ccb.content.plural_text("remolding goblin fruit", "remolding goblin fruits"),
    description = ccb.content.text("This gray fruit is hard to pierce, as it reshapes itself to close any hole you make in it.  Ironically, the fruit keeps tearing its surface apart, making its reshaping a sisyphean task."),
    copy_from = "goblin_fruit_abstract",
    color = "light_gray",
    mass = "330 g",
    volume = "330 ml",
    comestible = { kind = "FOOD", on_consume = "eat_remolding_goblin_fruit" },
}

ccb.content.define_item {
    id = "goblin_fruit_cure_dreamless",
    name = ccb.content.plural_text("cloudy goblin fruit", "cloudy goblin fruits"),
    description = ccb.content.text("This fruit looks like a crystal ball filled with clouds.  When you look into it, you see fragments of your most intense dreams."),
    copy_from = "goblin_fruit_abstract",
    color = "light_blue",
    mass = "220 g",
    volume = "220 ml",
    comestible = { kind = "FOOD", on_consume = "eat_cloudy_goblin_fruit" },
}
