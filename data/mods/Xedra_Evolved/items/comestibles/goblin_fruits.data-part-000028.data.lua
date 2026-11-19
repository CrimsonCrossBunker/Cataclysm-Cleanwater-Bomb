local ccb = require("ccb")

ccb.content.define_item {
    id = "goblin_fruit_blood_gain",
    name = ccb.content.plural_text("vein-filled goblin fruit", "vein-filled goblin fruits"),
    description = ccb.content.text("This translucent fruit is filled with a network of tubes not unlike veins and arteries.  Judging by the way its brown surface turns blue when bruised, it probably contains a fluid similar to blood."),
    copy_from = "goblin_fruit_abstract",
    color = "brown",
    mass = "279 g",
    volume = "294 ml",
    comestible = { kind = "FOOD", on_consume = "eat_blood_goblin_fruit" },
}

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
