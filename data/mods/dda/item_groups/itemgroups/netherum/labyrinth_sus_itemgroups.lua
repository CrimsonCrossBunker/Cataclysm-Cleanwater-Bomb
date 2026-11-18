local content = require("ccb").content

do
    local group = content.ItemGroup { id = "LS_tools_common_small", kind = "distribution" }
    group:item("hacksaw", 50)
    group:item("hammer", 80)
    group:item("pliers", 60)
    group:item("big_pliers", 2)
    group:item("screwdriver")
    group:item("dremel", 40)
    group:item("screwdriver_set", 50)
    group:item("socket_screwdriver_set", 10)
    group:group("duct_tape_roll_part", 10)
    group:group("glue_weak_domestic", 5)
    group:group("glue_strong_domestic", 5)
    group:item("tin_snips", 10)
    group:item("wrench", 20)
    group:item("wrench_small", 20)
    group:item("hand_pump", 10)
    group:item("socket_wrench_set", 20)
    group:item("pliers_locking", 20)
    group:item("xacto", 40)
    group:item("jumper_cable", 10)
    group:item("extension_cable", 15)
    group:item("hd_tow_cable", 5)
    group:item("claw_bar", 2)
    group:item("crowbar", 10)
    group:item("thermometer", 5)
    group:item("multitool", 10)
    group:item("recharge_station", 10)
    group:item("hand_crank_charger", 25)
    group:group("graphite_small_bottle_part", 10)
    group:item("metal_file", 10)
    group:item("clamp", 10)
    group:item("sandpaper", 80)
    group:group("writing_utensils", 5)
    group:group("soldering_supplies", 50)
    group:item("nl_grav_aware_jig", 20)
    group:item("tape_measure", 40)
    group:item("nl_laser_mass_indexer", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "LS_SUS_tier0_metal_materials", kind = "collection" }
    group:entry { item = "chain", count = { 2, 15 }, probability = 30 }
    group:entry { item = "steel_chunk", count = { 2, 10 }, probability = 40 }
    group:entry { item = "spring", count = { 2, 10 }, probability = 20 }
    group:entry { item = "steel_lump", count = { 1, 5 }, probability = 40 }
    group:entry { item = "frame", count = { 1, 10 }, probability = 10 }
    group:entry { item = "frame", count = { 1, 5 }, probability = 10 }
    group:entry { item = "pipe", count = { 2, 8 }, probability = 20 }
    group:entry { item = "nuts_bolts", count = { 5, 4000 }, probability = 50 }
    group:entry { item = "bolt_steel", count = { 1, 10 }, charges = { 1, 10 }, probability = 10 }
    group:entry { item = "spike", count = { 3, 40 }, probability = 10 }
    group:entry { item = "hinge", count = { 1, 30 }, probability = 20 }
    group:entry { item = "wire", count = { 5, 20 }, probability = 40 }
    group:entry { item = "rebar", count = { 2, 30 }, probability = 30 }
    group:entry { item = "sheet_metal", count = { 2, 30 }, probability = 20 }
    group:entry { item = "sheet_metal_small", count = { 5, 50 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "LS_SUS_tier0_kipple", kind = "distribution" }
    group:entry { item = "kipple_object", count = { 1, 3 }, probability = 40 }
    group:entry { item = "nl_kipple_scrap_plastic", count = { 2, 5 }, probability = 40 }
    group:entry { item = "nl_kipple_scrap_nanotubes", count = { 2, 5 }, probability = 40 }
    group:entry { item = "nl_kipple_scrap_unob", count = { 2, 5 }, probability = 40 }
    group:entry { item = "nl_kipple_scrap_copper", count = { 2, 5 }, probability = 40 }
    group:entry { item = "nl_kipple_scrap_alu", count = { 2, 5 }, probability = 40 }
    group:entry { item = "nl_kipple_scrap_steel", count = { 2, 5 }, probability = 40 }
    content.add(group)
end

do
    -- Filler.  This should actually be a distribution of different collections and should contain a little weird stuff.
    local group = content.ItemGroup { id = "LS_SUS_crate_tier0_materials", kind = "collection" }
    group:group("LS_SUS_tier0_metal_materials", 40)
    group:group("LS_SUS_tier0_kipple", 40)
    group:entry { item = "nl_chem_thrower_mag", charges = { 57, 57 }, probability = 5 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "LS_SUS_crate_tier0_loot", kind = "collection" }
    group:group("LS_SUS_tier0_kipple", 80)
    group:entry { item = "nl_chem_thrower_mag", charges = { 57, 57 }, probability = 5 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "LS_SUS_crate_tier1_loot", kind = "collection" }
    group:group("LS_SUS_tier0_kipple", 80)
    group:item("nl_robo_surg_app", 5)
    group:item("nl_surg_int_unit", 5)
    group:entry { item = "nl_chem_thrower_mag", charges = { 57, 57 }, probability = 10 }
    group:item("plut_cell", 5)
    group:item("exodii_wire_kit", 1)
    group:group("bionics", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "LS_SUS_crate_tier1_finale_loot", kind = "collection" }
    group:group("LS_SUS_tier0_kipple", 80)
    group:entry { item = "nl_chem_thrower_mag", charges = { 57, 57 }, probability = 10 }
    group:item("plut_cell", 10)
    group:item("exodii_wire_kit", 10)
    group:group("LS_bionics", 50)
    content.add(group)
end

do
    -- Filler.  Pieces to repair stuff within the dungeon.
    local group = content.ItemGroup { id = "LS_SUS_crate_tier0_machineparts", kind = "collection" }
    group:entry { item = "e_scrap", count = { 5, 40 }, probability = 40 }
    group:entry { item = "wire", count = { 5, 40 }, probability = 40 }
    group:entry { item = "bone", count = { 5, 40 }, probability = 40 }
    group:entry {
        distribution = {
            { item = "welding_rod_steel", charges = { 300, 900 }, probability = 30 },
            { item = "welding_rod_alloy", charges = { 300, 900 }, probability = 20 },
            { item = "welding_wire_steel", charges = { 300, 900 }, probability = 10 },
            { item = "welding_wire_alloy", charges = { 300, 900 }, probability = 40 },
            { item = "brazing_rod_bronze", charges = { 300, 900 }, probability = 80 },
            { item = "brazing_rod_alloy", charges = { 300, 900 }, probability = 30 },
        },
    }
    content.add(group)
end

do
    -- Filler.  Should contain several boxes of food and foodlike objects.
    local group = content.ItemGroup { id = "LS_SUS_shelf_tier0_food", kind = "collection" }
    group:item("dry_meat", 20)
    group:item("dry_fish", 30)
    group:item("dry_veggy", 40)
    group:item("dry_corn", 40)
    group:item("dry_fruit", 30)
    group:item("salt", 30)
    group:item("flour", 20)
    group:item("cornmeal", 25)
    group:item("oatmeal", 40)
    group:item("barley", 20)
    content.add(group)
end

do
    -- Filler.  Should contain tools you might need to survive down here.
    local group = content.ItemGroup { id = "LS_SUS_shelf_tier0_tools", kind = "collection" }
    group:entry { group = "LS_tools_common_small", count = { 1, 8 } }
    content.add(group)
end

do
    -- Incomplete.  Make tables look interesting.
    local group = content.ItemGroup { id = "LS_SUS_table_items_workspace", kind = "distribution" }
    group:group("LS_SUS_crate_tier0_machineparts", 40)
    group:group("LS_SUS_tier0_kipple", 40)
    group:group("LS_tools_common_small", 40)
    content.add(group)
end

do
    -- Incomplete.  Make tables look interesting.
    local group = content.ItemGroup { id = "LS_SUS_table_items_bunk_room", kind = "distribution" }
    group:item("emer_blanket")
    group:item("scrap")
    group:item("ceramic_mug")
    group:item("bone")
    content.add(group)
end

do
    -- Filler.  Not totally sure what would be in a locker in an imperfect copy of an exodii bedroom.  Huh.  I'll add a welding blanket, not because I think it actually goes in a bedroom, but because I think it's very funny.
    local group = content.ItemGroup { id = "LS_SUS_bunk_room", kind = "collection" }
    group:entry {
        distribution = {
            { group = "LS_SUS_tier0_kipple", probability = 40 },
            { item = "e_scrap", probability = 40 },
            { item = "bone", probability = 40 },
        },
        probability = 60,
    }
    group:entry {
        distribution = {
            { item = "emer_blanket", probability = 40 },
            { item = "welding_blanket", probability = 40 },
        },
        probability = 80,
    }
    group:group("games_basic", 10)
    content.add(group)
end
