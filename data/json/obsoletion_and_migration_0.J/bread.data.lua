local ccb = require("ccb")

ccb.content.define_item {
    id = "sourdough_young_uncovered",
    category = "food",
    name = ccb.content.plural_text("juvenile sourdough starter (obsolete)", "juvenile sourdough starter (obsolete)"),
    description = ccb.content.text("A floury paste that is slowly going bad.  Someday it will be sourdough."),
    mass = "100 g",
    volume = "100 ml",
    price = "10 cent",
    survival_price = "10 cent",
    materials = { "wheat" },
    symbol = "%",
    color = "white",
    flags = { "SOFT" },
    comestible = {
        kind = "FOOD",
        fun = -5,
        calories = 192,
        vitamins = { { id = "wheat_allergen", amount = 1 } },
    },
    use_actions = {
        {
            kind = "delayed_transform",
            target = "sourdough_starter_uncovered",
            message = ccb.content.text("After feeding it and caring for it for a week, your sourdough starter is finally ready for the big leagues."),
            moves = 50,
            age = 518400,
            not_ready_message = ccb.content.text("You've been caring for your starter for a while, but it's going to need longer before you can do anything tasty with it."),
        },
    },
}

ccb.content.define_item {
    id = "sourdough_split_uncovered",
    category = "food",
    name = ccb.content.plural_text("freshly fed sourdough starter (obsolete)", "freshly fed sourdough starter (obsolete)"),
    description = ccb.content.text("A floury paste with sourdough starter mixed in.  It needs a day to recover its strength before it can be used again."),
    mass = "100 g",
    volume = "100 ml",
    price = "10 cent",
    survival_price = "10 cent",
    materials = { "wheat" },
    symbol = "%",
    color = "white",
    flags = { "SOFT" },
    comestible = {
        kind = "FOOD",
        fun = -5,
        calories = 192,
        vitamins = { { id = "wheat_allergen", amount = 1 } },
    },
    use_actions = {
        {
            kind = "delayed_transform",
            target = "sourdough_starter_uncovered",
            message = ccb.content.text("The starter is now stinky and bubbly, and looks ready for cooking."),
            moves = 50,
            age = 86400,
            not_ready_message = ccb.content.text("The starter isn't quite ready to go."),
        },
    },
}
