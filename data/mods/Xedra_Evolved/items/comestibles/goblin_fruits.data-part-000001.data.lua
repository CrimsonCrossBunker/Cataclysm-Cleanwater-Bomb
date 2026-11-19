local ccb = require("ccb")

ccb.content.define_item {
    id = "goblin_fruit_water",
    name = ccb.content.text("cubic goblin fruit"),
    description = ccb.content.text("This pale blue goblin fruit is a cube, and the edges are fine enough to leave a line in your thumb when you press on them.  It smells incredibly sour."),
    copy_from = "goblin_fruit_abstract",
    color = "light_blue",
    mass = "182 g",
    volume = "232 ml",
    comestible = { kind = "FOOD", quench = 200, fun = -2 },
}
