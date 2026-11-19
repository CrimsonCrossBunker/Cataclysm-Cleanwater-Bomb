local ccb = require("ccb")
local content = ccb.content

content.add(content.TerrainTransform { id = "industrial_runoff" }
    :terrain {
        inputs = { "t_snow" },
        results = { "t_polluted_snow", { "t_snow", 2 } },
    })

content.add(content.TerrainTransform { id = "afs_unlock_metal_doors" }
    :terrain {
        inputs = { "t_door_metal_locked" },
        results = { "t_door_metal_c" },
        message = ccb.content.text("The doors unlock."),
    })

-- Used for unlocking all hackable furniture in the mod.
content.add(content.TerrainTransform { id = "afs_multi_unlock" }
    :terrain {
        inputs = { "t_afs_door_metal_elocked" },
        results = { "t_door_metal_c" },
        message = ccb.content.text("The door's PIN pad chimes happily as the locking mechanism releases."),
        message_good = true,
    }
    :terrain {
        inputs = { "t_afs_security_gate_closed" },
        results = { "t_afs_security_door_frame" },
        message = ccb.content.text("The security gate recedes into the ceiling."),
        message_good = true,
    }
    :furniture {
        inputs = { "f_sealed_intermodal_crate" },
        results = { "f_intermodal_crate_open" },
        message = ccb.content.text("The shipping crate bolts slide back and the lid pops open."),
        message_good = true,
    }
    :furniture {
        inputs = { "f_reinforced_displaycase" },
        results = { "f_reinforced_displaycase_o" },
        message = ccb.content.text("A panel of reinforced glass receeds into the case."),
        message_good = true,
    }
    :furniture {
        inputs = { "f_e_safe_l" },
        results = { "f_e_safe_c" },
        message = ccb.content.text("The safe's display chimes happily as the locking mechanism releases."),
        message_good = true,
    })

content.add(content.TerrainTransform { id = "afs_open_cryo_storage" }
    :furniture {
        inputs = { "f_cryo_storage_l" },
        results = { "f_cryo_storage_o" },
        message = ccb.content.text("Vapor hisses out from the cryogenic storage unit as its locking mechanism releases.  Whatever is inside should be recovered before it thaws out."),
        message_good = true,
    })

content.add(content.TerrainTransform { id = "your_ship_dim_lights" }
    :terrain {
        inputs = { "t_ship_floor_heated" },
        results = { "t_ship_floor_heated_low_light" },
    })

content.add(content.TerrainTransform { id = "your_ship_lights_on" }
    :terrain {
        inputs = { "t_ship_floor_heated_low_light" },
        results = { "t_ship_floor_heated" },
    })

content.add(content.TerrainTransform { id = "your_ship_stairs_up" }
    :terrain {
        inputs = { "t_ship_stairs_down" },
        results = { "t_ship_stairs_down_retracted" },
    })

content.add(content.TerrainTransform { id = "your_ship_stairs_down" }
    :terrain {
        inputs = { "t_ship_stairs_down_retracted" },
        results = { "t_ship_stairs_down" },
    })

content.add(content.TerrainTransform { id = "your_ship_ramp_up" }
    :terrain {
        inputs = { "t_bay_rap_down" },
        results = { "t_afs_ship_retracted_bay_ramp" },
    }
    :terrain {
        inputs = { "t_open_air_bay" },
        results = { "t_afs_ship_retracted_bay_ramp_air" },
    })

content.add(content.TerrainTransform { id = "your_ship_ramp_down" }
    :terrain {
        inputs = { "t_afs_ship_retracted_bay_ramp" },
        results = { "t_bay_rap_down" },
    }
    :terrain {
        inputs = { "t_afs_ship_retracted_bay_ramp_air" },
        results = { "t_open_air_bay" },
    })

-- Used for generic critical failures on furniture that doesn't define custom behavior.
content.add(content.TerrainTransform { id = "afs_multi_lockdown" }
    :terrain {
        inputs = { "t_afs_door_metal_elocked" },
        results = { "t_door_metal_locked" },
        message = ccb.content.text("The door's PIN pad chimes unhappily before powering down."),
    }
    :furniture {
        inputs = { "f_sealed_intermodal_crate" },
        results = { "f_sealed_intermodal_crate_locked" },
        message = ccb.content.text("The shipping crate beeps unhappily before powering down."),
    }
    :furniture {
        inputs = { "f_e_safe_l" },
        results = { "f_e_safe_l_down" },
        message = ccb.content.text("The safe beeps unhappily before powering down."),
    }
    :furniture {
        inputs = { "f_security_panel", "f_security_panel_10" },
        results = { "f_security_panel_locked" },
        message = ccb.content.text("You trip the security failsafe and the panel fries its own electronics."),
    }
    :furniture {
        inputs = { "f_reinforced_displaycase" },
        results = { "f_reinforced_displaycase_locked" },
        message = ccb.content.text("The display case beeps unhappily before powering down."),
    })

content.add(content.TerrainTransform { id = "afs_computer_off" }
    :furniture {
        inputs = { "f_console" },
        results = { "f_console_broken" },
        message = ccb.content.text("The console shuts down."),
    })

content.add(content.TerrainTransform { id = "transform_gratings" }
    :terrain {
        inputs = { "t_prison_grate" },
        results = { "t_prison_grate_r" },
        message = ccb.content.text("The grating retracts into the floor and ceiling."),
    })

content.add(content.TerrainTransform { id = "engine_overload_transform" }
    :terrain {
        inputs = { "t_afs_gun_ship_engine_console" },
        results = { "t_afs_gun_ship_engine_console_burnt" },
    })

content.add(content.TerrainTransform { id = "afs_lights_on" }
    :terrain {
        inputs = { "t_metal_floor_olight_inactive" },
        results = { "t_metal_floor_olight" },
    }
    :terrain {
        inputs = { "t_linoleum_white_olight_inactive" },
        results = { "t_linoleum_whitefloor_olight" },
    }
    :terrain {
        inputs = { "t_thconc_floor_olight_inactive" },
        results = { "t_thconc_floor_olight" },
    })

content.add(content.TerrainTransform { id = "afs_lights_off" }
    :terrain {
        inputs = { "t_metal_floor_olight" },
        results = { "t_metal_floor_olight_inactive" },
    }
    :terrain {
        inputs = { "t_linoleum_whitefloor_olight" },
        results = { "t_linoleum_white_olight_inactive" },
    })

content.add(content.TerrainTransform { id = "afs_deadify_plants" }
    :terrain {
        inputs = {
            "t_tree", "t_tree_young", "t_tree_blackjack", "t_tree_alder", "t_tree_basswood",
            "t_tree_cottonwood", "t_tree_elm", "t_tree_pine", "t_tree_birch", "t_tree_willow",
            "t_tree_walnut", "t_tree_butternut", "t_tree_chestnut", "t_tree_beech", "t_tree_hazelnut",
            "t_tree_apple", "t_tree_crabapple", "t_tree_pear", "t_tree_coffee", "t_tree_cherry",
            "t_tree_juniper", "t_tree_peach", "t_tree_apricot", "t_tree_plum", "t_tree_mulberry",
            "t_tree_elderberry", "t_tree_maple", "t_tree_hickory", "t_tree_pistachio", "t_tree_almond",
            "t_tree_pecan", "t_tree_sassafras", "t_underbrush", "t_shrub", "t_fern", "t_shrub_rose",
            "t_shrub_hydrangea", "t_shrub_lilac", "t_shrub_peanut", "t_shrub_blueberry", "t_shrub_strawberry",
            "t_shrub_blackberry", "t_shrub_huckleberry", "t_shrub_raspberry", "t_shrub_grape", "t_grass",
            "t_grass_tall",
        },
        results = { "t_dirt" },
    }
    :terrain {
        inputs = { "t_water_sh", "t_water_dp", "t_water_pool_outdoors" },
        results = { "t_ice" },
    }
    :furniture {
        inputs = {
            "f_dandelion", "f_maianthemum_stellatum", "f_salsify", "f_chamomile", "f_flower_tulip",
            "f_flower_spurge", "f_sunflower", "f_jerusalem_artichoke", "f_lily", "f_bluebell", "f_dahlia",
            "f_chicory", "f_datura", "f_mustard", "f_wild_sarsaparilla", "f_fireweed", "f_selfheal",
            "f_purple_loosestrife",
        },
        results = { "f_null" },
    })
