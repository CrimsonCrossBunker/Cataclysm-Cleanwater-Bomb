local ccb = require("ccb")

ccb.content.define_item {
    id = "black_nether_crystal_pseudo_tool",
    name = ccb.content.plural_text("nether crystal outcropping", "nether crystal outcroppings"),
    description = ccb.content.text("This is the pseudo-tool provided by having a nearby cluster of black nether crystal.  You shouldn't see this as an individual item."),
    symbol = "O",
    color = "red",
    mass = "0 g",
    volume = "0 ml",
    flags = { "ZERO_WEIGHT" },
    tool = {},
}

ccb.content.define_item {
    id = "psi_noetic_resonance_detector_tool",
    copy_from = "fake_appliance_tool",
    name = ccb.content.plural_text("active noetic resonance detector", "active noetic resonance detectors"),
    description = ccb.content.text("This is the pseudo-tool provided by having a nearby active noetic resonance detector.  You shouldn't see this as an individual item."),
    symbol = "O",
    color = "red",
    mass = "0 g",
    volume = "0 ml",
    flags = { "ZERO_WEIGHT" },
    tool = {},
}
