local ccb = require("ccb")

ccb.content.define_item {
    id = "goblin_fruit_altitude_speed",
    name = ccb.content.plural_text("rushing goblin fruit", "rushing goblin fruits"),
    description = ccb.content.text("This pale fruit is surrounded by small lines of wind revolving around it.  The lines grow thicker the further the fruit is from the ground."),
    copy_from = "goblin_fruit_abstract",
    color = "white",
    mass = "188 g",
    volume = "191 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_altitude_speed" },
}
