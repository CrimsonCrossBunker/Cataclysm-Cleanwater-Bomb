local content = require("ccb").content

do
    -- Fabric sheets used for tailoring.
    local group = content.ItemGroup { id = "tailoring_fabric", kind = "distribution" }
    group:item("sheet_cotton", 200)
    group:item("sheet_neoprene", 10)
    group:item("tanned_hide", 50)
    group:item("tanned_pelt", 50)
    content.add(group)
end

do
    -- 8 oz bottle, filled 80% as new
    local group = content.ItemGroup { id = "graphite_small_bottle", kind = "distribution", container = "bottle_plastic_355ml" }
    group:entry { item = "graphite", count = { 118, 118 } }
    content.add(group)
end

do
    -- 8 oz bottle, opened with a variable amount
    local group = content.ItemGroup {
        id = "graphite_small_bottle_part",
        kind = "distribution",
        container = "bottle_plastic_355ml",
    }
    group:entry { item = "graphite", count = { 2, 118 } }
    content.add(group)
end

do
    -- 8 oz bottle, filled 80% as new
    local group = content.ItemGroup { id = "zincpowder_small_bottle", kind = "distribution", container = "bottle_plastic_355ml" }
    group:entry { item = "chem_zinc_powder", charges = { 122, 122 } }
    content.add(group)
end

do
    -- 8 oz bottle, opened with a variable amount
    local group = content.ItemGroup {
        id = "zincpowder_small_bottle_part",
        kind = "distribution",
        container = "bottle_plastic_355ml",
    }
    group:entry { item = "chem_zinc_powder", charges = { 2, 122 } }
    content.add(group)
end

do
    -- 8 oz glass flask, filled 80% as new
    local group = content.ItemGroup { id = "zincpowder_glass_flask", kind = "distribution", container = "flask_glass" }
    group:entry { item = "chem_zinc_powder", charges = { 175, 175 } }
    content.add(group)
end

do
    -- 8 oz glass flask, opened with a variable amount
    local group = content.ItemGroup { id = "zincpowder_glass_flask_part", kind = "distribution", container = "flask_glass" }
    group:entry { item = "chem_zinc_powder", charges = { 2, 175 } }
    content.add(group)
end

do
    -- 8 oz bottle, filled 80% as new
    local group = content.ItemGroup {
        id = "potassiumchloride_small_bottle",
        kind = "distribution",
        container = "bottle_plastic_355ml",
    }
    group:entry { item = "chem_potassium_chloride", count = { 355, 355 } }
    content.add(group)
end

do
    -- 8 oz bottle, opened with a variable amount
    local group = content.ItemGroup {
        id = "potassiumchloride_small_bottle_part",
        kind = "distribution",
        container = "bottle_plastic_355ml",
    }
    group:entry { item = "chem_potassium_chloride", count = { 2, 355 } }
    content.add(group)
end

do
    -- 8 oz bottle, filled 80% as new
    local group = content.ItemGroup {
        id = "redphosphorus_small_bottle",
        kind = "distribution",
        container = "bottle_plastic_355ml",
    }
    group:entry { item = "red_phosphorous", charges = { 71, 71 } }
    content.add(group)
end

do
    -- 8 oz bottle, opened with a variable amount
    local group = content.ItemGroup {
        id = "redphosphorus_small_bottle_part",
        kind = "distribution",
        container = "bottle_plastic_355ml",
    }
    group:entry { item = "red_phosphorous", charges = { 2, 71 } }
    content.add(group)
end

do
    -- 8 oz bottle, filled 80% as new
    local group = content.ItemGroup {
        id = "whitephosphorus_small_bottle",
        kind = "distribution",
        container = "bottle_plastic_355ml",
    }
    group:entry { item = "white_phosphorous", charges = { 71, 71 } }
    content.add(group)
end

do
    -- 8 oz bottle, opened with a variable amount
    local group = content.ItemGroup {
        id = "whitephosphorus_small_bottle_part",
        kind = "distribution",
        container = "bottle_plastic_355ml",
    }
    group:entry { item = "white_phosphorous", charges = { 2, 71 } }
    content.add(group)
end

do
    -- 8 oz bottle, filled 80% as new
    local group = content.ItemGroup {
        id = "manganesedioxide_small_bottle",
        kind = "distribution",
        container = "bottle_plastic_355ml",
    }
    group:entry { item = "chem_manganese_dioxide", charges = { 170, 170 } }
    content.add(group)
end

do
    -- 8 oz bottle, opened with a variable amount
    local group = content.ItemGroup {
        id = "manganesedioxide_small_bottle_part",
        kind = "distribution",
        container = "bottle_plastic_355ml",
    }
    group:entry { item = "chem_manganese_dioxide", charges = { 2, 170 } }
    content.add(group)
end

do
    -- 8 oz bottle, filled 80% as new
    local group = content.ItemGroup {
        id = "chromiumoxide_small_bottle",
        kind = "distribution",
        container = "bottle_plastic_355ml",
    }
    group:entry { item = "chem_chromium_oxide", charges = { 165, 165 } }
    content.add(group)
end

do
    -- 8 oz bottle, opened with a variable amount
    local group = content.ItemGroup {
        id = "chromiumoxide_small_bottle_part",
        kind = "distribution",
        container = "bottle_plastic_355ml",
    }
    group:entry { item = "chem_chromium_oxide", charges = { 2, 165 } }
    content.add(group)
end

do
    -- 8 oz bottle, filled 80% as new
    local group = content.ItemGroup {
        id = "calciumcarbonate_small_bottle",
        kind = "distribution",
        container = "bottle_plastic_355ml",
    }
    group:entry { item = "chem_caco3", charges = { 322, 322 } }
    content.add(group)
end

do
    -- 8 oz bottle, opened with a variable amount
    local group = content.ItemGroup {
        id = "calciumcarbonate_small_bottle_part",
        kind = "distribution",
        container = "bottle_plastic_355ml",
    }
    group:entry { item = "chem_caco3", charges = { 2, 322 } }
    content.add(group)
end

do
    -- 8 oz bottle, filled 80% as new
    local group = content.ItemGroup {
        id = "calciumcarbide_small_bottle",
        kind = "distribution",
        container = "bottle_plastic_355ml",
    }
    group:entry { item = "chem_carbide", charges = { 355, 355 } }
    content.add(group)
end

do
    -- 8 oz bottle, opened with a variable amount
    local group = content.ItemGroup {
        id = "calciumcarbide_small_bottle_part",
        kind = "distribution",
        container = "bottle_plastic_355ml",
    }
    group:entry { item = "chem_carbide", charges = { 2, 355 } }
    content.add(group)
end

do
    -- 71 oz box, filled 80% as new
    local group = content.ItemGroup { id = "detergent_small_box", kind = "distribution", container = "box_small" }
    group:entry { item = "detergent", charges = { 129, 129 } }
    content.add(group)
end

do
    -- 71 oz box, opened with a variable amount
    local group = content.ItemGroup { id = "detergent_small_box_part", kind = "distribution", container = "box_small" }
    group:entry { item = "detergent", charges = { 2, 129 } }
    content.add(group)
end

do
    -- 128 oz
    local group = content.ItemGroup { id = "bleach_jug", kind = "distribution" }
    group:entry { item = "bleach", charges = { -1, -1 } }
    content.add(group)
end

do
    -- 64 oz
    local group = content.ItemGroup {
        id = "ammonia_hydroxide_bottle_twoliter",
        kind = "distribution",
        container = "bottle_twoliter",
    }
    group:entry { item = "ammonia_hydroxide", count = { 15, 15 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ammonia_hydroxide_bottle_twoliter_part",
        kind = "distribution",
        container = "bottle_twoliter",
    }
    group:entry { item = "ammonia_hydroxide", count = { 1, 15 } }
    content.add(group)
end

do
    -- 32 oz
    local group = content.ItemGroup { id = "ethanol_bottle_liter", kind = "distribution", container = "bottle_liter" }
    group:entry { item = "chem_ethanol", count = { 950, 950 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ethanol_bottle_liter_part", kind = "distribution", container = "bottle_liter" }
    group:entry { item = "chem_ethanol", count = { 15, 950 } }
    content.add(group)
end

do
    -- 17 oz bag, filled 80% as new
    local group = content.ItemGroup { id = "magnesiumpowder_small_bag", kind = "distribution", container = "box_small" }
    group:entry { item = "magnesium", count = { 200, 200 } }
    content.add(group)
end

do
    -- 17 oz bag, opened with a variable amount
    local group = content.ItemGroup { id = "magnesiumpowder_small_bag_part", kind = "distribution", container = "box_small" }
    group:entry { item = "magnesium", count = { 2, 200 } }
    content.add(group)
end

do
    -- 15 liter bag, filled 80% as new
    local group = content.ItemGroup { id = "saltpeter_canvas_bag", kind = "distribution", container = "bag_canvas" }
    group:entry { item = "chem_saltpetre", count = { 300, 300 } }
    content.add(group)
end

do
    -- 15 liter bag, opened with a variable amount
    local group = content.ItemGroup { id = "saltpeter_canvas_bag_part", kind = "distribution", container = "bag_canvas" }
    group:entry { item = "chem_saltpetre", count = { 2, 300 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sandbag", kind = "distribution", container = "bag_durasack" }
    group:entry { item = "material_sand", count = { 2500, 2500 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sandbag_part", kind = "distribution", container = "bag_durasack" }
    group:entry { item = "material_sand", count = { 400, 2500 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "gravelbag", kind = "distribution", container = "bag_durasack" }
    group:entry { item = "material_gravel", count = { 2500, 2500 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "gravelbag_part", kind = "distribution", container = "bag_durasack" }
    group:entry { item = "material_gravel", count = { 400, 2500 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "earthbag", kind = "distribution", container = "bag_durasack" }
    group:entry { item = "material_soil", count = { 3, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "earthbag_part", kind = "distribution", container = "bag_durasack" }
    group:entry { item = "material_soil", count = { 1, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "concrete_bag", kind = "distribution", container = "bag_durasack" }
    group:entry { item = "concrete", count = { 45, 45 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "concrete_bag_part", kind = "distribution", container = "bag_durasack" }
    group:entry { item = "concrete", count = { 7, 45 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cement_bag", kind = "distribution", container = "bag_durasack_cement" }
    group:entry { item = "material_cement", count = { 2800, 2800 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cement_bag_part", kind = "distribution", container = "bag_durasack_cement" }
    group:entry { item = "material_cement", count = { 400, 2800 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "quicklime_bag", kind = "distribution", container = "bag_durasack" }
    group:entry { item = "material_quicklime", count = { 1200, 1200 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "quicklime_bag_part", kind = "distribution", container = "bag_durasack" }
    group:entry { item = "material_quicklime", count = { 400, 1200 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "quicklime_barrel", kind = "distribution", container = "30gal_barrel" }
    group:entry { item = "material_quicklime", count = { 6000, 6000 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "quicklime_barrel_part", kind = "distribution", container = "30gal_barrel" }
    group:entry { item = "material_quicklime", count = { 600, 6000 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "paintcans", kind = "distribution" }
    group:item("paint_can_steel")
    group:item("paint_can_plastic")
    content.add(group)
end

do
    -- ~100 ft.
    local group = content.ItemGroup { id = "cable_roll", kind = "distribution", container = "spool_small" }
    group:entry { item = "cable", count = { 100, 100 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cable_roll_part", kind = "distribution", container = "spool_small" }
    group:entry { item = "cable", count = { 3, 100 } }
    content.add(group)
end

do
    -- ~100 ft.
    local group = content.ItemGroup { id = "copper_wire_roll", kind = "distribution", container = "spool_small" }
    group:entry { item = "copper_wire", count = { 100, 100 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "copper_wire_roll_part", kind = "distribution", container = "spool_small" }
    group:entry { item = "copper_wire", count = { 3, 100 } }
    content.add(group)
end

do
    -- 200 charges = 25 m. One charge = 125 mm.
    local group = content.ItemGroup { id = "duct_tape_roll", kind = "distribution", container = "cardboard_roll" }
    group:entry { item = "duct_tape", charges = { 200, 200 } }
    content.add(group)
end

do
    -- 25 charges = 5 m. One charge = 200 mm.
    local group = content.ItemGroup { id = "medical_tape_roll", kind = "distribution", container = "cardboard_roll" }
    group:entry { item = "medical_tape", count = { 25, 25 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "charcoal_bag_part", kind = "distribution", container = "bag_paper_charcoal" }
    group:entry { item = "charcoal", charges = { 200, 5000 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ultralight_battery_small_bag", kind = "distribution", container = "shrink_wrap" }
    group:entry { item = "light_minus_disposable_cell", count = { 4, 4 }, charges = { 1000, 1000 } }
    group:entry { item = "light_minus_battery_cell", count = { 4, 4 }, charges = { 1000, 1000 }, probability = 25 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ultralight_battery_small_bag_part", kind = "distribution", container = "shrink_wrap" }
    group:entry { item = "light_minus_disposable_cell", count = { 1, 4 }, charges = { 1000, 1000 } }
    group:entry { item = "light_minus_battery_cell", count = { 1, 4 }, charges = { 1000, 1000 }, probability = 25 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ultralight_battery_large_bag", kind = "distribution", container = "shrink_wrap" }
    group:entry { item = "light_minus_disposable_cell", count = { 10, 10 }, charges = { 1000, 1000 } }
    group:entry { item = "light_minus_battery_cell", count = { 10, 10 }, charges = { 1000, 1000 }, probability = 25 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ultralight_battery_large_bag_part", kind = "distribution", container = "shrink_wrap" }
    group:entry { item = "light_minus_disposable_cell", count = { 1, 10 }, charges = { 1000, 1000 } }
    group:entry { item = "light_minus_battery_cell", count = { 1, 10 }, charges = { 1000, 1000 }, probability = 25 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "light_battery_small_bag", kind = "distribution", container = "shrink_wrap" }
    group:entry { item = "light_battery_cell", count = { 8, 8 }, charges = { 1000, 1000 } }
    group:entry { item = "light_cell_rechargeable", count = { 8, 8 }, charges = { 1000, 1000 }, probability = 25 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "light_battery_small_bag_part", kind = "distribution", container = "shrink_wrap" }
    group:entry { item = "light_battery_cell", count = { 1, 8 }, charges = { 1000, 1000 } }
    group:entry { item = "light_cell_rechargeable", count = { 1, 8 }, charges = { 1000, 1000 }, probability = 25 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "light_battery_large_bag", kind = "distribution", container = "shrink_wrap" }
    group:entry { item = "light_battery_cell", count = { 24, 24 }, charges = { 1000, 1000 } }
    group:entry { item = "light_cell_rechargeable", count = { 24, 24 }, charges = { 1000, 1000 }, probability = 25 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "light_battery_large_bag_part", kind = "distribution", container = "shrink_wrap" }
    group:entry { item = "light_battery_cell", count = { 1, 24 }, charges = { 1000, 1000 } }
    group:entry { item = "light_cell_rechargeable", count = { 1, 24 }, charges = { 1000, 1000 }, probability = 25 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "medium_battery_small_bag", kind = "distribution", container = "shrink_wrap" }
    group:entry { item = "medium_battery_cell", count = { 1, 1 }, charges = { 1000, 1000 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "medium_battery_small_bag_part", kind = "distribution", container = "shrink_wrap" }
    group:entry { item = "medium_battery_cell", count = { 0, 1 }, charges = { 1000, 1000 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "medium_battery_large_bag", kind = "distribution", container = "shrink_wrap" }
    group:entry { item = "medium_battery_cell", count = { 2, 2 }, charges = { 1000, 1000 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "medium_battery_large_bag_part", kind = "distribution", container = "shrink_wrap" }
    group:entry { item = "medium_battery_cell", count = { 0, 2 }, charges = { 1000, 1000 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "nail_box_1lb_full",
        kind = "distribution",
        container = "box_small",
        overflow = "spill",
    }
    group:entry { item = "nail", count = { 23, 23 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "nail_box_1lb", kind = "distribution", container = "box_small", overflow = "spill" }
    group:entry { item = "nail", charges = { 7, 23 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "nail_box_5lb_full",
        kind = "distribution",
        container = "box_small",
        overflow = "spill",
    }
    group:entry { item = "nail", count = { 115, 115 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "nail_box_5lb", kind = "distribution", container = "box_small", overflow = "spill" }
    group:entry { item = "nail", charges = { 35, 115 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "nail_box_10lb_full",
        kind = "distribution",
        container = "box_small",
        overflow = "spill",
    }
    group:entry { item = "nail", count = { 230, 230 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "nail_box_10lb", kind = "distribution", container = "box_small", overflow = "spill" }
    group:entry { item = "nail", charges = { 69, 230 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "nail_box_15lb_full",
        kind = "distribution",
        container = "box_small",
        overflow = "spill",
    }
    group:entry { item = "nail", count = { 345, 345 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "nail_box_15lb", kind = "distribution", container = "box_small", overflow = "spill" }
    group:entry { item = "nail", charges = { 103, 345 } }
    content.add(group)
end

do
    -- 65 oz
    local group = content.ItemGroup { id = "borax_box", kind = "distribution", container = "box_small", overflow = "spill" }
    group:entry { item = "chem_borax", count = { 532, 532 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "borax_box_part", kind = "distribution", container = "box_small", overflow = "spill" }
    group:entry { item = "chem_borax", count = { 100, 532 } }
    content.add(group)
end

do
    -- 8 oz
    local group = content.ItemGroup { id = "solder_wire_spool", kind = "distribution", container = "spool_small" }
    group:entry { item = "solder_wire", count = { 113, 113 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bag_garbage_box", kind = "distribution", container = "box_small" }
    group:entry { item = "bag_garbage", count = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bag_garbage_box_part", kind = "distribution", container = "box_small" }
    group:entry { item = "bag_garbage", count = { 0, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "rug", kind = "distribution" }
    group:item("r_carpet", 45)
    group:item("g_carpet", 45)
    group:item("y_carpet", 45)
    group:item("p_carpet", 45)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "styrofoam_sheet_pack", kind = "distribution" }
    group:item("material_styrofoam_sheet", 6)
    content.add(group)
end

do
    -- Common plumbing supplies. These are more likely to be found on jobsites and work spaces, rather than store shelves. Use bulk for store shelves.
    local group = content.ItemGroup { id = "supplies_plumbing", kind = "distribution" }
    group:entry { item = "pipe_cpvc", count = { 1, 2 }, probability = 60 }
    group:entry { item = "cu_pipe", count = { 1, 2 }, probability = 200 }
    group:entry { item = "hose", count = { 1, 2 }, probability = 200 }
    group:entry { group = "solder_wire_spool_part", count = { 1, 2 } }
    group:item("metal_tank_little", 5)
    group:item("metal_tank", 1)
    group:item("jerrycan", 5)
    group:entry { item = "scrap_copper", count = { 1, 2 }, probability = 15 }
    group:item("lc_wire", 10)
    group:group("box_of_batteries_random", 50)
    group:item("pilot_light", 50)
    group:group("duct_tape_roll_part", 200)
    group:group("glue_weak_domestic")
    group:group("glue_strong_domestic")
    group:item("string_6")
    group:item("string_36")
    group:entry { group = "glue_weak_professional_full", count = { 6, 10 } }
    group:item("rope_6")
    group:item("rope_30", 50)
    group:item("water_faucet")
    group:item("bubblewrap", 20)
    group:item("pump_complex", 5)
    group:item("well_pump", 5)
    group:item("plastic_sheet", 20)
    group:item("recharge_station", 20)
    group:item("plunger_toilet", 75)
    group:item("plunger_futuristic", 25)
    group:item("pipe_fittings", 70)
    content.add(group)
end

do
    -- Common plumbing supplies you might find in large amounts in a store or a plumber's work truck.
    local group = content.ItemGroup { id = "plumbing_bulk", kind = "distribution" }
    group:entry { group = "supplies_plumbing", count = { 1, 2 } }
    group:entry { item = "cu_pipe", count = { 1, 10 } }
    group:entry { item = "pipe_cpvc", count = { 150, 400 } }
    group:entry { item = "hose", count = { 1, 10 } }
    group:entry { item = "water_faucet", count = { 1, 5 }, probability = 30 }
    group:entry { group = "solder_wire_spool", count = { 2, 6 } }
    group:entry { item = "pilot_light", count = { 1, 2 }, probability = 50 }
    group:entry { item = "metal_tank_little", count = { 1, 2 }, probability = 50 }
    group:item("metal_tank", 10)
    group:item("jerrycan", 10)
    group:group("glue_weak_domestic_full", 40)
    group:item("pump_complex", 10)
    group:item("well_pump", 10)
    group:entry { item = "scrap_copper", count = { 1, 12 }, probability = 15 }
    group:entry { item = "plunger_toilet", count = { 1, 2 }, probability = 90 }
    group:item("plunger_futuristic", 50)
    group:item("pipe_fittings", 70)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "lumberyard", kind = "collection" }
    group:entry {
        distribution = {
            { item = "2x4", count = { 20, 50 }, probability = 500 },
            { item = "plank_short", count = { 20, 50 }, probability = 300 },
            { item = "plank_long", count = { 5, 20 }, probability = 80 },
            { item = "wood_block", count = { 20, 100 }, probability = 150 },
            { item = "wooden_post", count = { 20, 50 }, probability = 500 },
            { item = "wooden_post_long", count = { 5, 20 }, probability = 80 },
            { item = "wooden_post_short", count = { 20, 50 }, probability = 300 },
            { item = "wood_beam", count = { 5, 20 }, probability = 50 },
            { item = "wood_sheet", count = { 10, 30 }, probability = 400 },
            { item = "wood_panel", count = { 15, 40 }, probability = 300 },
            { item = "log", count = { 5, 10 }, probability = 200 },
            { item = "stick_long", count = { 10, 20 } },
            { group = "nail_box_1lb_full", count = { 10, 20 }, probability = 90 },
            { group = "nail_box_5lb_full", count = { 2, 6 }, probability = 85 },
            { group = "nail_box_10lb_full", count = { 1, 6 }, probability = 80 },
            { group = "nail_box_15lb_full", count = { 1, 4 }, probability = 75 },
            { group = "nail_box_1lb", count = { 6, 20 }, probability = 95 },
            { group = "nail_box_5lb", count = { 2, 6 }, probability = 90 },
            { group = "nail_box_10lb", count = { 1, 6 }, probability = 85 },
            { group = "nail_box_15lb", count = { 1, 4 }, probability = 80 },
            { item = "stick", count = { 5, 10 }, probability = 50 },
        },
    }
    group:item("rigid_plastic_sheet", 50)
    group:item("plastic_sheet", 50)
    group:item("pine_bough", 10)
    content.add(group)
end

do
    -- for domestic or small trade wood working shops
    local group = content.ItemGroup { id = "wood_workshop", kind = "collection" }
    group:entry {
        distribution = {
            { item = "2x4", count = { 4, 6 } },
            { item = "plank_short", count = { 4, 10 }, probability = 65 },
            { item = "plank_long", count = { 2, 4 }, probability = 30 },
            { item = "wood_block", count = { 5, 35 } },
            { item = "wood_beam", count = { 1, 2 }, probability = 10 },
            { item = "wooden_post", count = { 4, 6 } },
            { item = "plank_long", count = { 2, 4 }, probability = 30 },
            { item = "wooden_post_short", count = { 4, 10 }, probability = 65 },
            { item = "wood_sheet", count = { 2, 3 }, probability = 50 },
            { item = "wood_panel", count = { 2, 3 }, probability = 30 },
            { item = "stick_long", count = { 5, 10 }, probability = 30 },
            { item = "stick", count = { 1, 7 }, probability = 50 },
            { group = "nail_box_1lb_full", count = { 6, 24 } },
            { group = "nail_box_5lb_full", count = { 1, 10 }, probability = 95 },
            { group = "nail_box_10lb_full", count = { 1, 10 }, probability = 95 },
            { group = "nail_box_15lb_full", count = { 1, 10 }, probability = 90 },
            { group = "nail_box_1lb", count = { 1, 24 } },
            { group = "nail_box_5lb", count = { 1, 10 }, probability = 95 },
            { group = "nail_box_10lb", count = { 1, 10 }, probability = 95 },
            { group = "nail_box_15lb", count = { 1, 10 }, probability = 90 },
        },
    }
    group:item("pencil", 20)
    group:item("rigid_plastic_sheet", 5)
    group:item("plastic_sheet", 5)
    group:item("pine_bough", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "supplies_woodcrafts", kind = "distribution" }
    group:group("glue_weak_professional", 30)
    group:group("glue_strong_professional", 10)
    group:item("sandpaper", 40)
    group:item("screwdriver", 5)
    group:item("dremel", 20)
    group:item("chisel", 10)
    group:item("hammer", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "concrete_bag_any", kind = "distribution" }
    group:group("concrete_bag", 30)
    group:group("concrete_bag_part", 50)
    group:item("bag_durasack_cement", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cement_bag_any", kind = "distribution" }
    group:group("cement_bag", 30)
    group:group("cement_bag_part", 50)
    group:item("bag_durasack", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sandbag_any", kind = "distribution" }
    group:group("sandbag", 30)
    group:group("sandbag_part", 50)
    group:item("bag_durasack", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "gravelbag_any", kind = "distribution" }
    group:group("gravelbag", 30)
    group:group("gravelbag_part", 50)
    group:item("bag_durasack", 20)
    content.add(group)
end

do
    -- non-secret laboratory biological samples.
    local group = content.ItemGroup { id = "supplies_samples_lab", kind = "distribution" }
    group:item("meat", 10)
    group:item("offal", 10)
    group:entry { item = "lung", count = { 4, 12 }, probability = 10 }
    group:entry { item = "kidney", count = { 4, 12 }, probability = 10 }
    group:entry { item = "liver", count = { 4, 12 }, probability = 10 }
    group:entry { item = "mouse_sample", count = { 1, 3 }, probability = 40 }
    group:entry { item = "rat_sample", count = { 1, 3 }, probability = 40 }
    group:entry { item = "fish_sample", count = { 1, 3 }, probability = 40 }
    group:entry { item = "chiropteran_sample", count = { 1, 3 }, probability = 40 }
    group:entry { item = "meat_tainted", count = { 1, 3 }, probability = 30 }
    group:entry { item = "brain", count = { 4, 12 }, probability = 10 }
    group:entry { item = "rabbit_sample", count = { 1, 3 }, probability = 10 }
    group:entry { item = "gastropod_sample", count = { 1, 3 }, probability = 10 }
    group:entry { item = "batrachian_sample", count = { 1, 3 }, probability = 10 }
    group:entry { item = "insect_sample", count = { 1, 3 }, probability = 10 }
    group:entry { item = "cattle_sample", count = { 1, 3 }, probability = 10 }
    group:entry { item = "spider_sample", count = { 1, 3 }, probability = 10 }
    group:entry { item = "troglobite_sample", count = { 1, 3 }, probability = 10 }
    group:entry { item = "lizard_sample", count = { 1, 3 }, probability = 10 }
    group:entry { item = "ursine_sample", count = { 1, 3 }, probability = 10 }
    group:entry { item = "beast_sample", count = { 1, 3 }, probability = 10 }
    group:entry { item = "human_sample", count = { 1, 3 }, probability = 10 }
    group:entry { item = "cephalopod_sample", count = { 1, 3 }, probability = 10 }
    group:entry { item = "lupine_sample", count = { 1, 3 }, probability = 10 }
    group:entry { item = "feline_sample", count = { 1, 3 }, probability = 10 }
    group:entry { item = "plant_sample", count = { 3, 6 }, probability = 10 }
    group:entry { item = "slime_sample", count = { 3, 6 }, probability = 10 }
    group:entry { item = "bird_sample", count = { 3, 6 }, probability = 10 }
    group:entry { item = "sweetbread", count = { 4, 12 }, probability = 10 }
    content.add(group)
end

do
    -- Consumable supplies excluding seeds used for farming or other agriculture
    local group = content.ItemGroup { id = "supplies_farming", kind = "distribution" }
    group:group("fertilizer_commercial_bag_canvas_60")
    group:item("fertilizer_liquid", 60)
    group:group("quicklime_bag", 80)
    group:group("quicklime_barrel", 20)
    group:entry { item = "chem_saltpetre", charges = { 10, 50 }, probability = 15 }
    content.add(group)
end

do
    -- untouched bar stock for machine shops, steel mills, etc.
    local group = content.ItemGroup { id = "supplies_machining", kind = "distribution" }
    group:entry { item = "aluminum_bar_round", count = { 5, 30 }, probability = 30 }
    group:entry { item = "lc_steel_bar_round", count = { 5, 25 }, probability = 30 }
    group:entry { item = "mc_steel_bar_round", count = { 1, 10 }, probability = 10 }
    group:entry { item = "hc_steel_bar_round", count = { 1, 10 }, probability = 5 }
    group:entry { item = "small_aluminum_bar_round", count = { 5, 30 }, probability = 20 }
    group:entry { item = "small_lc_steel_bar_round", count = { 5, 25 }, probability = 20 }
    group:entry { item = "small_mc_steel_bar_round", count = { 1, 15 }, probability = 5 }
    group:entry { item = "small_hc_steel_bar_round", count = { 1, 10 }, probability = 5 }
    group:entry { item = "aluminum_bar_flat", count = { 5, 30 }, probability = 30 }
    group:entry { item = "lc_steel_bar_flat", count = { 5, 25 }, probability = 30 }
    group:entry { item = "mc_steel_bar_flat", count = { 1, 10 }, probability = 10 }
    group:entry { item = "hc_steel_bar_flat", count = { 1, 10 }, probability = 5 }
    group:entry { item = "small_aluminum_bar_flat", count = { 5, 30 }, probability = 20 }
    group:entry { item = "small_lc_steel_bar_flat", count = { 5, 25 }, probability = 20 }
    group:entry { item = "small_mc_steel_bar_flat", count = { 1, 15 }, probability = 5 }
    group:entry { item = "small_hc_steel_bar_flat", count = { 1, 10 }, probability = 5 }
    content.add(group)
end

do
    -- Metals of significant economic value before the Cataclysm
    local group = content.ItemGroup { id = "supplies_metal_precious", kind = "distribution" }
    group:entry { item = "gold_small", count = { 50, 150 } }
    group:entry { item = "silver_small", count = { 50, 150 } }
    group:entry { item = "platinum_small", count = { 50, 150 } }
    content.add(group)
end

do
    -- Spare parts for crafting or mending vehicle parts
    local group = content.ItemGroup { id = "supplies_spares_vehicle", kind = "distribution" }
    group:item("bb", 40)
    group:item("drivebelt", 200)
    group:item("filter_air", 60)
    group:item("filter_liquid", 60)
    group:item("glowplug", 10)
    group:entry {
        item = "blister_pack",
        count = { 0, 8 },
        contents = {
            { item = "tire_repair_kit" },
        },
    }
    group:group("glue_weak_professional_full", 20)
    group:item("motor_small", 20)
    group:item("pump_complex", 10)
    group:item("well_pump", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "charged_inhaler", kind = "collection" }
    group:entry { item = "inhaler", charges = { 100, 100 } }
    content.add(group)
end

do
    -- barrel with gasoline, diesel or motor oil like you would find at fuel depot
    local group = content.ItemGroup { id = "fuel_barrel", kind = "distribution" }
    group:entry { item = "gasoline", charges = { 0, 50000 }, container = "30gal_drum", probability = 30 }
    group:entry { item = "diesel", charges = { 0, 50000 }, container = "30gal_drum", probability = 10 }
    group:entry { item = "motor_oil", charges = { 0, 10000 }, container = "jerrycan", probability = 5 }
    content.add(group)
end

do
    -- barrel with aviation gas like you would find at a fuel depot for planes or helicopters
    local group = content.ItemGroup { id = "avgas_barrel", kind = "distribution" }
    group:entry { item = "avgas", charges = { 0, 50000 }, container = "30gal_drum", probability = 30 }
    content.add(group)
end

do
    -- barrel with aviation gas like you would find at a fuel depot for planes or helicopters
    local group = content.ItemGroup { id = "jp8_barrel", kind = "distribution" }
    group:entry { item = "jp8", charges = { 0, 50000 }, container = "30gal_drum", probability = 30 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pens", kind = "distribution" }
    group:entry { item = "pen", charges = { 0, 100 }, probability = 30 }
    group:entry { item = "black_pen", charges = { 0, 100 }, probability = 30 }
    group:entry { item = "blue_pen", charges = { 0, 100 }, probability = 30 }
    group:entry { item = "red_pen", charges = { 0, 100 }, probability = 5 }
    group:entry { item = "green_pen", charges = { 0, 100 }, probability = 5 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "autodoc_supplies", kind = "collection" }
    group:entry { item = "anesthetic_kit", charges = { 0, 6000 } }
    group:entry { item = "arm_splint", count = { 1, 3 } }
    group:entry { item = "leg_splint", count = { 1, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "chem_agar_bottle_plastic_small_50",
        kind = "collection",
        container = "bottle_plastic_small",
    }
    group:entry { item = "chem_agar", count = { 50, 50 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "chem_sulphur_bottle_plastic_small_100_inf",
        kind = "collection",
        container = "bottle_plastic_small",
    }
    group:entry { item = "chem_sulphur", count = { 100, 250 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "chem_citric_acid_bottle_glass_50", kind = "collection", container = "bottle_glass" }
    group:entry { item = "chem_citric_acid", count = { 50, 50 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "hair_dye", kind = "distribution" }
    group:entry { item = "hair_dye_black", charges = { 2, 2 }, probability = 70 }
    group:entry { item = "hair_dye_blond", charges = { 2, 2 }, probability = 70 }
    group:entry { item = "hair_dye_blue", charges = { 2, 2 }, probability = 30 }
    group:entry { item = "hair_dye_brown", charges = { 2, 2 }, probability = 70 }
    group:entry { item = "hair_dye_gray", charges = { 2, 2 }, probability = 50 }
    group:entry { item = "hair_dye_green", charges = { 2, 2 }, probability = 30 }
    group:entry { item = "hair_dye_red", charges = { 2, 2 }, probability = 30 }
    group:entry { item = "hair_dye_pink", charges = { 2, 2 }, probability = 30 }
    group:entry { item = "hair_dye_white", charges = { 2, 2 }, probability = 70 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "hair_dye_display", kind = "collection" }
    group:item("hair_dye_kit")
    group:entry { group = "hair_dye", count = { 1, 4 }, probability = 90 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bathroom_hair_dye_kit", kind = "collection" }
    group:group("hair_dye", 70)
    group:item("hair_dye_kit", 75)
    content.add(group)
end

do
    -- 67.6 oz, or 2L
    local group = content.ItemGroup { id = "lye_bottle_twoliter", kind = "distribution", container = "bottle_twoliter" }
    group:entry { item = "lye", count = { 40, 40 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "lye_bottle_twoliter_part", kind = "distribution", container = "bottle_twoliter" }
    group:entry { item = "lye", count = { 1, 40 } }
    content.add(group)
end

do
    -- 32 oz, or 1L
    local group = content.ItemGroup { id = "lye_potassium_bottle_liter", kind = "distribution", container = "bottle_twoliter" }
    group:entry { item = "lye_potassium", count = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "lye_potassium_bottle_liter_part",
        kind = "distribution",
        container = "bottle_twoliter",
    }
    group:entry { item = "lye_potassium", count = { 1, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bleach_jug_part", kind = "distribution" }
    group:entry { item = "bleach", charges = { 125, -1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "oxy_powder_bottle_part", kind = "distribution", container = "bottle_plastic_small" }
    group:entry { item = "oxy_powder", charges = { 30, -1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "lye_powder_bottle_part", kind = "distribution", container = "bottle_plastic_small" }
    group:entry { item = "lye_powder", charges = { 30, -1 } }
    content.add(group)
end

do
    -- General laboratory reagents and expendibles.  This list contains most conceivable chemicals in the game.  More specific lists for each type of lab would be reasonable eventually.
    local group = content.ItemGroup { id = "supplies_fluid_catalytic_lab", kind = "distribution" }
    group:entry { item = "water_clean", charges = { 1, -1 }, sealed = false, container = "bottle_plastic", probability = 90 }
    group:entry { item = "cooking_oil", count = { 4, 4 }, charges = { 10, -1 } }
    group:entry { item = "chem_washing_soda", charges = { 1, 20 } }
    group:entry { item = "lamp_oil", count = { 4, 4 }, charges = { 10, -1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "gym_school", kind = "distribution" }
    group:item("basketball")
    group:item("indoor_volleyball", 50)
    group:item("baseball")
    group:item("shuttlecock", 10)
    group:item("hat_ball", 10)
    group:entry {
        item = "helmet_ball",
        flags = {
            "UNDERSIZE",
        },
        probability = 20,
    }
    group:item("bat", 80)
    group:item("bat_metal", 40)
    group:item("bat_nerf", 50)
    group:item("hockey_stick", 10)
    group:item("towel", 30)
    group:item("pom_poms", 50)
    group:entry {
        item = "tank_top",
        variant = "tank_top_cheerleader",
        flags = {
            "UNDERSIZE",
        },
        probability = 25,
    }
    group:entry {
        item = "cheerleader_top_short",
        flags = {
            "UNDERSIZE",
        },
        probability = 1,
    }
    group:entry {
        item = "cheerleader_skirt",
        flags = {
            "UNDERSIZE",
        },
        probability = 25,
    }
    group:entry {
        item = "cheerleader_skirt_short",
        flags = {
            "UNDERSIZE",
        },
        probability = 1,
    }
    group:item("football")
    group:entry {
        item = "football_armor",
        flags = {
            "UNDERSIZE",
        },
        probability = 20,
    }
    group:entry {
        item = "helmet_football",
        flags = {
            "UNDERSIZE",
        },
        probability = 20,
    }
    group:item("medical_gauze", 10)
    group:item("heatpack", 10)
    group:item("whistle", 5)
    group:item("airhorn", 2)
    content.add(group)
end

do
    -- now used for shelters that have been looted by kids, see SUS groups for general shelter supplies
    local group = content.ItemGroup { id = "shelter_supplies", kind = "collection" }
    group:item("wrapper", 90)
    group:item("evac_pamphlet", 80)
    group:item("glass_shard", 80)
    group:item("emer_blanket", 40)
    group:item("bottle_plastic", 30)
    group:item("plastic_knife", 20)
    group:item("plastic_spoon", 20)
    group:item("plastic_fork", 20)
    group:item("bowl_plastic", 10)
    group:item("jacket_evac", 15)
    group:item("folding_poncho", 10)
    group:item("sponge", 10)
    group:item("mask_dust", 9)
    group:item("handflare_dead", 9)
    group:item("whistle", 7)
    group:item("teddy_bear", 7)
    group:entry { item = "vinegar", charges = { 1, -1 }, probability = 6 }
    group:item("candle", 5)
    group:item("pliers", 4)
    group:item("mirror", 4)
    group:item("wearable_light", 2)
    group:item("calcium_tablet", 1)
    group:item("vitamins", 1)
    group:entry { item = "protein_bar_evac", count = { 0, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "chem_peptone_broth_bottle_plastic_small_1_inf",
        kind = "collection",
        container = "bottle_plastic_small",
    }
    group:entry { item = "chem_peptone_broth", count = { 1, -1 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "chem_agar_bottle_plastic_small_1_inf",
        kind = "collection",
        container = "bottle_plastic_small",
    }
    group:entry { item = "chem_agar", count = { 1, -1 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "chem_citric_acid_bottle_glass_100_inf",
        kind = "collection",
        container = "bottle_glass",
    }
    group:entry { item = "chem_citric_acid", count = { 100, -1 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "chem_acrylamide_bottle_glass_1_inf", kind = "collection", container = "bottle_glass" }
    group:entry { item = "chem_acrylamide", count = { 1, -1 }, container = "null" }
    content.add(group)
end
