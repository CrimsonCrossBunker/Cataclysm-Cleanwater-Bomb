local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_afs_starcrane_control_deco",
    name = ccb.content.text("THI-14 StarCrane instrument panel"),
    description = ccb.content.text("A large console, instrument panels and control surfaces.  You can fly the ship from here."),
    roof = "t_metal_flat_roof",
    looks_like = "t_intercom",
    move_cost = 0,
    coverage = 65,
    flags = { "NOITEM", "SUPPORTS_ROOF", "NO_SCENT", "TRANSPARENT", "SHORT" },
    symbol = "o",
    color = "white",
}
