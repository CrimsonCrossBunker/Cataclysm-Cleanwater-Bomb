local content = require("ccb").content

do
    local group = content.ItemGroup { id = "EXODII_basic_trade", kind = "collection" }
    group:entry { group = "EXODII_Shop_Tier0", count = { 1, 2 } }
    group:entry { group = "EXODII_Shop_NomadGear_Tier0", count = { 1, 2 } }
    group:entry { group = "EXODII_Shop_Guns_Tier0", count = { 2, 2 } }
    group:entry { group = "EXODII_Shop_OldArmour", count = { 1, 2 } }
    group:entry { group = "EXODII_CBM_Store_Tier1", count = { 4, 6 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "EXODII_trade_Tier1", kind = "collection" }
    group:entry { group = "EXODII_CBM_Store_tier1_extra", count = { 1, 2 } }
    group:entry { group = "EXODII_Shop_Guns_Tier1", count = { 1, 2 }, probability = 70 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "EXODII_trade_Tier2", kind = "collection" }
    group:entry { group = "EXODII_CBM_Store_Tier2", count = { 1, 2 } }
    group:entry { group = "EXODII_Shop_Guns_Tier2", count = { 1, 2 }, probability = 80 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "EXODII_trade_Tier3", kind = "collection" }
    group:entry { group = "EXODII_CBM_Store_Tier3", count = { 1, 2 } }
    group:entry { group = "EXODII_Shop_Guns_Tier3", count = { 1, 2 } }
    content.add(group)
end

do
    -- This stuff should be available in the Exodii store from the start.
    local group = content.ItemGroup { id = "EXODII_Shop_Tier0", kind = "collection" }
    group:entry { item = "thread", count = { 10, 20 }, probability = 75 }
    group:item("vac_mold", 10)
    group:item("box_medium", 75)
    group:item("box_large", 25)
    group:item("pipe_fittings", 70)
    group:item("goggles_welding", 50)
    group:item("welding_mask", 30)
    group:item("jerrycan", 10)
    group:item("jerrycan_big", 10)
    group:item("metal_tank", 8)
    group:item("metal_tank_little", 8)
    group:item("cu_pipe", 25)
    group:item("plastic_sheet", 10)
    group:item("oxy_torch", 45)
    group:entry { item = "weldtank", count = { 1, 2 }, probability = 15 }
    group:entry { item = "smallweldtank", count = { 1, 3 }, probability = 45 }
    group:entry { item = "tinyweldtank", count = { 1, 3 }, probability = 45 }
    group:entry { item = "oxygen_cylinder", count = { 1, 2 }, probability = 10 }
    content.add(group)
end

do
    -- This stuff should be available in the Exodii store from the start.  This group includes common items used to craft nomad gear, which the Exodii are happy to offer, as well as blueprints for them.
    local group = content.ItemGroup { id = "EXODII_Shop_NomadGear_Tier0", kind = "distribution" }
    group:entry {
        collection = {
            { item = "bp_nomad_cowl" },
            { item = "bp_nomad_bodyglove" },
            { item = "bp_nomad_jumpsuit" },
            { item = "exodii_ac_kit", count = { 1, 1 } },
            { item = "exodii_wire_kit", count = { 1, 1 } },
        },
    }
    group:entry {
        collection = {
            { item = "leather", count = { 2, 4 }, probability = 50 },
            { item = "tanned_hide", count = { 1, 2 }, probability = 30 },
            { item = "glasses_safety", probability = 30 },
            { item = "goggles_chem", probability = 10 },
            { item = "glasses_bal", probability = 10 },
        },
        probability = 50,
    }
    group:entry {
        collection = {
            { item = "sheet_cotton_patchwork", count = { 1, 4 }, probability = 50 },
            { item = "cotton_patchwork", count = { 3, 6 }, probability = 30 },
            { item = "leather", count = { 2, 4 }, probability = 50 },
            { item = "tanned_hide", count = { 1, 2 }, probability = 30 },
            { item = "thread_nomex", count = { 1, 6 }, probability = 20 },
            { item = "thread_kevlar", count = { 1, 6 }, probability = 20 },
            { item = "zipper_long_plastic", count = { 1, 2 }, probability = 10 },
            { item = "snapfastener_steel", count = { 5, 10 }, probability = 40 },
            { item = "chunk_rubber", count = { 1, 2 }, probability = 50 },
            { group = "glue_strong_domestic", count = { 1, 2 }, probability = 30 },
            { group = "glue_weak_domestic", count = { 1, 2 }, probability = 40 },
        },
        probability = 50,
    }
    group:entry {
        collection = {
            { item = "exodii_ac_kit", count = { 1, 1 } },
            { item = "exodii_wire_kit", count = { 1, 3 } },
            { item = "sheet_cotton_patchwork", count = { 1, 4 }, probability = 50 },
            { item = "cotton_patchwork", count = { 3, 6 }, probability = 30 },
            { item = "leather", count = { 2, 4 }, probability = 50 },
            { item = "tanned_hide", count = { 1, 2 }, probability = 30 },
            { item = "leather_pouch", count = { 1, 2 }, probability = 10 },
            { item = "ragpouch", count = { 1, 2 }, probability = 40 },
            { item = "tool_belt", probability = 40 },
            { item = "leather_pouch", probability = 10 },
            { group = "glue_strong_domestic", count = { 1, 2 }, probability = 15 },
            { group = "glue_weak_domestic", count = { 1, 2 }, probability = 15 },
        },
        probability = 50,
    }
    content.add(group)
end

do
    -- This stuff should be available in the Exodii store from the start.  This group includes guns and ammo the Exodii are happy to sell to noobs.
    local group = content.ItemGroup { id = "EXODII_Shop_Guns_Tier0", kind = "collection" }
    group:entry {
        distribution = {
            { item = "brogyeki", count = { 1, 2 }, probability = 20 },
            { item = "brogyaga", count = { 1, 2 }, probability = 5 },
            { item = "pamd68", count = { 1, 2 }, probability = 60 },
            { item = "pamd71z", count = { 1, 2 }, probability = 10 },
            { item = "knife_combat_army", count = { 1, 2 }, variant = "exodiibayonet", probability = 50 },
        },
    }
    group:entry {
        distribution = {
            { item = "exodiiminimag", count = { 1, 2 }, charges = { 0, 0 }, probability = 60 },
            { item = "exodiiBRmag", count = { 1, 2 }, charges = { 0, 0 }, probability = 10 },
            { item = "exodiiBRmag_26", count = { 2, 5 }, charges = { 0, 0 }, probability = 25 },
        },
    }
    group:entry { item = "123ln", count = { 2, 4 }, sealed = true, container = "box_small", probability = 60 }
    group:entry { item = "123ln_ap", count = { 2, 4 }, sealed = true, container = "box_small", probability = 30 }
    group:entry { item = "273x110sluglight", count = { 3, 4 }, sealed = true, container = "box_small", probability = 40 }
    group:entry { item = "273x44trainer", count = { 3, 5 }, sealed = true, container = "box_small", probability = 30 }
    group:entry { item = "273x110flock", count = { 1, 2 }, sealed = true, container = "box_small", probability = 10 }
    group:entry { item = "273x44flare", count = { 1, 2 }, sealed = true, container = "box_small_wood", probability = 5 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "EXODII_Shop_Guns_Tier1", kind = "collection" }
    group:entry {
        distribution = {
            { item = "sapra", count = { 1, 2 }, probability = 10 },
        },
    }
    group:entry {
        distribution = {
            { item = "exodiisapramag5", count = { 1, 2 }, charges = { 0, 0 }, probability = 10 },
        },
    }
    group:entry { item = "273x110canister", count = { 2, 4 }, sealed = true, container = "box_small", probability = 25 }
    group:entry { item = "273x44HE", count = { 1, 3 }, sealed = true, container = "box_small_wood", probability = 5 }
    group:entry { item = "exodiiBRmag_153", count = { 1, 1 }, charges = { 0, 0 }, probability = 25 }
    group:entry { item = "exodii_prybar", count = { 1, 2 }, probability = 40 }
    group:entry { item = "exodii_digger", count = { 1, 2 }, probability = 35 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "EXODII_Shop_Guns_Tier3", kind = "collection" }
    group:entry { item = "273x44RG", count = { 1, 2 }, sealed = true, container = "box_medium_wood", probability = 10 }
    group:entry { item = "273x110slugheavy", count = { 1, 2 }, sealed = true, container = "box_small", probability = 30 }
    content.add(group)
end

do
    -- Ideally this will be moved into possible reward for finding useful stuff within exodii dungeons.
    local group = content.ItemGroup { id = "EXODII_Shop_Guns_caotel", kind = "collection" }
    group:entry { item = "exodii_plasma_projectile", count = { 1, 1 } }
    group:entry { item = "caotel_plasma_ring", count = { 1, 1 } }
    group:entry { item = "caotel_cell", count = { 2, 2 }, sealed = true, container = "box_small" }
    content.add(group)
end

do
    -- This stuff should be available in the Exodii store from the start.  Old Thessalonian armor the Exodii brought with them.
    -- Ideally, the spear should be sold as a spearhead and the player crafts it by getting their own pole.
    local group = content.ItemGroup { id = "EXODII_Shop_OldArmour", kind = "collection" }
    group:entry { item = "gambeson", count = { 1, 2 }, probability = 40 }
    group:entry { item = "armor_lorica", count = { 1, 2 }, probability = 20 }
    group:entry { item = "helmet_corinthian", count = { 1, 2 }, probability = 60 }
    group:entry { item = "armor_thessalonian", count = { 1, 2 }, probability = 80 }
    group:entry { item = "leggings_thessalonian", count = { 1, 2 }, probability = 80 }
    group:entry { item = "sword_xiphos", count = { 1, 2 }, probability = 50 }
    group:entry { item = "spear_dory", count = { 1, 2 }, probability = 30 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "EXODII_CBM_tier1_utility", kind = "distribution" }
    group:item("bio_watch", 10)
    group:item("bio_alarm", 10)
    group:item("bio_sunglasses", 10)
    group:item("bio_meteorologist", 10)
    group:item("bio_pitch_perfect", 10)
    group:item("bio_fitnessband", 10)
    group:item("bio_radio", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "EXODII_CBM_tier1_power", kind = "distribution" }
    group:item("bio_power_storage", 30)
    group:item("bio_batteries", 1)
    group:item("bio_cable", 5)
    group:item("bio_betavoltaic", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "EXODII_CBM_tier1_tools", kind = "distribution" }
    group:item("bio_syringe", 10)
    group:item("bio_flashlight", 10)
    group:item("bio_lighter", 10)
    group:item("bio_multimeter", 5)
    group:item("bio_magnet", 5)
    group:item("bio_fingerhack", 2)
    group:item("bio_geiger", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bionics_pulled_out_prototype", kind = "distribution" }
    group:entry { item = "bio_power_storage", count = { 1, 5 } }
    group:entry { item = "bio_power_storage_mkII", count = { 1, 2 }, probability = 8 }
    group:entry { item = "bio_armor_arms", count = { 1, 1 }, probability = 60 }
    group:entry { item = "bio_armor_eyes", count = { 1, 1 }, probability = 60 }
    group:entry { item = "bio_armor_head", count = { 1, 1 }, probability = 60 }
    group:entry { item = "bio_armor_legs", count = { 1, 1 }, probability = 60 }
    group:entry { item = "bio_armor_torso", count = { 1, 1 }, probability = 60 }
    group:entry { item = "bio_batteries", count = { 1, 1 }, probability = 11 }
    group:entry { item = "bio_blood_anal", count = { 1, 1 }, probability = 4 }
    group:entry { item = "bio_blood_filter", count = { 1, 1 }, probability = 5 }
    group:entry { item = "bio_cable", count = { 1, 1 }, probability = 30 }
    group:entry { item = "bio_climate", count = { 1, 1 }, probability = 10 }
    group:entry { item = "bio_dex_enhancer", count = { 1, 1 }, probability = 8 }
    group:entry { item = "bio_ears", count = { 1, 1 }, probability = 17 }
    group:entry { item = "bio_sonar", count = { 1, 1 }, probability = 2 }
    group:entry { item = "bio_evap", count = { 1, 1 }, probability = 8 }
    group:entry { item = "bio_eye_enhancer", count = { 1, 1 }, probability = 2 }
    group:entry { item = "bio_eye_optic", count = { 1, 1 }, probability = 2 }
    group:entry { item = "bio_fitnessband", count = { 1, 1 }, probability = 16 }
    group:entry { item = "bio_geiger", count = { 1, 1 }, probability = 18 }
    group:entry { item = "bio_gills", count = { 1, 1 }, probability = 10 }
    group:entry { item = "bio_ground_sonar", count = { 1, 1 }, probability = 9 }
    group:entry { item = "bio_heat_absorb", count = { 1, 1 }, probability = 4 }
    group:entry { item = "bio_heatsink", count = { 1, 1 }, probability = 6 }
    group:entry { item = "bio_radio", count = { 1, 1 }, probability = 11 }
    group:entry { item = "bio_sunglasses", count = { 1, 1 }, probability = 11 }
    group:entry { item = "bio_ar", count = { 1, 1 }, probability = 22 }
    group:entry { item = "bio_alarm", count = { 1, 1 }, probability = 26 }
    group:entry { item = "bio_painkiller", count = { 1, 1 }, probability = 12 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "EXODII_CBM_tier1_fun", kind = "distribution" }
    group:item("bio_tattoo_led", 10)
    group:item("bio_nostril", 1)
    group:item("bio_voice", 10)
    group:item("bio_sleep_shutdown", 2)
    content.add(group)
end

do
    -- To get items from this group in the Exodii CBM store requires finishing missions for their faction and earning their trust
    local group = content.ItemGroup { id = "EXODII_CBM_unlocks_weapons_light", kind = "distribution" }
    group:item("bio_blade", 10)
    group:item("bio_claws", 10)
    group:item("bio_cqb", 10)
    group:item("bio_flashbang", 10)
    group:item("bio_razors", 10)
    content.add(group)
end

do
    -- To get items from this group in the Exodii CBM store requires finishing missions for their faction and earning their trust
    local group = content.ItemGroup { id = "EXODII_CBM_unlocks_weapons_medium", kind = "distribution" }
    group:item("bio_resonator", 10)
    group:item("bio_targeting", 15)
    group:item("bio_shotgun", 10)
    group:item("bio_laser", 5)
    group:item("bio_shock", 10)
    group:item("bio_recoil", 15)
    group:item("bio_taser", 10)
    content.add(group)
end

do
    -- At this point the Exodii trust you enough to sell you the materials to bootstrap some of their salvaged tech onto your own tech.
    local group = content.ItemGroup { id = "EXODII_Store_Salvage_Tech", kind = "collection" }
    group:item("exodii_wiring_kit_reference")
    group:entry { item = "exodii_wire_kit", count = { 1, 4 } }
    content.add(group)
end

do
    -- This group does not spawn anywhere, it exists only to set Exodii merchant prices
    -- It does not include exodii-specific metal resources--the exodii don't buy those because they know where they came from.
    local group = content.ItemGroup { id = "exodii_pay_extra_for_metals", kind = "distribution" }
    group:item("1l_aluminum", 1)
    group:item("5l_aluminum", 1)
    group:item("10l_aluminum", 1)
    group:item("1l_brass", 1)
    group:item("5l_brass", 1)
    group:item("10l_brass", 1)
    group:item("1l_bronze", 1)
    group:item("5l_bronze", 1)
    group:item("10l_bronze", 1)
    group:item("1l_copper", 1)
    group:item("5l_copper", 1)
    group:item("10l_copper", 1)
    group:item("1l_tin", 1)
    group:item("5l_tin", 1)
    group:item("10l_tin", 1)
    group:item("1l_zinc", 1)
    group:item("5l_zinc", 1)
    group:item("10l_zinc", 1)
    group:item("1l_gold", 1)
    group:item("5l_gold", 1)
    group:item("10l_gold", 1)
    group:item("1l_silver", 1)
    group:item("5l_silver", 1)
    group:item("10l_silver", 1)
    group:item("5l_iron", 1)
    group:item("10l_iron", 1)
    group:item("10l_zinc", 1)
    group:item("1l_lead", 1)
    group:item("5l_lead", 1)
    group:item("10l_lead", 1)
    group:item("1l_platinum", 1)
    group:item("5l_platinum", 1)
    group:item("10l_platinum", 1)
    group:item("5l_steel", 1)
    group:item("10l_steel", 1)
    group:item("5l_budget_steel", 1)
    group:item("10l_budget_steel", 1)
    group:item("5l_lc_steel", 1)
    group:item("10l_lc_steel", 1)
    group:item("5l_mc_steel", 1)
    group:item("10l_mc_steel", 1)
    group:item("5l_hc_steel", 1)
    group:item("10l_hc_steel", 1)
    content.add(group)
end

do
    -- This group does not spawn anywhere, it exists only to set Exodii merchant prices
    local group = content.ItemGroup { id = "exodii_do_not_pay_extra_for_exodii_metal", kind = "distribution" }
    group:item("exodii_ingot_tin", 1)
    group:item("exodii_ingot_lc_steel", 1)
    group:item("exodii_ingot_plastic", 1)
    group:item("exodii_ingot_aluminum", 1)
    group:item("exodii_ingot_copper", 1)
    group:item("exodii_ingot_zinc", 1)
    group:item("exodii_ingot_lead", 1)
    content.add(group)
end

do
    -- This group does not spawn anywhere, it exists only to set Exodii merchant prices
    local group = content.ItemGroup { id = "exodii_pay_extra_for_medicine", kind = "collection" }
    group:item("disinfectant", 1)
    group:item("medical_gauze", 1)
    group:item("bandages", 1)
    group:item("liq_bandage_spray", 1)
    group:item("chem_hydrogen_peroxide_conc", 1)
    group:item("metaprolol", 1)
    group:item("codeine", 1)
    group:item("acetaminophen", 1)
    group:item("ibuprofen", 1)
    group:item("naproxen", 1)
    group:item("antiparasitic", 1)
    group:item("aspirin", 1)
    group:item("antifungal", 1)
    group:item("diazepam", 1)
    group:item("antibiotics", 1)
    group:item("strong_antibiotic", 1)
    group:item("weak_antibiotic", 1)
    group:item("panacea", 1)
    group:item("morphine", 1)
    group:item("tramadol", 1)
    group:item("thorazine", 1)
    content.add(group)
end

do
    -- This group does not spawn anywhere, it exists only to set Exodii merchant prices
    local group = content.ItemGroup { id = "exodii_do_not_pay_extra_for_makeshift_medicine", kind = "distribution" }
    group:item("bandages_makeshift", 1)
    group:item("bandages_makeshift_boiled", 1)
    group:item("bandages_makeshift_bleached", 1)
    group:item("disinfectant_makeshift", 1)
    content.add(group)
end

do
    -- This group does not spawn anywhere, it exists only to set Exodii merchant prices
    local group = content.ItemGroup { id = "exodii_pay_extra_for_ammo", kind = "distribution" }
    group:item("50ss", 1)
    group:item("50match", 1)
    group:item("50bmg", 1)
    group:item("50_incendiary", 1)
    group:item("9mm", 1)
    group:item("9mmP", 1)
    group:item("9mmP2", 1)
    group:item("9mmfmj", 1)
    group:item("556", 1)
    group:item("556_m995", 1)
    group:item("556_mk262", 1)
    group:item("556_mk318", 1)
    group:item("556_m855a1", 1)
    group:item("556_incendiary", 1)
    content.add(group)
end

do
    -- This group does not spawn anywhere, it exists only to set Exodii merchant prices
    local group = content.ItemGroup { id = "exodii_pay_extra_for_petrochemical", kind = "distribution" }
    group:item("gasoline", 1)
    group:item("diesel", 1)
    group:item("biodiesel", 1)
    group:item("jp8", 1)
    group:item("avgas", 1)
    group:item("propane", 1)
    group:item("lamp_oil", 1)
    group:item("crude_lamp_oil", 1)
    group:item("crude_oil", 1)
    content.add(group)
end

do
    -- Boy it sure would be nice if there were a better way to do this
    local group = content.ItemGroup { id = "exodii_do_not_buy_ammo_blacklist", kind = "collection" }
    group:item("22_cb", 1)
    group:item("22_lr", 1)
    group:item("22_fmj", 1)
    group:item("bp_223", 1)
    group:item("22_blank", 1)
    group:item("22_ratshot", 1)
    group:item("reloaded_22_lr", 1)
    group:item("reloaded_22_fmj", 1)
    group:item("shot_slug", 1)
    group:item("shot_beanbag", 1)
    group:item("shot_00", 1)
    group:item("shot_bird", 1)
    group:item("shot_flechette", 1)
    group:item("reloaded_shot_bird", 1)
    group:item("reloaded_shot_00", 1)
    group:item("reloaded_shot_flechette", 1)
    group:item("shot_scrap", 1)
    group:item("bp_shot_slug", 1)
    group:item("bp_shot_00", 1)
    group:item("bp_shot_bird", 1)
    group:item("bp_shot_flechette", 1)
    group:item("bp_shot_scrap", 1)
    group:item("reloaded_shot_dragon", 1)
    group:item("bp_shot_dragon", 1)
    group:item("reloaded_shot_00")
    group:item("reloaded_shot_bird", 30)
    group:item("reloaded_shot_dragon", 20)
    group:item("reloaded_shot_flechette", 5)
    group:item("reloaded_shot_slug", 30)
    group:item("shot_scrap", 80)
    group:item("reloaded_9mm", 1)
    group:item("reloaded_9mmfmj", 1)
    group:item("reloaded_9mmP", 1)
    group:item("reloaded_9mmP2", 1)
    group:item("reloaded_9x18mm", 1)
    group:item("reloaded_9x18mmP2", 1)
    group:item("reloaded_9x18mmfmj", 1)
    group:item("bp_9mm", 1)
    group:item("bp_9mmfmj", 1)
    group:item("reloaded_10mm_fmj", 1)
    group:item("reloaded_10mm_jhp", 1)
    group:item("reloaded_10mmP", 1)
    group:item("reloaded_10mm_fmj", 1)
    group:item("reloaded_10mm_jhp", 1)
    group:item("reloaded_10mmP", 1)
    group:item("reloaded_30carbine_jsp", 1)
    group:item("reloaded_30carbine", 1)
    group:item("reloaded_32_acp", 1)
    group:item("reloaded_32_acp_jhp", 1)
    group:item("reloaded_38_fmj", 1)
    group:item("bp_38super_fmj", 1)
    group:item("reloaded_38_special", 1)
    group:item("reloaded_38_special_p", 1)
    group:item("reloaded_38_super", 1)
    group:item("reloaded_38super_fmj", 1)
    group:item("bp_38_fmj", 1)
    group:item("bp_38_special", 1)
    group:item("matchhead_38_fmj", 1)
    group:item("matchhead_38_special", 1)
    group:item("reloaded_40fmj", 1)
    group:item("reloaded_40sw", 1)
    group:item("40x53mm_buckshot_m169", 1)
    group:item("40x53mm_slug_m169", 1)
    group:item("40x53mm_flechette_m169", 1)
    group:item("reloaded_44fmj", 1)
    group:item("reloaded_44magnum", 1)
    group:item("reloaded_45_acp", 1)
    group:item("reloaded_45_jhp", 1)
    group:item("bp_45_acp", 1)
    group:item("bp_45_jhp", 1)
    group:item("bp_44fmj", 1)
    group:item("matchhead_45_acp", 1)
    group:item("matchhead_45_jhp", 1)
    group:item("reloaded_45_super", 1)
    group:item("reloaded_45colt_jhp", 1)
    group:item("reloaded_45colt_fmj", 1)
    group:item("reloaded_50beowulf_xtp", 1)
    group:item("reloaded_50beowulf_penetrator", 1)
    group:item("reloaded_50_incendiary", 1)
    group:item("reloaded_50bmg", 1)
    group:item("reloaded_50ss", 1)
    group:item("reloaded_50ss", 1)
    group:item("reloaded_50ae_fmj", 1)
    group:item("reloaded_50ae_jhp", 1)
    group:item("reloaded_57mm", 1)
    group:item("reloaded_77mm_arisaka_jsp", 1)
    group:item("reloaded_223", 1)
    group:item("bp_223", 1)
    group:item("reloaded_556", 1)
    group:item("reloaded_556_incendiary", 1)
    group:item("reloaded_270win_jsp", 1)
    group:item("reloaded_270win_fmj", 1)
    group:item("reloaded_300_winmag", 1)
    group:item("reloaded_300blk", 1)
    group:item("reloaded_300blk_ss", 1)
    group:item("reloaded_303", 1)
    group:item("reloaded_303sp", 1)
    group:item("reloaded_303fmj", 1)
    group:item("reloaded_308", 1)
    group:item("bp_308", 1)
    group:item("bp_762_51", 1)
    group:item("bp_762_51_incendiary", 1)
    group:item("reloaded_762_51", 1)
    group:item("reloaded_762_51_incendiary", 1)
    group:item("reloaded_338lapua_hpbt", 1)
    group:item("reloaded_338lapua_fmjbt", 1)
    group:item("reloaded_338lapua_api", 1)
    group:item("reloaded_357mag_fmj", 1)
    group:item("reloaded_357mag_jhp", 1)
    group:item("matchhead_357mag_fmj", 1)
    group:item("matchhead_357mag_jhp", 1)
    group:item("reloaded_357sig_fmj", 1)
    group:item("reloaded_357sig_jhp", 1)
    group:item("bp_357sig_fmj", 1)
    group:item("bp_357sig_jhp", 1)
    group:item("matchhead_357sig_fmj", 1)
    group:item("matchhead_357sig_jhp", 1)
    group:item("reloaded_380_FMJ", 1)
    group:item("reloaded_380_JHP", 1)
    group:item("reloaded_380_p", 1)
    group:item("matchhead_380_FMJ", 1)
    group:item("matchhead_380_JHP", 1)
    group:item("reloaded_410shot_slug", 1)
    group:item("bp_410shot_slug", 1)
    group:item("reloaded_410shot_000", 1)
    group:item("bp_410shot_000", 1)
    group:item("reloaded_410shot_bird", 1)
    group:item("bp_410shot_bird", 1)
    group:item("410shot_scrap", 1)
    group:item("bp_410shot_scrap", 1)
    group:item("reloaded_450_ftx", 1)
    group:item("reloaded_450_penetrator", 1)
    group:item("reloaded_454_Casull", 1)
    group:item("bp_454_Casull", 1)
    group:item("reloaded_458wm", 1)
    group:item("reloaded_460sw_jhp", 1)
    group:item("reloaded_460sw", 1)
    group:item("reloaded_545", 1)
    group:item("reloaded_545_ap", 1)
    group:item("bp_545", 1)
    group:item("bp_545_ap", 1)
    group:item("bp_556", 1)
    group:item("bp_556_incendiary", 1)
    group:item("reloaded_762_jhp", 1)
    group:item("bp_762_jhp", 1)
    group:item("reloaded_762_m87", 1)
    group:item("bp_762_m87", 1)
    group:item("reloaded_762_54R", 1)
    group:item("bp_762_54R", 1)
    group:item("reloaded_762_25", 1)
    group:item("matchhead_762_25", 1)
    group:item("bp_3006_jsp", 1)
    group:item("reloaded_3006_jsp", 1)
    group:item("bp_3006", 1)
    group:item("bp_3006_incendiary", 1)
    group:item("bp_3006fmj", 1)
    group:item("reloaded_3006", 1)
    group:item("reloaded_3006_incendiary", 1)
    group:item("reloaded_3030_fmj", 1)
    group:item("reloaded_3030", 1)
    group:item("reloaded_3030_bp", 1)
    group:item("reloaded_3030_fmj_bp", 1)
    group:item("reloaded_4570_sp", 1)
    group:item("reloaded_4570_pen", 1)
    group:item("reloaded_4570_low", 1)
    group:item("reloaded_4570_bp", 1)
    group:item("reloaded_shot_00", 1)
    group:item("reloaded_shot_flechette", 1)
    group:item("reloaded_shot_slug", 1)
    group:item("bp_shot_bird", 1)
    group:item("bp_shot_dragon", 1)
    group:item("bp_shot_00", 1)
    group:item("bp_shot_flechette", 1)
    group:item("bp_shot_slug", 1)
    group:item("shot_beanbag", 1)
    group:item("shot_scrap", 1)
    group:item("bp_shot_scrap", 1)
    group:item("wax_slug", 1)
    content.add(group)
end

do
    -- Due to jumps making currency from the last world worthless, the Exodii prefers to directly barter for what they want or need.
    -- This should include all currencies used by post-cataclysm groups.
    local group = content.ItemGroup { id = "exodii_do_not_buy_currency_blacklist", kind = "collection" }
    group:item("FMCNote", 1)
    group:item("money_strap_FMCNote", 1)
    group:item("money_bundle_FMCNote", 1)
    group:item("RobofacCoin", 1)
    group:item("FlatCoin", 1)
    group:item("signed_chit", 1)
    group:item("icon", 1)
    content.add(group)
end

do
    -- copy-from and expand this in mods for all mod items that Exodii simply should not buy.
    local group = content.ItemGroup { id = "Exodii_mod_blacklist_items", kind = "collection" }
    group:group("Exodii_Magiclysm_no_spell_scrolls", 1)
    group:group("Exodii_XE_no_dreamdross_items", 1)
    group:group("Exodii_XE_no_fair_folk_items", 1)
    group:group("Exodii_XE_no_spell_items", 1)
    content.add(group)
end

do
    -- This group does not spawn anywhere, it exists only to set Exodii merchant prices
    local group = content.ItemGroup { id = "exodii_unwanted_bathroom_medicine", kind = "collection" }
    group:entry {
        distribution = {
            { group = "birth_control", probability = 50 },
            { group = "estrogen_hrt", probability = 3 },
            { group = "testosterone_hrt", probability = 2 },
        },
        probability = 95,
    }
    group:item("comb_lice", 10)
    group:entry { item = "eyedrops", count = { 10, 10 }, probability = 15 }
    group:entry { item = "steroid_eyedrops", count = { 5, 5 }, probability = 5 }
    group:entry { item = "pepto", charges = { 1, -1 }, container = "bottle_plastic_small", probability = 60 }
    group:group("tums_bottle_plastic_small_1_20", 60)
    group:entry { item = "inhaler", charges = { 10, 100 }, probability = 25 }
    group:group("tampon_box_used", 20)
    group:group("menstrual_pad_box_used", 20)
    group:item("menstrual_cup", 2)
    group:group("alcohol_wipes_box_used", 60)
    group:group("alcohol_wipes_box_full", 20)
    group:entry {
        distribution = {
            {
                item = "pills_sleep",
                count = { 1, 10 },
                wrapper = "bottle_plastic_pill_prescription",
                container = "null",
                probability = 60,
            },
            {
                item = "melatonin_tablet",
                count = { 1, 30 },
                wrapper = "bottle_plastic_pill_prescription",
                container = "null",
                probability = 40,
            },
        },
        probability = 10,
    }
    group:entry {
        distribution = {
            { item = "nyquil", charges = { 1, -1 }, probability = 60 },
            { item = "dayquil", charges = { 1, -1 }, probability = 20 },
        },
        probability = 50,
    }
    content.add(group)
end
