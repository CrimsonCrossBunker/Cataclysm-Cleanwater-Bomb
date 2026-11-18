local content = require("ccb").content

do
    -- Tools commonly used by blacksmiths
    local group = content.ItemGroup { id = "tools_blacksmith", kind = "collection" }
    group:entry {
        distribution = {
            { item = "anvil" },
            { item = "anvil_crude" },
        },
        probability = 30,
    }
    group:item("chisel", 90)
    group:item("crucible", 30)
    group:item("swage", 60)
    group:item("drift", 70)
    group:group("graphite_small_bottle_part", 70)
    group:group("borax_box_part", 90)
    group:item("metal_file", 90)
    group:item("hotcut", 90)
    group:item("metalworking_tongs", 90)
    group:item("hammer", 90)
    group:item("sandpaper", 90)
    group:item("belt_grinder", 50)
    content.add(group)
end

do
    -- Portable tools used for luthier
    local group = content.ItemGroup { id = "tools_luthier", kind = "collection" }
    group:item("luthier_toolset")
    group:entry { item = "tonewood", count = { 1, 6 } }
    group:entry { item = "tuning_pegs", count = { 5, 15 } }
    group:entry { item = "qt_wire", count = { 1, 3 } }
    group:item("hand_drill", 20)
    group:group("glue_strong_professional")
    group:item("chisel", 10)
    group:item("sandpaper")
    content.add(group)
end

do
    -- A typical toolbox filled with tools.
    local group = content.ItemGroup {
        id = "tools_workshop",
        kind = "collection",
        container = "toolbox_workshop_empty",
        overflow = "discard",
    }
    group:item("hammer", 80)
    group:item("screwdriver_set", 65)
    group:item("pliers_locking", 40)
    group:item("big_pliers", 5)
    group:entry {
        distribution = {
            { item = "wrench", probability = 75 },
            { item = "wrench_small", probability = 20 },
            { item = "socket_wrench_set", probability = 20 },
        },
        probability = 60,
    }
    group:item("funnel", 50)
    group:item("metal_file", 40)
    group:item("sandpaper", 65)
    group:item("tape_measure", 90)
    group:entry {
        distribution = {
            { item = "saw", probability = 65 },
            { item = "bow_saw", probability = 40 },
        },
        probability = 40,
    }
    group:entry {
        distribution = {
            { item = "reciprocating_saw", charges = { 0, 500 }, probability = 20 },
            { item = "hacksaw", probability = 30 },
        },
        probability = 40,
    }
    group:group("graphite_small_bottle_part", 30)
    group:item("pin_reamer", 18)
    group:item("clamp", 30)
    group:item("boxcutter", 20)
    group:entry { item = "nailgun", charges = { 0, 20 }, probability = 15 }
    group:entry { item = "circsaw_off", charges = { 0, 500 }, probability = 25 }
    group:entry {
        distribution = {
            { item = "cordless_impact_wrench", charges = { 0, 500 }, probability = 10 },
            { item = "cordless_drill", charges = { 0, 500 }, probability = 20 },
            { item = "corded_powerdrill", probability = 20 },
        },
        probability = 20,
    }
    content.add(group)
end

do
    -- Common tools you might find in a hardware store or in a shop.
    -- More professional/rare than tools_common; less likely to be in a home basement.
    local group = content.ItemGroup { id = "tools_general", kind = "distribution" }
    group:group("tools_common")
    group:group("tools_construction", 50)
    group:group("tools_carpentry")
    group:group("tools_earthworking")
    group:group("tools_electronics", 20)
    group:group("tools_lighting_industrial")
    group:group("tools_mechanic", 2)
    group:group("tools_plumbing", 20)
    group:item("portable_generator", 5)
    group:entry { item = "char_smoker", charges = { 0, 300 }, probability = 5 }
    content.add(group)
end

do
    -- Portable tools for plumbing and pipefitting
    local group = content.ItemGroup { id = "tools_plumbing", kind = "collection" }
    group:entry {
        distribution = {
            { item = "wrench", probability = 200 },
            { item = "wrench_large", probability = 50 },
            { item = "wrench_48", probability = 50 },
        },
    }
    group:entry {
        distribution = {
            { item = "big_pliers", probability = 10 },
            { item = "pliers", probability = 200 },
        },
        probability = 90,
    }
    group:entry {
        distribution = {
            { item = "claw_bar", probability = 2 },
            { item = "crowbar", probability = 10 },
        },
        probability = 10,
    }
    group:entry {
        distribution = {
            { item = "bucket", probability = 50 },
            { item = "bucket_5gal", probability = 50 },
        },
        probability = 50,
    }
    group:entry {
        distribution = {
            { item = "mop", probability = 60 },
            { item = "mop_folded", probability = 40 },
        },
        probability = 50,
    }
    group:item("shovel", 40)
    group:entry {
        distribution = {
            { item = "hammer_sledge", probability = 10 },
            { item = "hammer_sledge_short", probability = 20 },
            { item = "hammer_sledge_engineer", probability = 20 },
            { item = "hammer_sledge_heavy", probability = 10 },
        },
        probability = 20,
    }
    group:entry { item = "spray_can", charges = { 0, 10 } }
    group:entry { item = "permanent_marker", charges = { 0, 500 }, probability = 50 }
    group:item("funnel")
    group:item("vac_mold", 10)
    group:item("polycarbonate_sheet", 50)
    group:item("boltcutters")
    group:item("tin_snips", 30)
    group:entry {
        distribution = {
            { item = "flashlight", charges = { 0, 300 } },
            { item = "heavy_flashlight", charges = { 0, 300 }, probability = 60 },
        },
    }
    group:item("magnifying_glass", 20)
    group:entry {
        distribution = {
            { item = "soldering_iron", probability = 150 },
            { item = "soldering_iron_portable", charges = { 0, 50 }, probability = 150 },
        },
    }
    group:entry { item = "reciprocating_saw", charges = { 0, 500 }, probability = 50 }
    group:entry {
        distribution = {
            { item = "cordless_drill", charges = { 0, 500 } },
            { item = "hand_drill", probability = 10 },
        },
    }
    group:item("pin_reamer", 30)
    group:group("graphite_small_bottle_part", 30)
    group:item("clamp", 10)
    group:item("sandpaper", 90)
    group:item("bench_vise", 15)
    content.add(group)
end

do
    -- Portable tools used by electricians and for electronics repair
    local group = content.ItemGroup { id = "tools_electronics", kind = "collection" }
    group:item("soldering_iron")
    group:entry { item = "soldering_iron_portable", charges = { 0, 50 } }
    group:item("magnifying_glass")
    group:item("voltmeter", 10)
    group:entry { item = "multimeter", charges = { 0, 100 } }
    group:item("recharge_station", 10)
    group:item("vac_mold", 10)
    group:item("polycarbonate_sheet", 50)
    group:item("hand_crank_charger", 4)
    content.add(group)
end

do
    -- Tools used for forcing entry into a building
    local group = content.ItemGroup { id = "tools_entry", kind = "collection" }
    group:item("boltcutters", 30)
    group:entry {
        distribution = {
            { item = "crowbar", probability = 50 },
            { item = "claw_bar", probability = 25 },
            { item = "halligan", probability = 10 },
            { item = "ny_hook", probability = 10 },
            { item = "heavy_crowbar", probability = 10 },
        },
        probability = 60,
    }
    group:entry {
        distribution = {
            { item = "hammer_sledge", probability = 10 },
            { item = "hammer_sledge_short", probability = 20 },
            { item = "hammer_sledge_heavy", probability = 10 },
        },
        probability = 20,
    }
    group:item("pike_pole", 10)
    content.add(group)
end

do
    -- Equipment of any size commonly used by engineers and mechanics
    local group = content.ItemGroup { id = "tools_mechanic", kind = "collection", with_ammo = 100 }
    group:entry {
        distribution = {
            { item = "jack", probability = 80 },
            { item = "jack_small", probability = 80 },
        },
        probability = 80,
    }
    group:item("lug_wrench", 80)
    group:entry {
        collection = {
            { item = "oxy_torch" },
            {
                distribution = {
                    { item = "weldtank", count = { 1, 2 } },
                    { item = "tinyweldtank", count = { 1, 3 } },
                    { item = "smallweldtank", count = { 1, 3 } },
                },
            },
            {
                distribution = {
                    { item = "brazing_rod_bronze", charges = { 500, 1500 }, wrapper = "tube_welding_rod", probability = 75 },
                    { item = "brazing_rod_alloy", charges = { 500, 1500 }, wrapper = "tube_welding_rod", probability = 50 },
                },
            },
        },
        probability = 80,
    }
    group:item("oxy_torch", 60)
    group:entry { item = "weldtank", count = { 1, 2 }, probability = 60 }
    group:entry { item = "smallweldtank", count = { 1, 3 }, probability = 60 }
    group:entry { item = "tinyweldtank", count = { 1, 3 }, probability = 60 }
    group:entry { item = "polisher", charges = { 0, 100 }, probability = 70 }
    group:entry { item = "angle_grinder", charges = { 0, 500 }, probability = 5 }
    group:item("dremel", 15)
    group:item("grinder_cutoff_disc", 2)
    group:item("welder", 10)
    group:entry { item = "small_propane_tank", count = { 1, 5 }, charges = { 1000, 3000 }, probability = 10 }
    group:entry { item = "medium_propane_tank", count = { 1, 3 }, charges = { 5000, 15000 }, probability = 20 }
    group:entry { item = "large_propane_tank", count = { 1, 2 }, charges = { 20000, 60000 }, probability = 15 }
    group:entry { item = "welding_blanket", count = { 0, 1 }, probability = 20 }
    group:entry {
        distribution = {
            { item = "welding_rod_steel", charges = { 1000, 1600 }, wrapper = "tube_welding_rod", probability = 20 },
            { item = "welding_rod_alloy", charges = { 1000, 1600 }, wrapper = "tube_welding_rod", probability = 10 },
            { item = "welding_wire_steel", charges = { 1000, 1600 }, wrapper = "spool_welding", probability = 15 },
            { item = "welding_wire_alloy", charges = { 1000, 1600 }, wrapper = "spool_welding", probability = 5 },
            { item = "brazing_rod_bronze", charges = { 500, 1500 }, wrapper = "tube_welding_rod", probability = 7 },
            { item = "brazing_rod_alloy", charges = { 400, 1200 }, wrapper = "tube_welding_rod", probability = 5 },
        },
    }
    group:item("clamp", 10)
    group:item("goggles_welding", 80)
    group:item("welding_papr_helmet", 40)
    group:group("papr_kit", 20)
    group:item("thread_cutting_set", 40)
    group:group("graphite_small_bottle_part", 40)
    content.add(group)
end

do
    -- Equipment mostly used in tire shops
    local group = content.ItemGroup { id = "tools_tire", kind = "collection", with_ammo = 100 }
    group:item("jack")
    group:item("lug_wrench", 80)
    group:item("jack_small", 80)
    group:group("graphite_small_bottle_part", 50)
    group:item("compressor", 40)
    group:entry {
        distribution = {
            { group = "tools_toolbox", probability = 80 },
            { group = "tools_workshop", probability = 70 },
        },
        probability = 80,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "full_survival_kit", kind = "collection", container = "survival_kit_box" }
    group:item("knife_folding")
    group:item("flint_steel")
    group:item("whistle_multitool")
    group:entry { item = "glowstick", charges = { 1400, 1400 } }
    group:entry { item = "handflare", count = { 4, 4 }, charges = { 300, 300 } }
    group:group("pur_tablets_bottle_plastic_small_50")
    group:item("pocket_survival")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "used_survival_kit", kind = "collection", container = "survival_kit_box" }
    group:item("knife_folding", 40)
    group:item("flint_steel", 50)
    group:item("whistle_multitool", 70)
    group:entry { item = "glowstick", charges = { 1400, 1400 }, probability = 60 }
    group:entry { item = "handflare", count = { 0, 4 }, charges = { 300, 300 } }
    group:group("pur_tablets_bottle_plastic_small_1_50")
    group:item("pocket_survival", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "knife_rambo_full", kind = "collection", container = "knife_rambo" }
    group:item("fishing_hook_basic")
    group:item("needle_steel")
    group:entry { item = "pur_tablets", count = { 3, 3 } }
    group:entry { item = "survival_match", count = { 3, 3 } }
    group:entry { item = "thread_kevlar", charges = { 36, 36 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "knife_rambo_used", kind = "collection", container = "knife_rambo" }
    group:item("fishing_hook_basic", 50)
    group:item("needle_steel", 40)
    group:entry { item = "pur_tablets", count = { 0, 3 }, probability = 50 }
    group:entry { item = "survival_match", count = { 0, 3 }, probability = 50 }
    group:entry { item = "thread_kevlar", charges = { 0, 36 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "knife_rambo_cont", kind = "distribution" }
    group:group("knife_rambo_full", 20)
    group:group("knife_rambo_used", 80)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "full_ipok", kind = "collection", container = "ipok" }
    group:entry { item = "medical_gauze", count = { 3, 3 } }
    group:entry { item = "bandages", count = { 1, 1 } }
    group:item("gloves_medical")
    group:item("tourniquet_upper")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "used_1st_aid", kind = "collection", container = "1st_aid_box" }
    group:group("medical_tape_roll_part", 70)
    group:entry { item = "gloves_medical", count = { 0, 2 } }
    group:group("bottle_otc_painkiller_0_10")
    group:entry { item = "disinfectant", charges = { 0, 5 } }
    group:item("saline", 60)
    group:entry { item = "adhesive_bandages", count = { 0, 16 } }
    group:entry { item = "bandages", count = { 0, 3 } }
    group:entry { item = "medical_gauze", count = { 0, 6 } }
    group:item("booklet_firstaid", 50)
    group:item("scissors_medical", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "full_ifak", kind = "collection", container = "ifak_pouch" }
    group:group("medical_tape_roll_part")
    group:item("tourniquet_upper")
    group:group("quikclot_bag_plastic_5")
    group:entry { item = "bandages", count = { 9, 9 } }
    group:entry { item = "medical_gauze", count = { 3, 3 } }
    group:entry { item = "adhesive_bandages", count = { 3, 3 } }
    group:group("pur_tablets_bottle_plastic_small_0_9")
    group:item("gloves_medical")
    group:item("scissors_medical")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "used_ifak", kind = "collection", container = "ifak_pouch" }
    group:group("medical_tape_roll_part", 20)
    group:item("tourniquet_upper", 20)
    group:group("quikclot_bag_plastic_0_5")
    group:entry { item = "bandages", count = { 0, 9 } }
    group:entry { item = "medical_gauze", count = { 0, 3 } }
    group:entry { item = "adhesive_bandages", count = { 0, 3 } }
    group:group("pur_tablets_bottle_plastic_small_0_9")
    group:item("gloves_medical", 50)
    group:item("scissors_medical", 30)
    content.add(group)
end

do
    -- Tools used for working with guns and ammo
    local group = content.ItemGroup { id = "tools_gunsmith", kind = "collection" }
    group:entry { item = "large_repairkit", charges = { 0, 500 }, probability = 50 }
    group:item("puller")
    group:item("press")
    group:item("arbor_press")
    content.add(group)
end

do
    -- Light sources balanced according to rarity
    local group = content.ItemGroup { id = "tools_lighting", kind = "distribution" }
    group:entry { item = "candle", charges = { 0, 100 }, probability = 70 }
    group:entry { item = "electric_lantern", charges = { 0, 100 }, probability = 20 }
    group:entry { item = "handflare", charges = { 300, 300 }, probability = 50 }
    group:entry { item = "flashlight", charges = { 0, 300 } }
    group:entry { item = "heavy_flashlight", charges = { 0, 300 }, probability = 30 }
    group:entry { item = "gasoline_lantern", charges = { 0, 500 }, probability = 10 }
    group:entry { item = "glowstick", charges = { 1400, 1400 }, probability = 60 }
    group:entry { item = "oil_lamp", charges = { 0, 750 }, probability = 10 }
    group:entry { item = "wearable_light", charges = { 0, 100 }, probability = 15 }
    group:entry { item = "propane_lantern", charges = { 2000, 3000 }, probability = 15 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "toy_radio_car", kind = "collection", container = "rc_car_box" }
    group:item("radiocontrol")
    group:entry { item = "light_minus_battery_cell", count = { 3, 3 }, charges = { 50, 50 } }
    group:item("radio_car")
    group:entry { item = "bubblewrap", count = { 2, 2 } }
    group:item("screwdriver")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fireman_cabinet", kind = "distribution", with_ammo = 100 }
    group:item("extinguisher", 35)
    group:item("sm_extinguisher", 35)
    group:entry {
        collection = {
            { item = "hose" },
            { item = "sm_extinguisher" },
            { item = "fire_ax", probability = 50 },
            { item = "crash_axe", probability = 80 },
            { item = "throw_extinguisher", count = { 3, 5 }, probability = 30 },
        },
        probability = 30,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "hand_tools", kind = "collection" }
    group:entry { item = "flashlight", charges = { 0, 300 }, probability = 35 }
    group:item("wrench", 50)
    group:item("hammer", 40)
    group:item("saw", 50)
    group:item("bow_saw", 40)
    group:item("ax", 20)
    group:item("machete", 15)
    group:item("brush_handaxe", 5)
    group:item("hacksaw", 50)
    group:item("chipper", 60)
    group:item("screwdriver", 35)
    group:item("pin_reamer", 10)
    group:item("metal_file", 10)
    group:item("clamp", 20)
    group:item("dremel", 20)
    group:item("bench_vise", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "power_tools", kind = "distribution" }
    group:entry { item = "chainsaw_off", charges = { 0, 450 }, probability = 10 }
    group:entry { item = "polesaw_off", charges = { 0, 450 }, probability = 10 }
    group:entry { item = "elec_chainsaw_off", charges = { 0, 500 }, probability = 10 }
    group:item("elec_chainsaw_cord_off", 10)
    group:entry { item = "trimmer_off", charges = { 0, 600 }, probability = 40 }
    group:entry { item = "jackhammer", charges = { 0, 1200 }, probability = 50 }
    group:entry { item = "jackhammer_mining", charges = { 0, 1200 }, probability = 10 }
    group:entry { item = "elec_jackhammer", charges = { 0, 1320 }, probability = 50 }
    group:entry { item = "elec_jackhammer_mining", charges = { 0, 1320 }, probability = 10 }
    group:entry { item = "reciprocating_saw", charges = { 0, 500 }, probability = 50 }
    group:entry { item = "cordless_impact_wrench", charges = { 0, 500 }, probability = 30 }
    group:entry { item = "cordless_drill", charges = { 0, 500 }, probability = 20 }
    group:item("corded_powerdrill", 30)
    group:entry { item = "circsaw_off", charges = { 0, 500 }, probability = 10 }
    group:item("dremel", 40)
    group:entry { item = "angle_grinder", charges = { 0, 500 }, probability = 20 }
    group:item("corded_demolition_hammer", 25)
    group:item("grinder_cutoff_disc", 10)
    group:item("grinder_metal_grinding_disc", 10)
    group:entry { item = "masonrysaw_off", charges = { 0, 450 }, probability = 50 }
    group:entry { item = "heavy_masonrysaw_off", charges = { 0, 450 }, probability = 50 }
    group:entry { item = "electric_masonrysaw_off", charges = { 0, 495 }, probability = 50 }
    group:item("belt_grinder", 20)
    content.add(group)
end

do
    -- Axes and saws.
    local group = content.ItemGroup { id = "tools_tree_cutting", kind = "distribution" }
    group:item("ax")
    group:item("hatchet", 120)
    group:entry { item = "chainsaw_off", charges = { 0, 400 }, probability = 80 }
    group:entry { item = "polesaw_off", charges = { 0, 400 }, probability = 75 }
    group:item("saw")
    group:item("bow_saw", 80)
    group:entry { item = "circsaw_off", charges = { 0, 500 }, probability = 50 }
    group:item("circsaw_blade", 10)
    group:entry { item = "elec_chainsaw_off", charges = { 0, 500 }, probability = 35 }
    group:item("elec_chainsaw_cord_off", 35)
    content.add(group)
end

do
    -- Commercially available fishing rods
    local group = content.ItemGroup { id = "tools_fishingrods_commercial", kind = "distribution" }
    group:item("fishing_rod_professional", 2)
    group:item("fishing_rod_2pc_packed", 4)
    group:item("fishing_rod_tele_packed", 3)
    content.add(group)
end

do
    -- Fishing rods with better portability
    local group = content.ItemGroup { id = "tools_fishingrods_portable", kind = "distribution" }
    group:item("fishing_rod_2pc_packed", 3)
    group:item("fishing_rod_tele_packed", 3)
    group:item("plastichoboreel", 1)
    content.add(group)
end

do
    -- Tools that would be found in a tractor.
    local group = content.ItemGroup { id = "tools_tractor", kind = "collection" }
    group:item("wrench", 35)
    group:item("wrench_small", 35)
    group:item("hammer", 20)
    group:item("multitool", 20)
    group:item("pliers_locking", 15)
    group:item("wrench_large", 5)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "pur_tablets_bottle_plastic_small_1_50",
        kind = "collection",
        container = "bottle_plastic_small",
    }
    group:entry { item = "pur_tablets", count = { 1, 50 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "pur_tablets_bottle_plastic_small_0_9",
        kind = "collection",
        container = "bottle_plastic_small",
    }
    group:entry { item = "pur_tablets", count = { 0, 9 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "pur_tablets_bottle_plastic_small_75_100",
        kind = "collection",
        container = "bottle_plastic_small",
    }
    group:entry { item = "pur_tablets", count = { 75, 100 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dynamite_shipment", kind = "collection" }
    group:entry { item = "dynamite", count = { 2, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "superglue_bottles", kind = "distribution" }
    group:item("small_squeeze_tube", 90)
    group:item("bottle_plastic_tiny_glue", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "glue_weak_domestic_full", kind = "distribution" }
    group:entry { item = "glue_weak", charges = { 30, 30 }, container = "bottle_plastic_tiny_glue" }
    group:entry { item = "glue_weak", charges = { 250, 250 }, container = "bottle_plastic_small_glue" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "glue_weak_professional", kind = "distribution" }
    group:entry { item = "glue_weak", charges = { 0, 500 }, container = "bottle_plastic_small_glue" }
    group:entry { item = "glue_weak", charges = { 0, 1000 }, container = "bottle_plastic_glue" }
    group:entry { item = "glue_weak", charges = { 0, 2000 }, container = "bottle_twoliter_glue" }
    group:entry { item = "glue_weak", charges = { 0, 3750 }, container = "jug_plastic_glue" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "glue_weak_professional_full", kind = "distribution" }
    group:entry { item = "glue_weak", charges = { 500, 500 }, container = "bottle_plastic_small_glue" }
    group:entry { item = "glue_weak", charges = { 1000, 1000 }, container = "bottle_plastic_glue" }
    group:entry { item = "glue_weak", charges = { 2000, 2000 }, container = "bottle_twoliter_glue" }
    group:entry { item = "glue_weak", charges = { 3750, 3750 }, container = "jug_plastic_glue" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "glue_strong_domestic_full", kind = "distribution" }
    group:entry { item = "glue_strong", charges = { 4, 4 }, container = "small_squeeze_tube" }
    group:entry { item = "glue_strong", charges = { 30, 30 }, container = "bottle_plastic_tiny_glue" }
    group:entry { item = "glue_strong", charges = { 250, 250 }, container = "bottle_plastic_small_glue" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "glue_strong_professional", kind = "distribution" }
    group:entry { item = "glue_strong", charges = { 0, 500 }, container = "bottle_plastic_small_glue" }
    group:entry { item = "glue_strong", charges = { 0, 1000 }, container = "bottle_plastic_glue" }
    group:entry { item = "glue_strong", charges = { 0, 2000 }, container = "bottle_twoliter_glue" }
    group:entry { item = "glue_strong", charges = { 0, 3750 }, container = "jug_plastic_glue" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "glue_strong_professional_full", kind = "distribution" }
    group:entry { item = "glue_strong", charges = { 500, 500 }, container = "bottle_plastic_small_glue" }
    group:entry { item = "glue_strong", charges = { 1000, 1000 }, container = "bottle_plastic_glue" }
    group:entry { item = "glue_strong", charges = { 2000, 2000 }, container = "bottle_twoliter_glue" }
    group:entry { item = "glue_strong", charges = { 3750, 3750 }, container = "jug_plastic_glue" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "tools_tailor", kind = "collection" }
    group:item("awl_steel", 60)
    group:item("loom_frame", 5)
    group:item("needle_curved", 30)
    group:item("scissors")
    group:entry {
        distribution = {
            { item = "sewing_kit", charges = { 0, -1 }, probability = 120 },
            { item = "tailors_kit", charges = { 0, -1 }, probability = 10 },
        },
    }
    group:item("sewing_machine")
    group:item("shed_stick", 5)
    group:item("electric_spinwheel", 10)
    group:item("knitting_needles", 40)
    group:item("kevlar_shears", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "tools_commercial_tailor", kind = "collection" }
    group:item("awl_steel")
    group:item("needle_curved", 30)
    group:item("scissors")
    group:entry {
        distribution = {
            { item = "sewing_kit", charges = { 0, -1 }, probability = 120 },
            { item = "tailors_kit", charges = { 0, -1 }, probability = 10 },
        },
    }
    group:item("sewing_machine")
    group:item("kevlar_shears", 40)
    content.add(group)
end

do
    -- Portable tools used for carpentry
    local group = content.ItemGroup { id = "tools_carpentry", kind = "collection" }
    group:group("tools_common")
    group:entry { item = "circsaw_off", charges = { 0, 500 } }
    group:entry {
        distribution = {
            { item = "cordless_drill", charges = { 0, 500 }, probability = 80 },
            { item = "corded_powerdrill", probability = 80 },
            { item = "hand_drill", probability = 20 },
        },
        probability = 80,
    }
    group:entry { item = "reciprocating_saw", charges = { 0, 500 }, probability = 80 }
    group:entry { item = "cordless_impact_wrench", charges = { 0, 500 }, probability = 20 }
    group:entry { item = "nailgun", charges = { 0, 20 } }
    group:item("chisel", 10)
    group:entry {
        distribution = {
            { group = "tools_toolbox", probability = 12 },
            { group = "tools_workshop", probability = 5 },
        },
        probability = 20,
    }
    group:item("tape_measure")
    group:item("sandpaper")
    content.add(group)
end

do
    -- Industrial machinery used for construction
    local group = content.ItemGroup { id = "tools_construction", kind = "collection" }
    group:item("con_mix_foldable")
    group:entry { item = "reciprocating_saw", charges = { 0, 500 }, probability = 80 }
    group:entry { item = "cordless_impact_wrench", charges = { 0, 500 }, probability = 20 }
    group:item("metal_smoother", 90)
    group:group("graphite_small_bottle_part", 10)
    group:entry {
        distribution = {
            { item = "elec_jackhammer", charges = { 0, 6600 }, probability = 40 },
            { item = "elec_jackhammer_mining", charges = { 0, 6600 }, probability = 8 },
            { item = "jackhammer", charges = { 0, 1200 }, probability = 40 },
            { item = "jackhammer_mining", charges = { 0, 1200 }, probability = 8 },
            { item = "corded_demolition_hammer", probability = 40 },
        },
        probability = 40,
    }
    group:entry {
        distribution = {
            { group = "tools_toolbox", probability = 20 },
            { group = "tools_workshop", probability = 5 },
        },
        probability = 20,
    }
    group:item("recharge_station", 10)
    group:entry { item = "angle_grinder", charges = { 0, 500 }, probability = 30 }
    group:item("grinder_cutoff_disc", 15)
    group:item("grinder_metal_grinding_disc", 15)
    content.add(group)
end

do
    -- Common household tools
    local group = content.ItemGroup { id = "tools_common", kind = "collection" }
    group:entry {
        distribution = {
            { item = "bucket", probability = 5 },
            { item = "bucket_5gal", probability = 5 },
        },
        probability = 5,
    }
    group:entry {
        distribution = {
            { item = "jerrycan", probability = 10 },
            { item = "jerrycan_big", probability = 10 },
        },
        probability = 10,
    }
    group:item("tape_measure", 25)
    group:item("funnel", 20)
    group:entry {
        distribution = {
            { item = "rake", probability = 15 },
            { item = "rake_plastic", probability = 25 },
        },
        probability = 20,
    }
    group:item("aluminum_stepladder", 5)
    group:entry {
        distribution = {
            { item = "machete", probability = 10 },
            { item = "brush_handaxe", probability = 5 },
        },
        probability = 15,
    }
    group:item("misc_repairkit", 25)
    group:entry {
        distribution = {
            { item = "saw", probability = 60 },
            { item = "bow_saw", probability = 50 },
        },
        probability = 40,
    }
    group:group("tools_common_small", 50)
    content.add(group)
end

do
    -- A typical toolbox filled with tools.
    local group = content.ItemGroup {
        id = "tools_toolbox",
        kind = "collection",
        container = "toolbox_empty",
        overflow = "discard",
    }
    group:item("hammer", 80)
    group:entry {
        distribution = {
            { item = "screwdriver", probability = 80 },
            { item = "screwdriver_set", probability = 50 },
            { item = "socket_screwdriver_set", probability = 10 },
        },
        probability = 65,
    }
    group:item("pliers_locking", 40)
    group:entry {
        distribution = {
            { item = "wrench", probability = 20 },
            { item = "wrench_small", probability = 20 },
            { item = "socket_wrench_set", probability = 20 },
        },
        probability = 20,
    }
    group:item("hand_pump", 1)
    group:item("funnel", 20)
    group:item("metal_file", 40)
    group:group("graphite_small_bottle_part", 50)
    group:item("tape_measure", 70)
    group:item("sandpaper", 65)
    content.add(group)
end

do
    -- Portable tools for earthworking or farming
    local group = content.ItemGroup { id = "tools_earthworking", kind = "collection" }
    group:item("ax", 80)
    group:item("hatchet")
    group:item("bucket_5gal", 40)
    group:entry {
        distribution = {
            { item = "chainsaw_off", charges = { 0, 450 }, probability = 30 },
            { item = "elec_chainsaw_off", charges = { 0, 500 }, probability = 30 },
            { item = "polesaw_off", charges = { 0, 450 }, probability = 10 },
        },
        probability = 20,
    }
    group:item("g_shovel", 40)
    group:item("hand_drill", 20)
    group:item("hoe", 60)
    group:item("pickaxe", 80)
    group:item("pitchfork", 60)
    group:entry { item = "trimmer_off", charges = { 0, 600 }, probability = 20 }
    group:item("scythe", 40)
    group:item("shovel")
    group:item("sickle", 40)
    group:item("machete", 25)
    group:item("hose_garden", 20)
    group:entry {
        distribution = {
            { item = "brush_handaxe", probability = 15 },
            { item = "brush_axe", probability = 10 },
            { item = "brush_pole", probability = 5 },
        },
        probability = 15,
    }
    group:entry {
        distribution = {
            { item = "rake", probability = 20 },
            { item = "rake_plastic", probability = 40 },
        },
        probability = 30,
    }
    group:entry {
        distribution = {
            { item = "shovel_snow", probability = 20 },
            { item = "shovel_snow_plastic", probability = 40 },
        },
        probability = 30,
    }
    group:entry {
        distribution = {
            { item = "shears", probability = 40 },
            { item = "forged_shears", probability = 40 },
        },
        probability = 40,
    }
    content.add(group)
end

do
    -- Tools commonly found in the home or other domestic settings
    local group = content.ItemGroup { id = "tools_home", kind = "distribution" }
    group:group("tools_common")
    group:group("tools_lighting", 50)
    group:group("tools_tailor", 50)
    group:group("tools_toolbox", 4)
    group:group("tools_workshop", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "full_1st_aid", kind = "collection", container = "1st_aid_box" }
    group:group("medical_tape_roll_part")
    group:entry { item = "gloves_medical", count = { 2, 2 } }
    group:group("bottle_otc_painkiller_10")
    group:item("disinfectant")
    group:item("saline")
    group:entry { item = "adhesive_bandages", count = { 16, 16 } }
    group:entry { item = "bandages", count = { 3, 3 } }
    group:entry { item = "medical_gauze", count = { 6, 6 } }
    group:item("booklet_firstaid")
    group:item("scissors_medical")
    content.add(group)
end

do
    -- Light sources used as industrial working equipment.
    local group = content.ItemGroup { id = "tools_lighting_industrial", kind = "collection" }
    group:entry { item = "flashlight", charges = { 0, 300 } }
    group:entry { item = "heavy_flashlight", charges = { 0, 300 }, probability = 40 }
    group:entry { item = "wearable_light", charges = { 0, 100 }, probability = 60 }
    content.add(group)
end

do
    -- Practical, small and light-weight tools for survival excluding camping gear.
    local group = content.ItemGroup { id = "tools_survival", kind = "collection" }
    group:item("binoculars", 30)
    group:item("canteen", 15)
    group:item("e_tool", 10)
    group:entry {
        collection = {
            { item = "flaregun" },
            { item = "signal_flare", count = { 1, 3 } },
        },
        probability = 20,
    }
    group:entry { item = "handflare", charges = { 300, 300 }, probability = 20 }
    group:item("hatchet", 10)
    group:entry {
        distribution = {
            { item = "knife_hunting", probability = 10 },
            { group = "knife_rambo_cont", probability = 10 },
            { item = "knife_swissarmy", probability = 5 },
            { item = "knife_trench", probability = 10 },
        },
        probability = 10,
    }
    group:item("mess_kit", 20)
    group:entry { item = "portable_stove", sealed = false, container = "nylon_bag", probability = 2 }
    group:item("multitool", 5)
    group:entry {
        distribution = {
            { item = "pockknife", probability = 50 },
            { item = "knife_folding", probability = 30 },
            { item = "utility_knife_folding", probability = 2 },
        },
        probability = 50,
    }
    group:group("pur_tablets_bottle_plastic_small_75_100", 10)
    group:entry { item = "ref_lighter", charges = { 0, 50 }, probability = 20 }
    group:entry {
        collection = {
            { item = "ref_lighter_butane" },
            { item = "butane_can", charges = { 350, 400 } },
        },
        probability = 5,
    }
    group:entry { item = "sm_extinguisher", charges = { 10, 10 }, probability = 20 }
    group:item("whistle", 20)
    group:item("hand_crank_charger", 15)
    group:item("flint_steel", 5)
    group:entry { item = "tinderbox", charges = { 0, 100 }, probability = 2 }
    group:item("whistle_multitool", 1)
    group:item("chem_hexamine", 10)
    group:entry { item = "esbit_stove", charges = { 0, 50 }, probability = 15 }
    group:item("lifestraw", 3)
    group:item("light_snare_kit", 3)
    group:entry { item = "propane_lantern", charges = { 2000, 3000 }, probability = 15 }
    group:entry { item = "propane_cooker", charges = { 2000, 3000 }, probability = 15 }
    group:item("camping_multitool", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "glue_weak_domestic", kind = "distribution" }
    group:entry { item = "glue_weak", charges = { 0, 30 }, container = "bottle_plastic_tiny_glue" }
    group:entry { item = "glue_weak", charges = { 0, 250 }, container = "bottle_plastic_small_glue" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "glue_strong_domestic", kind = "distribution" }
    group:entry { item = "glue_strong", charges = { 0, 4 }, container = "small_squeeze_tube" }
    group:entry { item = "glue_strong", charges = { 0, 30 }, container = "bottle_plastic_tiny_glue" }
    group:entry { item = "glue_strong", charges = { 0, 250 }, container = "bottle_plastic_small_glue" }
    content.add(group)
end
