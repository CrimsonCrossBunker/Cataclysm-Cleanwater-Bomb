local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_bay_ramp_control",
    name = ccb.content.text("cargo bay ramp control"),
    description = ccb.content.text("A large console used to lower and raise the cargo bay ramp.  The ramp needs to be retracted before you can take off."),
    roof = "t_metal_flat_roof",
    looks_like = "t_intercom",
    move_cost = 0,
    coverage = 65,
    flags = { "NOITEM", "SUPPORTS_ROOF", "NO_SCENT", "TRANSPARENT", "SHORT" },
    symbol = "o",
    color = "white",
    examine_handler = "examine_t_bay_ramp_control",
}
