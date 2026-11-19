local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = "magic_shop",
    name = ccb.content.text("magic shop"),
    symbol = "M",
    color = "red",
    looks_like = "s_shoppingplaza_b1",
    see_cost = "high",
    extras = "build",
    monster_density = 2,
    vision_levels = "city_building",
    travel_cost = "structure",
    flags = { "SIDEWALK" },
}

ccb.content.define_overmap_terrain {
    id = "magic_shop_2ndfloor",
    name = ccb.content.text("magic shop"),
    symbol = "M",
    color = "red",
    looks_like = "s_shoppingplaza_b2",
    see_cost = "high",
    extras = "build",
    vision_levels = "city_building",
    travel_cost = "roof",
    monster_density = 2,
}

ccb.content.define_overmap_terrain {
    id = "magic_shop_roof",
    name = ccb.content.text("magic shop roof"),
    symbol = "M",
    color = "red",
    looks_like = "s_shoppingplaza_b6",
    see_cost = "none",
    extras = "build",
    vision_levels = "roof_or_air",
    travel_cost = "roof",
    monster_density = 2,
}

ccb.content.define_overmap_terrain {
    id = "magic_cabin",
    name = ccb.content.text("cabin"),
    symbol = "F",
    color = "green",
    see_cost = "high",
    extras = "build",
    vision_levels = "blends_till_details",
    travel_cost = "structure",
    monster_density = 2,
}

ccb.content.define_overmap_terrain {
    id = "magic_cabin_roof",
    name = ccb.content.text("cabin"),
    symbol = "F",
    color = "green",
    see_cost = "none",
    extras = "build",
    vision_levels = "blends_till_outlines",
    travel_cost = "roof",
    monster_density = 2,
}

ccb.content.define_overmap_terrain {
    id = "demon_spider_lair",
    name = ccb.content.text("demon spider lair"),
    symbol = "F",
    color = "light_gray",
    looks_like = "spider_pit",
    vision_levels = "unusual_structure",
    travel_cost = "structure",
    see_cost = "spaced_high",
}

ccb.content.define_overmap_terrain {
    id = "used_bookstore",
    name = ccb.content.text("used bookstore"),
    symbol = "B",
    color = "white",
    looks_like = "s_bookstore",
    see_cost = "high",
    extras = "build",
    monster_density = 1,
    vision_levels = "city_building",
    travel_cost = "structure",
    flags = { "SIDEWALK" },
}

ccb.content.define_overmap_terrain {
    id = "used_bookstore_roof",
    name = ccb.content.text("used bookstore"),
    symbol = "B",
    color = "white",
    looks_like = "s_bookstore_roof",
    see_cost = "none",
    extras = "build",
    vision_levels = "city_building",
    travel_cost = "roof",
    monster_density = 1,
}

ccb.content.define_overmap_terrain {
    id = { "house_technomancer_1", "house_technomancer_2", "house_elf_01" },
    copy_from = "generic_city_house",
}

ccb.content.define_overmap_terrain {
    id = { "house_elf_01_roof" },
    copy_from = "generic_city_house_roof",
}

ccb.content.define_overmap_terrain {
    id = {
        "house_technomancer_3",
        "house_technomancer_4",
        "house_technomancer_5",
        "house_technomancer_6",
    },
    copy_from = "generic_city_house_no_sidewalk",
}

ccb.content.define_overmap_terrain {
    id = { "magic_basement", "house_technomancer_7", "house_technomancer_8" },
    copy_from = "generic_city_house_basement",
}

-- overridden by the magic basement, so suppress warnings about it not spawning
ccb.content.define_overmap_terrain {
    id = { "house_detatched5_basement" },
    copy_from = "generic_city_house_basement",
    extend = { flags = { "SHOULD_NOT_SPAWN" } },
}

ccb.content.define_overmap_terrain {
    id = "black_dragon_lair_z-0_NW",
    name = ccb.content.text("black dragon lair"),
    symbol = "D",
    color = "dark_gray",
    see_cost = "spaced_high",
    vision_levels = "forested_swampy",
    travel_cost = "swamp",
    flags = { "SOURCE_FORAGE", "RISK_EXTREME" },
}

ccb.content.define_overmap_terrain {
    id = "black_dragon_lair_z-0_NE",
    copy_from = "black_dragon_lair_z-0_NW",
}

ccb.content.define_overmap_terrain {
    id = "black_dragon_lair_z-0_SE",
    copy_from = "black_dragon_lair_z-0_NW",
}

ccb.content.define_overmap_terrain {
    id = "black_dragon_lair_z-0_SW",
    copy_from = "black_dragon_lair_z-0_NW",
}

ccb.content.define_overmap_terrain {
    id = "black_dragon_lair_z-1_NW",
    name = ccb.content.text("solid earth"),
    symbol = "#",
    color = "brown",
    looks_like = "solid_earth",
    vision_levels = "underground_dirt",
    travel_cost = "basement",
    see_cost = "full_high",
}

ccb.content.define_overmap_terrain {
    id = "black_dragon_lair_z-1_NE",
    copy_from = "black_dragon_lair_z-1_NW",
}

ccb.content.define_overmap_terrain {
    id = "black_dragon_lair_z-1_SE",
    copy_from = "black_dragon_lair_z-1_NW",
}

ccb.content.define_overmap_terrain {
    id = "black_dragon_lair_z-1_SW",
    copy_from = "black_dragon_lair_z-1_NW",
}

ccb.content.define_overmap_terrain {
    id = "black_dragon_lair_z-2_NW",
    name = ccb.content.text("solid rock"),
    symbol = "%",
    color = "dark_gray",
    looks_like = "empty_rock",
    vision_levels = "underground_stone",
    travel_cost = "basement",
    see_cost = "full_high",
}

ccb.content.define_overmap_terrain {
    id = "black_dragon_lair_z-2_NE",
    copy_from = "black_dragon_lair_z-2_NW",
}

ccb.content.define_overmap_terrain {
    id = "black_dragon_lair_z-2_SE",
    copy_from = "black_dragon_lair_z-2_NW",
}

ccb.content.define_overmap_terrain {
    id = "black_dragon_lair_z-2_SW",
    copy_from = "black_dragon_lair_z-2_NW",
}

ccb.content.define_overmap_terrain {
    id = "black_dragon_lair_z-3_NW",
    name = ccb.content.text("solid rock"),
    symbol = "%",
    color = "dark_gray",
    looks_like = "deep_rock",
    see_cost = "full_high",
    vision_levels = "underground_stone",
    travel_cost = "basement",
}

ccb.content.define_overmap_terrain {
    id = "black_dragon_lair_z-3_NE",
    copy_from = "black_dragon_lair_z-3_NW",
}

ccb.content.define_overmap_terrain {
    id = "black_dragon_lair_z-3_SE",
    copy_from = "black_dragon_lair_z-3_NW",
}

ccb.content.define_overmap_terrain {
    id = "black_dragon_lair_z-3_SW",
    copy_from = "black_dragon_lair_z-3_NW",
}

ccb.content.define_overmap_terrain {
    id = "black_dragon_lair_z-4_NW",
    name = ccb.content.text("solid rock"),
    symbol = "%",
    color = "dark_gray",
    looks_like = "deep_rock",
    see_cost = "full_high",
    vision_levels = "underground_stone",
    travel_cost = "basement",
}

ccb.content.define_overmap_terrain {
    id = "black_dragon_lair_z-4_NE",
    copy_from = "black_dragon_lair_z-4_NW",
}

ccb.content.define_overmap_terrain {
    id = "black_dragon_lair_z-4_SE",
    copy_from = "black_dragon_lair_z-4_NW",
}

ccb.content.define_overmap_terrain {
    id = "black_dragon_lair_z-4_SW",
    copy_from = "black_dragon_lair_z-4_NW",
}

ccb.content.define_overmap_terrain {
    id = "ogre_mound",
    name = ccb.content.text("ogre lair"),
    symbol = "O",
    color = "dark_gray",
    looks_like = "forest_water",
    see_cost = "high",
    vision_levels = "forested_swampy",
    travel_cost = "structure",
}

ccb.content.define_overmap_terrain {
    id = "ogre_mound_roof",
    name = ccb.content.text("ogre lair roof"),
    symbol = "O",
    color = "dark_gray",
    see_cost = "none",
    vision_levels = "forested_swampy",
    travel_cost = "roof",
}

ccb.content.define_overmap_terrain {
    id = "lake_retreat_ground",
    name = ccb.content.text("lake tower"),
    symbol = "F",
    color = "c_light_green",
    looks_like = "forest",
    see_cost = "high",
    vision_levels = "isolated_tower",
    travel_cost = "structure",
}

ccb.content.define_overmap_terrain {
    id = "lake_retreat_z1",
    name = ccb.content.text("lake tower"),
    symbol = ".",
    color = "blue",
    looks_like = "open_air",
    see_cost = "all_clear",
    vision_levels = "isolated_tower",
    travel_cost = "roof",
}

ccb.content.define_overmap_terrain {
    id = "lake_retreat_z2",
    name = ccb.content.text("lake tower"),
    symbol = ".",
    color = "blue",
    looks_like = "open_air",
    see_cost = "all_clear",
    vision_levels = "isolated_tower",
    travel_cost = "roof",
}

ccb.content.define_overmap_terrain {
    id = "lake_retreat_z3",
    name = ccb.content.text("lake tower"),
    symbol = ".",
    color = "blue",
    looks_like = "open_air",
    see_cost = "all_clear",
    vision_levels = "isolated_tower",
    travel_cost = "roof",
}

ccb.content.define_overmap_terrain {
    id = "lake_retreat_z4",
    name = ccb.content.text("lake tower roof"),
    symbol = ".",
    color = "blue",
    looks_like = "open_air",
    see_cost = "all_clear",
    vision_levels = "roof_or_air",
    travel_cost = "roof",
}

ccb.content.define_overmap_terrain {
    id = "lake_retreat_boathouse",
    name = ccb.content.text("boathouse"),
    symbol = "#",
    color = "light_blue",
    looks_like = "lake_shore",
    see_cost = "none",
    vision_levels = "isolated_building",
    travel_cost = "structure",
}

ccb.content.define_overmap_terrain {
    id = "lake_retreat_boathouse_roof",
    name = ccb.content.text("boathouse roof"),
    symbol = ".",
    color = "blue",
    looks_like = "open_air",
    see_cost = "none",
    vision_levels = "roof_or_air",
    travel_cost = "roof",
}

ccb.content.define_overmap_terrain {
    id = "wizardtower1_ground",
    copy_from = "generic_city_building",
    symbol = "W",
    color = "light_blue",
    name = ccb.content.text("wizard tower"),
    vision_levels = "isolated_tower",
    flags = { "SOURCE_LUXURY", "RISK_HIGH", "SIDEWALK" },
}

ccb.content.define_overmap_terrain {
    id = "wizardtower1_living",
    copy_from = "wizardtower1_ground",
    vision_levels = "isolated_tower",
}

ccb.content.define_overmap_terrain {
    id = "wizardtower1_golems",
    copy_from = "wizardtower1_ground",
    vision_levels = "isolated_tower",
}

ccb.content.define_overmap_terrain {
    id = "wizardtower1_study",
    copy_from = "wizardtower1_ground",
    vision_levels = "isolated_tower",
}

ccb.content.define_overmap_terrain {
    id = "wizardtower1_roof",
    copy_from = "wizardtower1_ground",
    vision_levels = "roof_or_air",
}

ccb.content.define_overmap_terrain {
    id = "wizardtower2_ground",
    copy_from = "wizardtower1_ground",
    vision_levels = "isolated_tower",
}

ccb.content.define_overmap_terrain {
    id = "wizardtower2_stairs1",
    copy_from = "wizardtower1_ground",
    vision_levels = "isolated_tower",
}

ccb.content.define_overmap_terrain {
    id = "wizardtower2_stairs2",
    copy_from = "wizardtower1_ground",
    vision_levels = "isolated_tower",
}

ccb.content.define_overmap_terrain {
    id = "wizardtower2_study",
    copy_from = "wizardtower1_ground",
    vision_levels = "isolated_tower",
}

ccb.content.define_overmap_terrain {
    id = "wizardtower2_roof",
    copy_from = "wizardtower1_ground",
    vision_levels = "roof_or_air",
}

ccb.content.define_overmap_terrain {
    id = "forest_tomb",
    name = ccb.content.text("forest"),
    symbol = "F",
    color = "brown",
    looks_like = "cemetery_small",
    see_cost = "spaced_high",
    travel_cost = "structure",
}

ccb.content.define_overmap_terrain {
    id = "forest_tomb_roof",
    copy_from = "forest_tomb",
    travel_cost = "roof",
}

ccb.content.define_overmap_terrain {
    id = "forest_tomb_bottom",
    copy_from = "forest_tomb",
    travel_cost = "basement",
}

ccb.content.define_overmap_terrain {
    id = "magic_academy_ground",
    name = ccb.content.text("magic academy"),
    symbol = "#",
    color = "light_blue",
    looks_like = "campus_lecture_0_0_0",
    see_cost = "high",
    monster_density = 2,
    flags = { "SIDEWALK" },
    vision_levels = "isolated_tower",
    travel_cost = "structure",
}

ccb.content.define_overmap_terrain {
    id = "magic_academy_2nd",
    name = ccb.content.text("magic academy"),
    symbol = "#",
    color = "light_blue",
    looks_like = "campus_lecture_0_0_1",
    monster_density = 2,
    see_cost = "high",
    vision_levels = "isolated_tower",
    travel_cost = "roof",
}

ccb.content.define_overmap_terrain {
    id = "magic_academy_3rd",
    copy_from = "magic_academy_2nd",
}

ccb.content.define_overmap_terrain {
    id = "magic_academy_4th",
    copy_from = "magic_academy_3rd",
}

ccb.content.define_overmap_terrain {
    id = "magic_academy_5th",
    copy_from = "magic_academy_4th",
}

ccb.content.define_overmap_terrain {
    id = "magic_academy_6th",
    copy_from = "magic_academy_5th",
}

ccb.content.define_overmap_terrain {
    id = "magic_academy_7th",
    copy_from = "magic_academy_6th",
}

ccb.content.define_overmap_terrain {
    id = "magic_academy_8th",
    copy_from = "magic_academy_7th",
}

ccb.content.define_overmap_terrain {
    id = "magic_academy_basement",
    copy_from = "magic_academy_2nd",
    vision_levels = "underground_dirt",
    travel_cost = "basement",
}

ccb.content.define_overmap_terrain {
    id = "magic_academy_roof",
    name = ccb.content.text("magic academy"),
    symbol = "#",
    color = "light_blue",
    looks_like = "campus_lecture_0_0_3",
    see_cost = "none",
    vision_levels = "roof_or_air",
    travel_cost = "roof",
}

ccb.content.define_overmap_terrain {
    id = {
        "attunement_altar_NW", "attunement_altar_NE", "attunement_altar_SW", "attunement_altar_SE",
        "attunement_altar_NW_roof", "attunement_altar_NE_roof", "attunement_altar_SW_roof",
        "attunement_altar_SE_roof",
    },
    name = ccb.content.text("attunement altar"),
    symbol = "O",
    color = "light_green",
    looks_like = "standing_stones",
    see_cost = "high",
    monster_density = 2,
    vision_levels = "unusual_structure",
    travel_cost = "structure",
}

ccb.content.define_overmap_terrain {
    id = {
        "mine_balrog_west", "mine_balrog_central", "mine_balrog_east", "mine_balrog_-1_west",
        "mine_balrog_-1_central", "mine_balrog_-1_east", "mine_balrog_finale_nw", "mine_balrog_finale_n",
        "mine_balrog_finale_ne", "mine_balrog_finale_sw", "mine_balrog_finale_s",
        "mine_balrog_finale_se", "mine_balrog_bottomless_pit", "mine_balrog_lava",
    },
    name = ccb.content.text("mine tunnels"),
    symbol = "O",
    color = "dark_gray",
    see_cost = "high",
    flags = { "KNOWN_UP" },
    travel_cost = "tunnel",
}

ccb.content.define_overmap_terrain {
    id = { "magic_field_a1", "magic_field_a2", "magic_field_b1", "magic_field_b2" },
    name = ccb.content.text("big magic meadow"),
    symbol = "*",
    color = "blue",
    flags = { "NO_ROTATE" },
    vision_levels = "blends_till_outlines",
    travel_cost = "forest",
    see_cost = "low",
}

ccb.content.define_overmap_terrain {
    id = { "mystic_glade_nw", "mystic_glade_ne", "mystic_glade_sw", "mystic_glade_se" },
    name = ccb.content.text("mystic glade"),
    symbol = "*",
    color = "green",
    vision_levels = "blends_till_outlines",
    travel_cost = "forest",
    see_cost = "low",
}

ccb.content.define_overmap_terrain {
    id = { "small_magic_field" },
    name = ccb.content.text("magic meadow"),
    symbol = "*",
    color = "blue",
    flags = { "NO_ROTATE" },
    vision_levels = "blends_till_details",
    travel_cost = "forest",
    see_cost = "low",
}

ccb.content.define_overmap_terrain {
    id = { "standing_teleport_stones" },
    name = ccb.content.text("ancient ring of stones"),
    symbol = "O",
    color = "dark_gray",
    flags = { "NO_ROTATE", "REQUIRES_PREDECESSOR" },
    vision_levels = "blends_till_outlines",
    travel_cost = "forest",
    see_cost = "medium",
}

ccb.content.define_overmap_terrain {
    id = {
        "druid_ritual_home_z0", "druid_ritual_home_z1", "druid_ritual_home_z2", "druid_ritual_home_z3",
        "druid_ritual_home_z4",
    },
    name = ccb.content.text("druid tower"),
    symbol = "F",
    color = "green",
    see_cost = "high",
    vision_levels = "unusual_structure",
    travel_cost = "structure",
}

ccb.content.define_overmap_terrain {
    id = {
        "druid_ritual_home_crown_nw", "druid_ritual_home_crown_n", "druid_ritual_home_crown_ne",
        "druid_ritual_home_crown_w", "druid_ritual_home_crown", "druid_ritual_home_crown_e",
        "druid_ritual_home_crown_sw", "druid_ritual_home_crown_s", "druid_ritual_home_crown_se",
    },
    name = ccb.content.text("druid tower crown"),
    symbol = "F",
    color = "green",
    see_cost = "high",
    vision_levels = "unusual_structure",
    travel_cost = "roof",
}

ccb.content.define_overmap_terrain {
    id = { "last_mage_on_earth_shelter" },
    copy_from = "lmoe_under",
    spawns = {},
}

ccb.content.define_overmap_terrain {
    id = {
        "forge_x0y0z0", "forge_x1y0z0", "forge_x2y0z0", "forge_x3y0z0", "forge_x0y1z0", "forge_x1y1z0",
        "forge_x2y1z0", "forge_x3y1z0", "forge_x0y2z0", "forge_x1y2z0", "forge_x2y2z0", "forge_x3y2z0",
        "forge_x0y3z0", "forge_x1y3z0", "forge_x2y3z0", "forge_x3y3z0", "forge_x0y0z1", "forge_x1y0z1",
        "forge_x2y0z1", "forge_x3y0z1", "forge_x0y1z1", "forge_x1y1z1", "forge_x2y1z1", "forge_x3y1z1",
        "forge_x0y2z1", "forge_x1y2z1", "forge_x2y2z1", "forge_x3y2z1", "forge_x0y3z1", "forge_x1y3z1",
        "forge_x2y3z1", "forge_x3y3z1", "forge_x0y0z2", "forge_x1y0z2", "forge_x2y0z2", "forge_x3y0z2",
        "forge_x0y1z2", "forge_x1y1z2", "forge_x2y1z2", "forge_x3y1z2", "forge_x0y2z2", "forge_x1y2z2",
        "forge_x2y2z2", "forge_x3y2z2", "forge_x0y3z2", "forge_x1y3z2", "forge_x2y3z2", "forge_x3y3z2",
        "forge_x0y0z3", "forge_x1y0z3", "forge_x2y0z3", "forge_x3y0z3", "forge_x0y1z3", "forge_x1y1z3",
        "forge_x2y1z3", "forge_x3y1z3", "forge_x0y2z3", "forge_x1y2z3", "forge_x2y2z3", "forge_x3y2z3",
        "forge_x0y3z3", "forge_x1y3z3", "forge_x2y3z3", "forge_x3y3z3", "forge_x0y0z4", "forge_x1y0z4",
        "forge_x2y0z4", "forge_x3y0z4", "forge_x0y1z4", "forge_x1y1z4", "forge_x2y1z4", "forge_x3y1z4",
        "forge_x0y2z4", "forge_x1y2z4", "forge_x2y2z4", "forge_x3y2z4", "forge_x0y3z4", "forge_x1y3z4",
        "forge_x2y3z4", "forge_x3y3z4",
    },
    name = ccb.content.text("forge of wonders"),
    on_entry = "enter_forge_of_wonders",
    symbol = "$",
    color = "red",
    see_cost = "full_high",
    travel_cost = "structure",
}

ccb.content.define_overmap_terrain {
    id = "farm_aenoren_stable_1",
    copy_from = "generic_rural_building",
    name = ccb.content.text("aenóren hutch"),
    symbol = "&",
}

ccb.content.define_overmap_terrain {
    id = "farm_aenoren_stable_1_loft",
    copy_from = "generic_rural_building",
    name = ccb.content.text("aenóren hutch loft"),
    symbol = "&",
}

ccb.content.define_overmap_terrain {
    id = "farm_aenoren_stable_1_roof",
    copy_from = "generic_rural_building",
    travel_cost = "roof",
    name = ccb.content.text("aenóren hutch roof"),
    symbol = "&",
}

ccb.content.define_overmap_terrain {
    id = {
        "aenor_paddock", "aenor_paddock_L_butt", "aenor_paddock_R_butt", "aenor_paddock_L_gap",
        "aenor_paddock_R_gap", "aenor_paddock_C", "aenor_paddock_UL", "aenor_paddock_UR",
        "aenor_paddock_DL", "aenor_paddock_DR", "aenor_paddock_d_D_butt", "aenor_paddock_d_U_gap",
        "aenor_paddock_d_D_gap", "aenor_paddock_d_U_butt", "aenor_paddock_special_1",
        "aenor_paddock_special_2", "aenor_paddock_special_3", "aenor_paddock_special_4",
        "aenor_paddock_trailhead_1", "aenor_paddock_trailhead_3", "aenor_paddock_trailhead_4",
        "aenor_paddock_trailhead_6", "aenor_paddock_trailhead_7", "aenor_paddock_trailhead_9",
        "aenor_paddock_end_UL", "aenor_paddock_end_UR", "aenor_paddock_end_DL", "aenor_paddock_end_DR",
    },
    copy_from = "generic_rural_field",
    name = ccb.content.text("paddock"),
    symbol = "#",
    color = "white",
}

ccb.content.define_overmap_terrain {
    id = { "aenor_farm_ring_1", "aenor_farm_ring_2", "aenor_farm_ring_3", "aenor_farm_ring_4" },
    copy_from = "generic_rural_building",
    travel_cost = "dirt_road",
    name = ccb.content.text("ring"),
    symbol = "#",
    color = "brown",
}

ccb.content.define_overmap_terrain {
    id = { "aenor_farm_track_1", "aenor_farm_track_2" },
    copy_from = "generic_rural_building",
    travel_cost = "dirt_road",
    name = ccb.content.text("track"),
    symbol = "_",
    color = "i_light_gray",
}

ccb.content.define_overmap_terrain {
    id = { "aenor_farm_track_large_1" },
    copy_from = "generic_rural_building",
    travel_cost = "dirt_road",
    name = ccb.content.text("track"),
    symbol = "┌",
    color = "i_light_gray",
}

ccb.content.define_overmap_terrain {
    id = { "aenor_farm_track_large_2" },
    copy_from = "generic_rural_building",
    travel_cost = "dirt_road",
    name = ccb.content.text("track"),
    symbol = "┐",
    color = "i_light_gray",
}

ccb.content.define_overmap_terrain {
    id = { "aenor_farm_track_large_3" },
    copy_from = "generic_rural_building",
    travel_cost = "dirt_road",
    name = ccb.content.text("track"),
    symbol = "└",
    color = "i_light_gray",
}

ccb.content.define_overmap_terrain {
    id = { "aenor_farm_track_large_4" },
    copy_from = "generic_rural_building",
    travel_cost = "dirt_road",
    name = ccb.content.text("track"),
    symbol = "┘",
    color = "i_light_gray",
}

ccb.content.define_overmap_terrain {
    id = { "aenor_paddock_trailhead_2" },
    copy_from = "generic_rural_building",
    travel_cost = "dirt_road",
    name = ccb.content.text("trailhead"),
    symbol = "T",
    color = "brown",
}

ccb.content.define_overmap_terrain {
    id = { "aenor_paddock_trailhead_5", "aenor_paddock_trailhead_8" },
    copy_from = "generic_rural_building",
    travel_cost = "trail",
    name = ccb.content.text("forest trail"),
    symbol = "│",
    color = "green",
}
