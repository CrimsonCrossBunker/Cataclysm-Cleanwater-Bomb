local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_afs_escapepod_g_shipboard",
    name = ccb.content.text("escape pod guidance system"),
    description = ccb.content.text("The rudimentary descent guidance system and easy-use control console of an escape pod.  Can be activated to launch the pod."),
    roof = "t_metal_flat_roof",
    looks_like = "t_intercom",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "NO_SCENT", "BLOCK_WIND" },
    symbol = "o",
    color = "white",
    copy_from = "t_afs_space_ship_hull_wall",
    examine_handler = "examine_escape_pod_guidance",
}
