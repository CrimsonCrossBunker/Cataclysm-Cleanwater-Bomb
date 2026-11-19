local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_exodii_locator_antenna",
    name = ccb.content.text("locator antenna"),
    description = ccb.content.text("A tall metal pole solidly fixed to the roof.  It does not look activated but there's a small set of holes near its base, maybe something could be plugged in one to reboot the locator."),
    symbol = "Z",
    color = "light_gray",
    move_cost_mod = -1,
    coverage = 50,
    required_strength = -1,
    bash = {
        minimum_strength = 45,
        maximum_strength = 200,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("crash!"),
        drops = {
            { item = "scrap", count = { 1, 4 } },
            { item = "cable", count = { 1, 2 } },
            { item = "sheet_metal_small", count = { 0, 4 } },
            { item = "circuit", count = { 1, 3 } },
            { item = "amplifier", count = { 1, 3 } },
            { item = "power_supply", count = { 1, 4 } },
            { item = "exodii_module", count = { 0, 1 } },
        },
    },
    flags = { "NOITEM", "TRANSPARENT", "MOUNTABLE" },
    examine_handler = "examine_f_exodii_locator_antenna",
}
