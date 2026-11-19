local ccb = require("ccb")
local content = ccb.content

content.add(content.TerrainTransform { id = "unlock_elock" }
    :terrain {
        inputs = { "t_door_elocked" },
        results = { "t_door_c" },
        message = ccb.content.text("The numpad chirps happily at you as the door unlocks."),
    }
    :terrain {
        inputs = { "t_door_elocked_peep" },
        results = { "t_door_c_peep" },
        message = ccb.content.text("The numpad chirps happily at you as the door unlocks."),
    }
    :terrain {
        inputs = { "t_door_elocked_alarm" },
        results = { "t_door_c" },
        message = ccb.content.text("The numpad chirps happily at you as the door unlocks."),
    }
    :terrain {
        inputs = { "t_door_metal_elocked" },
        results = { "t_door_metal_c" },
        message = ccb.content.text("The numpad chirps happily at you as the door unlocks."),
    })

content.add(content.TerrainTransform { id = "ter_shadowman_close_wound" }
    :field {
        inputs = { "fd_dream_wound_shadow" },
        results = { "fd_null" },
        message = ccb.content.text("The shadowy rift pulls closed!"),
        message_good = true,
    })

content.add(content.TerrainTransform { id = "XE_quake_transform" }
    :furniture {
        inputs = { "f_null" },
        results = { "f_rubble" },
        message = ccb.content.text("The earth is upheaved!"),
    })

content.add(content.TerrainTransform { id = "xedra_chronomancer_normalize_time_terrain_furn_transform" }
    :field {
        inputs = { "fd_frozen_time" },
        results = { "fd_null" },
        message = ccb.content.text("You unfreeze a zone of frozen time."),
    })

content.add(content.TerrainTransform { id = "xedra_chronomancer_memorize_terrain_switch" }
    :furniture {
        inputs = { "f_null" },
        results = { "xedra_chronomancer_memorized_terrain" },
        message = ccb.content.text("You don't think you'll forget this spot."),
        message_good = true,
    })

content.add(content.TerrainTransform { id = "xedra_chronomancer_cement_time_terrain_furn_transform" }
    :field {
        inputs = { "fd_frozen_time" },
        results = { "fd_frozen_time_permanent" },
        message = ccb.content.text("You permanently freeze a zone of frozen time."),
    })

content.add(content.TerrainTransform { id = "inventor_portal_closer_spell_furn_transform" }
    :field {
        inputs = { "fd_fatigue" },
        results = { "fd_null" },
        message = ccb.content.text("The tear in reality smoothes out."),
    }
    :trap {
        inputs = { "tr_portal" },
        results = { "tr_glass" },
        message = ccb.content.text("The portal shatters into shards of glass!"),
    })

content.add(content.TerrainTransform { id = "xedra_inventor_time_pierce_furn_transform" }
    :field {
        inputs = { "fd_frozen_time" },
        results = { "fd_null" },
        message = ccb.content.text("You unfreeze a zone of frozen time."),
    })

content.add(content.TerrainTransform { id = "ter_arvore_tree_to_grass" }
    :terrain {
        flags = { "TREE" },
        results = { "t_tree_young" },
    })

content.add(content.TerrainTransform { id = "ter_arvore_plant_growth" }
    :terrain {
        inputs = { "t_tree_young" },
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
        message = ccb.content.text("The young tree creaks as its limbs begin growing, first slowly and then with increasing speed.  Roots churn through the soil and leaves stretch toward the sun, and in moments, before you is a tree that could have stood for a human lifetime."),
    }
    :terrain {
        inputs = { "t_grass" },
        results = { "t_grass_long" },
        message = ccb.content.text("Fresh green grass grows longer and longer until it stands as tall as your knees."),
    }
    :terrain {
        inputs = { "t_grass_long" },
        results = { "t_grass_tall" },
        message = ccb.content.text("The tall grass grows and grows until a child could easily hide themselves within it."),
    }
    :furniture {
        inputs = { "f_plant_mature", "f_plant_seedling", "f_plant_seed" },
        results = { "f_plant_harvest" },
        message = ccb.content.text("The plant grows in moments, leaves unfurling, roots churning the soil, and flowers opening toward the sun.  Before you even lower your hands, it's ripe and ready for the harvest."),
    })

content.add(content.TerrainTransform { id = "ter_arvore_command_grasses" }
    :terrain {
        inputs = { "t_grass_long" },
        results = { "t_grass_tall" },
        message = ccb.content.text("The grass grows tall, reaching toward the sky."),
    }
    :terrain {
        inputs = { "t_grass" },
        results = { { "t_grass_long", 100 }, { "t_grass_tall", 25 } },
        message = ccb.content.text("The grass grows tall, reaching toward the sky."),
    }
    :terrain {
        flags = { "DIGGABLE" },
        results = { { "t_grass", 50 }, { "t_grass_long", 100 }, { "t_grass_tall", 10 } },
        message = ccb.content.text("The ground churns as blades of grass push out of the soil."),
    })

content.add(content.TerrainTransform { id = "ter_arvore_wood_wall" }
    :terrain {
        inputs = { "t_barkfloor", "t_barkfloor_no_roof" },
        results = { "t_triffid_bark_wall" },
        message = ccb.content.text("The bark surges upward as the roots below grow into a heavy, solid wall covered in bark."),
    }
    :terrain {
        inputs = { "t_triffid_bark_wall" },
        results = { "t_triffid_wood_wall" },
        message = ccb.content.text("The wooden wall shudders as the bark peels off in sheets, eventually becoming a solid expanse of bare wood."),
    }
    :terrain {
        inputs = { "t_triffid_wood_wall" },
        results = { "t_triffid_bark_wall" },
        message = ccb.content.text("The bare wooden wall shudders as bark sprouts and spreads over it, covering the entire surface in moments."),
    })

content.add(content.TerrainTransform { id = "ter_arvore_wood_wall_top" }
    :terrain {
        inputs = { "t_open_air" },
        results = { "t_barkfloor_no_roof" },
    })

content.add(content.TerrainTransform { id = "ter_arvore_wood_floor" }
    :terrain {
        inputs = {
            "t_grass", "t_grass_long", "t_dirt", "t_dirtfloor", "t_dirtfloor_no_roof", "t_dirtmoundfloor",
            "t_dirtmound", "t_grass_dead", "t_grass_white", "t_sand", "t_moss", "t_clay", "t_sandmound",
            "t_forestfloor",
        },
        results = { "t_barkfloor_no_roof" },
        message = ccb.content.text("The ground churns as bark-covered roots erupt from it and form into a solid bark-covered floor."),
    }
    :terrain {
        inputs = { "t_barkfloor_no_roof" },
        results = { "t_barkfloor" },
        message = ccb.content.text("The ground churns as bark-covered roots quest upward, forming an intertwining roof."),
    }
    :terrain {
        inputs = { "t_triffid_wood_wall", "t_triffid_bark_wall" },
        results = { "t_barkfloor_no_roof" },
        message = ccb.content.text("The wooden wall spasms and recedes into the ground, leaving only a bark-covered floor in its place."),
    })

content.add(content.TerrainTransform { id = "ter_arvore_wood_branch" }
    :terrain {
        inputs = { "t_barkfloor_no_roof", "t_barkfloor" },
        results = { "t_triffid_leaves" },
        message = ccb.content.text("The bark floor shudders as thin branches sprout from it, leaves already growing and unfurling, and soon a thicket of dense leaves covers the area."),
    }
    :terrain {
        inputs = {
            "t_grass", "t_grass_long", "t_dirt", "t_dirtfloor", "t_dirtfloor_no_roof", "t_dirtmoundfloor",
            "t_dirtmound", "t_grass_dead", "t_grass_white", "t_sand", "t_moss", "t_clay", "t_sandmound",
            "t_forestfloor",
        },
        results = { "t_triffid_leaves" },
        message = ccb.content.text("The ground shudders as thin branches sprout from it, leaves already growing and unfurling, and soon a thicket of dense leaves covers the area."),
    })

content.add(content.TerrainTransform { id = "ter_arvore_wood_door" }
    :terrain {
        inputs = { "t_triffid_wood_wall", "t_triffid_bark_wall" },
        results = { "t_bramble_door_c" },
        message = ccb.content.text("The wall trembles and splits apart into a tangle of gnarled roots, waving in the air like monstrous tentacles.  They weave together into a sturdy door before ceasing their motion."),
    }
    :terrain {
        inputs = { "t_bramble_door_c", "t_bramble_door_o" },
        results = { "t_triffid_bark_wall" },
        message = ccb.content.text("The roots surge into motion, growing together thicker and more tangled until a bark-covered wall of solid wood is all that remains."),
    })

content.add(content.TerrainTransform { id = "ter_arvore_translocate_location_attune" }
    :furniture {
        inputs = { "f_null" },
        results = { "f_arvore_translocator_ground" },
        message = ccb.content.text("You meditate within the depths of the forest."),
        message_good = true,
    })

content.add(content.TerrainTransform { id = "ter_arvore_climbing_vine" }
    :terrain {
        flags = { "DIGGABLE" },
        results = { "t_arvore_climbing_vine" },
        message = ccb.content.text("A vine bursts out of the ground and grows in moments!"),
    })

content.add(content.TerrainTransform { id = "ter_arvore_overgrowth" }
    :terrain {
        flags = { "YOUNG" },
        results = {
            { "t_tree_birch", 32 }, { "t_tree_elm", 32 }, { "t_tree_cottonwood", 32 },
            { "t_tree_basswood", 32 }, { "t_tree_alder", 32 }, { "t_tree_pine", 64 }, { "t_tree_maple", 64 },
            { "t_tree_willow", 64 }, { "t_tree_hickory_harvested", 32 }, { "t_tree_walnut_harvested", 16 },
            { "t_tree_nannyberry_harvested", 16 }, { "t_tree_tupelo_harvested", 16 },
            { "t_tree_butternut", 4 }, { "t_tree_chestnut_harvested", 8 }, { "t_tree_hazelnut_harvested", 2 },
            { "t_tree_beech", 4 }, { "t_tree_blackjack", 8 }, { "t_tree_apple_harvested", 2 },
            { "t_tree_cherry_harvested", 2 }, { "t_tree_juniper", 2 }, { "t_tree_pear_harvested", 2 },
            { "t_tree_plum_harvested", 2 }, { "t_tree_elderberry_harvested", 2 },
            { "t_tree_mulberry_harvested", 2 }, { "t_tree_sassafras", 3 },
        },
        message = ccb.content.text("Wood creaks as the tree's limbs grow and stretch toward the sky."),
    }
    :terrain {
        flags = { "DIGGABLE", "SHRUB" },
        results = {
            { "t_grass", 150 }, { "t_grass_long", 50 }, { "t_grass_tall", 20 }, { "t_shrub", 30 },
            { "t_underbrush", 65 }, { "t_shrub_hobblebush_harvested", 10 },
            { "t_shrub_autumn_olive_harvested", 10 }, { "t_shrub_spicebush_harvested", 10 },
            { "t_shrub_chokeberry_harvested", 10 }, { "t_shrub_rose", 5 },
            { "t_shrub_blackberry_harvested", 5 }, { "t_shrub_grape_harvested", 5 },
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

content.add(content.TerrainTransform { id = "ter_arvore_verdant_tree_transform" }
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
        message = ccb.content.text("The target's limbs begin stretching and spreading toward the sky as their body elongates, and in moments, a tree that could have stood for a hundred years stands in their place."),
    })

content.add(content.TerrainTransform { id = "ter_arvore_living_tent" }
    :terrain {
        flags = { "DIGGABLE" },
        results = { "t_arvore_living_tent" },
        message = ccb.content.text("Vines and brambles rapidly grow from the ground into a small shelter."),
    })

content.add(content.TerrainTransform { id = "ter_bloodthorne_druid_heal_from_spilled_blood" }
    :field {
        inputs = { "fd_blood" },
        results = { "fd_null" },
        message = ccb.content.text("The blood sinks into the ground and vanishes."),
    })

content.add(content.TerrainTransform { id = "ter_changeling_spring_command_grasses" }
    :terrain {
        inputs = { "t_grass_long" },
        results = { { "t_grass_tall", 300 } },
        message = ccb.content.text("The grass grows tall, reaching toward the sky."),
    }
    :terrain {
        inputs = { "t_grass" },
        results = { { "t_grass_long", 300 }, { "t_grass_tall", 75 } },
        message = ccb.content.text("The grass grows tall, reaching toward the sky."),
    }
    :terrain {
        flags = { "DIGGABLE" },
        results = { { "t_grass", 150 }, { "t_grass_long", 300 }, { "t_grass_tall", 30 } },
        message = ccb.content.text("The ground churns as blades of grass push out of the soil."),
    }
    :furniture {
        inputs = { "f_null" },
        results = {
            { "f_null", 300 }, "f_flower_spurge", "f_flower_tulip", "f_bluebell", "f_black_eyed_susan",
            "f_sunflower", "f_dandelion", "f_lily", "f_dahlia",
        },
    })

content.add(content.TerrainTransform { id = "ter_changeling_spring_verdant_vitality" }
    :terrain {
        flags = { "PLOWABLE" },
        results = { "t_grass_dead" },
        message = ccb.content.text("The grass wilts."),
    }
    :terrain {
        inputs = { "t_forestfloor" },
        results = { "t_dirt" },
    })

content.add(content.TerrainTransform { id = "ter_changeling_spring_plant_growth" }
    :terrain {
        inputs = { "t_tree_young" },
        results = {
            { "t_tree_birch", 32 }, { "t_tree_elm", 32 }, { "t_tree_cottonwood", 32 },
            { "t_tree_basswood", 32 }, { "t_tree_alder", 32 }, { "t_tree_pine", 64 }, { "t_tree_maple", 64 },
            { "t_tree_willow", 64 }, { "t_tree_hickory", 32 }, { "t_tree_walnut_harvested", 16 },
            { "t_tree_tupelo_harvested", 16 }, { "t_tree_nannyberry_harvested", 16 },
            { "t_tree_butternut_harvested", 4 }, { "t_tree_chestnut_harvested", 8 },
            { "t_tree_hazelnut_harvested", 2 }, { "t_tree_beech", 4 }, { "t_tree_blackjack", 8 },
            { "t_tree_apple_harvested", 2 }, { "t_tree_cherry_harvested", 2 },
            { "t_tree_juniper_harvested", 2 }, { "t_tree_pear_harvested", 2 }, { "t_tree_plum_harvested", 2 },
            { "t_tree_elderberry_harvested", 2 }, { "t_tree_mulberry_harvested", 2 },
            { "t_tree_sassafras_harvested", 3 },
        },
        message = ccb.content.text("The young tree creaks as its limbs begin growing, first slowly and then with increasing speed.  Roots churn through the soil and leaves stretch toward the sun, and in moments, before you is a tree that could have stood for a human lifetime."),
    }
    :terrain {
        inputs = { "t_grass" },
        results = { "t_grass_long" },
        message = ccb.content.text("Fresh green grass grows longer and longer until it stands as tall as your knees."),
    }
    :terrain {
        inputs = { "t_grass_long" },
        results = { "t_grass_tall" },
        message = ccb.content.text("The tall grass grows and grows until a child could easily hide themselves within it."),
    }
    :furniture {
        inputs = { "f_plant_seedling", "f_plant_seed" },
        results = { "f_plant_mature" },
        message = ccb.content.text("The plant grows in moments, leaves unfurling, roots churning the soil, and flowers opening toward the sun.  Before you even lower your hands, it's fully grown, though not yet ready for the harvest."),
    })

content.add(content.TerrainTransform { id = "ter_changeling_summer_remove_ring_fire" }
    :field {
        inputs = { "fd_fire" },
        results = { "fd_null" },
    })

content.add(content.TerrainTransform { id = "ter_changeling_autumn_plant_harvest" }
    :furniture {
        inputs = { "f_plant_mature" },
        results = { "f_plant_harvest" },
        message = ccb.content.text("The plant's buds swell, fruiting and growing.  Before you even lower your hands, it's ripe and ready for the harvest."),
    })

content.add(content.TerrainTransform { id = "ter_changeling_autumn_clean_nearby_spills" }
    :field {
        inputs = {
            "fd_dust", "fd_mechanical_fluid", "fd_dirty_water", "fd_blood", "fd_bile", "fd_bile_adv",
            "fd_slime", "fd_sap", "fd_blood_veggy", "fd_blood_insect", "fd_blood_invertebrate",
        },
        results = { "fd_null" },
        message = ccb.content.text("Spills and dust on the floor shimmer and disappear."),
    })

content.add(content.TerrainTransform { id = "ter_changeling_winter_close_the_reality_tear" }
    :field {
        inputs = { "fd_fatigue" },
        results = { "fd_null" },
        message = ccb.content.text("The edges of the swirling wound in reality crack like ice over new fallen snow, and then the entire portal shatters into shards of nothingness."),
    }
    :trap {
        inputs = { "tr_portal" },
        results = { "tr_null" },
        message = ccb.content.text("The edges of the swirling wound in reality crack like ice over new fallen snow, and then the entire portal shatters into shards of nothingness."),
    })

content.add(content.TerrainTransform { id = "ter_local_metal_door_opening" }
    :terrain {
        inputs = { "t_door_metal_locked" },
        results = { "t_door_metal_c" },
    })

content.add(content.TerrainTransform { id = "ter_local_computer_shutdown" }
    :furniture {
        inputs = { "f_console" },
        results = { "f_console_broken" },
    })

content.add(content.TerrainTransform { id = "ter_local_metal_door_closing" }
    :terrain {
        inputs = { "t_door_metal_o" },
        results = { "t_door_metal_locked" },
    })

content.add(content.TerrainTransform { id = "ter_hedge_extra_lock_door" }
    :terrain {
        inputs = { "t_door_c" },
        results = { "t_door_locked" },
    }
    :terrain {
        inputs = { "t_door_c_peep" },
        results = { "t_door_locked_peep" },
    }
    :terrain {
        inputs = { "t_door_metal_c" },
        results = { "t_door_metal_locked" },
    })

content.add(content.TerrainTransform { id = "ter_hedge_extinguish_fire_spell" }
    :field {
        inputs = { "fd_fire" },
        results = { "fd_null" },
        message = ccb.content.text("The fire gutters and dies!"),
        message_good = true,
    })

content.add(content.TerrainTransform { id = "ter_homullus_translocate_location_attune" }
    :furniture {
        inputs = { "f_null" },
        results = { "f_homullus_translocator_location" },
        message = ccb.content.text("You close your eyes and listen to the sounds of civilization."),
        message_good = true,
    })

content.add(content.TerrainTransform { id = "ierde_stomp_ground_smash_transform" }
    :terrain {
        inputs = { "t_grass" },
        results = { { "t_grass", 10 }, "t_pit_shallow" },
    }
    :terrain {
        inputs = { "t_grass_long" },
        results = { { "t_grass_long", 10 }, "t_pit_shallow" },
    }
    :terrain {
        inputs = { "t_dirt" },
        results = { { "t_dirt", 10 }, "t_pit_shallow" },
    }
    :terrain {
        inputs = { "t_dirtfloor" },
        results = { { "t_dirtfloor", 10 }, "t_pit_shallow" },
    }
    :terrain {
        inputs = { "t_dirtfloor_no_roof" },
        results = { { "t_dirtfloor_no_roof", 10 }, "t_pit_shallow" },
    }
    :terrain {
        inputs = { "t_dirtmoundfloor" },
        results = { { "t_dirtmoundfloor", 10 }, "t_pit_shallow" },
    }
    :terrain {
        inputs = { "t_dirtmound" },
        results = { { "t_dirtmound", 10 }, "t_pit_shallow" },
    }
    :terrain {
        inputs = { "t_grass_dead" },
        results = { { "t_grass_dead", 10 }, "t_pit_shallow" },
    }
    :terrain {
        inputs = { "t_grass_white" },
        results = { { "t_grass_white", 10 }, "t_pit_shallow" },
    }
    :terrain {
        inputs = { "t_sand" },
        results = { { "t_sand", 10 }, "t_pit_shallow" },
    }
    :terrain {
        inputs = { "t_clay" },
        results = { { "t_clay", 10 }, "t_pit_shallow" },
    }
    :terrain {
        inputs = { "t_sandmound" },
        results = { { "t_sandmound", 10 }, "t_pit_shallow" },
    }
    :terrain {
        inputs = { "t_forestfloor" },
        results = { { "t_forestfloor", 10 }, "t_pit_shallow" },
    }
    :terrain {
        inputs = { "t_grass_tall" },
        results = { { "t_grass_tall", 10 }, "t_pit_shallow" },
    }
    :terrain {
        inputs = { "t_fungus_floor_in" },
        results = { { "t_fungus_floor_in", 10 }, "t_pit_shallow" },
    }
    :terrain {
        inputs = { "t_fungus_floor_sup" },
        results = { { "t_fungus_floor_sup", 10 }, "t_pit_shallow" },
    }
    :terrain {
        inputs = { "t_fungus_floor_out" },
        results = { { "t_fungus_floor_out", 10 }, "t_pit_shallow" },
    }
    :terrain {
        inputs = { "t_sandbox" },
        results = { { "t_sandbox", 10 }, "t_pit_shallow" },
    }
    :terrain {
        inputs = { "t_pit_shallow" },
        results = { { "t_null", 10 }, "t_dirt", "t_pit" },
    }
    :terrain {
        inputs = { "t_pit" },
        results = { { "t_null", 10 }, "t_pit_shallow" },
    }
    :furniture {
        inputs = { "f_null" },
        results = { { "f_null", 15 }, "f_rubble_rock" },
    })

content.add(content.TerrainTransform { id = "ierde_create_pits_transform" }
    :terrain {
        flags = { "DIGGABLE" },
        results = { "t_pit" },
        message = ccb.content.text("The ground opens up!"),
    })

content.add(content.TerrainTransform { id = "ter_ierde_make_destroy_walls" }
    :terrain {
        inputs = { "t_rock_floor", "t_rock_floor_no_roof", "t_railroad_rubble" },
        results = { "t_rock" },
        message = ccb.content.text("The stone rises up into a stone wall."),
    }
    :terrain {
        inputs = { "t_rock" },
        results = { "t_rock_floor" },
        message = ccb.content.text("The stone wall sinks away."),
    }
    :terrain {
        flags = { "DIGGABLE" },
        results = { "t_soil" },
        message = ccb.content.text("The ground rises into a wall of solid earth."),
    }
    :terrain {
        inputs = { "t_soil" },
        results = { "t_dirt" },
        message = ccb.content.text("The solid earth sinks away."),
    }
    :furniture {
        flags = { "TRANSPARENT", "WALL" },
        results = { "f_null" },
    })

content.add(content.TerrainTransform { id = "ter_ierde_make_pits" }
    :terrain {
        inputs = { "t_soil" },
        results = { "t_dirt" },
        message = ccb.content.text("The solid earth sinks away."),
    }
    :terrain {
        flags = { "DIGGABLE" },
        results = { "t_pit" },
        message = ccb.content.text("The ground opens up!"),
    }
    :terrain {
        inputs = { "t_pit" },
        results = { "t_open_air" },
        message = ccb.content.text("The pit deepens!"),
    })

content.add(content.TerrainTransform { id = "ter_ierde_raise_earth" }
    :terrain {
        inputs = { "t_rock_floor", "t_rock_floor_no_roof", "t_railroad_rubble", "t_rock" },
        results = { "t_earthen_stairs_up" },
        message = ccb.content.text("The ground rises up into a set of earthen stairs."),
    }
    :terrain {
        flags = { "DIGGABLE" },
        results = { "t_earthen_stairs_up" },
        message = ccb.content.text("The dirt rises up into a set of earthen stairs."),
    }
    :terrain {
        inputs = { "t_soil" },
        results = { "t_earthen_stairs_up" },
        message = ccb.content.text("The dirt rises up into a set of earthen stairs."),
    }
    :furniture {
        flags = { "TRANSPARENT", "WALL" },
        results = { "f_null" },
    })

content.add(content.TerrainTransform { id = "ter_ierde_lower_earth" }
    :terrain {
        inputs = { "t_rock_floor", "t_rock_floor_no_roof", "t_railroad_rubble", "t_rock" },
        results = { "t_earthen_stairs_down" },
        message = ccb.content.text("The ground sinks down into a set of earthen stairs."),
    }
    :terrain {
        flags = { "DIGGABLE" },
        results = { "t_earthen_stairs_down" },
        message = ccb.content.text("The dirt sinks down into a set of earthen stairs."),
    }
    :terrain {
        inputs = { "t_soil" },
        results = { "t_earthen_stairs_down" },
        message = ccb.content.text("The dirt sinks down into a set of earthen stairs."),
    }
    :furniture {
        flags = { "TRANSPARENT", "WALL" },
        results = { "f_null" },
    })

content.add(content.TerrainTransform { id = "ter_ierde_smoothing_stone" }
    :terrain {
        inputs = { "t_rock" },
        results = { "t_rock_smooth" },
        message = ccb.content.text("All imperfections in the stone are smoothed away."),
    })

content.add(content.TerrainTransform { id = "ter_ierde_churn_earth" }
    :terrain {
        inputs = {
            "t_dirt", "t_dirtfloor", "t_grass", "t_grass_long", "t_grass_tall", "t_grass_dead",
            "t_grass_white", "t_pit_shallow",
        },
        results = { "t_dirtmound" },
        message = ccb.content.text("The ground churns as a long straight furrow suitable for planting appears."),
    })

content.add(content.TerrainTransform { id = "ter_ierde_earth_to_stone" }
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
        results = { "f_rubble_rock" },
        message = ccb.content.text("The pile of dirt hardens into a large pile of stones."),
    })

content.add(content.TerrainTransform { id = "ter_ierde_stone_to_earth" }
    :terrain {
        inputs = { "t_rock_floor", "t_rock_floor_no_roof", "t_railroad_rubble" },
        results = { "t_dirt" },
        message = ccb.content.text("The earth hardens into solid rock."),
    }
    :terrain {
        inputs = { "t_rock" },
        results = { "t_soil" },
        message = ccb.content.text("The earth hardens into solid rock."),
    }
    :furniture {
        inputs = { "f_rubble_rock" },
        results = { "f_dirtmound_shallow" },
        message = ccb.content.text("The loose rock falls apart into a pile of dirt."),
    })

content.add(content.TerrainTransform { id = "ter_ierde_entrap_target_in_stone" }
    :furniture {
        inputs = { "f_null" },
        results = { "f_ierde_lithic_gaol_fang" },
        message = ccb.content.text("Fangs of rock erupt around the target!"),
    })

content.add(content.TerrainTransform { id = "ter_ierde_entrap_target_in_stone_ground_zero" }
    :furniture {
        inputs = { "f_ierde_lithic_gaol_fang" },
        results = { "f_null" },
    })

content.add(content.TerrainTransform { id = "ter_ierde_translocate_location_attune" }
    :furniture {
        inputs = { "f_null" },
        results = { "f_ierde_translocator_location" },
        message = ccb.content.text("You place both hands on the living earth and feel the rhythms of the rock."),
        message_good = true,
    })

-- There has got to be a better way to do the below
content.add(content.TerrainTransform { id = "ter_salamander_fire_drop" }
    :field {
        inputs = {
            "fd_null", "fd_blood", "fd_bile", "fd_gibs_flesh", "fd_gibs_veggy", "fd_web", "fd_web_nostick",
            "fd_slime", "fd_sap", "fd_sludge", "fd_biolum", "fd_smoke", "fd_pollen_triffid", "fd_tear_gas",
            "fd_gas_vent", "fd_fire_vent", "fd_flame_burst", "fd_spotlight", "fd_blood_veggy",
            "fd_blood_insect", "fd_blood_invertebrate", "fd_gibs_insect", "fd_gibs_invertebrate",
            "fd_cigsmoke", "fd_weedsmoke", "fd_cracksmoke", "fd_methsmoke", "fd_relax_gas", "fd_swamp_gas",
            "fd_fog", "fd_fungal_haze", "fd_cold_air1", "fd_cold_air2", "fd_cold_air3", "fd_cold_air4",
            "fd_hot_air1", "fd_hot_air2", "fd_hot_air3", "fd_hot_air4", "fd_smoke_vent", "fd_clairvoyant",
            "fd_churned_earth", "fd_blood_karma", "fd_salamander_heat",
        },
        results = { "fd_fire" },
    })

content.add(content.TerrainTransform { id = "ter_sylph_massive_lightning" }
    :terrain {
        flags = { "ROAD", "FLAT", "DIGGABLE" },
        results = { "t_pit_shallow" },
        message = ccb.content.text("The lightning blasts a crater where it strikes!"),
    }
    :terrain {
        inputs = { "t_pit_shallow" },
        results = { "t_pit" },
        message = ccb.content.text("The lightning blasts a crater where it strikes!"),
    })

content.add(content.TerrainTransform { id = "ter_sylph_translocate_location_attune" }
    :furniture {
        inputs = { "f_null" },
        results = { "f_sylph_translocator_location" },
        message = ccb.content.text("High above the earth, you close your eyes and feel the wind on your face."),
        message_good = true,
    })

content.add(content.TerrainTransform { id = "ter_sylph_clear_the_air" }
    :field {
        inputs = {
            "fd_extinguisher", "fd_smoke", "fd_toxic_gas", "fd_pollen_triffid", "fd_tear_gas", "fd_nuke_gas",
            "fd_gas_vent", "fd_weedsmoke", "fd_cracksmoke", "fd_methsmoke", "fd_relax_gas", "fd_swamp_gas",
            "fd_fungal_haze", "fd_hallucinogenic_spores", "fd_fungicidal_gas", "fd_migo_atmosphere",
            "fd_smoke_vent", "fd_nm_monster_gas_2",
        },
        results = { "fd_null" },
        message = ccb.content.text("The air clears."),
        message_good = true,
    })

content.add(content.TerrainTransform { id = "ter_werewolf_close_reality_tear" }
    :field {
        inputs = { "fd_fatigue" },
        results = { "fd_null" },
        message = ccb.content.text("The rent in reality slowly collapses on itself and fades away."),
    })
