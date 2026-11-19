local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_nl_water_cooler",
    looks_like = "f_water_purifier",
    name = ccb.content.text("bulbous water dispenser"),
    description = ccb.content.text("This device almost looks like an earthly water cooler, but the base is made of scrap metal, and the tank is a bulbous, black glass globe that obfuscates its contents.  It has no tap; instead, the base has a small compartment with a plastic flap, resembling that of a vending machine.  Examine it to dispense drinks, if it has any."),
    symbol = "W",
    background_color = "blue",
    move_cost_mod = 0,
    coverage = 50,
    required_strength = 0,
    bash = {
        minimum_strength = 15,
        maximum_strength = 50,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        destroyed_field = { "fd_dirty_water", 4 },
    },
    examine_handler = "examine_f_nl_water_cooler",
}
