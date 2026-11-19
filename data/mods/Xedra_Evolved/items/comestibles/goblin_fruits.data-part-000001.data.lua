local ccb = require("ccb")

ccb.content.define_item {
    id = "goblin_fruit_gacha",
    name = ccb.content.plural_text("mysterious fruit", "mysterious fruits"),
    description = ccb.content.text("Some sort of fruit sealed in a thick shell.  The shell is rigid but seems surprisingly brittle; you could easily peel it open to see what's inside with your bare hands."),
    mass = "364 g",
    volume = "464 ml",
    color = "magenta",
    symbol = "%",
    price = "40 cent",
    survival_price = "1 USD",
    materials = { "fruit" },
    flags = { "NO_AUTO_CONSUME", "SINGLE_USE" },
    comestible = {
        shelf_life = "60 days",
        kind = "FOOD",
        vitamins = { { id = "fruit_allergen", amount = 1 } },
        on_consume = "eat_mysterious_goblin_fruit",
    },
}

ccb.content.define_item {
    id = "goblin_fruit_healing",
    name = ccb.content.plural_text("sweet goblin fruit", "sweet goblin fruits"),
    description = ccb.content.text("This round goblin fruit is reddish-orange with a waxy texture.  It smells sweet with a hint of petrichor."),
    copy_from = "goblin_fruit_abstract",
    color = "red_yellow",
    mass = "210 g",
    volume = "273 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_healing" },
}
