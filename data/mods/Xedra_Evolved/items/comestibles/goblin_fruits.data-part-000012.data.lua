local ccb = require("ccb")

-- Dolm is a fictional color from the 1920 book "A Voyage to Arcturus" that's a mix of infrared and blue.
ccb.content.define_item {
    id = "goblin_fruit_no_bleed",
    name = ccb.content.plural_text("dolm goblin fruit", "dolm goblin fruits"),
    description = ccb.content.text("This teardrop-shaped goblin fruit hurts to look at.  Sometimes it's a dark blue, sometimes it's a feverish red, and sometimes it's a mix of the two that you would previously have sworn could not exist.  It smells faintly peppery with a hint of lemon."),
    copy_from = "goblin_fruit_abstract",
    color = "blue_red",
    mass = "191 g",
    volume = "244 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_no_bleed" },
}
