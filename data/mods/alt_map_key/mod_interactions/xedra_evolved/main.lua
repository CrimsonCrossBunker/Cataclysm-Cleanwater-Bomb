local ccb = require("ccb")
local content = ccb.content

content.patch_overmap_terrain {
    ids = {
        "field_office_1", "field_office_2", "field_office_3", "field_office_4", "field_office_5",
        "field_office_6", "field_office_7", "field_office_8", "field_office_9", "field_office_10",
        "field_office_11", "field_office_12", "field_office_13", "field_office_14", "field_office_15",
        "field_office_16", "field_office_ex_1", "field_office_ex_2", "field_office_ex_3",
        "field_office_ex_4", "field_office_ex_5", "field_office_ex_6", "field_office_ex_7",
        "field_office_ex_8", "field_office_ex_9", "field_office_ex_10", "field_office_ex_11",
        "field_office_ex_12", "field_office_ex_13", "field_office_ex_14", "field_office_ex_15",
        "field_office_ex_16", "field_office_17", "field_office_18", "field_office_19", "field_office_20",
    },
    copy_from = "field_office_1",
    symbol = "B",
    color = "light_gray",
}

content.patch_overmap_terrain {
    ids = { "boann_sidhe_island" },
    copy_from = "boann_sidhe_island",
    symbol = "#",
    color = "cyan",
}

content.patch_overmap_terrain {
    ids = { "safe_house_basement" },
    copy_from = "safe_house_basement",
    symbol = "B",
    color = "light_green",
}

content.patch_overmap_terrain {
    ids = {
        "cathedralv_1_NW", "cathedralv_1_NE", "cathedralv_1_SW", "cathedralv_1_SE", "cathedralv_2_NW",
        "cathedralv_2_NE", "cathedralv_2_SW", "cathedralv_2_SE", "cathedralv_3_NW", "cathedralv_3_NE",
        "cathedralv_3_SW", "cathedralv_3_SE",
    },
    copy_from = "cathedralv_1_NW",
    symbol = "C",
    color = "white",
}

content.patch_overmap_terrain {
    ids = {
        "cathedralv_4_NW", "cathedralv_4_NE", "cathedralv_5_NW", "cathedralv_5_NE", "cathedralv_6_NW",
        "cathedralv_6_NE", "cathedralv_7_NW", "cathedralv_7_NE",
    },
    copy_from = "cathedralv_4_NW",
    symbol = "C",
    color = "white",
}

content.patch_overmap_terrain {
    ids = { "cathedralv_b_NW", "cathedralv_b_NE", "cathedralv_b_SW", "cathedralv_b_SE" },
    copy_from = "cathedralv_b_NW",
    symbol = "C",
    color = "white",
}

content.patch_overmap_terrain {
    ids = {
        "ierde_genius_loci_NW", "ierde_genius_loci_NE", "ierde_genius_loci_SW", "ierde_genius_loci_SE",
        "undine_genius_loci_NW", "undine_genius_loci_NE", "undine_genius_loci_SW", "undine_genius_loci_SE",
        "sylph_genius_loci_NW", "sylph_genius_loci_NE", "sylph_genius_loci_SW", "sylph_genius_loci_SE",
        "arvore_genius_loci_NW", "arvore_genius_loci_NE", "arvore_genius_loci_SW", "arvore_genius_loci_SE",
        "salamander_genius_loci_NW", "salamander_genius_loci_NE", "salamander_genius_loci_SW",
        "salamander_genius_loci_SE", "homullus_genius_loci_NW", "homullus_genius_loci_NE",
        "homullus_genius_loci_SW", "homullus_genius_loci_SE", "genius_loci_NW_roof", "genius_loci_NE_roof",
        "genius_loci_SW_roof", "genius_loci_SE_roof",
    },
    copy_from = "ierde_genius_loci_NW",
    symbol = "A",
    color = "cyan",
}

content.patch_overmap_terrain {
    ids = { "xedra_monochrome_meadow" },
    copy_from = "xedra_monochrome_meadow",
    symbol = "*",
    color = "cyan",
}

content.patch_overmap_terrain {
    ids = { "salamander_eruption_ground" },
    copy_from = "salamander_eruption_ground",
    symbol = "S",
    color = "cyan",
}

content.patch_overmap_terrain {
    ids = { "salamander_eruption_roof" },
    copy_from = "salamander_eruption_roof",
    symbol = "S",
    color = "cyan",
}

content.patch_overmap_terrain {
    ids = { "salamander_eruption_entrance" },
    copy_from = "salamander_eruption_entrance",
    symbol = "S",
    color = "red",
}

content.patch_overmap_terrain {
    ids = { "salamander_tunnel" },
    copy_from = "salamander_tunnel",
    color = "red",
}

content.patch_overmap_terrain {
    ids = { "salamander_finale" },
    copy_from = "salamander_finale",
    symbol = "S",
    color = "red",
}

content.patch_overmap_terrain {
    ids = { "lodgev_ground1", "lodgev_ground2" },
    copy_from = "lodgev_ground1",
    symbol = "L",
    color = "brown",
}

content.patch_overmap_terrain {
    ids = { "lodgev_2ndfloor1", "lodgev_2ndfloor2" },
    copy_from = "lodgev_2ndfloor1",
    symbol = "L",
    color = "brown",
}

content.patch_overmap_terrain {
    ids = { "lodgev_roof1", "lodgev_roof2" },
    copy_from = "lodgev_roof1",
    symbol = "L",
    color = "brown",
}

content.patch_overmap_terrain {
    ids = { "lodgev_basement_residential1", "lodgev_basement_residential2" },
    copy_from = "lodgev_basement_residential1",
    symbol = "B",
    color = "brown",
}

content.patch_overmap_terrain {
    ids = {
        "great_tree_z0_nw", "great_tree_z0_ne", "great_tree_z0_sw", "great_tree_z0_se", "great_tree_z1_nw",
        "great_tree_z1_ne", "great_tree_z1_sw", "great_tree_z1_se", "great_tree_z2_nw", "great_tree_z2_ne",
        "great_tree_z2_sw", "great_tree_z2_se", "great_tree_z3_01", "great_tree_z3_02", "great_tree_z3_03",
        "great_tree_z3_04", "great_tree_z3_05", "great_tree_z3_06", "great_tree_z3_07", "great_tree_z3_08",
        "great_tree_z3_09", "great_tree_z3_10", "great_tree_z3_11", "great_tree_z3_12", "great_tree_z3_13",
        "great_tree_z3_14", "great_tree_z3_15", "great_tree_z3_16", "great_tree_z4_01", "great_tree_z4_02",
        "great_tree_z4_03", "great_tree_z4_04", "great_tree_z4_05", "great_tree_z4_06", "great_tree_z4_07",
        "great_tree_z4_08", "great_tree_z4_09", "great_tree_z4_10", "great_tree_z4_11", "great_tree_z4_12",
        "great_tree_z4_13", "great_tree_z4_14", "great_tree_z4_15", "great_tree_z4_16", "great_tree_z5_01",
        "great_tree_z5_02", "great_tree_z5_03", "great_tree_z5_04", "great_tree_z5_05", "great_tree_z5_06",
        "great_tree_z5_07", "great_tree_z5_08", "great_tree_z5_09", "great_tree_z5_10", "great_tree_z5_11",
        "great_tree_z5_12", "great_tree_z5_13", "great_tree_z5_14", "great_tree_z5_15", "great_tree_z5_16",
        "great_tree_z6_nw", "great_tree_z6_ne", "great_tree_z6_sw", "great_tree_z6_se", "great_tree_z7_nw",
        "great_tree_z7_ne", "great_tree_z7_sw", "great_tree_z7_se",
    },
    copy_from = "great_tree_z0_nw",
    symbol = "#",
    color = "brown",
}

content.patch_overmap_terrain {
    ids = {
        "great_tree_roots_nw", "great_tree_roots_n", "great_tree_roots_ne", "great_tree_roots_w",
        "great_tree_roots", "great_tree_roots_e", "great_tree_roots_sw", "great_tree_roots_s",
        "great_tree_roots_se",
    },
    copy_from = "great_tree_roots_nw",
    symbol = "*",
    color = "brown",
}

content.patch_overmap_terrain {
    ids = {
        "great_tree_crown_01", "great_tree_crown_02", "great_tree_crown_03", "great_tree_crown_04",
        "great_tree_crown_05", "great_tree_crown_06", "great_tree_crown_07", "great_tree_crown_08",
        "great_tree_crown_09", "great_tree_crown_10", "great_tree_crown_11", "great_tree_crown_12",
        "great_tree_crown_13", "great_tree_crown_14", "great_tree_crown_15", "great_tree_crown_16",
        "great_tree_crown_top_01", "great_tree_crown_top_02", "great_tree_crown_top_03",
        "great_tree_crown_top_04",
    },
    copy_from = "great_tree_crown_01",
    symbol = "#",
    color = "green",
}

content.patch_overmap_terrain {
    ids = { "cabin_sevenoclock", "cabin_roof_sevenoclock" },
    copy_from = "cabin_sevenoclock",
    symbol = "O",
    color = "brown",
}

content.patch_overmap_terrain {
    ids = { "undine_warp_pool_surface" },
    copy_from = "undine_warp_pool_surface",
    symbol = "#",
    color = "blue",
}

content.patch_overmap_terrain {
    ids = { "undine_warp_pool_zneg", "undine_warp_pool_zneg_dirt", "undine_warp_pool_warper" },
    copy_from = "undine_warp_pool_zneg",
    symbol = "#",
    color = "blue",
}
