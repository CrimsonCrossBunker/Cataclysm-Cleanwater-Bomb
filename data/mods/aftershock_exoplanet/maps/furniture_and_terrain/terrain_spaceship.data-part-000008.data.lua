local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_afs_gun_ship_engine_console_burnt",
    name = ccb.content.text("Iblis Interplanetary Drive Console"),
    looks_like = "t_console",
    description = ccb.content.text("The engine has been overloaded and burnt out."),
    symbol = "0",
    color = "green_red",
    move_cost = 0,
    coverage = 80,
    flags = { "NOITEM", "SEALED", "REDUCE_SCENT", "PERMEABLE" },
    bash = {
        minimum_strength = 70,
        maximum_strength = 400,
        sound = ccb.content.text("metal screeching!"),
        terrain = "t_metal_floor",
        failure_sound = ccb.content.text("clang!"),
        drops = {
            { item = "afs_circuitry_1", count = { 1, 7 } },
            { item = "afs_circuitry_2", count = { 0, 2 } },
            { item = "afs_heat_2_salvage", count = { 0, 1 } },
            { item = "afs_material_1", count = { 8, 12 } },
        },
    },
    examine_handler = "examine_t_afs_gun_ship_engine_console_burnt",
}
