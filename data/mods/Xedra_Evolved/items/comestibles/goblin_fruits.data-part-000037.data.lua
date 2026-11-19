local ccb = require("ccb")

ccb.content.define_item {
    id = "goblin_fruit_carry_boost",
    name = ccb.content.plural_text("balloon goblin fruit", "balloon goblin fruits"),
    description = ccb.content.text("This fruit is nothing more than a thin layer of fruit filled with air.  It has a heady aroma that makes you a little lightheaded."),
    copy_from = "goblin_fruit_abstract",
    color = "yellow",
    mass = "25 g",
    volume = "257 ml",
    materials = { "fruit_light" },
    comestible = { kind = "FOOD", calories = 5, on_consume = "consume_goblin_fruit_carry_boost" },
}
