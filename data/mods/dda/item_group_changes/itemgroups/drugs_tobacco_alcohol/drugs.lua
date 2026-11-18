local content = require("ccb").content

do
    -- Drugs not contained within any other category
    local group = content.ItemGroup { id = "drugs_misc", kind = "distribution" }
    group:group("bfipowder_bottle_plastic_5_60")
    group:group("any_cough_syrup_in_bottle")
    group:entry { item = "flu_shot", count = { 1, 10 }, container = "null", probability = 50 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "harddrugs", kind = "distribution" }
    group:group("harddrugs_residential", 133)
    group:item("flu_shot", 5)
    content.add(group)
end

do
    -- Rare and/or valuable drugs excluding painkillers
    local group = content.ItemGroup { id = "drugs_rare", kind = "distribution" }
    group:group("adderall_dr_group", 10)
    group:group("antibiotics_dr_group", 10)
    group:group("strong_antibiotics_dr_group", 10)
    group:group("antifungal_dr_group", 10)
    group:group("antiparasitic_dr_group", 10)
    group:group("diazepam_dr_group", 10)
    group:group("iron_dr_group", 10)
    group:group("prozac_dr_group", 10)
    group:group("thorazine_dr_group", 10)
    group:group("xanax_dr_group", 10)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "birth_control",
        kind = "distribution",
        container = "blister_pack_small",
        container_variant = "blister_pack_bc",
    }
    group:entry {
        collection = {
            { item = "birth_control", count = { 0, 21 } },
            { item = "homeopathic_pills", count = { 7, 7 }, variant = "sugar_pill" },
        },
        probability = 40,
    }
    group:entry { item = "homeopathic_pills", count = { 0, 6 }, variant = "sugar_pill", probability = 5 }
    group:entry { item = "birth_control", count = { 0, 28 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "softdrugs", kind = "distribution" }
    group:entry { item = "bandages", count = { 1, 3 }, probability = 30 }
    group:group("adhesive_bandages_box_used", 30)
    group:entry { item = "liq_bandage_spray", charges = { 1, -1 }, probability = 5 }
    group:group("cotton_ball_bag_used", 50)
    group:group("cotton_ball_bag_full", 5)
    group:group("used_1st_aid", 35)
    group:entry { item = "saline", charges = { 1, 5 }, probability = 25 }
    group:group("box_of_contact_lens_any", 10)
    group:item("transition_contacts", 1)
    group:group("vitamins_bottle_plastic_pill_supplement_1_20", 75)
    group:entry { item = "gummy_vitamins", count = { 1, 10 }, probability = 25 }
    group:group("calcium_tablet_bottle_plastic_pill_supplement_1_20", 75)
    group:group("vitc_tablet_bottle_plastic_pill_supplement_1_20", 40)
    group:group("bottle_otc_painkiller_1_20", 85)
    group:group("caffeine_bottle_plastic_pill_supplement_1_10", 25)
    group:group("pills_sleep_bottle_plastic_pill_prescription_1_10", 15)
    group:group("melatonin_tablet_bottle_plastic_pill_supplement_1_30", 10)
    group:group("antihistamine_bottle_plastic_pill_supplement_1_30", 15)
    group:group("iodine_bottle_plastic_pill_supplement_1_10", 5)
    group:group("prussian_blue_bottle_plastic_pill_supplement_1_10", 5)
    group:group("any_cough_syrup_in_bottle", 140)
    group:group("alcohol_wipes_box_used", 75)
    group:group("alcohol_wipes_box_full", 10)
    group:entry { item = "disinfectant", charges = { 1, 10 }, probability = 35 }
    group:group("homeopathic_pills_bottle_plastic_pill_supplement_1_20", 10)
    group:group("protein_powder_bottle_plastic_small_1_9", 12)
    group:entry { item = "caff_gum", count = { 1, 10 }, probability = 10 }
    group:entry { item = "smoxygen_tank", charges = { 0, 12 }, probability = 5 }
    group:item("eyedrops", 35)
    group:item("steroid_eyedrops", 15)
    group:entry { item = "shavingkit", charges = { 0, 10 }, probability = 5 }
    group:entry { item = "elec_hairtrimmer", charges = { 0, 50 }, probability = 2 }
    group:entry { item = "nic_gum", count = { 1, 10 }, probability = 25 }
    group:group("weak_antibiotic_bottle_plastic_pill_prescription_1_5", 30)
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "virology_lab_fridge", kind = "distribution" }
    group:item("blood", 300)
    group:item("vacutainer")
    group:item("jar_glass_sealed", 30)
    group:item("jar_3l_glass_sealed", 15)
    group:item("hygrometer", 3)
    group:item("chem_nitric_acid", 15)
    group:item("denat_alcohol", 60)
    group:item("methed_alcohol", 40)
    group:item("thermometer", 50)
    group:item("pressure_cooker", 15)
    group:item("flu_shot", 50)
    group:item("disinfectant", 35)
    content.upsert_item_group(group)
end
