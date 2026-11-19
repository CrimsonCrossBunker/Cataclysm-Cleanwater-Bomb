local ccb = require("ccb")

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
