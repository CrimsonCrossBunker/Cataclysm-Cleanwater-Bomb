local content = require("ccb").content

do
    local group = content.ItemGroup { id = "smokelounge_items", kind = "distribution" }
    group:entry { item = "cigar", count = { 5, 5 }, probability = 65 }
    group:group("cigar_box_opened", 25)
    group:entry { item = "ecig", count = { 40, 40 }, probability = 25 }
    group:group("cig_box_cigarette_20", 35)
    group:group("tobacco_bag_plastic_20", 45)
    group:item("rolling_paper", 15)
    group:item("pipe_tobacco", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_armory", kind = "distribution", with_magazine = 100 }
    group:group("ammo_cop", 80)
    group:group("guns_cop")
    group:group("mags_cop", 40)
    group:group("ammo_swat", 20)
    group:item("gasbomb", 1)
    group:group("guns_swat", 20)
    group:group("mags_swat", 20)
    group:group("gear_eod", 20)
    group:group("molle_papr_kit", 10)
    group:item("survnote", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "vfw_tools", kind = "distribution" }
    group:item("boots_steel", 50)
    group:item("boots_hiking", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "vfw_books", kind = "distribution" }
    group:item("mag_traps", 20)
    group:item("manual_traps", 12)
    group:item("trappers_companion", 2)
    group:item("mag_guns", 40)
    group:item("mag_rifle", 40)
    group:item("mag_shotgun", 15)
    group:item("mag_survival", 40)
    group:item("textbook_firstaid", 8)
    group:item("pocket_firstaid", 2)
    group:item("pocket_survival", 2)
    group:item("pocket_firearms", 2)
    group:item("mag_archery", 15)
    group:item("manual_archery", 8)
    group:item("book_archery", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "vfw_alcohol", kind = "distribution" }
    group:item("beer", 20)
    group:item("vodka", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mansion_guns", kind = "distribution", with_ammo = 100, with_magazine = 100 }
    group:group("guns_pistol_common", 162)
    group:group("guns_rifle_common", 36)
    group:group("guns_shotgun_common", 2)
    group:group("guns_display_pieces", 20)
    group:group("guns_collectible", 2)
    group:group("ammo_common_boxed", 40)
    group:group("mags_common", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "hospital_incubator", kind = "distribution" }
    group:item("blanket", 90)
    group:item("child_book", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "waitingroom", kind = "distribution" }
    group:group("magazines", 2000)
    group:group("kids_books", 35)
    group:group("stand_flyer")
    group:item("recipe_augs", 20)
    group:item("decoy_anarch", 50)
    group:group("newspaper_recent", 200)
    group:item("survnote", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "hospital_samples", kind = "distribution" }
    group:item("blood", 20)
    group:item("vacutainer", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "hospital_oxygen", kind = "distribution" }
    group:entry { item = "smoxygen_tank", count = { 0, 4 }, charges = { 0, 0 } }
    group:entry { item = "smoxygen_tank", charges = { 0, 12 }, probability = 60 }
    group:entry { item = "oxygen_tank", count = { 0, 2 }, charges = { 0, 0 } }
    group:entry { item = "oxygen_tank", charges = { 0, 24 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "prison_textile", kind = "collection" }
    group:item("blanket", 25)
    group:item("jumpsuit_pocketless", 70, "orange")
    content.add(group)
end

do
    -- For mortuary
    local group = content.ItemGroup { id = "corpse_male_mortuary", kind = "collection" }
    group:group("male_underwear_top")
    group:group("male_underwear_bottom")
    group:item("corpse")
    group:item("sheet")
    group:item("bag_body_bag")
    content.add(group)
end

do
    -- For mortuary
    local group = content.ItemGroup { id = "corpse_female_mortuary", kind = "collection" }
    group:group("female_underwear_top")
    group:group("female_underwear_bottom")
    group:item("corpse")
    group:item("sheet")
    group:item("bag_body_bag")
    content.add(group)
end

do
    -- For mortuary
    local group = content.ItemGroup { id = "corpse_viewing", kind = "collection" }
    group:group("female_underwear_top")
    group:group("female_underwear_bottom")
    group:item("gold_ring")
    group:item("veil_wedding")
    group:item("dress_wedding")
    group:item("corpse")
    content.add(group)
end

do
    -- for ws_regional_dump
    local group = content.ItemGroup { id = "oa_ig_rd_desks", kind = "distribution" }
    group:group("box_of_batteries_random", 30)
    group:group("candy_chocolate", 570)
    group:group("snacks", 820)
    group:entry { item = "radio", charges = { 0, 100 }, probability = 10 }
    group:item("eyedrops", 10)
    group:item("cotton_patchwork", 30)
    group:entry { item = "paper", count = { 30, 80 }, probability = 30 }
    group:item("foon", 30)
    group:item("spork", 30)
    group:entry { item = "cell_phone", charges = { 0, 150 }, probability = 10 }
    group:item("file", 40)
    group:item("mag_mechanics", 20)
    group:item("manual_mechanics", 10)
    group:item("manual_driving", 10)
    content.add(group)
end

do
    -- for ws_regional_dump
    local group = content.ItemGroup { id = "oa_ig_rd_lockers", kind = "distribution" }
    group:group("box_of_batteries_random", 50)
    group:entry { item = "radio", charges = { 0, 100 }, probability = 10 }
    group:item("cotton_patchwork", 30)
    group:entry { item = "flashlight", charges = { 0, 300 }, probability = 20 }
    group:entry { item = "heavy_flashlight", charges = { 0, 300 }, probability = 10 }
    group:item("jumper_cable", 20)
    group:item("jumper_cable_heavy", 10)
    group:item("hd_tow_cable", 5)
    group:item("pliers", 10)
    group:item("battery_motorbike", 10)
    group:item("battery_car", 10)
    group:item("stereo", 10)
    group:item("wrench", 10)
    group:item("screwdriver", 15)
    group:group("glue_weak_domestic", 5)
    group:group("glue_strong_domestic", 5)
    group:item("boots", 70)
    group:item("boots_steel", 50)
    group:item("sneakers_steel", 35)
    group:item("boots_hiking", 10)
    group:item("denim_overalls", 10)
    group:item("technician_coveralls", 15)
    group:item("technician_coveralls_h", 5)
    group:item("gloves_rubber", 20)
    group:item("gloves_leather", 45)
    group:item("shovel", 45)
    group:item("crowbar", 15)
    group:item("gloves_work", 45)
    group:entry { item = "mask_filter", charges = { 0, 100 }, probability = 30 }
    group:entry { item = "mask_gas_half", charges = { 0, 100 }, probability = 25 }
    group:item("glasses_safety", 40)
    group:item("hat_hard", 50)
    group:item("hat_hard_hooded", 25)
    group:entry { item = "wearable_light", charges = { 0, 100 }, probability = 5 }
    group:item("ear_plugs", 50)
    group:entry { item = "flashlight", charges = { 0, 300 }, probability = 40 }
    group:item("boots_rubber", 20)
    group:group("tools_toolbox", 5)
    group:item("apron_cotton", 5)
    group:item("apron_leather", 3)
    group:item("apron_plastic", 20)
    content.add(group)
end

do
    -- for ws_regional_dump
    local group = content.ItemGroup { id = "oa_ig_rd_electronic_trash", kind = "distribution" }
    group:group("ammo_pocket_batteries", 10)
    group:item("solar_panel", 15)
    group:item("jumper_cable", 5)
    group:item("extension_cable", 5)
    group:item("pipe", 20)
    group:item("stereo", 6)
    group:item("toaster", 20)
    group:item("television", 20)
    group:item("microwave", 20)
    group:item("multi_cooker", 1)
    group:item("waffleiron", 25)
    group:item("radio", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "alloy_sheet_storage", kind = "distribution" }
    group:entry { item = "alloy_sheet", count = { 5, 10 }, probability = 50 }
    group:item("alloy_plate", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "steel_mill_storage", kind = "collection" }
    group:entry { group = "alloy_sheet_storage", count = { 1, 2 } }
    group:entry {
        distribution = {
            { item = "hard_steel_armor", count = { 10, 30 }, probability = 50 },
            { item = "hard_plate", count = { 1, 3 }, probability = 50 },
        },
        probability = 50,
    }
    group:entry { group = "metal_workshop", count = { 1, 3 }, probability = 50 }
    content.add(group)
end

do
    -- for ws_regional_dump
    local group = content.ItemGroup { id = "oa_ig_ash_pile", kind = "distribution" }
    group:item("ash", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "recycle_paper", kind = "distribution" }
    group:group("schematics", 2)
    group:group("magazines", 300)
    group:item("ZSG", 10)
    group:item("glassblowing_book", 15)
    group:item("textbook_chemistry", 15)
    group:group("novels", 75)
    group:group("literature", 20)
    group:group("religious_books", 10)
    group:group("kids_books", 20)
    group:item("wrapper_foil_roll", 25)
    group:item("recipe_bows", 15)
    group:item("manual_stabbing", 20)
    group:item("manual_dodge", 20)
    group:item("manual_driving", 20)
    group:item("manual_throw", 20)
    group:item("manual_zui_quan", 20)
    group:item("howto_computer", 20)
    group:item("touristmap", 25)
    group:item("restaurantmap", 25)
    group:group("roadmap_stock", 25)
    group:item("trailmap", 25)
    group:item("modern_tanner", 20)
    group:item("pocket_survival", 20)
    group:item("godco_flier", 15)
    group:item("flyer", 120)
    group:entry { item = "paper", count = { 10, 60 }, probability = 500 }
    group:item("wrapper", 150)
    group:item("phonebook", 110)
    group:item("box_small_folded", 400)
    group:item("box_medium_folded", 400)
    group:item("box_large_folded", 200)
    group:item("box_oversize_folded", 200)
    group:group("newspaper", 1000)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "recycle_electronic", kind = "distribution" }
    group:entry {
        group = "used_usb_drives",
        contents = {
            { group = "efiles_scrap" },
        },
        probability = 45,
    }
    group:entry {
        group = "used_memory_cards",
        contents = {
            { group = "efiles_scrap" },
        },
        probability = 80,
    }
    group:entry { item = "two_way_radio", charges = { 0, 15 }, probability = 30 }
    group:item("transponder", 25)
    group:item("receiver", 25)
    group:item("small_lcd_screen", 10)
    group:item("large_lcd_screen", 10)
    group:entry { item = "radiocontrol", charges = { 0, 25 }, probability = 15 }
    group:entry { item = "radio_car", charges = { 0, 25 }, probability = 15 }
    group:item("RAM", 45)
    group:entry { item = "radio", charges = { 0, 15 }, probability = 25 }
    group:item("power_supply", 25)
    group:item("processor", 25)
    group:item("laptop_hard_case", 10)
    group:entry { item = "mp3", charges = { 0, 15 }, probability = 20 }
    group:entry {
        group = "used_laptops",
        contents = {
            { group = "efiles_scrap" },
        },
        probability = 20,
    }
    group:item("hotplate", 20)
    group:entry { item = "flashlight", charges = { 0, 10 }, probability = 30 }
    group:item("coffeemaker", 20)
    group:item("clock", 30)
    group:item("alarmclock", 25)
    group:item("circuit", 25)
    group:entry { item = "cell_phone", charges = { 0, 15 }, probability = 35 }
    group:item("e_scrap", 55)
    group:item("amplifier", 25)
    group:entry { item = "smart_lamp", charges = { 0, 100 }, probability = 5 }
    group:entry { item = "reading_light", charges = { 0, 100 }, probability = 10 }
    group:item("carver_off", 5)
    group:item("coffeemaker", 5)
    group:item("dehydrator", 5)
    group:item("food_processor", 5)
    group:item("hotplate", 5)
    group:item("multi_cooker", 5)
    group:item("vac_sealer", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "recycle_plastic", kind = "distribution" }
    group:item("barrette", 30)
    group:group("sex_accessories_domestic", 20)
    group:item("bubblewrap", 30)
    group:item("syringe", 35)
    group:item("glowstick_dead", 15)
    group:item("credit_card", 5)
    group:item("id_science", 3)
    group:item("sandbox_kit", 5)
    group:item("ear_spool", 15)
    group:entry { item = "lighter", charges = { 0, 15 }, probability = 35 }
    group:entry { item = "pipe_cpvc", count = { 2, 9 }, probability = 35 }
    group:item("funnel", 25)
    group:item("canteen", 20)
    group:item("basket_laundry", 20)
    group:item("plastic_pot_flower", 35)
    group:item("gloves_medical", 20)
    group:item("fitover_sunglasses", 20)
    group:item("goggles_swim", 20)
    group:item("bag_plastic", 150)
    group:item("plastic_shopping_bag", 200)
    group:item("jug_plastic", 120)
    group:item("jerrycan", 15)
    group:item("bottle_plastic", 150)
    group:item("bottle_plastic_small", 150)
    group:item("cup_plastic")
    group:item("bowl_plastic")
    group:item("plastic_chunk", 150)
    group:item("plastic_plate", 50)
    group:item("tumbler_plastic", 50)
    group:item("plastic_bowl_kids", 25)
    group:group("pillbox_any_empty", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "recycle_glass", kind = "distribution" }
    group:item("glass_sheet", 10)
    group:item("glasses_reading", 20)
    group:item("glasses_bifocal", 20)
    group:item("glasses_eye", 20)
    group:entry { item = "marble", charges = { 1, 3 }, probability = 20 }
    group:item("fish_bowl", 15)
    group:item("jar_3l_glass_sealed", 120)
    group:item("magnifying_glass", 20)
    group:item("mirror", 30)
    group:entry { item = "glass_shard", count = { 1, 8 }, probability = 650 }
    group:item("crackpipe", 5)
    group:item("glass", 80)
    group:item("glass_bowl", 80)
    group:item("glass_plate", 80)
    group:item("bottle_glass", 150)
    group:item("pipe_glass", 10)
    group:item("jar_glass_sealed", 120)
    group:item("flask_glass", 60)
    group:item("tempered_glass_sheet", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "recycle_aluminum", kind = "distribution" }
    group:item("teleumbrella", 15)
    group:item("cane", 30)
    group:item("wizard_cane", 1)
    group:item("toaster", 30)
    group:item("stethoscope", 2)
    group:entry { item = "spray_can", charges = { 1, 3 }, probability = 45 }
    group:entry { item = "aluminum_foil", charges = { 1, 10 }, probability = 40 }
    group:item("wrapper_foil", 20)
    group:item("cup_foil", 1)
    group:item("golf_club", 3)
    group:item("bat_metal", 2)
    group:item("can_drink", 130)
    group:item("can_drink", 130)
    group:item("keg", 15)
    group:item("material_aluminium_ingot", 25)
    group:item("xlframe", 10)
    group:item("survival_kit_box", 1)
    group:item("wearable_light", 5)
    group:item("rebreather", 1)
    group:item("small_scuba_tank", 1)
    group:item("hand_pump", 3)
    group:item("pilot_light", 30)
    group:item("waffleiron", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "recycle_copper", kind = "distribution" }
    group:item("cu_pipe", 45)
    group:entry { item = "cable", count = { 1, 20 }, probability = 50 }
    group:entry { item = "copper_wire", count = { 1, 20 }, probability = 50 }
    group:item("pot_copper", 30)
    group:item("pot_makeshift_copper", 15)
    group:item("copper_pan", 15)
    group:entry { item = "copper", charges = { 1, 20 }, probability = 40 }
    group:item("copper_ear", 25)
    group:item("copper_bracelet", 25)
    group:item("copper_necklace", 25)
    group:item("copper_ring", 25)
    group:item("copper_hairpin", 25)
    group:item("copper_locket", 25)
    group:item("jumper_cable", 10)
    group:item("jumper_cable_heavy", 10)
    group:item("extension_cable", 10)
    group:item("antenna", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "recycle_iron", kind = "distribution" }
    group:entry { item = "oil_lamp", charges = { 0, 3 }, probability = 20 }
    group:item("steam_triple_small", 1)
    group:item("steam_triple_medium", 1)
    group:item("spring", 150)
    group:item("pastaextruder", 75)
    group:entry { item = "nail", charges = { 1, 15 }, probability = 300 }
    group:entry { item = "nuts_bolts", count = { 5, 30 }, probability = 60 }
    group:item("well_pump", 50)
    group:item("manhole_cover", 20)
    group:item("hairpin", 120)
    group:item("dutch_oven", 5)
    group:item("pan", 90)
    group:item("cow_bell", 20)
    group:item("flask_hip", 25)
    group:item("iron_pot", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "recycle_battery", kind = "distribution" }
    group:group("ammo_any_batteries", 200)
    group:item("storage_battery", 25)
    group:item("medium_storage_battery", 35)
    group:item("small_storage_battery", 45)
    group:item("battery_motorbike", 30)
    group:item("battery_car", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "recycle_steel", kind = "distribution" }
    group:item("can_food", 65)
    group:item("can_food", 65)
    group:item("can_medium", 65)
    group:item("can_medium", 65)
    group:entry { item = "scrap", charges = { 1, 3 }, probability = 50 }
    group:entry { item = "lc_steel_chunk", charges = { 1, 2 }, probability = 50 }
    group:entry { item = "lc_steel_lump", charges = { 1, 2 }, probability = 50 }
    group:item("jerrycan_big", 25)
    group:item("jumper_cable_heavy", 20)
    group:item("jumper_cable", 30)
    group:entry { item = "lc_wire", count = { 0, 40 }, probability = 80 }
    group:entry { item = "mc_wire", count = { 0, 40 }, probability = 20 }
    group:entry { item = "hc_wire", count = { 0, 40 }, probability = 20 }
    group:entry { item = "qt_wire", count = { 0, 40 }, probability = 10 }
    group:item("wheel_metal", 25)
    group:item("foot_crank", 25)
    group:item("chain", 35)
    group:item("rebar", 35)
    group:item("pipe", 40)
    group:item("muffler", 30)
    group:item("pot", 30)
    group:item("pot_canning", 10)
    group:item("stock_pot", 10)
    group:item("steel_pan", 10)
    group:item("teapot", 25)
    group:item("kettle", 25)
    group:item("fuel_tin", 25)
    group:item("fishing_hook_basic", 35)
    group:item("spike", 30)
    group:item("wire_barbed", 25)
    group:item("sheet_metal", 25)
    group:item("sheet_metal_small", 40)
    group:item("frame", 20)
    group:item("basket", 25)
    group:item("wrench", 10)
    group:item("wrench_large", 5)
    group:item("shovel", 10)
    group:item("claw_bar", 2)
    group:item("crowbar", 10)
    group:item("crucible", 3)
    group:item("beartrap", 5)
    group:item("blade", 35)
    group:item("spoon", 35)
    group:item("fork", 35)
    group:item("knife_butter", 35)
    group:item("knife_small", 35, "knife_steak")
    group:item("tourist_table", 10)
    group:item("canister_empty", 45)
    group:item("tongs", 10)
    group:item("pressure_cooker", 10)
    group:item("sieve_steel", 10)
    group:item("hand_controls", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cavern", kind = "distribution" }
    group:item("rock", 40)
    group:item("rock_flaking", 15)
    group:item("flint", 5)
    group:item("rock_large", 10)
    group:entry { item = "jackhammer_mining", charges = { 0, 1200 }, probability = 2 }
    group:item("elec_jackhammer_mining", 1)
    group:entry { item = "flashlight", charges = { 0, 300 }, probability = 40 }
    group:item("dynamite", 5)
    group:entry { item = "matches", charges = { 1, 20 }, probability = 60 }
    group:entry { item = "ref_matches", charges = { 1, 32 }, probability = 60 }
    group:item("55gal_drum", 10)
    group:item("30gal_drum", 15)
    group:item("grapnel", 1)
    group:group("tools_toolbox", 1)
    group:item("apron_leather", 2)
    group:item("apron_cut_resistant", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "golf_green", kind = "distribution" }
    group:item("golf_tee")
    group:item("golf_ball", 65)
    group:item("golf_club", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "museum_melee", kind = "distribution" }
    group:entry { item = "hollow_cane", damage = { 2, 4 }, probability = 2 }
    group:entry { item = "sword_cane", damage = { 2, 4 }, probability = 2 }
    group:entry { item = "katana_fake", damage = { 2, 4 }, probability = 8 }
    group:entry { item = "katana_inferior", damage = { 2, 4 }, probability = 10 }
    group:entry { item = "cutlass_fake", damage = { 2, 4 }, probability = 8 }
    group:entry { item = "cutlass_inferior", damage = { 2, 4 }, probability = 10 }
    group:entry { item = "scimitar_inferior", damage = { 2, 4 }, probability = 7 }
    group:entry { item = "scimitar_fake", damage = { 2, 4 }, probability = 10 }
    group:entry { item = "arming_sword_fake", damage = { 2, 4 }, probability = 7 }
    group:entry { item = "arming_sword_inferior", damage = { 2, 4 }, probability = 10 }
    group:entry { item = "broadsword_fake", damage = { 2, 4 }, probability = 8 }
    group:entry { item = "broadsword_inferior", damage = { 2, 4 }, probability = 10 }
    group:entry { item = "longsword_fake", damage = { 2, 4 }, probability = 8 }
    group:entry { item = "longsword_inferior", damage = { 2, 4 }, probability = 10 }
    group:entry { item = "qiang", damage = { 2, 4 }, probability = 3 }
    group:entry { item = "jian_fake", damage = { 2, 4 }, probability = 8 }
    group:entry { item = "jian_inferior", damage = { 2, 4 }, probability = 10 }
    group:entry { item = "rapier_fake", damage = { 2, 4 }, probability = 8 }
    group:entry { item = "cavalry_sabre_fake", damage = { 2, 4 }, probability = 8 }
    group:entry { item = "estoc_inferior", damage = { 2, 4 }, probability = 4 }
    group:entry { item = "estoc_fake", damage = { 2, 4 }, probability = 5 }
    group:entry { item = "kris", damage = { 2, 4 }, probability = 3 }
    group:entry { item = "kris_fake", damage = { 2, 4 }, probability = 8 }
    group:entry { item = "zweihander_fake", damage = { 2, 4 }, probability = 6 }
    group:entry { item = "zweihander_inferior", damage = { 2, 4 }, probability = 10 }
    group:entry { item = "nodachi_fake", damage = { 2, 4 }, probability = 6 }
    group:entry { item = "bullwhip", damage = { 2, 4 }, probability = 6 }
    group:entry { item = "wakizashi_fake", damage = { 2, 4 }, probability = 8 }
    group:entry { item = "wakizashi_inferior", damage = { 2, 4 }, probability = 10 }
    group:entry { item = "q_staff", damage = { 2, 4 }, probability = 8 }
    group:entry { item = "i_staff", damage = { 2, 4 }, probability = 6 }
    group:entry { item = "glaive", damage = { 2, 4 }, probability = 3 }
    group:entry { item = "naginata_inferior", damage = { 2, 4 }, probability = 2 }
    group:entry { item = "halberd", damage = { 2, 4 }, probability = 2 }
    group:entry { item = "halberd_fake", damage = { 2, 4 }, probability = 6 }
    group:entry { item = "lucern_hammer", damage = { 2, 4 }, probability = 1 }
    group:entry { item = "lucern_hammerfake", damage = { 2, 4 }, probability = 4 }
    group:entry { item = "battleaxe_fake", damage = { 2, 4 }, probability = 6 }
    group:entry { item = "battleaxe_inferior", damage = { 2, 4 }, probability = 10 }
    group:entry { item = "mace", damage = { 2, 4 }, probability = 1 }
    group:entry { item = "mace_fake", damage = { 2, 4 }, probability = 2 }
    group:entry { item = "mace_inferior", damage = { 2, 4 }, probability = 3 }
    group:entry { item = "morningstar", damage = { 2, 4 }, probability = 2 }
    group:entry { item = "morningstar_fake", damage = { 2, 4 }, probability = 3 }
    group:entry { item = "morningstar_inferior", damage = { 2, 4 }, probability = 4 }
    group:entry { item = "warhammer", damage = { 2, 4 }, probability = 1 }
    group:entry { item = "warhammer_fake", damage = { 2, 4 }, probability = 2 }
    group:entry { item = "warhammer_inferior", damage = { 2, 4 }, probability = 3 }
    group:entry { item = "scythe_war", damage = { 2, 4 }, probability = 2 }
    group:entry { item = "pike", damage = { 2, 4 }, probability = 2 }
    group:entry { item = "spear_steel", damage = { 2, 4 }, probability = 2 }
    group:entry { item = "ji", damage = { 2, 4 }, probability = 2 }
    group:entry { item = "dao", damage = { 2, 4 }, probability = 3 }
    group:entry { item = "sword_xiphos", damage = { 2, 4 }, probability = 4 }
    group:entry { item = "khopesh", damage = { 2, 4 }, probability = 1 }
    group:entry { item = "khopesh_fake", damage = { 2, 4 }, probability = 2 }
    group:entry { item = "khopesh_inferior", damage = { 2, 4 }, probability = 3 }
    group:entry { item = "iron_khopesh", damage = { 2, 4 }, probability = 1 }
    group:entry { item = "iron_khopesh_fake", damage = { 2, 4 }, probability = 2 }
    group:entry { item = "iron_khopesh_inferior", damage = { 2, 4 }, probability = 3 }
    group:entry { item = "spear_dory", damage = { 2, 4 }, probability = 3 }
    group:entry { item = "pike_bronze", damage = { 2, 4 }, probability = 3 }
    group:entry { item = "cestus", damage = { 2, 4 }, probability = 4 }
    group:entry { item = "bagh_nakha", damage = { 2, 4 }, probability = 2 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "museum_guns", kind = "distribution" }
    group:entry { item = "pistol_flintlock", damage = { 2, 4 }, probability = 60 }
    group:entry { item = "carbine_flintlock", damage = { 2, 4 }, probability = 40 }
    group:entry { item = "rifle_flintlock", damage = { 2, 4 }, probability = 60 }
    group:entry { item = "flintlock_pouch", damage = { 2, 4 }, probability = 30 }
    group:entry { item = "flintlock_ammo", damage = { 2, 4 }, probability = 60 }
    group:entry { item = "flintlock_shot", damage = { 2, 4 }, probability = 40 }
    group:entry { item = "colt_army", damage = { 2, 4 }, probability = 50 }
    group:entry { item = "colt_navy", damage = { 2, 4 }, probability = 50 }
    group:entry { item = "36navy", damage = { 2, 4 }, probability = 50 }
    group:entry { item = "44army", damage = { 2, 4 }, probability = 50 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "museum_security", kind = "distribution" }
    group:item("television", 90)
    group:item("tonfa", 20)
    group:entry { item = "tazer", charges = { 0, 500 }, probability = 20 }
    group:entry { item = "flashlight", charges = { 0, 300 }, probability = 40 }
    group:entry { item = "two_way_radio", charges = { 0, 100 }, probability = 10 }
    group:item("camera_control", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mine_materials", kind = "collection" }
    group:entry { item = "coal_lump", count = { 2, 20 }, probability = 20 }
    group:entry { item = "rock", count = { 1, 10 }, probability = 40 }
    group:entry { item = "rock_large", count = { 1, 10 }, probability = 10 }
    group:entry { item = "rock_flaking", count = { 1, 10 }, probability = 20 }
    group:entry { item = "flint", count = { 1, 10 }, probability = 5 }
    group:entry { item = "material_shrd_limestone", count = { 1, 10 }, probability = 40 }
    group:entry { item = "material_limestone", count = { 1, 10 }, probability = 40 }
    group:entry { item = "material_niter", count = { 1, 10 }, probability = 5 }
    group:entry { item = "material_sand", charges = { 500, 500 }, container = "bag_canvas", probability = 50 }
    group:entry { item = "material_soil", charges = { 1, 2 }, container = "bag_canvas", probability = 50 }
    group:entry { item = "chunk_sulfur", count = { 1, 10 }, probability = 5 }
    group:entry { item = "material_rocksalt", count = { 1, 10 }, probability = 5 }
    group:entry { item = "material_rhodonite", count = { 1, 10 }, probability = 5 }
    group:entry { item = "material_zincite", count = { 1, 10 }, probability = 5 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mine_equipment", kind = "distribution", with_ammo = 80, with_magazine = 100 }
    group:item("water_clean", 90)
    group:group("used_1st_aid", 35)
    group:item("rope_30", 35)
    group:item("chain", 20)
    group:item("boots_steel", 50)
    group:item("sneakers_steel", 35)
    group:item("denim_overalls", 20)
    group:item("technician_coveralls", 10)
    group:item("technician_coveralls_h", 10)
    group:item("gloves_leather", 45)
    group:entry { item = "mask_filter", charges = { 0, 100 }, probability = 30 }
    group:group("gasmask_bag_full", 10)
    group:item("glasses_safety", 40)
    group:group("SUS_welding_gear", 70)
    group:entry { item = "goggles_nv", charges = { 0, 100 }, probability = 1 }
    group:entry { item = "goggles_ir", charges = { 0, 100 }, probability = 2 }
    group:item("hat_hard", 50)
    group:entry { item = "wearable_light", charges = { 0, 100 }, probability = 20 }
    group:item("ear_plugs", 50)
    group:item("backpack", 18)
    group:item("backpack_denim", 20)
    group:item("slingpack", 19)
    group:item("briefcase", 20)
    group:item("backpack_leather", 18)
    group:group("box_of_batteries_random", 10)
    group:group("ammo_heavy_batteries", 40)
    group:entry { item = "flashlight", charges = { 0, 300 }, probability = 40 }
    group:entry { item = "heavy_flashlight", charges = { 0, 300 }, probability = 10 }
    group:item("pickaxe", 1)
    group:entry { item = "jackhammer_mining", charges = { 0, 1200 }, probability = 2 }
    group:entry { item = "elec_jackhammer_mining", charges = { 0, 7920 }, probability = 1 }
    group:item("dynamite", 5)
    group:entry { item = "UPS_OFF", charges = { 0, 1000 }, probability = 5 }
    group:item("jerrycan", 10)
    group:item("jerrycan_big", 10)
    group:entry { item = "gasoline_lantern", charges = { 0, 500 }, probability = 5 }
    group:entry { item = "electric_lantern", charges = { 0, 100 }, probability = 8 }
    group:entry { item = "oil_lamp", charges = { 0, 750 }, probability = 5 }
    group:item("lamp_oil", 5)
    group:item("shovel", 10)
    group:item("e_tool", 5)
    group:group("hat_hard_flashlight", 40)
    group:item("bucket", 5)
    group:item("bucket_5gal", 20)
    group:item("grapnel", 1)
    group:group("tools_toolbox", 1)
    group:item("apron_leather", 5)
    group:item("apron_cut_resistant", 10)
    group:entry { item = "remotevehcontrol", charges = { 0, 100 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "prison_armor", kind = "distribution" }
    group:item("helmet_riot", 25)
    group:group("gasmask_bag_full", 10)
    group:item("armor_riot", 25)
    group:item("armor_riot_arm", 15)
    group:item("armor_riot_leg", 15)
    group:item("armor_riot_torso", 5)
    group:item("gloves_tactical", 10)
    group:item("emergency_book", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "forensic_locker", kind = "collection", with_magazine = 100 }
    group:item("coat_lab")
    group:item("mask_dust")
    group:item("gloves_rubber")
    group:item("boots_rubber")
    group:item("glasses_safety", 50)
    group:item("apron_plastic", 25)
    group:item("file", 25)
    content.add(group)
end

do
    -- concealable items only plz
    local group = content.ItemGroup { id = "contraband", kind = "distribution" }
    group:group("caffeine_bottle_plastic_pill_supplement_1_10", 25)
    group:group("oxycodone_bottle_plastic_pill_prescription_1_10", 4)
    group:entry { item = "morphine", count = { 1, 4 }, probability = 4 }
    group:group("adderall_bottle_plastic_pill_prescription_1_10", 10)
    group:group("xanax_bottle_plastic_pill_prescription_1_10", 10)
    group:item("adrenaline_injector", 2)
    group:group("crack_bag_zipper_1_4", 2)
    group:item("crackpipe", 2)
    group:entry { item = "lighter", charges = { 0, 100 }, probability = 20 }
    group:group("chewing_gum_used_caff", 10)
    group:group("chewing_gum_used_nic", 10)
    group:entry { item = "lsd", count = { 1, 5 }, probability = 2 }
    group:item("joint", 10)
    group:item("rolling_paper", 5)
    group:group("heroin_bag_zipper_1_4", 2)
    group:item("syringe", 2)
    group:item("mag_porn", 30)
    group:item("mag_survival", 20)
    group:item("mag_cutting", 10)
    group:item("mag_stabbing", 20)
    group:item("mag_melee", 10)
    group:item("mag_traps", 10)
    group:entry { item = "mp3", charges = { 0, 100 }, probability = 9 }
    group:entry { item = "cell_phone", charges = { 0, 150 }, probability = 80 }
    group:group("civilian_phones", 10)
    group:entry {
        group = "used_usb_drives",
        contents = {
            { group = "efiles_contraband" },
        },
        probability = 20,
    }
    group:entry {
        group = "used_eink_tablet_pcs",
        contents = {
            { group = "efiles_contraband" },
        },
        probability = 5,
    }
    group:entry { item = "camera", charges = { 0, 150 }, probability = 3 }
    group:entry { item = "camera_pro", charges = { 0, 150 }, probability = 1 }
    group:item("gold_watch", 3)
    group:item("silver_watch", 6)
    group:item("pocketwatch", 2)
    group:item("gold_dental_grill", 2)
    group:item("diamond_dental_grill", 1)
    group:item("picklocks", 4)
    group:item("chisel", 2)
    group:item("scissors", 10)
    group:item("screwdriver", 8)
    group:item("knife_small", 4, "knife_steak")
    group:item("chain", 10)
    group:item("glass_shiv", 30)
    group:item("bottle_glass", 5)
    group:item("knuckle_brass", 7)
    group:item("knuckle_steel_forged", 3)
    group:item("switchblade", 4)
    group:item("throwing_knife", 5)
    group:entry { item = "throwing_knife", count = { 1, 6 }, wrapper = "leg_sheath6", probability = 1 }
    group:item("leg_sheath6", 2)
    group:entry { item = "punch_dagger", container = "gartersheath1", probability = 1 }
    group:item("gartersheath1", 10)
    group:item("gartersheath2", 5)
    group:entry { item = "tazer", charges = { 0, 100 }, probability = 1 }
    group:group("cig_box_cigarette_1_20", 30)
    group:item("rope_6", 5)
    group:item("rope_30", 2)
    group:group("duct_tape_roll_part", 10)
    group:group("ammo_pocket_batteries_full", 15)
    group:entry { item = "matches", charges = { 0, 20 }, probability = 10 }
    group:entry { item = "ref_matches", charges = { 0, 32 }, probability = 10 }
    group:group("chewing_gum_used", 10)
    group:item("panties", 2)
    group:item("sharp_toothbrush", 10)
    group:item("razor_blade", 20)
    group:entry { item = "soap", charges = { 1, 10 }, probability = 5 }
    group:group("detergent_small_box_part", 5)
    group:group("borax_box_part", 5)
    group:item("knitting_needles", 1)
    group:item("survnote", 2)
    group:item("ankle_wallet_pouch", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ambulance_equipment", kind = "distribution" }
    group:group("tools_medical")
    group:item("bag_body_bag", 5)
    group:group("drugs_emergency", 50)
    group:group("quikclot_bag_plastic_1_6", 10)
    group:item("badge_doctor", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "synagogue_books", kind = "distribution" }
    group:item("book_judaica_hardcover", 70)
    group:item("book_judaica_softcover", 50)
    group:item("book_judaica_siddur", 35)
    group:item("holybook_tanakh", 50)
    group:item("holybook_talmud", 20)
    group:item("essay_book", 25)
    group:item("poetry_book", 15)
    group:group("literature", 35)
    group:item("philosophy_book", 25)
    content.add(group)
end

do
    -- Remains of bodies burned in the corpse pits.
    local group = content.ItemGroup { id = "mil_base_ash", kind = "distribution" }
    group:item("ash", 3)
    content.add(group)
end

do
    -- A corpse of a civilian or a soldier that died on the base, put in a bodybag.
    local group = content.ItemGroup { id = "mil_base_bodybag", kind = "collection" }
    group:entry {
        distribution = {
            { group = "mil_base_corpse_soldier" },
            { group = "everyday_corpse", probability = 120 },
        },
    }
    group:item("bag_body_bag")
    content.add(group)
end

do
    -- Nested to damage corpse.
    local group = content.ItemGroup { id = "mil_base_corpse_soldier", kind = "collection" }
    group:entry { group = "mil_base_corpse_corpse_soldier", damage = { 2, 4 } }
    content.add(group)
end

do
    -- Nested to damage all gear.
    local group = content.ItemGroup {
        id = "mil_base_corpse_corpse_soldier",
        kind = "collection",
        container = "corpse_generic_human",
    }
    group:entry { group = "mil_base_clothes_corpse_soldier", damage = { 1, 4 } }
    content.add(group)
end

do
    -- Soldier clothes, without gear.
    local group = content.ItemGroup { id = "mil_base_clothes_corpse_soldier", kind = "collection" }
    group:group("clothing_soldier_shirt")
    group:entry {
        distribution = {
            { item = "combat_shirt", probability = 50 },
            { item = "jacket_army_modern", probability = 50 },
        },
        probability = 50,
    }
    group:item("elbow_pads", 10)
    group:item("laptop_hard_case", 2)
    group:item("pants_army", 75)
    group:group("loaded_webbing_belt", 50)
    group:item("knee_pads", 10)
    group:entry {
        distribution = {
            { item = "socks", probability = 95 },
            { item = "socks_wool", probability = 5 },
        },
        probability = 90,
    }
    group:item("boots_combat", 50)
    group:item("helmet_army", 10)
    group:item("gloves_tactical", 10)
    group:group("military_ballistic_vest", 10)
    group:group("clothing_tactical_leg", 5)
    group:item("military_poncho", 40)
    group:item("military_poncho_heavy", 40)
    group:item("military_poncho_liner", 40)
    group:entry {
        distribution = {
            {
                collection = {
                    { item = "sports_bra" },
                    { item = "boy_shorts" },
                },
            },
            {
                distribution = {
                    { item = "briefs" },
                    { item = "boxer_briefs" },
                    { item = "boxer_shorts" },
                },
            },
        },
    }
    group:group("clothing_watch", 5)
    group:item("dog_tag", 20)
    content.add(group)
end

do
    -- HMG casing and linkage fired in a machine gun nest.
    local group = content.ItemGroup { id = "mil_base_casing_hmg", kind = "collection" }
    group:item("ammolink50")
    group:item("50_casing")
    content.add(group)
end

do
    -- M2 browning in a machine gun nest.
    local group = content.ItemGroup { id = "mil_base_hmg", kind = "distribution" }
    group:entry { item = "m2browning", charges = { 0, 100 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mil_base_books", kind = "distribution" }
    group:group("book_military", 50)
    group:group("novels", 150)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mil_base_coats", kind = "distribution" }
    group:entry {
        distribution = {
            { item = "trenchcoat", probability = 80 },
            { item = "trenchcoat_leather", probability = 60 },
        },
        probability = 40,
    }
    group:entry {
        distribution = {
            { item = "coat_rain", probability = 80 },
            { item = "peacoat", probability = 50 },
            { item = "greatcoat", probability = 35 },
        },
        probability = 80,
    }
    group:entry {
        distribution = {
            { item = "combat_shirt", probability = 40 },
            { item = "jacket_army_modern", probability = 40 },
            { item = "winter_jacket_army", probability = 20 },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mil_base_iv", kind = "distribution" }
    group:item("blood")
    group:group("saline_bottle_random", 80)
    group:item("bag_iv", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mil_base_mess_hall", kind = "collection" }
    group:item("plastic_fork")
    group:item("mess_tray")
    content.add(group)
end

do
    -- Personal items left behind by civilians in their tents.
    local group = content.ItemGroup { id = "mil_base_tent_civilian", kind = "distribution" }
    group:item("sleeping_bag")
    group:item("blanket")
    group:entry { group = "default_zombie_items_bags", count = { 1, 3 }, probability = 80 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "moonshine_brew", kind = "distribution" }
    group:item("moonshine", 60)
    group:item("still", 20)
    group:item("thermometer", 20)
    group:item("brew_moonshine", 5)
    group:group("cornbread_in_bag", 35)
    group:group("yeast_bag_plastic", 25)
    group:group("sugar_various", 20)
    group:group("ethanol_bottle_liter_part", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "exodii_tools", kind = "distribution" }
    group:group("tools_blacksmith", 50)
    group:group("supplies_metal", 40)
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
                    { item = "brazing_rod_bronze", charges = { 100, 360 }, probability = 75 },
                    { item = "brazing_rod_alloy", charges = { 80, 360 }, probability = 50 },
                },
            },
        },
        probability = 25,
    }
    group:item("oxy_torch", 25)
    group:entry { item = "weldtank", count = { 1, 2 }, probability = 12 }
    group:entry { item = "smallweldtank", count = { 1, 3 }, probability = 12 }
    group:entry { item = "tinyweldtank", count = { 1, 3 }, probability = 12 }
    group:entry { item = "oxygen_cylinder", count = { 1, 2 }, probability = 10 }
    group:entry { item = "polisher", charges = { 0, 100 }, probability = 15 }
    group:item("sandpaper", 20)
    group:item("vac_mold", 15)
    group:item("welder", 10)
    group:entry { item = "welding_blanket", count = { 0, 1 }, probability = 10 }
    group:entry {
        distribution = {
            { item = "welding_rod_steel", charges = { 1000, 1600 }, wrapper = "tube_welding_rod", probability = 30 },
            { item = "welding_rod_alloy", charges = { 1000, 1600 }, wrapper = "tube_welding_rod", probability = 20 },
            { item = "welding_wire_steel", charges = { 1000, 1600 }, wrapper = "spool_welding", probability = 20 },
            { item = "welding_wire_alloy", charges = { 1000, 1600 }, wrapper = "spool_welding", probability = 15 },
            { item = "brazing_rod_bronze", charges = { 500, 1500 }, wrapper = "tube_welding_rod", probability = 10 },
            { item = "brazing_rod_alloy", charges = { 400, 1200 }, wrapper = "tube_welding_rod", probability = 5 },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "nursing_home_clothes", kind = "collection" }
    group:entry {
        distribution = {
            { item = "jersey", probability = 5 },
            { item = "longshirt", probability = 20 },
            { item = "buttonshirt", variant = "striped", probability = 10 },
            { item = "denim_shirt", probability = 5 },
            { item = "sweater", probability = 20 },
            { item = "sweatshirt", probability = 20 },
            { item = "tshirt", probability = 10 },
            { item = "polo_shirt", probability = 10 },
        },
    }
    group:entry {
        distribution = {
            { item = "pants_checkered", probability = 10 },
            { item = "pants", probability = 40 },
            { item = "jeans", probability = 20 },
            { item = "jeans_skinny", probability = 5 },
            { item = "pants", variant = "pants_flag", probability = 5 },
            { item = "breeches", probability = 25 },
        },
    }
    group:item("slippers", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxing_misc", kind = "distribution" }
    group:group("bottle_otc_painkiller_1_20", 50)
    group:group("full_1st_aid", 40)
    group:entry { item = "bandages", count = { 1, 3 }, probability = 15 }
    group:entry { item = "liq_bandage_spray", charges = { 1, -1 }, probability = 5 }
    group:group("adhesive_bandages_box_used", 15)
    group:group("duct_tape_roll_part", 20)
    group:group("glue_weak_domestic", 5)
    group:group("glue_strong_domestic", 5)
    group:entry { item = "sewing_kit", charges = { 0, -1 }, probability = 10 }
    group:item("mouthpiece", 10)
    group:entry { item = "cigar", count = { 1, 5 }, probability = 20 }
    group:group("cig_box_cigarette_1_20", 15)
    group:entry { item = "matches", charges = { 1, 20 }, probability = 10 }
    group:entry { item = "ref_matches", charges = { 1, 32 }, probability = 10 }
    content.add(group)
end

do
    -- For fishing themed locations, excludes makeshift items
    local group = content.ItemGroup { id = "fishing_items", kind = "distribution" }
    group:item("flotation_vest", 50)
    group:item("swimming_kickboard", 5)
    group:item("plastic_sheet", 10)
    group:item("fishing_waders", 5)
    group:group("bikini", 10)
    group:item("rashguard", 5)
    group:item("wetsuit_jacket", 10)
    group:item("wetsuit_top", 10)
    group:item("wetsuit_top_sleeved", 10)
    group:item("wetsuit_pants", 10)
    group:item("wetsuit_shorts", 10)
    group:item("flag_swimsuit", 10)
    group:item("wetsuit", 10)
    group:item("wetsuit_thick", 1)
    group:item("wetsuit_spring", 10)
    group:item("wetsuit_spring_sleeveless", 10)
    group:item("wetsuit_gloves", 20)
    group:item("wetsuit_gloves_thick", 20)
    group:item("wetsuit_booties", 20)
    group:item("wetsuit_booties_thick", 2)
    group:item("wetsuit_hood", 10)
    group:item("wetsuit_hood_thick", 1)
    group:item("swim_cap", 10)
    group:item("scuba_regulator", 5)
    group:entry { item = "scuba_tank", charges = { 0, 60 }, probability = 5 }
    group:entry { item = "small_scuba_tank", charges = { 0, 20 }, probability = 5 }
    group:item("dive_bag", 10)
    group:entry { item = "rebreather", charges = { 180, 180 }, ammo = { item = "rebreather_cartridge_o2" }, probability = 2 }
    group:item("dry_bag", 10)
    group:item("dry_duffelbag", 10)
    group:item("dry_bag_large", 5)
    group:entry { item = "glowstick", charges = { 1400, 1400 }, probability = 60 }
    group:entry { item = "handflare", charges = { 300, 300 }, probability = 40 }
    group:item("hand_pump", 10)
    group:item("folded_inflatable_boat", 10)
    group:item("grapnel", 40)
    group:group("tools_fishingrods_commercial", 80)
    group:group("tools_fishingrods_portable", 20)
    group:item("rope_6", 60)
    group:item("rope_30", 60)
    group:item("fish_bait")
    group:item("fish_trap")
    group:item("bucket")
    group:item("bucket_5gal")
    group:item("fishing_hook_basic")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "methlab", kind = "distribution" }
    group:entry { item = "bandages", count = { 1, 3 }, probability = 25 }
    group:group("adhesive_bandages_box_used", 25)
    group:group("cotton_ball_bag_used", 50)
    group:group("cotton_ball_bag_full", 20)
    group:item("pan", 60)
    group:group("coke_bag_zipper_1_8", 10)
    group:group("meth_bag_zipper_1_6", 90)
    group:item("jar_glass_sealed", 80)
    group:group("heroin_bag_zipper_1_4", 1)
    group:group("bleach_jug_part", 60)
    group:entry { item = "ammonia_liquid", charges = { 6, -1 }, probability = 80 }
    group:entry { item = "chem_baking_soda", charges = { 10, -1 }, probability = 60 }
    group:item("syringe", 30)
    group:item("punch_dagger", 12)
    group:item("knuckle_brass", 12)
    group:item("knuckle_steel_forged", 6)
    group:entry { item = "water_clean", charges = { 1, -1 }, sealed = false, container = "bottle_plastic", probability = 80 }
    group:group("salt_various", 80)
    group:item("mag_porn", 20)
    group:entry { item = "lighter", charges = { 0, 100 }, probability = 60 }
    group:entry { item = "ref_lighter", charges = { 0, 50 }, probability = 2 }
    group:entry { item = "matches", charges = { 0, 20 }, probability = 60 }
    group:entry { item = "ref_matches", charges = { 0, 32 }, probability = 60 }
    group:item("pipebomb", 4)
    group:group("crack_bag_zipper_1_4", 8)
    group:item("crackpipe", 37)
    group:entry { item = "lsd", count = { 1, 5 }, probability = 10 }
    group:entry { item = "ketene_lamp", charges = { 0, 500 }, probability = 5 }
    group:item("chemistry_set", 50)
    group:group("box_of_batteries_random", 70)
    group:entry { item = "flashlight", charges = { 0, 300 }, probability = 40 }
    group:item("chem_acetone", 40)
    group:item("chem_hexamine", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_locker", kind = "collection", with_magazine = 100 }
    group:item("pants")
    group:item("badge_deputy")
    group:item("cowboy_hat", 10)
    group:item("leather_police_jacket", 25, "leather_police_jacket")
    group:item("postman_shirt", 100, "sheriff")
    group:item("police_belt")
    group:group("cop_shoes")
    group:item("whistle", 75)
    group:item("ear_plugs", 66)
    group:group("charged_two_way_radio", 50)
    group:item("kevlar_harness", 20)
    group:item("file", 25)
    group:item("baton", 20)
    group:item("kevlar", 15)
    group:entry { item = "usp_45", charges = { 12, 12 }, container = "holster", ammo = { item = "45_acp" }, probability = 4 }
    group:entry {
        item = "usp_45",
        charges = { 12, 12 },
        container = "nylon_holster",
        ammo = { item = "45_acp" },
        probability = 6,
    }
    group:item("survnote", 10)
    group:item("family_photo", 10)
    group:item("tazer", 5)
    group:item("laptop_hard_case", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "forensic_lab", kind = "collection", with_magazine = 100 }
    group:entry { item = "blood", count = { 1, 3 }, container = "flask_glass", probability = 30 }
    group:group("coke_bag_zipper_1_8", 32)
    group:group("meth_bag_zipper_1_6", 8)
    group:group("heroin_bag_zipper_1_4", 4)
    group:group("crack_bag_zipper_1_4", 16)
    group:group("lsd_bag_zipper_1_5", 24)
    group:entry { group = "ammo_casings", count = { 1, 5 }, container = "bag_zipper", probability = 20 }
    group:entry {
        item = "cotton_patchwork",
        flags = {
            "FILTHY",
        },
        probability = 20,
    }
    group:entry { item = "slime_scrap", container = "bag_zipper", probability = 3 }
    group:entry { item = "raw_hleather", container = "bag_zipper", probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ambulance_drugs", kind = "distribution" }
    group:entry { item = "morphine", count = { 4, 16 }, probability = 5 }
    group:entry { group = "thorazine_bottle_plastic_pill_prescription_10", count = { 1, 4 }, probability = 5 }
    group:entry { group = "tramadol_bottle_plastic_pill_prescription_10", count = { 1, 4 }, probability = 5 }
    group:entry { item = "adrenaline_injector", count = { 1, 4 }, probability = 5 }
    group:entry { group = "oxycodone_bottle_plastic_pill_prescription_10", count = { 1, 4 }, probability = 5 }
    group:entry { group = "quikclot_bag_plastic_6", count = { 1, 4 }, probability = 10 }
    group:entry { group = "antibiotics_bottle_plastic_pill_prescription_15", count = { 1, 4 }, probability = 12 }
    group:entry { item = "disinfectant", count = { 1, 4 }, probability = 15 }
    group:entry { group = "bottle_otc_painkiller_20", count = { 1, 4 }, probability = 15 }
    group:entry { item = "bandages", count = { 3, 12 }, probability = 20 }
    group:entry { item = "liq_bandage_spray", charges = { 1, -1 }, probability = 5 }
    group:entry { item = "inhaler", count = { 1, 4 }, charges = { 100, 100 }, probability = 20 }
    group:entry { group = "full_1st_aid", count = { 1, 2 }, probability = 20 }
    group:entry { group = "full_ifak", count = { 1, 2 }, probability = 20 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mil_base_table_hospital", kind = "distribution" }
    group:entry { item = "bandages", count = { 1, 3 }, probability = 25 }
    group:entry {
        item = "cotton_patchwork",
        flags = {
            "FILTHY",
        },
    }
    content.add(group)
end

do
    -- Pile of thrash next to the medical tents.
    local group = content.ItemGroup { id = "mil_base_tent_medical_thrash", kind = "distribution" }
    group:item("bottle_plastic_small", 20)
    group:item("box_small", 40)
    group:item("box_medium_folded")
    group:item("box_large_folded")
    group:item("box_oversize_folded")
    group:item("bag_iv", 60)
    group:item("bag_body_bag", 40)
    group:item("syringe", 30)
    group:entry {
        item = "cotton_patchwork",
        flags = {
            "FILTHY",
        },
        probability = 60,
    }
    group:item("coat_lab", 20)
    group:item("blanket", 20)
    group:item("sheet", 20)
    group:item("tent_pole", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "grave", kind = "distribution" }
    group:item("bone_human", 70)
    group:item("skull_human", 40)
    group:item("skull_canis", 20)
    group:item("holy_symbol", 50)
    group:item("sheet", 20)
    group:item("bag_body_bag", 20)
    group:item("gloves_medical", 1)
    group:item("barrette", 5)
    group:item("hairpin", 5)
    group:item("child_book", 5)
    group:group("clothing_glasses", 20)
    group:item("flask_hip", 5)
    group:entry { item = "ref_lighter", charges = { 0, 50 }, probability = 5 }
    group:group("jewelry_accessories", 35)
    group:item("story_book", 5)
    group:item("syringe", 3)
    group:entry {
        item = "teddy_bear",
        damage = { 0, 3 },
        flags = {
            "FILTHY",
        },
        probability = 15,
    }
    group:item("arm", 5)
    group:item("leg", 5)
    group:item("fetus", 5)
    group:entry { item = "foodperson_mask", charges = { 0, 500 }, probability = 1 }
    group:item("human_brain_embalmed", 5)
    group:group("newspaper_old", 8)
    group:item("months_old_newspaper", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "exodii_ammo_crate", kind = "collection" }
    group:entry {
        item = "exodiiminimag",
        count = { 2, 20 },
        charges = { 10, 10 },
        ammo = { item = "123ln_ap" },
        probability = 80,
    }
    group:entry { group = "full_exodiiBRmag", count = { 2, 20 } }
    group:entry { group = "full_exodiiBRmag_153", count = { 1, 5 } }
    group:entry { group = "full_exodiiBRmag_26", count = { 4, 30 } }
    group:entry { item = "grenade", count = { 1, 10 }, probability = 20 }
    content.add(group)
end

do
    -- for the steel mill in the well, steel mill
    local group = content.ItemGroup { id = "steel_mill_mill", kind = "distribution" }
    group:entry { item = "scrap", charges = { 1, 3 }, probability = 50 }
    group:entry { item = "lc_steel_chunk", charges = { 1, 2 }, probability = 50 }
    group:entry { item = "lc_steel_lump", charges = { 1, 2 }, probability = 50 }
    group:entry { item = "lc_wire", count = { 0, 40 }, probability = 80 }
    group:entry { item = "mc_wire", count = { 0, 40 }, probability = 20 }
    group:entry { item = "hc_wire", count = { 0, 40 }, probability = 20 }
    group:entry { item = "qt_wire", count = { 0, 40 }, probability = 10 }
    group:entry { group = "supplies_machining", count = { 3, -1 }, probability = 50 }
    group:item("chain", 35)
    group:item("rebar", 35)
    group:item("pipe", 40)
    group:item("sheet_metal", 25)
    group:item("sheet_metal_small", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "school", kind = "distribution" }
    group:group("candy_chocolate", 292)
    group:item("glasses_reading", 90)
    group:item("purse", 40)
    group:item("mbag", 20)
    group:group("box_of_batteries_random", 50)
    group:item("file", 20)
    group:item("howto_computer", 20)
    group:item("manual_fabrication", 30)
    group:entry {
        group = "used_usb_drives",
        contents = {
            { group = "efiles_school" },
        },
        probability = 5,
    }
    group:group("book_mag_tech", 70)
    group:group("book_mag_gen", 150)
    group:group("book_mag_interests", 20)
    group:item("breadboard", 70)
    group:item("voltmeter", 50)
    group:entry { item = "multimeter", charges = { 0, 100 }, probability = 50 }
    group:entry {
        item = "mask_hockey",
        flags = {
            "UNDERSIZE",
        },
        probability = 10,
    }
    group:item("throat_guard_nylon", 2)
    group:item("throat_guard_canvas", 2)
    group:item("hockey_stick", 20)
    group:item("puck", 20)
    group:item("jersey", 40)
    group:item("baseball", 20)
    group:item("shuttlecock", 5)
    group:item("manual_mechanics", 35)
    group:item("manual_driving", 5)
    group:item("manual_speech", 50)
    group:item("manual_business", 40)
    group:item("manual_first_aid", 40)
    group:item("manual_computer", 20)
    group:item("hackerman_computer", 10)
    group:item("webbasics_computer", 10)
    group:item("cookbook", 35)
    group:item("mask_skull", 5, "guy_fawkes")
    group:item("cookbook_italian", 25)
    group:item("cookbook_mexican", 14)
    group:item("manual_electronics", 20)
    group:item("manual_tailor", 15)
    group:item("manual_carpentry", 10)
    group:item("101_carpentry", 10)
    group:item("textbook_speech", 12)
    group:group("novels", 439)
    group:group("kids_books", 50)
    group:group("literature", 60)
    group:item("atomic_survival", 1)
    group:item("jewelry_book", 8)
    group:item("ZSG", 2)
    group:item("cookies", 50)
    group:item("backpack_small", 38)
    group:item("backpack", 18)
    group:item("backpack_denim", 8)
    group:item("backpack_leather", 18)
    group:item("slingpack", 18)
    group:item("briefcase", 5)
    group:item("pockknife", 14)
    group:item("knife_swissarmy", 10)
    group:item("mag_comic", 20)
    group:item("umbrella", 5)
    group:item("teleumbrella", 2)
    group:item("frisbee", 10)
    group:item("disc_golf", 10)
    group:item("pom_poms", 10)
    group:entry {
        item = "tank_top",
        variant = "tank_top_cheerleader",
        flags = {
            "UNDERSIZE",
        },
        probability = 5,
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
        probability = 5,
    }
    group:entry {
        item = "cheerleader_skirt_short",
        flags = {
            "UNDERSIZE",
        },
        probability = 1,
    }
    group:entry {
        item = "football_armor",
        flags = {
            "UNDERSIZE",
        },
        probability = 5,
    }
    group:entry {
        item = "helmet_football",
        flags = {
            "UNDERSIZE",
        },
        probability = 5,
    }
    group:item("mouthpiece", 5)
    group:item("football", 5)
    group:entry {
        item = "roller_blades",
        flags = {
            "UNDERSIZE",
        },
        probability = 20,
    }
    group:entry {
        item = "rollerskates",
        flags = {
            "UNDERSIZE",
        },
        probability = 20,
    }
    group:entry {
        item = "roller_shoes_off",
        flags = {
            "UNDERSIZE",
        },
        probability = 20,
    }
    group:item("folded_skateboard_generic", 20)
    group:item("survnote", 3)
    group:group("toy_radio_car", 3)
    group:group("toy_makerspace_kit", 1)
    group:group("toy_robot_kit", 1)
    group:group("toy_engine_kit", 1)
    group:item("air_launcher", 1)
    group:entry { item = "radiocontrol", charges = { 0, 50 }, probability = 10 }
    group:item("scots_cookbook", 1)
    group:item("scots_tailor", 1)
    group:item("eclipse_glasses", 1)
    group:item("sandbox_kit", 1)
    group:item("dnd_handbook", 1)
    group:item("balloon", 5)
    group:item("scissors_wavy", 7)
    group:group("pencil_case_contents", 50)
    group:group("pencil_case_with_contents", 30)
    content.add(group)
end
