local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_afs_ship_retracted_bay_ramp",
    name = ccb.content.text("retracted bay ramp"),
    description = ccb.content.text("The closed cargo bay ramp of the ship.  It needs to be lowered before you can disembark."),
    roof = "t_metal_flat_roof",
    looks_like = "t_bridge",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "NO_SCENT", "BLOCK_WIND" },
    symbol = "#",
    color = "white",
    bash = {
        minimum_strength = 350,
        maximum_strength = 800,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_null",
        drops = {
            { item = "afs_material_2", count = { 2, 4 } },
            { item = "afs_material_1", count = { 2, 12 } },
            { item = "scrap", count = { 6, 24 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_afs_ship_retracted_bay_ramp_air",
    copy_from = "t_afs_ship_retracted_bay_ramp",
}
