local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_landing_stair_control",
    name = ccb.content.text("landing stair control"),
    description = ccb.content.text("A wall mounted control panel for the ship's landing stairs.  Traditionally, its poorly seen for the ship's captain to disembark using the cargo bay ramp instead of these stairs."),
    roof = "t_metal_flat_roof",
    looks_like = "t_intercom",
    flags = { "NOITEM", "SUPPORTS_ROOF", "NO_SCENT", "BLOCK_WIND" },
    symbol = "o",
    move_cost = 0,
    coverage = 65,
    color = "white",
    examine_handler = "examine_t_landing_stair_control",
}
