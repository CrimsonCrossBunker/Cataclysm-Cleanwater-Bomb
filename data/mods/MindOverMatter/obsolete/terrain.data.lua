local ccb = require("ccb")

-- Remove after 0.J
ccb.content.define_terrain {
    id = "t_nether_crystal_structure",
    name = ccb.content.text("glowing crystal"),
    description = ccb.content.text("An irregular chunk of glowing crystal.  The fitful glow sheds no illumination on the nearby terrain."),
    symbol = "#",
    color = "black",
    move_cost = 0,
    looks_like = "f_boulder_large",
    flags = { "ALLOW_ON_OPEN_AIR", "PERMEABLE", "SHARP" },
    bash = {
        minimum_strength = 20,
        maximum_strength = 50,
        sound = ccb.content.text("crystal shattering!"),
        failure_sound = ccb.content.text("whack!"),
        volume = 16,
        failure_volume = 10,
        terrain = "t_grass_alien",
        drops = {
            { item = "matrix_shard", count = { 4, 20 } },
            { item = "matrix_crystal_biokin_dust", count = { 0, 3 } },
            { item = "matrix_crystal_clair_dust", count = { 0, 3 } },
            { item = "matrix_crystal_pyrokin_dust", count = { 0, 3 } },
            { item = "matrix_crystal_telekin_dust", count = { 0, 3 } },
            { item = "matrix_crystal_telepath_dust", count = { 0, 3 } },
            { item = "matrix_crystal_teleport_dust", count = { 0, 3 } },
            { item = "matrix_crystal_vitakin_dust", count = { 0, 3 } },
            { item = "matrix_crystal_drained_dust", count = { 3, 6 } },
        },
    },
}
