local ccb = require("ccb")

ccb.content.define_item {
    id = "goblin_fruit_focus_boost",
    name = ccb.content.plural_text("understandable goblin fruit", "understandable goblin fruits"),
    description = ccb.content.text("You understand everything about this pale green fruit.  You know that it will taste like an apple and you know that it will have the inner structure of a kiwi, the texture of a durian, the smell of a dragon fruit and the colors of an orange.  you also know that eating it will help you understand anything you could try to learn for a few hours."),
    copy_from = "goblin_fruit_abstract",
    color = "green_white",
    mass = "215 g",
    volume = "231 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_focus_boost" },
}
