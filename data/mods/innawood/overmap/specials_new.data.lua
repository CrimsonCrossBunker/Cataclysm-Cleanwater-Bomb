local ccb = require("ccb")

ccb.content.define_fixed_overmap_special {
    id = "innawood_ore_vein_shallow_z2",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "innawood_ore_vein_surface_indicator_north" },
        { point = { 0, 0, -1 }, terrain = "innawood_ore_vein_subsurface_north" },
        { point = { -1, 0, -2 }, terrain = "innawood_ore_vein_surface_z2_left_side_north" },
        { point = { 0, 0, -2 }, terrain = "innawood_ore_vein_surface_z2_center_north" },
        { point = { 1, 0, -2 }, terrain = "innawood_ore_vein_surface_z2_right_side_north" },
    },
    locations = { "wilderness" },
    occurrences = { 0, 5 },
}

ccb.content.define_fixed_overmap_special {
    id = "innawood_ore_vein_shallow_z3",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "innawood_ore_vein_surface_indicator_north" },
        { point = { 0, 0, -1 }, terrain = "innawood_ore_vein_subsurface_north" },
        { point = { 0, 0, -2 }, terrain = "special_rock" },
        { point = { -1, 0, -3 }, terrain = "innawood_ore_vein_surface_z3_left_side_north" },
        { point = { 0, 0, -3 }, terrain = "innawood_ore_vein_surface_z3_center_north" },
        { point = { 1, 0, -3 }, terrain = "innawood_ore_vein_surface_z3_right_side_north" },
    },
    locations = { "wilderness" },
    occurrences = { 3, 10 },
}

ccb.content.define_fixed_overmap_special {
    id = "innawood_ore_vein_shallow_larger",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "innawood_ore_vein_surface_indicator_north" },
        { point = { 0, 0, -1 }, terrain = "innawood_ore_vein_subsurface_north" },
        { point = { -1, 0, -2 }, terrain = "innawood_ore_vein_surface_z2_left_side_north" },
        { point = { 0, 0, -2 }, terrain = "innawood_ore_vein_surface_z2_center_north" },
        { point = { 1, 0, -2 }, terrain = "innawood_ore_vein_surface_z2_right_side_north" },
        { point = { -1, 0, -3 }, terrain = "innawood_ore_vein_surface_z3_left_side_north" },
        { point = { 0, 0, -3 }, terrain = "innawood_ore_vein_surface_z3_center_north" },
        { point = { 1, 0, -3 }, terrain = "innawood_ore_vein_surface_z3_right_side_north" },
        { point = { -1, 0, -4 }, terrain = "innawood_ore_vein_surface_z2_left_side_north" },
        { point = { 0, 0, -4 }, terrain = "innawood_ore_vein_surface_z2_center_north" },
        { point = { 1, 0, -4 }, terrain = "innawood_ore_vein_surface_z2_right_side_north" },
    },
    locations = { "wilderness" },
    occurrences = { 50, 100 },
    flags = { "OVERMAP_UNIQUE" },
}
