local ccb = require("ccb")

ccb.content.define_fixed_overmap_special {
    id = "druid_tower_innawood",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "druid_giant_tree_empty_z0_north" },
        { point = { 0, 0, 1 }, terrain = "druid_giant_tree_empty_z1_north" },
        { point = { 0, 0, 2 }, terrain = "druid_giant_tree_empty_z2_north" },
        { point = { 0, 0, 3 }, terrain = "druid_giant_tree_empty_z3_north" },
        { point = { -1, -1, 4 }, terrain = "druid_giant_tree_empty_crown_nw_north" },
        { point = { 0, -1, 4 }, terrain = "druid_giant_tree_empty_crown_n_north" },
        { point = { 1, -1, 4 }, terrain = "druid_giant_tree_empty_crown_ne_north" },
        { point = { -1, 0, 4 }, terrain = "druid_giant_tree_empty_crown_w_north" },
        { point = { 0, 0, 4 }, terrain = "druid_giant_tree_empty_crown_north" },
        { point = { 1, 0, 4 }, terrain = "druid_giant_tree_empty_crown_e_north" },
        { point = { -1, 1, 4 }, terrain = "druid_giant_tree_empty_crown_sw_north" },
        { point = { 0, 1, 4 }, terrain = "druid_giant_tree_empty_crown_s_north" },
        { point = { 1, 1, 4 }, terrain = "druid_giant_tree_empty_crown_se_north" },
    },
    locations = { "forest_center" },
    spawns = { group = "GROUP_FOREST_SPIRIT", population = { 2, 20 }, radius = { 1, 6 } },
    occurrences = { 1, 5 },
    flags = { "WILDERNESS" },
}
