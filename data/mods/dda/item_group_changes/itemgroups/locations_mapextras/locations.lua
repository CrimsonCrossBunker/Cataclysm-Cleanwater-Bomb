local content = require("ccb").content

do
    local group = content.ItemGroup { id = "energy_weapon_armory", kind = "distribution" }
    group:group("guns_energy", 20)
    group:group("gunmod_energy", 40)
    group:entry { item = "plut_cell", charges = { 1, 5 }, probability = 30 }
    group:item("plasma", 30)
    group:item("UPS_OFF", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "homeguns", kind = "distribution", with_ammo = 70, with_magazine = 100 }
    group:group("guns_common")
    group:group("ammo_common_boxed_used", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "lmoe_guns", kind = "distribution", with_ammo = 100, with_magazine = 100 }
    group:group("guns_pistol_common", 81)
    group:group("guns_rifle_common", 18)
    group:group("guns_shotgun_common", 2)
    group:group("guns_survival", 1)
    group:item("flaregun", 25)
    group:entry { item = "large_repairkit", charges = { 0, 500 }, probability = 5 }
    group:item("signal_flare", 20)
    group:entry { item = "small_repairkit", charges = { 0, 500 }, probability = 5 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "hospital_medical_items", kind = "distribution" }
    group:group("surgery", 80)
    group:group("drugs_emergency", 40)
    group:group("softdrugs", 20)
    group:group("harddrugs", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cave_minerals", kind = "distribution" }
    group:item("material_niter", 20)
    group:item("material_limestone", 5)
    content.add(group)
end

do
    -- for ws_regional_dump
    local group = content.ItemGroup { id = "oa_ig_rd_metal_trash", kind = "distribution" }
    group:entry { item = "scrap", count = { 1, 10 } }
    group:item("muffler", 30)
    group:item("pipe", 20)
    group:item("motor", 2)
    group:item("motor_small", 2)
    group:item("horn_car", 2)
    group:item("horn_big", 2)
    group:item("horn_bicycle", 8)
    group:item("pot", 25)
    group:item("pot_copper", 15)
    group:item("toaster", 20)
    group:item("television", 20)
    group:item("microwave", 20)
    group:item("multi_cooker", 1)
    group:item("pan", 25)
    group:item("dutch_oven", 5)
    group:item("waffleiron", 25)
    group:item("pastaextruder", 10)
    group:item("can_sealer", 5)
    group:item("oil_press_manual", 5)
    group:item("knife_butter", 90)
    group:item("knife_small", 85, "knife_steak")
    group:item("fork", 90)
    group:item("spoon", 90)
    group:item("knife_huge", 10, "knife_butcher")
    group:entry { item = "extinguisher", charges = { 0, 5 }, probability = 20 }
    group:item("hose", 15)
    group:item("water_faucet", 20)
    group:item("chain", 20)
    group:item("lc_steel_chunk", 30)
    group:item("spring", 50)
    group:item("lc_steel_lump", 30)
    group:item("frame", 20)
    group:item("hdframe", 20)
    group:item("cu_pipe", 25)
    group:item("scrap_copper", 62)
    content.add(group)
end

do
    -- for the foundry in the steel mill
    local group = content.ItemGroup { id = "steel_mill_foundry", kind = "distribution" }
    group:entry { item = "lc_steel_lump", count = { 1, 3 }, probability = 5 }
    group:entry { item = "lc_steel_chunk", count = { 1, 5 }, probability = 15 }
    group:entry { item = "scrap", count = { 1, 10 }, probability = 70 }
    group:entry { item = "lc_wire", count = { 0, 40 }, probability = 80 }
    group:entry { item = "mc_wire", count = { 0, 40 }, probability = 20 }
    group:entry { item = "hc_wire", count = { 0, 40 }, probability = 20 }
    group:entry { item = "qt_wire", count = { 0, 40 }, probability = 10 }
    group:item("chain", 35)
    group:item("rebar", 35)
    group:item("pipe", 40)
    group:item("sheet_metal", 5)
    group:entry { item = "sheet_metal_small", count = { 2, 4 }, probability = 5 }
    group:entry { item = "material_aluminium_ingot", count = { 1, 5 }, probability = 10 }
    group:entry { group = "supplies_machining", count = { 1, 5 }, probability = 70 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "museum_primitive", kind = "distribution" }
    group:entry { item = "awl_bone", damage = { 2, 4 }, probability = 50 }
    group:entry { item = "billet_bone", damage = { 2, 4 }, probability = 20 }
    group:entry { item = "billet_wood", damage = { 2, 4 }, probability = 20 }
    group:entry { item = "drill_rock_primitive", damage = { 2, 4 }, probability = 15 }
    group:entry { item = "loom_frame", damage = { 2, 4 }, probability = 10 }
    group:entry { item = "primitive_knife", damage = { 2, 4 }, probability = 50 }
    group:entry { item = "punch_bone", damage = { 2, 4 }, probability = 20 }
    group:entry { item = "shed_stick", damage = { 2, 4 }, probability = 10 }
    group:entry { item = "stone_chisel", damage = { 2, 4 }, probability = 20 }
    group:entry { item = "stone_chopper", damage = { 2, 4 }, probability = 50 }
    group:entry { item = "primitive_axe", damage = { 2, 4 }, probability = 50 }
    group:entry { item = "primitive_shovel", damage = { 2, 4 }, probability = 50 }
    group:entry { item = "primitive_hammer", damage = { 2, 4 }, probability = 50 }
    group:entry { item = "primitive_adze", damage = { 2, 4 }, probability = 50 }
    group:entry { item = "needle_bone", damage = { 2, 4 }, probability = 50 }
    group:entry { item = "needle_wood", damage = { 2, 4 }, probability = 50 }
    group:entry { item = "lc_steel_chunk", damage = { 2, 4 }, probability = 50 }
    group:entry { item = "loincloth_fur", damage = { 2, 4 }, probability = 50 }
    group:entry { item = "distaff_spindle", damage = { 2, 4 }, probability = 50 }
    group:entry { item = "carding_paddles", damage = { 2, 4 }, probability = 50 }
    group:entry { item = "knitting_needles", damage = { 2, 4 }, probability = 50 }
    group:entry { item = "pointy_stick", damage = { 2, 4 }, probability = 50 }
    group:entry { item = "throwing_stick", damage = { 2, 4 }, probability = 50 }
    group:entry { item = "copper_knife", damage = { 2, 4 }, probability = 10 }
    group:entry { item = "bronze_knife", damage = { 2, 4 }, probability = 10 }
    group:entry { item = "bronze_shears", damage = { 2, 4 }, probability = 3 }
    group:entry { item = "copper_ax", damage = { 2, 4 }, probability = 10 }
    group:entry { item = "bronze_axe", damage = { 2, 4 }, probability = 10 }
    group:entry { item = "bronze_hoe", damage = { 2, 4 }, probability = 5 }
    group:entry { item = "bronze_sickle", damage = { 2, 4 }, probability = 3 }
    group:entry { item = "bronze_pickaxe", damage = { 2, 4 }, probability = 2 }
    group:entry { item = "bone_flute", damage = { 2, 4 }, probability = 10 }
    group:entry { item = "spear_stone", damage = { 2, 4 }, probability = 50 }
    group:entry { item = "hand_axe", damage = { 2, 4 }, probability = 50 }
    group:entry { item = "bone_fossil", damage = { 2, 4 }, probability = 20 }
    group:entry { item = "large_bone_fossil", damage = { 2, 4 }, probability = 20 }
    group:entry { item = "bone_plaster", damage = { 2, 4 }, probability = 50 }
    group:entry { item = "large_bone_plaster", damage = { 2, 4 }, probability = 50 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "museum_armor_pet", kind = "distribution" }
    group:entry { item = "chainmail_armor_horse", damage = { 2, 4 }, probability = 30 }
    group:entry { item = "steel_armor_horse", damage = { 2, 4 }, probability = 30 }
    group:entry { item = "saddlebag", damage = { 2, 4 }, probability = 30 }
    group:entry { item = "chainmail_harness_dog", damage = { 2, 4 }, probability = 30 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "museum_misc", kind = "distribution" }
    group:entry { item = "small_relic", damage = { 2, 4 }, probability = 80 }
    group:entry { item = "holy_symbol", damage = { 2, 4 }, probability = 80 }
    group:entry { item = "spiral_stone", damage = { 2, 4 }, probability = 80 }
    group:entry { item = "petrified_eye", damage = { 2, 4 }, probability = 5 }
    group:entry { item = "etched_skull", damage = { 2, 4 }, probability = 80 }
    group:entry { item = "ceramic_plate", damage = { 2, 4 }, probability = 90 }
    group:entry { item = "ceramic_bowl", damage = { 2, 4 }, probability = 90 }
    group:entry { item = "clay_hydria", damage = { 2, 4 }, probability = 50 }
    group:entry { item = "ceramic_cup", damage = { 2, 4 }, probability = 90 }
    group:entry { group = "tinware", damage = { 2, 4 }, probability = 50 }
    group:entry { item = "crown_golden", damage = { 2, 4 }, probability = 10 }
    group:item("fluid_preserved_brain", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sewage_plant", kind = "distribution" }
    group:group("used_1st_aid", 35)
    group:item("motor", 2)
    group:item("motor_small", 1)
    group:item("hose", 15)
    group:item("water_faucet", 20)
    group:item("screwdriver", 40)
    group:item("folded_inflatable_boat", 10)
    group:item("hand_pump", 10)
    group:item("wrench", 30)
    group:item("pipe", 20)
    group:entry { item = "pipe_cpvc", count = { 7, 23 }, probability = 40 }
    group:item("boots", 70)
    group:item("denim_overalls", 10)
    group:item("technician_coveralls", 15)
    group:item("technician_coveralls_h", 5)
    group:item("coat_lab", 20)
    group:item("gloves_rubber", 20)
    group:item("fishing_waders", 12)
    group:entry { item = "mask_filter", charges = { 0, 100 }, probability = 30 }
    group:item("glasses_safety", 35)
    group:item("goggles_chem", 5)
    group:item("hat_hard", 50)
    group:entry { item = "wearable_light", charges = { 0, 100 }, probability = 15 }
    group:item("ear_plugs", 50)
    group:item("laptop_hard_case", 20)
    group:entry { item = "extinguisher", charges = { 100, 100 }, probability = 20 }
    group:entry {
        group = "used_laptops",
        contents = {
            { group = "SUS_efiles_sewage" },
        },
        probability = 20,
    }
    group:entry { item = "flashlight", charges = { 0, 300 }, probability = 40 }
    group:item("water_purifier", 5)
    group:item("flyer", 10)
    group:item("decoy_elfa", 10)
    group:item("tongs", 10)
    group:item("boots_rubber", 20)
    group:entry { item = "sm_extinguisher", charges = { 10, 10 }, probability = 10 }
    group:item("grapnel", 1)
    group:group("tools_toolbox", 5)
    group:item("apron_plastic", 20)
    group:item("apron_leather", 2)
    group:item("chem_aluminium_sulphate", 20)
    group:item("plunger_toilet", 10)
    group:item("plunger_futuristic", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "prison_weapons", kind = "distribution" }
    group:item("tonfa", 50)
    group:item("tonfa_wood", 10)
    group:entry { item = "shocktonfa_off", charges = { 0, 500 }, probability = 25 }
    group:entry { item = "tazer", charges = { 0, 500 }, probability = 25 }
    group:entry { item = "remington_700", charges = { 0, 4 }, probability = 1 }
    group:entry { item = "3006", charges = { 1, 20 }, probability = 1 }
    group:entry { item = "ksg", charges = { 0, 7 }, probability = 1 }
    group:entry { item = "remington_870_express", charges = { 0, 7 }, probability = 1 }
    group:entry { item = "benelli_tsa", charges = { 0, 6 }, probability = 1 }
    group:entry { item = "shot_beanbag", charges = { 1, 10 }, probability = 25 }
    group:entry { item = "gasbomb", count = { 1, 6 }, probability = 20 }
    group:entry { item = "m79", charges = { 0, 0 }, probability = 8 }
    group:entry { item = "40x46mm_m651", charges = { 1, 6 }, probability = 20 }
    group:entry { item = "40x46mm_m1006", charges = { 1, 6 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_evidence", kind = "distribution" }
    group:item("crackpipe", 8)
    group:entry { item = "weed", count = { 1, 5 }, probability = 10 }
    group:item("joint", 10)
    group:item("poppy_bud", 10)
    group:entry { item = "seed_weed", count = { 2, 2 }, probability = 15 }
    group:item("seed_tobacco", 5)
    group:item("seed_poppy_bud", 15)
    group:item("rolling_paper", 5)
    group:item("pipe_glass", 15)
    group:group("coke_bag_zipper_1_8", 8)
    group:group("meth_bag_zipper_1_6", 2)
    group:group("heroin_bag_zipper_1_4", 1)
    group:item("syringe", 8)
    group:entry { item = "electrohack", charges = { 0, 100 }, probability = 3 }
    group:item("textbook_gaswarfare", 1)
    group:item("textbook_anarch", 3)
    group:item("book_forensic_reports", 3)
    group:item("improvised_munition_handbook", 1)
    group:item("brewing_cookbook", 3)
    group:item("recipe_bullets", 1)
    group:item("knife_combat", 3)
    group:item("knife_combat_army", 1)
    group:item("knife_combat_marine", 1)
    group:item("knife_KABAR", 6)
    group:item("kukri", 2)
    group:item("knife_hunting", 4)
    group:group("knife_rambo_cont", 20)
    group:item("tanto", 3)
    group:item("throwing_knife", 7)
    group:item("punch_dagger", 12)
    group:item("knuckle_brass", 16)
    group:item("knuckle_steel_forged", 8)
    group:item("claw_bar", 3)
    group:item("crowbar", 18)
    group:entry { item = "tazer", charges = { 0, 500 }, probability = 3 }
    group:item("laptop_hard_case", 2)
    group:entry {
        group = "charged_laptop",
        contents = {
            { item = "software_hacking" },
        },
        probability = 10,
    }
    group:entry {
        group = "charged_laptop",
        contents = {
            { group = "efiles_contraband" },
        },
        probability = 20,
    }
    group:entry { item = "spray_can", charges = { 0, 10 }, probability = 50 }
    group:entry { item = "lsd", count = { 1, 5 }, probability = 2 }
    group:item("pocketwatch", 5)
    group:item("sf_watch", 5)
    group:item("platinum_watch", 1)
    group:item("file", 5)
    group:item("clown_suit", 2)
    group:item("clownshoes", 2)
    group:item("bondage_suit", 1)
    group:item("gold_dental_grill", 1)
    group:item("knife_trench", 14)
    group:item("switchblade", 15)
    group:item("bondage_mask", 1)
    group:item("survnote", 5)
    group:item("thermos", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "toxic_dump_equipment", kind = "distribution" }
    group:group("used_1st_aid", 35)
    group:group("iodine_bottle_plastic_pill_supplement_1_10", 5)
    group:group("prussian_blue_bottle_plastic_pill_supplement_1_10", 5)
    group:item("canister_empty", 5)
    group:item("boots_steel", 50)
    group:item("sneakers_steel", 35)
    group:item("wrapped_rad_badge", 15)
    group:item("cleansuit", 10)
    group:group("gasmask_bag_full", 10)
    group:item("hat_hard", 50)
    group:item("ear_plugs", 50)
    group:item("textbook_carpentry", 6)
    group:item("laptop_hard_case", 5)
    group:item("mag_mechanics", 25)
    group:item("decoy_elfa", 8)
    group:entry { item = "extinguisher", charges = { 100, 100 }, probability = 20 }
    group:entry { item = "radio", charges = { 0, 100 }, probability = 20 }
    group:entry { item = "geiger_off", charges = { 0, 100 }, probability = 8 }
    group:entry { item = "rad_monitor", charges = { 0, 50 }, probability = 4 }
    group:entry { item = "UPS_OFF", charges = { 0, 1000 }, probability = 5 }
    group:item("flyer", 10)
    group:item("hazmat_suit", 5)
    group:item("e_tool", 5)
    group:entry { item = "sm_extinguisher", charges = { 10, 10 }, probability = 10 }
    group:item("55gal_drum", 40)
    group:item("30gal_drum", 30)
    group:item("steam_triple_small", 1)
    group:item("steam_triple_medium", 1)
    group:entry { item = "wearable_light", charges = { 0, 100 }, probability = 10 }
    group:item("antiparasitic", 5)
    group:group("diazepam_bottle_plastic_pill_prescription_1_10", 5)
    group:item("misc_repairkit", 5)
    group:group("tools_toolbox", 2)
    group:item("apron_cotton", 5)
    group:item("apron_leather", 5)
    group:item("apron_plastic", 15)
    group:item("apron_cut_resistant", 5)
    group:item("thermometer", 3)
    group:item("hygrometer", 3)
    group:item("barometer", 3)
    group:entry { item = "remotevehcontrol", charges = { 0, 100 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "lab_dorm", kind = "distribution", with_ammo = 50, with_magazine = 100 }
    group:entry { item = "inhaler", charges = { 10, 100 }, probability = 14 }
    group:item("eyedrops", 20)
    group:item("steroid_eyedrops", 10)
    group:item("clock", 10)
    group:group("tobacco_products", 151)
    group:group("cigar_box_opened", 15)
    group:entry { item = "weed", count = { 1, 5 }, probability = 10 }
    group:item("joint", 10)
    group:item("seed_weed", 15)
    group:item("seed_tobacco", 5)
    group:entry { item = "rolling_paper", charges = { 1, 30 }, probability = 5 }
    group:item("pipe_glass", 5)
    group:group("coke_bag_zipper_1_8", 8)
    group:group("meth_bag_zipper_1_6", 2)
    group:group("heroin_bag_zipper_1_4", 1)
    group:item("sneakers", 40)
    group:item("mask_hockey", 5)
    group:item("mask_skull", 5, "guy_fawkes")
    group:item("scarf_long", 15)
    group:item("jersey", 20)
    group:item("coat_lab", 40)
    group:item("boots_steel", 5)
    group:item("sneakers_steel", 3)
    group:item("socks", 70)
    group:item("socks_ankle", 50)
    group:item("mocassins", 20)
    group:item("bandana", 35)
    group:group("clothing_glasses", 80)
    group:item("towel", 40)
    group:item("hat_ball", 30)
    group:item("briefcase", 50)
    group:item("purse", 40)
    group:item("mbag", 20)
    group:item("fanny", 10)
    group:group("box_of_batteries_random", 50)
    group:entry { item = "bb", charges = { 1, 500 }, probability = 8 }
    group:entry { item = "bbgun", charges = { 0, 150 }, probability = 10 }
    group:item("fan", 10)
    group:item("file", 30)
    group:item("photo_album", 5)
    group:group("magazines", 255)
    group:group("novels", 125)
    group:group("literature", 20)
    group:item("ZSG", 5)
    group:item("manual_mechanics", 35)
    group:item("manual_fabrication", 12)
    group:item("manual_speech", 50)
    group:item("manual_business", 40)
    group:item("manual_computer", 20)
    group:item("tailor_portfolio", 1)
    group:item("recipe_alpha", 1)
    group:item("recipe_serum", 4)
    group:item("recipe_animal", 4)
    group:item("recipe_raptor", 1)
    group:item("recipe_labchem", 1)
    group:item("textbook_anarch", 1)
    group:item("improvised_munition_handbook", 1)
    group:item("recipe_caseless", 1)
    group:entry {
        group = "used_laptops",
        contents = {
            { group = "civilian_laptop_efiles" },
        },
        probability = 30,
    }
    group:entry { item = "smart_lamp", charges = { 0, 100 }, probability = 5 }
    group:group("civilian_phones", 61)
    group:group("civilian_eink_tablet_pcs", 15)
    group:group("civilian_memory_cards", 40)
    group:group("civilian_usb_drives", 8)
    group:item("memory_card_science", 10)
    group:item("standard_template_construct", 5)
    group:item("standard_template_construct_combat_exoskeleton", 5)
    group:entry { item = "camera", charges = { 0, 150 }, probability = 15 }
    group:entry { item = "camera_pro", charges = { 0, 150 }, probability = 5 }
    group:entry { item = "lighter", charges = { 0, 100 }, probability = 50 }
    group:entry { item = "ref_lighter", charges = { 0, 50 }, probability = 4 }
    group:entry { item = "matches", charges = { 0, 20 }, probability = 60 }
    group:entry { item = "ref_matches", charges = { 0, 32 }, probability = 60 }
    group:entry { item = "sewing_kit", charges = { 0, -1 }, probability = 47 }
    group:entry { item = "tailors_kit", charges = { 0, -1 }, probability = 3 }
    group:item("electric_spinwheel", 3)
    group:item("thread", 40)
    group:item("scissors", 50)
    group:item("soldering_iron", 70)
    group:entry { item = "soldering_iron_portable", charges = { 0, 50 }, probability = 70 }
    group:group("solder_wire_spool_part", 70)
    group:entry { item = "radio", charges = { 0, 100 }, probability = 20 }
    group:item("syringe", 8)
    group:entry { item = "mp3", charges = { 0, 100 }, probability = 6 }
    group:entry { item = "portable_game", charges = { 0, 100 }, probability = 8 }
    group:entry { item = "game_watch", charges = { 0, 50 }, probability = 2 }
    group:group("sex_accessories_domestic", 6)
    group:item("firecracker_pack", 1)
    group:item("firecracker", 1)
    group:item("fried_seeds", 10)
    group:item("chips", 65)
    group:group("soda_in_small_container", 90)
    group:item("choco_coffee_beans", 20)
    group:group("caffeine_bottle_plastic_pill_supplement_1_10", 20)
    group:item("cola_meth", 1)
    group:item("picklocks", 10)
    group:item("fursuit", 4)
    group:item("jedi_cloak", 4)
    group:entry { item = "glowstick", charges = { 1400, 1400 }, probability = 60 }
    group:item("blanket", 10)
    group:item("house_coat", 25)
    group:entry { item = "talking_doll", charges = { 0, 100 }, probability = 5 }
    group:entry { item = "marble", charges = { 1, 20 }, probability = 5 }
    group:entry { item = "creepy_doll", charges = { 0, 100 }, probability = 1 }
    group:item("straw_doll", 1)
    group:item("wristwatch", 15)
    group:item("pocketwatch", 5)
    group:entry { item = "lsd", count = { 1, 5 }, probability = 1 }
    group:group("chewing_gum_used", 30)
    group:group("chewing_gum_used_caff", 20)
    group:group("chewing_gum_used_nic", 5)
    group:item("hairpin", 5)
    group:item("barrette", 3)
    group:item("clown_suit", 1)
    group:item("clownshoes", 1)
    group:item("bondage_suit", 5)
    group:item("bondage_mask", 5)
    group:item("bodysuit_lycra", 5)
    group:item("flask_hip", 5)
    group:item("corset", 15)
    group:item("corset_waist", 15)
    group:item("tieclip", 3)
    group:group("religious_books", 18)
    group:item("collarpin", 3)
    group:item("survnote", 1)
    group:item("magnifying_glass", 2)
    group:item("thermometer", 3)
    group:item("pressure_cooker", 3)
    group:item("hygrometer", 3)
    group:item("barometer", 3)
    group:item("sextant", 2)
    group:item("badge_doctor", 5)
    group:item("lanyard", 5)
    group:item("dnd_handbook", 2)
    group:item("bodypillow", 1)
    group:group("writing_utensils", 10)
    group:group("pillbox_any_used", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "vault", kind = "distribution" }
    group:entry { item = "money_strap_ten", count = { 1, 9 }, probability = 50 }
    group:entry { item = "money_strap_twenty", count = { 1, 9 }, probability = 50 }
    group:entry { item = "money_strap_fifty", count = { 1, 9 }, probability = 50 }
    group:entry { item = "money_strap_hundred", count = { 1, 9 }, probability = 20 }
    group:entry { item = "money_bundle_one", count = { 1, 10 }, probability = 10 }
    group:entry { item = "money_bundle_two", count = { 1, 10 }, probability = 10 }
    group:entry { item = "money_bundle_five", count = { 1, 10 }, probability = 40 }
    group:entry { item = "money_bundle_ten", count = { 1, 10 }, probability = 60 }
    group:entry { item = "money_bundle_twenty", count = { 1, 10 }, probability = 80 }
    group:entry { item = "money_bundle_fifty", count = { 1, 5 }, probability = 50 }
    group:entry { item = "money_bundle_hundred", count = { 1, 2 }, probability = 10 }
    group:entry { group = "coins", count = { 1, 10 }, probability = 2 }
    group:item("file", 20)
    group:entry { item = "platinum_small", count = { 50, 150 }, wrapper = "box_small_wood", probability = 10 }
    group:entry { item = "gold_small", count = { 50, 150 }, wrapper = "box_small_wood", probability = 10 }
    group:entry { item = "silver_small", count = { 50, 150 }, wrapper = "box_small_wood", probability = 30 }
    group:item("pocketwatch", 11)
    group:item("gold_watch", 12)
    group:item("sf_watch", 10)
    group:item("platinum_watch", 1)
    group:item("gold_ring", 10)
    group:item("diamond_ring", 10)
    group:item("gold_bracelet", 12)
    group:item("silver_bracelet", 14)
    group:item("copper_bracelet", 10)
    group:item("bead_bracelet", 5)
    group:item("pearl_collar", 10)
    group:item("silver_necklace", 14)
    group:item("bead_necklace", 5)
    group:item("silver_locket", 10)
    group:item("gold_ear", 12)
    group:item("silver_ear", 14)
    group:item("copper_ear", 10)
    group:item("jade_brooch", 10)
    group:item("diamond", 10)
    group:item("crown_golden", 5)
    group:item("diamond_dental_grill", 5)
    group:item("gold_dental_grill", 5)
    group:item("briefcase", 4)
    group:item("small_relic", 3)
    group:item("holy_symbol", 3)
    group:item("holy_symbol_wood", 3)
    group:item("magic_8_ball", 2)
    group:item("coin_silver", 1)
    group:item("coin_gold", 1)
    group:item("straw_doll", 2)
    group:item("petrified_eye", 1)
    group:item("spiral_stone", 1)
    group:item("etched_skull", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mil_base_bed_hospital", kind = "distribution" }
    group:item("blanket", 200)
    group:entry {
        item = "cotton_patchwork",
        flags = {
            "FILTHY",
        },
        probability = 400,
    }
    content.add(group)
end
