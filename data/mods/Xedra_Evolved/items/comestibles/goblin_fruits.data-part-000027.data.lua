local ccb = require("ccb")

-- When possible, this fruit should take longer to eat, as it literally opposes your attempts to eat it.
ccb.content.define_item {
    id = "goblin_fruit_dodge_instant",
    name = ccb.content.plural_text("evasive goblin fruit", "evasive goblin fruits"),
    description = ccb.content.text("This yellow half-liquid fruit is hard to hold, as it actively tries to escape your grasp.  You hope it won't try to escape your innards after you eat it."),
    copy_from = "goblin_fruit_abstract",
    color = "yellow_cyan",
    mass = "169 g",
    volume = "174 ml",
    comestible = { kind = "FOOD", fun = -1, on_consume = "consume_goblin_fruit_dodge_instant" },
}
