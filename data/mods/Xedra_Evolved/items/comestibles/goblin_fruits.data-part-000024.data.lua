local ccb = require("ccb")

ccb.content.define_item {
    id = "goblin_fruit_combat_skill_boost",
    name = ccb.content.plural_text("mirror goblin fruit", "mirror goblin fruits"),
    description = ccb.content.text("You can see your reflection in the mirror-like surface of this fruit.  This reflection of you seems angrier, closer to a feral human than to your own image."),
    copy_from = "goblin_fruit_abstract",
    color = "white",
    mass = "331 g",
    volume = "351 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_combat_skill_boost" },
}
