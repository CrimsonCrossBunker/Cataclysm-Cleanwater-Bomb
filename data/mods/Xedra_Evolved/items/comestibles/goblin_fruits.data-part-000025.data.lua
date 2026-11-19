local ccb = require("ccb")

ccb.content.define_item {
    id = "goblin_fruit_craft_skill_boost",
    name = ccb.content.plural_text("camouflaged goblin fruit", "camouflaged goblin fruits"),
    description = ccb.content.text("The many colors of this oblong fruit shift to mimic what's behind it, trying to imitate other things with the best of its ability."),
    copy_from = "goblin_fruit_abstract",
    color = "red",
    mass = "244 g",
    volume = "262 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_craft_skill_boost" },
}
