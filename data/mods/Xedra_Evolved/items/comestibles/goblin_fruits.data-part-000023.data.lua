local ccb = require("ccb")

ccb.content.define_item {
    id = "goblin_fruit_soothing",
    name = ccb.content.plural_text("soothing goblin fruit", "soothing goblin fruits"),
    description = ccb.content.text("This sky blue fruit slows the thoughts racing in your mind a little as you stare at it, making you feel sightly more calm until you put it away."),
    copy_from = "goblin_fruit_abstract",
    color = "light_blue",
    mass = "202 g",
    volume = "184 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_soothing" },
}
