local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_your_ship_panel",
    looks_like = "f_security_panel",
    name = ccb.content.text("control panel"),
    symbol = "e",
    description = ccb.content.text("A slim wall mounted metal panel with several buttons, sliders, and displays.  Can be used to control secondary systems of the ship."),
    color = "blue",
    move_cost_mod = 1,
    required_strength = -1,
    flags = { "TRANSPARENT" },
    examine_handler = "examine_f_your_ship_panel",
}
