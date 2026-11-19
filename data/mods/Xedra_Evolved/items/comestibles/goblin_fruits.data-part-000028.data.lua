local ccb = require("ccb")

ccb.content.define_item {
    id = "goblin_fruit_blind_flash",
    name = ccb.content.plural_text("dazzling goblin fruit", "dazzling goblin fruits"),
    description = ccb.content.text("This fruit shines a light bright enough to be painful to look at.  From the little you can see, it appears to be a purple ovoid fruit."),
    copy_from = "goblin_fruit_abstract",
    color = "magenta",
    mass = "279 g",
    volume = "294 ml",
    light = 650,
    flags = { "FREEZERBURN", "NO_AUTO_CONSUME" },
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_blind_flash" },
}
