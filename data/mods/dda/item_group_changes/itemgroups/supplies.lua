local content = require("ccb").content

do
    -- Parts for electronics crafting or repair
    local group = content.ItemGroup { id = "supplies_electronics", kind = "distribution" }
    group:entry {
        collection = {
            { group = "cable_roll", count = { 1, 2 }, probability = 40 },
            { group = "cable_roll_part" },
        },
        probability = 60,
    }
    group:entry {
        collection = {
            { group = "copper_wire_roll", count = { 1, 2 }, probability = 40 },
            { group = "copper_wire_roll_part" },
        },
        probability = 40,
    }
    group:item("voltmeter", 40)
    group:entry { item = "multimeter", charges = { 0, 100 }, probability = 40 }
    group:entry { item = "emf_detector", charges = { 0, 100 }, probability = 20 }
    group:item("light_detector", 5)
    group:item("amplifier", 40)
    group:item("antenna", 40)
    group:item("nuts_bolts", 15)
    group:group("ammo_any_batteries_full")
    group:group("batteries", 60)
    group:item("power_supply", 20)
    group:item("processor", 20)
    group:item("solar_cell", 10)
    group:group("solder_wire_spool_part", 60)
    group:item("RAM", 20)
    group:item("radiocontrol", 10)
    group:item("receiver", 30)
    group:item("transponder", 30)
    group:item("light_bulb", 60)
    group:item("lightstrip_inactive", 60)
    group:item("compressor", 10)
    group:item("hd_compressor", 2)
    group:item("magnet", 5)
    group:item("motor_small", 10)
    group:item("motor_tiny", 30)
    group:item("motor_micro", 40)
    group:item("extension_cable", 45)
    group:item("jumper_cable", 15)
    group:item("jumper_cable_heavy", 5)
    group:item("recharge_station", 20)
    group:item("hand_crank_charger", 30)
    group:item("polycarbonate_sheet", 15)
    group:item("vac_mold", 3)
    content.add(group)
end

do
    -- large quantities of common building supplies.
    local group = content.ItemGroup { id = "hardware_bulk", kind = "distribution" }
    group:entry { item = "2x4", count = { 5, 20 } }
    group:entry { item = "plank_short", count = { 5, 25 }, probability = 60 }
    group:entry { item = "plank_long", count = { 2, 8 }, probability = 40 }
    group:entry { item = "wood_beam", count = { 1, 5 }, probability = 50 }
    group:entry { item = "wooden_post", count = { 5, 20 }, probability = 85 }
    group:entry { item = "wooden_post_long", count = { 2, 10 }, probability = 35 }
    group:entry { item = "wooden_post_short", count = { 5, 25 }, probability = 60 }
    group:entry { item = "wood_sheet", count = { 1, 4 }, probability = 50 }
    group:entry { item = "wood_panel", count = { 1, 8 }, probability = 60 }
    group:entry { item = "wood_block", count = { 5, 20 } }
    group:entry { item = "rock", count = { 10, 20 }, probability = 70 }
    group:entry { item = "coal_lump", count = { 10, 200 }, probability = 20 }
    group:entry { item = "material_cement", charges = { 500, 500 }, wrapper = "bag_canvas" }
    group:entry { item = "material_sand", charges = { 500, 500 }, wrapper = "bag_canvas" }
    group:group("sandbag", 80)
    group:entry { item = "material_gravel", charges = { 500, 500 }, wrapper = "bag_canvas" }
    group:item("material_shrd_limestone", 70)
    group:group("fertilizer_commercial_bag_canvas_60")
    group:entry { group = "styrofoam_sheet_pack", count = { 1, 4 }, probability = 30 }
    group:group("quicklime_bag", 70)
    group:group("quicklime_barrel", 5)
    group:entry { group = "concrete_bag", count = { 3, 7 } }
    group:entry { group = "cement_bag", count = { 1, 3 } }
    group:entry { item = "nuts_bolts", count = { 250, 400 }, wrapper = "box_small", probability = 60 }
    group:item("rope_6", 10)
    group:item("sheet_metal", 10)
    group:item("sheet_metal_small", 10)
    group:entry { item = "plastic_sheet", count = { 5, 10 }, wrapper = "box_small", probability = 30 }
    group:entry { item = "polycarbonate_sheet", count = { 3, 12 }, probability = 20 }
    group:entry { item = "rebar", count = { 5, 10 }, probability = 40 }
    group:entry { item = "brick", count = { 5, 10 }, probability = 40 }
    group:entry { item = "pipe", count = { 5, 10 }, probability = 40 }
    group:entry { item = "pipe_cpvc", count = { 20, 40 }, probability = 60 }
    group:entry { item = "lc_wire", count = { 5, 10 }, probability = 40 }
    group:entry { item = "screen_mesh", count = { 5, 10 }, probability = 40 }
    group:entry { item = "spike", count = { 5, 10 }, probability = 40 }
    group:entry { group = "nail_box_1lb_full", count = { 12, 24 }, probability = 95 }
    group:entry { group = "nail_box_5lb_full", count = { 1, 10 }, probability = 80 }
    group:entry { group = "nail_box_10lb_full", count = { 1, 10 }, probability = 75 }
    group:entry { group = "nail_box_15lb_full", count = { 1, 10 }, probability = 70 }
    group:entry { group = "nail_box_1lb", count = { 6, 24 }, probability = 95 }
    group:entry { group = "nail_box_5lb", count = { 1, 10 }, probability = 90 }
    group:entry { group = "nail_box_10lb", count = { 1, 10 }, probability = 85 }
    group:entry { group = "nail_box_15lb", count = { 1, 10 }, probability = 80 }
    group:entry { item = "hinge", count = { 5, 10 }, probability = 60 }
    group:entry { item = "tempered_glass_sheet", count = { 5, 20 }, probability = 30 }
    group:entry { item = "rigid_plastic_sheet", count = { 5, 20 }, probability = 30 }
    group:entry { item = "steel_section_long", count = { 5, 20 }, probability = 20 }
    group:entry { item = "steel_section_short", count = { 5, 20 }, probability = 20 }
    content.add(group)
end

do
    -- General purpose supplies for building / blue collar work.
    -- Stuff you might find in a jobsite, a hardware store, or a home workshop.
    local group = content.ItemGroup { id = "supplies_hardware", kind = "distribution" }
    group:entry { item = "nuts_bolts", count = { 400, 400 }, wrapper = "box_small", probability = 80 }
    group:entry { item = "brazing_rod_bronze", charges = { 1500, 1500 }, wrapper = "tube_welding_rod", probability = 15 }
    group:entry { item = "welding_rod_steel", charges = { 1500, 1500 }, wrapper = "tube_welding_rod", probability = 20 }
    group:entry { item = "welding_wire_steel", charges = { 1500, 1500 }, wrapper = "spool_welding", probability = 20 }
    group:group("concrete_bag_any", 40)
    group:group("cement_bag_any", 50)
    group:group("sandbag_any", 50)
    group:group("gravelbag_any", 50)
    group:entry {
        collection = {
            {
                distribution = {
                    { item = "rope_30", probability = 70 },
                    { item = "chain", probability = 30 },
                },
                probability = 75,
            },
            { item = "block_and_tackle" },
        },
        probability = 15,
    }
    group:entry { item = "rebar", count = { 5, 10 }, probability = 20 }
    group:entry { item = "brick", count = { 5, 10 }, probability = 20 }
    group:entry { group = "wrapped_gasmask_filter", count = { 2, 6 }, probability = 20 }
    group:group("solder_wire_spool_part", 20)
    group:group("glue_weak_professional_full", 15)
    group:group("glue_strong_professional_full", 15)
    group:group("glue_weak_domestic_full", 25)
    group:item("magnet", 10)
    group:item("chain", 20)
    group:item("rope_6", 4)
    group:item("rope_30", 35)
    group:item("circsaw_blade", 8)
    group:item("glass_sheet", 5)
    group:item("box_small_folded", 10)
    group:item("box_medium_folded", 10)
    group:item("box_large_folded", 10)
    group:item("box_oversize_folded", 10)
    group:item("plastic_sheet", 15)
    group:entry { item = "plastic_sheet", count = { 5, 10 }, wrapper = "box_small", probability = 15 }
    group:entry { item = "pipe", count = { 5, 10 }, probability = 20 }
    group:entry { item = "polycarbonate_sheet", count = { 1, 3 }, probability = 10 }
    group:item("vac_mold", 3)
    group:entry { group = "nail_box_1lb_full", count = { 1, 12 }, probability = 90 }
    group:entry { group = "nail_box_5lb_full", count = { 1, 3 }, probability = 80 }
    group:entry { group = "nail_box_10lb_full", count = { 1, 3 }, probability = 75 }
    group:entry { group = "nail_box_15lb_full", count = { 1, 3 }, probability = 70 }
    group:entry { group = "nail_box_1lb", count = { 1, 12 }, probability = 95 }
    group:entry { group = "nail_box_5lb", count = { 1, 3 }, probability = 90 }
    group:entry { group = "nail_box_10lb", count = { 1, 3 }, probability = 85 }
    group:entry { group = "nail_box_15lb", count = { 1, 2 }, probability = 80 }
    group:item("hose", 15)
    group:item("string_36", 40)
    group:entry { item = "22_blank", count = { 1, 4 }, probability = 30 }
    group:item("frame", 20)
    group:item("hdframe", 10)
    group:item("metal_tank", 10)
    group:item("screen_mesh", 10)
    group:item("metal_tank_little", 10)
    group:item("water_faucet", 10)
    group:item("wood_panel", 10)
    group:entry { item = "lc_wire", count = { 1, 10 }, probability = 50 }
    group:entry { item = "wire_barbed", count = { 1, 10 }, probability = 20 }
    group:group("duct_tape_roll", 60)
    group:item("compressor", 5)
    group:item("foot_crank", 10)
    group:item("spray_can", 50)
    group:item("nitrogen_membrane_filter", 1)
    group:item("hd_pipe", 5)
    group:item("hd_pipe_fittings", 5)
    group:item("hd_valve", 5)
    group:entry { item = "gasket_plastic", count = { 1, 3 }, probability = 5 }
    group:item("pressure_gauge", 5)
    group:item("pyrometer", 2)
    group:item("hd_compressor", 1)
    group:item("large_pressure_vessel", 1)
    group:item("small_pressure_vessel", 1)
    group:item("bearing", 1)
    group:group("writing_utensils", 25)
    group:item("cu_pipe", 50)
    group:item("fungicide", 5)
    group:group("insecticide_bag_plastic", 5)
    group:group("charcoal_bag_part", 5)
    group:group("box_of_batteries_unopened", 25)
    group:group("ammo_heavy_batteries_full", 25)
    group:item("solar_cell", 5)
    group:group("fertilizer_commercial_bag_canvas_60", 30)
    group:group("styrofoam_sheet_pack", 15)
    group:item("chem_sulphuric_acid", 30)
    group:item("chem_muriatic_acid", 35)
    group:item("peephole", 25)
    group:group("chromiumoxide_small_bottle_part", 5)
    group:group("zincpowder_small_bottle_part", 5)
    group:item("denat_alcohol", 3)
    group:item("methed_alcohol", 2)
    group:item("lamp_oil", 25)
    group:item("recharge_station", 10)
    group:item("tarp", 15)
    group:item("tempered_glass_sheet", 25)
    group:item("rigid_plastic_sheet", 30)
    group:item("gas_forge", 15)
    group:entry { item = "chem_turpentine", charges = { 20, -1 }, probability = 20 }
    group:entry { item = "silicone", charges = { 29, -1 }, sealed = true, container = "squeeze_tube", probability = 15 }
    group:entry { item = "silicone", charges = { 8, -1 }, sealed = true, container = "squeeze_tube_small", probability = 35 }
    content.add(group)
end

do
    -- General laboratory reagents and expendibles.  This list contains most conceivable chemicals in the game.  More specific lists for each type of lab would be reasonable eventually.
    local group = content.ItemGroup { id = "supplies_reagents_lab", kind = "distribution" }
    group:entry { item = "water_clean", charges = { 1, -1 }, sealed = false, container = "bottle_plastic", probability = 90 }
    group:entry { item = "salt_water", charges = { 1, -1 }, probability = 20 }
    group:group("detergent_small_box_part", 10)
    group:group("borax_box_part", 10)
    group:group("bleach_jug_part", 10)
    group:entry { item = "ammonia_liquid", charges = { 6, -1 }, probability = 20 }
    group:group("ammonia_hydroxide_bottle_twoliter_part", 10)
    group:group("iodine_bottle_plastic_pill_supplement_1_10", 10)
    group:group("oxy_powder_bottle_part", 10)
    group:item("ash", 5)
    group:group("lye_powder_bottle_part", 10)
    group:group("magnesiumpowder_small_bag_part", 10)
    group:group("charcoal_bag_part", 10)
    group:group("chem_sulphur_bottle_plastic_small_100_inf", 10)
    group:item("chunk_sulfur", 5)
    group:item("chem_aluminium_powder", 10)
    group:item("chem_aluminium_sulphate", 10)
    group:item("chem_saltpetre", 10)
    group:group("redphosphorus_small_bottle_part", 5)
    group:group("whitephosphorus_small_bottle_part", 5)
    group:entry { item = "bismuth", charges = { 1, -1 }, probability = 5 }
    group:entry { item = "chem_benzene", charges = { 1, -1 }, probability = 10 }
    group:entry { item = "chem_toluene", charges = { 1, -1 }, probability = 10 }
    group:entry { item = "chem_antimony_trichloride", count = { 1, -1 }, probability = 2 }
    group:entry { item = "chem_ferric_chloride", count = { 1, -1 }, probability = 15 }
    group:entry { item = "chem_nickel_powder", count = { 1, -1 }, probability = 5 }
    group:entry { item = "chem_slaked_lime", count = { 1, -1 }, sealed = false, wrapper = "bag_plastic", probability = 5 }
    group:entry { item = "chem_baking_soda", charges = { 1, -1 }, probability = 10 }
    group:entry { item = "chem_washing_soda", charges = { 1, -1 }, probability = 10 }
    group:item("chem_calcium_chloride", 5)
    group:entry { item = "chem_nitric_acid", charges = { 1, -1 }, probability = 10 }
    group:entry { item = "chem_sulphuric_acid", charges = { 1, -1 }, probability = 10 }
    group:entry { item = "chem_muriatic_acid", charges = { 1, -1 }, probability = 10 }
    group:entry { item = "chem_acetic_acid", charges = { 1, -1 }, probability = 10 }
    group:entry { item = "chem_formaldehyde", charges = { 1, -1 }, probability = 10 }
    group:entry { item = "chem_acetone", charges = { 1, -1 }, probability = 10 }
    group:group("calciumcarbide_small_bottle_part", 10)
    group:group("calciumcarbonate_small_bottle_part", 10)
    group:entry { item = "mercury", charges = { 100, -1 }, probability = 10 }
    group:entry { item = "chem_sodium", charges = { 100, -1 }, probability = 10 }
    group:entry { item = "chem_potassium", charges = { 100, -1 }, probability = 10 }
    group:item("chem_ammonium_nitrate", 10)
    group:group("chromiumoxide_small_bottle_part", 10)
    group:group("zincpowder_small_bottle_part", 10)
    group:group("manganesedioxide_small_bottle_part", 10)
    group:entry { item = "chem_hydrogen_peroxide_conc", charges = { 1, -1 }, probability = 10 }
    group:item("material_rocksalt", 2)
    group:entry { item = "ether", charges = { 100, -1 }, probability = 10 }
    group:entry { item = "denat_alcohol", charges = { 250, -1 }, probability = 6 }
    group:entry { item = "methed_alcohol", charges = { 250, -1 }, probability = 4 }
    group:entry { item = "chem_DMSO", charges = { 100, -1 }, probability = 10 }
    group:entry { item = "chem_phenol", charges = { 100, -1 }, probability = 10 }
    group:entry { item = "chem_glycerol", charges = { 10, -1 }, probability = 10 }
    group:group("chem_peptone_broth_bottle_plastic_small_1_inf", 10)
    group:group("chem_agar_bottle_plastic_small_1_inf", 10)
    group:group("chem_acrylamide_bottle_glass_1_inf", 10)
    group:entry { item = "oxygen_tank", charges = { 24, 24 }, probability = 6 }
    group:entry { item = "nitrogen_tank", charges = { 12, 24 }, probability = 7 }
    group:entry { item = "hydrogen_tank", charges = { 12, 24 }, probability = 8 }
    group:entry { item = "polycarbonate_sheet", count = { 1, 30 }, probability = 7 }
    group:group("salt_bag_plastic", 10)
    group:group("sugar_bag_plastic", 10)
    group:group("ethanol_bottle_liter_part", 10)
    group:item("oxygen_cylinder", 8)
    group:group("chem_citric_acid_bottle_glass_100_inf", 16)
    group:group("ethanol_bottle_liter_part", 10)
    group:entry { item = "chem_turpentine", charges = { 20, -1 }, probability = 10 }
    group:group("lye_bottle_twoliter_part", 5)
    group:group("lye_potassium_bottle_liter_part", 5)
    content.add(group)
end

do
    -- metal for metalworkers, machine shops, blacksmiths, etc.
    local group = content.ItemGroup { id = "supplies_metal", kind = "distribution" }
    group:item("sheet_metal", 5)
    group:entry { item = "sheet_metal_small", count = { 2, 4 }, probability = 5 }
    group:entry { item = "copper", charges = { 1, 5 }, probability = 10 }
    group:entry { item = "tin", count = { 1, 5 }, probability = 10 }
    group:entry { item = "material_aluminium_ingot", count = { 1, 5 }, probability = 10 }
    group:entry { item = "scrap_copper", count = { 1, 12 }, probability = 5 }
    group:entry { item = "lc_wire", count = { 5, 10 }, probability = 30 }
    group:entry { item = "mc_wire", count = { 1, 5 }, probability = 5 }
    group:entry { item = "hc_wire", count = { 1, 5 }, probability = 5 }
    group:entry { item = "qt_wire", count = { 1, 5 }, probability = 5 }
    group:entry { item = "scrap", count = { 1, 10 }, probability = 70 }
    group:entry { item = "lc_steel_lump", count = { 1, 3 }, probability = 5 }
    group:entry { item = "lc_steel_chunk", count = { 1, 5 }, probability = 15 }
    group:entry { item = "mc_steel_lump", count = { 1, 3 }, probability = 5 }
    group:entry { item = "mc_steel_chunk", count = { 1, 5 }, probability = 15 }
    group:entry { item = "hc_steel_lump", count = { 1, 3 }, probability = 5 }
    group:entry { item = "hc_steel_chunk", count = { 1, 5 }, probability = 15 }
    group:entry { item = "aluminum_bar_round", count = { 1, 25 }, probability = 15 }
    group:entry { item = "lc_steel_bar_round", count = { 1, 25 }, probability = 15 }
    group:entry { item = "mc_steel_bar_round", count = { 1, 15 }, probability = 10 }
    group:entry { item = "hc_steel_bar_round", count = { 1, 10 }, probability = 5 }
    content.add(group)
end

do
    -- General supplies to run a mechanics shop or do mechanical work
    local group = content.ItemGroup { id = "supplies_mechanics", kind = "distribution" }
    group:item("v_airjack_item", 20)
    group:entry {
        collection = {
            {
                distribution = {
                    { item = "rope_30", probability = 50 },
                    { item = "chain", probability = 50 },
                },
                probability = 85,
            },
            { item = "block_and_tackle" },
        },
        probability = 35,
    }
    group:entry { item = "nuts_bolts", count = { 400, 400 }, wrapper = "box_small", probability = 80 }
    group:item("jumper_cable", 15)
    group:item("jumper_cable_heavy", 5)
    group:item("stereo", 25)
    group:item("frame", 20)
    group:item("hd_tow_cable", 5)
    group:item("hdframe", 10)
    group:item("motor", 2)
    group:item("wheel", 10)
    group:entry { item = "polycarbonate_sheet", count = { 1, 3 }, probability = 4 }
    group:entry { item = "seatbelt", count = { 3, 10 }, probability = 10 }
    group:entry { item = "five-point_harness", count = { 2, 4 }, probability = 3 }
    group:entry { group = "glue_weak_professional_full", count = { 3, 9 }, probability = 15 }
    group:item("vac_mold", 1)
    group:item("wheel_wide", 10)
    group:item("wheel_bicycle", 10)
    group:item("wheel_motorbike", 10)
    group:item("wheel_small", 10)
    group:item("wheel_wide_or", 5)
    group:item("wheel_bicycle_or", 5)
    group:item("wheel_motorbike_or", 5)
    group:item("wheel_slick", 5)
    group:item("tire_bicycle", 10)
    group:item("tire_medium", 10)
    group:item("tire_motorbike", 10)
    group:item("tire_wide", 5)
    group:item("tire_wide_or", 5)
    group:item("tire_bicycle_or", 5)
    group:item("tire_motorbike_or", 5)
    group:item("tire_medium_slick", 5)
    group:item("deflated_wheel_bicycle", 10)
    group:item("deflated_wheel", 10)
    group:item("deflated_wheel_motorbike", 10)
    group:item("deflated_wheel_wide_or", 5)
    group:item("deflated_wheel_bicycle_or", 5)
    group:item("deflated_wheel_motorbike_or", 5)
    group:item("deflated_wheel_slick", 5)
    group:item("hand_pump", 10)
    group:item("wheel_rim_medium", 5)
    group:item("wheel_rim_wide", 5)
    group:item("wheel_rim_motorbike", 5)
    group:item("wheel_rim_bicycle", 5)
    group:item("1cyl_combustion", 10)
    group:item("engine_1cyl_diesel_large", 10)
    group:item("v2_combustion", 10)
    group:item("i4_combustion", 10)
    group:item("v6_combustion", 10)
    group:item("i4_diesel", 10)
    group:item("v6_diesel", 10)
    group:item("steam_triple_small", 1)
    group:item("steam_triple_medium", 1)
    group:item("steam_watts_small", 1)
    group:item("aero_engine_light", 1)
    group:item("1cyl_combustion_small", 10)
    group:item("vehicle_controls", 3)
    group:item("horn_car", 10)
    group:item("horn_big", 8)
    group:item("horn_bicycle", 8)
    group:item("v8_combustion", 10)
    group:item("veh_tools_workshop", 1)
    group:item("welder", 1)
    group:item("welding_papr_helmet", 1)
    group:item("soldering_iron", 1)
    group:entry { item = "soldering_iron_portable", charges = { 0, 50 }, probability = 1 }
    group:item("veh_tools_kitchen", 1)
    group:item("hotplate", 1)
    group:item("pan", 1)
    group:item("pot", 1)
    group:item("solar_cell", 5)
    group:item("bearing", 1)
    group:item("headlight_reinforced", 10)
    group:item("motor_large", 1)
    group:item("battery_motorbike", 6)
    group:item("battery_car", 6)
    group:item("alternator_motorbike", 6)
    group:item("alternator_car", 6)
    group:item("alternator_truck", 6)
    group:item("alternator_bicycle", 4)
    group:item("hd_tow_cable", 1)
    group:item("storage_battery", 6)
    group:item("motor_oil")
    group:item("solar_panel", 3)
    group:item("recharge_station", 8)
    group:item("gas_forge", 2)
    group:item("pedal_extenders", 1)
    group:item("hand_controls", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "paint", kind = "distribution" }
    group:entry { item = "paint_red", container_group = "paintcans", probability = 45 }
    group:entry { item = "paint_blue", container_group = "paintcans", probability = 45 }
    group:entry { item = "paint_yellow", container_group = "paintcans", probability = 45 }
    group:entry { item = "paint_green", container_group = "paintcans", probability = 45 }
    group:entry { item = "paint_purple", container_group = "paintcans", probability = 45 }
    group:entry { item = "paint_orange", container_group = "paintcans", probability = 45 }
    group:entry { item = "paint_pink", container_group = "paintcans", probability = 45 }
    group:entry { item = "paint_cyan", container_group = "paintcans", probability = 45 }
    group:entry { item = "paint_brown", container_group = "paintcans", probability = 45 }
    group:entry { item = "paint_white", container_group = "paintcans", probability = 45 }
    group:entry { item = "paint_black", container_group = "paintcans", probability = 45 }
    group:entry { item = "paint_gray", container_group = "paintcans", probability = 45 }
    group:item("chipper", 55)
    group:item("paint_brush", 55)
    group:entry { item = "chem_turpentine", charges = { 20, -1 }, probability = 45 }
    content.add(group)
end
