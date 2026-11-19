local ccb = require("ccb")
local content = ccb.content

content.add(content.TerrainTransform { id = "move_earth" }
    :terrain {
        inputs = { "t_pit", "t_slope_down" },
        results = { "t_open_air" },
        message = ccb.content.text("The pit has deepened further."),
    }
    :terrain {
        inputs = {
            "t_pit_corpsed", "t_pit_covered", "t_pit_glass", "t_pit_glass_covered", "t_pit_spiked",
            "t_pit_spiked_covered", "t_rootcellar", "t_pit_shallow",
        },
        results = { "t_pit" },
        message = ccb.content.text("More debris shifts out of the pit."),
    }
    :terrain {
        inputs = {
            "t_grave", "t_dirt", "t_sand", "t_clay", "t_dirtmound", "t_grass", "t_grass_long", "t_grass_tall",
            "t_grass_dead", "t_grass_white", "t_dirtfloor", "t_fungus_floor_in", "t_fungus_floor_sup",
            "t_fungus_floor_out", "t_sandbox",
        },
        results = { "t_pit_shallow" },
        message = ccb.content.text("The earth moves out of the way for you."),
    }
    :terrain {
        inputs = {
            "t_pavement", "t_pavement_y", "t_sidewalk", "t_concrete", "t_thconc_floor",
            "t_thconc_floor_olight", "t_strconc_floor", "t_floor", "t_floor_waxed", "t_carpet_red",
            "t_carpet_yellow", "t_carpet_purple", "t_carpet_green", "t_linoleum_white", "t_linoleum_gray",
            "t_slope_up", "t_rock_red", "t_rock_blue", "t_floor_red", "t_floor_green", "t_floor_blue",
            "t_pavement_bg_dp", "t_pavement_y_bg_dp", "t_sidewalk_bg_dp",
        },
        results = { "t_sand" },
        message = ccb.content.text("The rocks here are ground into sand."),
    }
    :terrain {
        inputs = { "t_rock" },
        results = { "t_rock_floor" },
        message = ccb.content.text("The rock crumbles to dust."),
    }
    :terrain {
        inputs = { "t_null" },
        results = { "t_open_air" },
        message = ccb.content.text("All the dust in the air here falls to the ground."),
        message_good = false,
    })

content.add(content.TerrainTransform { id = "fungicide" }
    :terrain {
        flags = { "FUNGUS" },
        results = { "t_dirt_barren" },
        message = ccb.content.text("The fungus here dies back."),
    }
    :furniture {
        flags = { "FUNGUS" },
        results = { "f_null" },
        message = ccb.content.text("The fungus here dies back."),
    })

content.add(content.TerrainTransform { id = "lava_bomb" }
    :terrain {
        flags = { "DIGGABLE" },
        results = { "t_lava" },
    })

-- Furniture alteration has to be able to reasonably check for most intervening furniture and remove it.
content.add(content.TerrainTransform { id = "earthshaper_pillar" }
    :terrain {
        flags = { "DIGGABLE", "FLAT" },
        results = { "t_rock_smooth" },
        message = ccb.content.text("The ground shakes, a section of unnaturally smooth stone wall rising up."),
    }
    :furniture {
        flags = { "TRANSPARENT", "WALL" },
        results = { "f_null" },
    })

content.add(content.TerrainTransform { id = "earthshaper_turning_earth" }
    :terrain {
        inputs = {
            "t_dirt", "t_dirtfloor", "t_grass", "t_grass_long", "t_grass_tall", "t_grass_dead",
            "t_grass_white", "t_pit_shallow",
        },
        results = { "t_dirtmound" },
        message = ccb.content.text("The ground churns as a long straight furrow suitable for planting appears."),
    })

content.add(content.TerrainTransform { id = "earthshaper_boulder" }
    :furniture {
        inputs = { "f_null" },
        results = { "f_boulder_earthshaper" },
        message = ccb.content.text("The ground shakes, and a section of unnaturally smooth stone rises to the surface."),
    })

-- TODO: Update the birch and willow transformations if they ever make those trees behave consistent relative to blackjack oak and pine.
content.add(content.TerrainTransform { id = "druidic_renewal" }
    :terrain {
        inputs = { "t_tree_dead" },
        results = { { "t_tree_blackjack_harvested", 10 }, { "t_tree_harvested", 90 } },
        message = ccb.content.text("The dead tree regrows."),
    }
    :terrain {
        inputs = { "t_tree_deadpine" },
        results = { "t_tree_pine_harvested" },
        message = ccb.content.text("The dead tree regrows."),
    }
    :terrain {
        inputs = { "t_tree_hickory_dead" },
        results = { "t_tree_hickory_harvested" },
        message = ccb.content.text("The dead tree regrows."),
    }
    :terrain {
        inputs = { "t_tree_birch_harvested" },
        results = { "t_tree_birch" },
        message = ccb.content.text("The dead tree regrows."),
    }
    :terrain {
        inputs = { "t_tree_willow_harvested" },
        results = { "t_tree_willow" },
        message = ccb.content.text("The dead tree regrows."),
    }
    :terrain {
        inputs = { "t_grass_dead" },
        results = { "t_grass" },
        message = ccb.content.text("Life springs anew from the dead grass."),
    }
    :terrain {
        inputs = { "t_tree_very_dead" },
        results = {
            { "t_tree_birch", 32 }, { "t_tree_elm", 32 }, { "t_tree_cottonwood", 32 },
            { "t_tree_basswood", 32 }, { "t_tree_alder", 32 }, { "t_tree_pine", 64 }, { "t_tree_maple", 64 },
            { "t_tree_willow", 64 }, { "t_tree_hickory_harvested", 32 }, { "t_tree_walnut_harvested", 16 },
            { "t_tree_butternut", 4 }, { "t_tree_chestnut_harvested", 8 }, { "t_tree_hazelnut_harvested", 2 },
            { "t_tree_beech", 4 }, { "t_tree_blackjack", 8 }, { "t_tree_apple_harvested", 2 },
            { "t_tree_cherry_harvested", 2 }, { "t_tree_juniper", 2 }, { "t_tree_pear_harvested", 2 },
            { "t_tree_plum_harvested", 2 }, { "t_tree_elderberry_harvested", 2 },
            { "t_tree_mulberry_harvested", 2 }, { "t_tree_sassafras", 3 },
        },
        message = ccb.content.text("The withered, desiccated tree springs back to life."),
    })

content.add(content.TerrainTransform { id = "unlock_doors" }
    :terrain {
        inputs = { "t_door_locked", "t_door_locked_interior", "t_door_locked_alarm" },
        results = { "t_door_o" },
        message = ccb.content.text("The door opens forcefully!"),
    }
    :terrain {
        inputs = { "t_door_locked_peep" },
        results = { "t_door_o_peep" },
        message = ccb.content.text("The door opens forcefully!"),
    })

content.add(content.TerrainTransform { id = "unlock_all_doors" }
    :terrain {
        inputs = { "t_door_locked", "t_door_locked_interior", "t_door_locked_alarm" },
        results = { "t_door_o" },
        message = ccb.content.text("The door opens forcefully!"),
    }
    :terrain {
        inputs = { "t_door_locked_peep" },
        results = { "t_door_o_peep" },
        message = ccb.content.text("The door opens forcefully!"),
    }
    :terrain {
        inputs = {
            "t_door_metal_locked", "t_door_metal_pickable", "t_door_bar_locked",
            "t_door_metal_interior_locked",
        },
        results = { "t_door_metal_o" },
        message = ccb.content.text("The door opens forcefully!"),
    }
    :terrain {
        inputs = { "t_chaingate_l" },
        results = { "t_chaingate_o" },
        message = ccb.content.text("The gate opens forcefully!"),
    }
    :terrain {
        inputs = { "t_retractable_gate_l" },
        results = { "t_retractable_gate_o" },
        message = ccb.content.text("The gate opens forcefully!"),
    })

content.add(content.TerrainTransform { id = "icelemental_crystal" }
    :furniture {
        inputs = { "f_null" },
        results = { "f_everfrost_crystal" },
        message = ccb.content.text("There's a rippling in the air and a blast of cold air, then the crystal forms."),
    })

content.add(content.TerrainTransform { id = "earthshaper_granite_aegis_to_stone" }
    :terrain {
        inputs = {
            "t_rock_floor_no_roof", "t_rock_floor", "t_dirt", "t_dirtfloor", "t_dirtfloor_no_roof",
            "t_dirt_underground", "t_grass", "t_grass_long", "t_grass_tall", "t_grass_dead", "t_grass_white",
            "t_grass_golf", "t_pit_shallow", "t_sand", "t_sand_underground", "t_clay", "t_claymound",
            "t_claymound_underground", "t_dirtmound", "t_sandmound", "t_mud", "t_mud_underground",
            "t_forestfloor", "t_moss", "t_moss_underground", "t_region_soil", "t_puddle_underground",
            "t_concrete_y", "t_concrete", "t_thconc_y_olight", "t_thconc_warning", "t_thconc_y", "t_thconc_r",
            "t_thconc_floor", "t_strconc_floor", "t_strconc_floor_olight", "t_strconc_floor_no_roof",
            "t_railroad_rubble",
        },
        results = { "t_rock_smooth" },
        message = ccb.content.text("A wall of smooth stone rises up around you!"),
    })

content.add(content.TerrainTransform { id = "earthshaper_granite_aegis_to_stone_safe" }
    :terrain {
        inputs = { "t_rock_smooth" },
        results = { "t_dirtmound" },
    })

content.add(content.TerrainTransform { id = "earthshaper_granite_aegis_from_stone" }
    :terrain {
        inputs = { "t_rock_smooth" },
        results = { "t_dirtmound" },
        message = ccb.content.text("The stone wall crumbles to dust."),
    })

content.add(content.TerrainTransform { id = "druid_summoned_brambles" }
    :furniture {
        inputs = {
            "f_null", "f_cattails", "t_grass_tall", "t_grass_long", "f_burdock", "f_lotus",
            "f_japanese_knotweed", "f_golden_reed", "f_barnacle_weed", "f_lilypad", "f_whiskflower",
            "f_bluebell", "f_lily", "f_salsify", "f_wild_sarsaparilla",
        },
        results = { "f_druid_brambles" },
        message = ccb.content.text("The ground churns as thick, tangled brambles burst forth and grow in moments."),
    })

content.add(content.TerrainTransform { id = "ter_druid_cause_rot_terrain" }
    :terrain {
        flags = { "SHRUB", "GRAZEABLE" },
        results = { "t_dirt" },
        message = ccb.content.text("The plants wither and rot into nothingness in seconds!"),
    }
    :terrain {
        flags = { "TREE" },
        results = { "t_tree_very_dead" },
        message = ccb.content.text("The trees caught in the spell crack and desiccate, their branches warping and shrinking."),
    }
    :furniture {
        flags = { "SHRUB", "GRAZEABLE" },
        results = { "f_null" },
        message = ccb.content.text("The plants wither and rot into nothingness in seconds!"),
    })

content.add(content.TerrainTransform { id = "ter_druid_renew_forest" }
    :terrain {
        flags = { "YOUNG" },
        results = {
            { "t_tree_birch", 32 }, { "t_tree_elm", 32 }, { "t_tree_cottonwood", 32 },
            { "t_tree_basswood", 32 }, { "t_tree_alder", 32 }, { "t_tree_pine", 64 }, { "t_tree_maple", 64 },
            { "t_tree_willow", 64 }, { "t_tree_hickory_harvested", 32 }, { "t_tree_walnut_harvested", 16 },
            { "t_tree_nannyberry_harvested", 16 }, { "t_tree_tupelo_harvested", 32 },
            { "t_tree_butternut", 4 }, { "t_tree_chestnut_harvested", 8 }, { "t_tree_hazelnut_harvested", 2 },
            { "t_tree_beech", 4 }, { "t_tree_blackjack", 8 }, { "t_tree_apple_harvested", 2 },
            { "t_tree_cherry_harvested", 2 }, { "t_tree_juniper", 2 }, { "t_tree_pear_harvested", 2 },
            { "t_tree_plum_harvested", 2 }, { "t_tree_crabapple_harvested", 2 },
            { "t_tree_elderberry_harvested", 2 }, { "t_tree_mulberry_harvested", 2 },
            { "t_tree_sassafras", 3 },
        },
        message = ccb.content.text("Wood creaks as the tree's limbs grow and stretch toward the sky."),
    }
    :terrain {
        flags = { "DIGGABLE", "SHRUB" },
        results = {
            { "t_grass", 150 }, { "t_grass_long", 50 }, { "t_grass_tall", 20 }, { "t_shrub", 30 },
            { "t_underbrush", 65 }, { "t_shrub_spicebush_harvested", 10 },
            { "t_shrub_chokeberry_harvested", 10 }, { "t_shrub_autumn_olive_harvested", 10 },
            { "t_shrub_rose", 5 }, { "t_shrub_blackberry_harvested", 5 }, { "t_shrub_grape_harvested", 5 },
            { "t_shrub_lilac_harvested", 5 }, { "t_shrub_blueberry_harvested", 5 },
            { "t_shrub_raspberry_harvested", 5 }, { "t_shrub_hydrangea_harvested", 5 },
            { "t_shrub_huckleberry_harvested", 5 }, { "t_tree_young", 35 },
        },
        message = ccb.content.text("Soil churns as roots quest through it and grass and bushes spring forth from the ground."),
    }
    :terrain {
        inputs = { "t_grass" },
        results = { { "t_grass", 9 }, { "t_moss", 3 }, { "t_forestfloor", 4 } },
    }
    :terrain {
        inputs = { "t_floor" },
        results = { { "t_floor", 9 }, { "t_grass", 6 }, { "t_grass_long", 2 }, "t_grass_tall" },
        message = ccb.content.text("The works of civilization crack as plants force their way through to the sun."),
    }
    :terrain {
        inputs = { "t_floor_noroof" },
        results = { { "t_floor_noroof", 9 }, { "t_grass", 6 }, { "t_grass_long", 2 }, "t_grass_tall" },
        message = ccb.content.text("The works of civilization crack as plants force their way through to the sun."),
    }
    :terrain {
        inputs = { "t_floor_primitive" },
        results = { { "t_floor_primitive", 6 }, { "t_grass", 6 }, { "t_grass_long", 2 }, "t_grass_tall" },
        message = ccb.content.text("The works of civilization crack as plants force their way through to the sun."),
    }
    :terrain {
        inputs = { "t_pavement" },
        results = { { "t_pavement", 12 }, { "t_grass", 6 }, { "t_grass_long", 2 }, "t_grass_tall" },
        message = ccb.content.text("The works of civilization crack as plants force their way through to the sun."),
    }
    :terrain {
        inputs = { "t_pavement_y" },
        results = { { "t_pavement_y", 12 }, { "t_grass", 6 }, { "t_grass_long", 2 }, "t_grass_tall" },
        message = ccb.content.text("The works of civilization crack as plants force their way through to the sun."),
    }
    :terrain {
        inputs = { "t_zebra" },
        results = { { "t_zebra", 12 }, { "t_grass", 6 }, { "t_grass_long", 2 }, "t_grass_tall" },
        message = ccb.content.text("The works of civilization crack as plants force their way through to the sun."),
    }
    :terrain {
        inputs = { "t_sidewalk" },
        results = { { "t_sidewalk", 12 }, { "t_grass", 6 }, { "t_grass_long", 2 }, "t_grass_tall" },
        message = ccb.content.text("The works of civilization crack as plants force their way through to the sun."),
    }
    :terrain {
        inputs = { "t_concrete" },
        results = { { "t_concrete", 12 }, { "t_grass", 6 }, { "t_grass_long", 2 }, "t_grass_tall" },
        message = ccb.content.text("The works of civilization crack as plants force their way through to the sun."),
    }
    :terrain {
        inputs = { "t_concrete_y" },
        results = { { "t_concrete_y", 12 }, { "t_grass", 6 }, { "t_grass_long", 2 }, "t_grass_tall" },
        message = ccb.content.text("The works of civilization crack as plants force their way through to the sun."),
    }
    :furniture {
        flags = { "MOUNTABLE", "BLOCK_WIND", "ORGANIC" },
        results = { "f_null" },
    })

content.add(content.TerrainTransform { id = "ter_kelvinist_extinguish_transform" }
    :field {
        inputs = { "fd_fire", "fd_incendiary", "fd_flame_burst" },
        results = { "fd_null" },
        message = ccb.content.text("The fires suddenly vanish!"),
        message_good = true,
    })

content.add(content.TerrainTransform { id = "ter_earthshaper_harden_earth" }
    :terrain {
        inputs = { "t_dirt", "t_dirtfloor_no_roof", "t_dirtmound" },
        results = { "t_rock_floor_no_roof" },
        message = ccb.content.text("The earth hardens into solid rock."),
    }
    :terrain {
        inputs = { "t_dirt_underground" },
        results = { "t_rock_floor" },
        message = ccb.content.text("The earth hardens into solid rock."),
    }
    :terrain {
        inputs = { "t_soil" },
        results = { "t_rock" },
        message = ccb.content.text("The earth hardens into solid rock."),
    }
    :terrain {
        inputs = { "t_wall_rammed_earth" },
        results = { "t_rock" },
        message = ccb.content.text("The earth hardens into solid rock."),
    }
    :furniture {
        inputs = { "f_dirtmound_tall", "f_dirtmound_shallow" },
        results = { "f_null" },
    })

content.add(content.TerrainTransform { id = "ter_magus_permanent_light" }
    :furniture {
        inputs = { "f_null" },
        results = { "f_magus_permanent_light" },
        message = ccb.content.text("The air begins glowing softly."),
    }
    :furniture {
        inputs = { "f_magus_permanent_light" },
        results = { "f_null" },
        message = ccb.content.text("The imperishable light winks out."),
    })

content.add(content.TerrainTransform { id = "ter_druid_create_spring" }
    :terrain {
        flags = { "DIGGABLE" },
        results = { "t_water_moving_sh_druid" },
        message = ccb.content.text("Water bubbles forth from the earth."),
    })

content.add(content.TerrainTransform { id = "ter_druid_remove_spring" }
    :terrain {
        inputs = { "t_water_moving_sh_druid" },
        results = { "t_dirt" },
        message = ccb.content.text("The flow of water subsides."),
    })

content.add(content.TerrainTransform { id = "ter_druid_" }
    :terrain {
        flags = { "DIGGABLE" },
        results = { "t_water_moving_sh_druid" },
        message = ccb.content.text("Water bubbles forth from the earth."),
    })

content.add(content.TerrainTransform { id = "ter_druid_tree_guardian_turn" }
    :terrain {
        flags = { "TREE" },
        results = { "t_grass" },
        message = ccb.content.text("The tree shakes free of the soil."),
    })

content.add(content.TerrainTransform { id = "ter_druid_tree_guardian_turn_back" }
    :terrain {
        flags = {
            "BURROWABLE", "DIGGABLE", "COLLAPSES", "DOOR", "FLAT_SURF", "FUNGUS", "PLANTABLE", "ROAD",
            "ROUGH", "SHALLOW_WATER",
        },
        results = {
            { "t_tree_birch", 32 }, { "t_tree_elm", 32 }, { "t_tree_cottonwood", 32 },
            { "t_tree_basswood", 32 }, { "t_tree_alder", 32 }, { "t_tree_pine", 64 }, { "t_tree_maple", 64 },
            { "t_tree_willow", 64 }, { "t_tree_hickory", 32 }, { "t_tree_walnut", 16 },
            { "t_tree_tupelo", 16 }, { "t_tree_nannyberry", 16 }, { "t_tree_butternut", 4 },
            { "t_tree_chestnut", 8 }, { "t_tree_hazelnut", 2 }, { "t_tree_beech", 4 },
            { "t_tree_blackjack", 8 }, { "t_tree_apple", 2 }, { "t_tree_cherry", 2 }, { "t_tree_juniper", 2 },
            { "t_tree_pear", 2 }, { "t_tree_plum", 2 }, { "t_tree_elderberry", 2 }, { "t_tree_mulberry", 2 },
            { "t_tree_sassafras", 3 },
        },
    })

content.add(content.TerrainTransform { id = "ter_rock_troll_death" }
    :furniture {
        inputs = { "f_null", "f_straw_bed" },
        results = { "f_rock_troll_statue" },
    })

content.add(content.TerrainTransform { id = "immolate_transform" }
    :terrain {
        inputs = {
            "t_grass", "t_grass_long", "t_grass_tall", "t_grass_white", "t_grass_dead", "t_moss",
            "t_grass_golf",
        },
        results = { { "t_dirt", 3 }, "t_grass_dead" },
        message = ccb.content.text("The earth is scorched clean!"),
    }
    :terrain {
        flags = { "SHRUB" },
        results = { "t_dirtmound", "t_dirt" },
    }
    :terrain {
        flags = { "TREE" },
        results = { { "t_stump", 3 }, { "t_tree_dead", 2 }, "t_dirtmound" },
    }
    :furniture {
        inputs = { "f_null" },
        results = { { "f_ash", 2 }, { "f_null", 5 } },
    }
    :furniture {
        flags = { "FLAMMABLE_ASH" },
        results = { "f_ash" },
    })

content.add(content.TerrainTransform { id = "quake_transform" }
    :furniture {
        inputs = { "f_null" },
        results = { "f_rubble" },
        message = ccb.content.text("The earth is upheaved!"),
    })
