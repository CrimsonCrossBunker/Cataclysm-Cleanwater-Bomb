local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_cell_entrance_console",
    name = ccb.content.text("Prisoner Cell Console"),
    looks_like = "t_console",
    description = ccb.content.text("The control panel for the prisoner cell.  Might be able to open and close cell grating."),
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
            { item = "afs_circuitry_1", count = { 4, 16 } },
            { item = "afs_circuitry_2", count = { 1, 6 } },
            { item = "afs_circuitry_3", count = { 0, 1 } },
            { item = "afs_heat_1", count = { 0, 1 } },
            { item = "afs_energy_storage_1", count = { 1, 6 } },
            { item = "afs_material_1", count = { 12, 18 } },
        },
    },
    examine_handler = "examine_t_cell_entrance_console",
}
