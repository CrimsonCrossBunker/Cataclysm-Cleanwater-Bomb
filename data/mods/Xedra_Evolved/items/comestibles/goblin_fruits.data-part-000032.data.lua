local ccb = require("ccb")

-- The idea is that this fruit needs to feed on happiness to create other goblin fruits and it can't do that unless you eat it, with predictable results on your own happiness.
ccb.content.define_item {
    id = "goblin_fruit_spawn_more_fruits",
    name = ccb.content.plural_text("pupating goblin fruit", "pupating goblin fruits"),
    description = ccb.content.text("This dark red half-liquid fruit fills you with dread and sadness as it endlessly tries to split but fails to do so.  You sense that it wants you to eat it, but you're not sure if it would be worth it."),
    copy_from = "goblin_fruit_abstract",
    color = "dark_gray_red",
    mass = "331 g",
    volume = "350 ml",
    comestible = {
        kind = "FOOD",
        fun = -30,
        vitamins = {
            { id = "vitC", amount = 10 },
            { id = "calcium", amount = 10 },
            { id = "iron", amount = 10 },
            { id = "fruit_allergen", amount = 1 },
            { id = "bad_food", amount = 25 },
        },
        on_consume = "eat_goblin_fruit_cluster",
    },
}

ccb.content.define_item {
    id = "goblin_fruit_fun",
    name = ccb.content.text("patchwork goblin fruit"),
    description = ccb.content.text("This fruit is closer to an art project than to a fruit.  Numerous stitches hold together red-tinted parts of many different fruits so tightly it acts as a single, consistent whole."),
    copy_from = "goblin_fruit_abstract",
    color = "light_red",
    mass = "379 g",
    volume = "345 ml",
    comestible = { kind = "FOOD", fun = 30 },
}

ccb.content.define_item {
    id = "goblin_fruit_no_spoil",
    name = ccb.content.text("pristine goblin fruit"),
    description = ccb.content.text("This fruit has a perfectly unblemished surface that cannot be tarnished or dirtied, no matter what happens to it."),
    copy_from = "goblin_fruit_abstract",
    color = "yellow_cyan",
    mass = "222 g",
    volume = "202 ml",
    comestible = { kind = "FOOD", shelf_life = 0 },
}
