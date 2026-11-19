local ccb = require("ccb")

ccb.content.define_item {
    id = "goblin_fruit_purge_blood",
    name = ccb.content.plural_text("smoky goblin fruit", "smoky goblin fruits"),
    description = ccb.content.text("This sharply-curved goblin fruit is an off-white color turning red toward the ends.  It smells like the alley outside a club."),
    copy_from = "goblin_fruit_abstract",
    color = "light_red",
    mass = "182 g",
    volume = "232 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_purge_blood" },
}
