local content = require("ccb").content

do
    local group = content.ItemGroup { id = "drugs_morphine", kind = "distribution" }
    group:entry { item = "morphine", count = { 1, 12 }, container = "null", probability = 10 }
    group:entry { item = "heroin", count = { 20, 30 }, wrapper = "bag_zipper", container = "null", probability = 10 }
    group:group("oxycodone_ad_group", 40)
    group:group("codeine_ad_group", 60)
    group:group("tramadol_ad_group", 60)
    content.add(group)
end

do
    -- Common healing items found almost everywhere
    local group = content.ItemGroup { id = "drugs_heal_simple", kind = "distribution" }
    group:group("used_1st_aid", 5)
    group:item("aspirin", 10)
    group:item("ibuprofen", 17)
    group:item("acetaminophen", 13)
    group:item("naproxen", 10)
    group:group("alcohol_wipes_box_used", 40)
    group:group("alcohol_wipes_box_full", 5)
    group:entry { item = "bandages", count = { 1, 3 }, probability = 30 }
    group:item("liq_bandage_spray", 5)
    group:group("adhesive_bandages_box_used", 50)
    group:group("cotton_ball_bag_used", 40)
    group:group("cotton_ball_bag_full", 20)
    group:group("tampon_box_used", 40)
    group:group("menstrual_pad_box_used", 40)
    group:item("disinfectant", 30)
    group:item("eyedrops", 10)
    group:item("steroid_eyedrops", 5)
    group:item("medical_gauze", 20)
    group:group("medical_tape_roll_part", 20)
    group:item("pepto", 20)
    group:item("tums", 20)
    group:item("saline", 10)
    group:item("weak_antibiotic", 30)
    group:item("homeopathic_pills", 10)
    content.add(group)
end

do
    -- Medical consumables for emergency use excluding painkillers
    local group = content.ItemGroup { id = "drugs_emergency", kind = "distribution" }
    group:item("adrenaline_injector", 50)
    group:entry { item = "inhaler", charges = { 10, 100 } }
    group:group("quikclot_bag_plastic_1_6", 50)
    group:entry { item = "smoxygen_tank", charges = { 0, 12 }, probability = 70 }
    group:entry {
        distribution = {
            { group = "full_ifak" },
            { group = "used_ifak" },
        },
        probability = 40,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "harddrugs_residential", kind = "distribution" }
    group:entry { item = "inhaler", charges = { 10, 100 }, probability = 14 }
    group:group("codeine_bottle_plastic_pill_painkiller_1_10", 15)
    group:group("oxycodone_bottle_plastic_pill_prescription_1_10", 4)
    group:entry { item = "morphine", count = { 1, 4 }, probability = 4 }
    group:group("tramadol_bottle_plastic_pill_prescription_1_10", 11)
    group:group("xanax_bottle_plastic_pill_prescription_1_10", 10)
    group:group("adderall_bottle_plastic_pill_prescription_1_10", 10)
    group:group("thorazine_bottle_plastic_pill_prescription_1_10", 7)
    group:group("prozac_bottle_plastic_pill_prescription_1_15", 10)
    group:group("antibiotics_bottle_plastic_pill_prescription_1_15", 25)
    group:group("strong_antibiotic_bottle_plastic_pill_prescription_1_5", 5)
    group:group("antifungal_bottle_plastic_pill_prescription_1_5", 2)
    group:group("antiparasitic_bottle_plastic_pill_prescription_1_10", 3)
    group:item("survnote", 1)
    group:group("diazepam_bottle_plastic_pill_prescription_1_10", 4)
    group:item("syringe", 8)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pillbox_contents", kind = "collection" }
    group:entry {
        distribution = {
            { item = "vitamins", count = { 5, 7 }, container = "null", probability = 60 },
            { item = "gummy_vitamins", count = { 5, 7 }, container = "null", probability = 20 },
            { item = "calcium_tablet", count = { 5, 7 }, container = "null", probability = 20 },
        },
        probability = 90,
    }
    group:entry { item = "homeopathic_pills", count = { 5, 7 }, container = "null", probability = 30 }
    group:entry { item = "antihistamine", count = { 3, 7 }, container = "null", probability = 15 }
    group:entry {
        distribution = {
            { item = "adderall", count = { 3, 7 }, container = "null", probability = 20 },
            { item = "diazepam", count = { 3, 7 }, container = "null", probability = 20 },
            { item = "prozac", count = { 3, 7 }, container = "null", probability = 20 },
            { item = "thorazine", count = { 3, 7 }, container = "null", probability = 20 },
            { item = "pills_sleep", count = { 3, 7 }, container = "null", probability = 20 },
        },
        probability = 15,
    }
    group:entry {
        distribution = {
            { item = "antibiotics", count = { 3, 7 }, container = "null", probability = 40 },
            { item = "weak_antibiotic", count = { 3, 7 }, container = "null", probability = 40 },
            { item = "strong_antibiotic", count = { 3, 7 }, container = "null", probability = 20 },
        },
        probability = 10,
    }
    group:entry { item = "antifungal", count = { 3, 7 }, container = "null", probability = 5 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pillbox_used", kind = "distribution", container = "pillbox", overflow = "discard" }
    group:group("pillbox_contents")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "pillbox_large_used",
        kind = "distribution",
        container = "pillbox_large",
        overflow = "discard",
    }
    group:group("pillbox_contents")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pillbox_any_used", kind = "distribution" }
    group:group("pillbox_used")
    group:group("pillbox_large_used")
    content.add(group)
end

do
    -- Includes aspirin and other similar low-grade painkillers.
    local group = content.ItemGroup {
        id = "bottle_otc_painkiller_20",
        kind = "distribution",
        container = "bottle_plastic_pill_painkiller",
    }
    group:entry { item = "aspirin", count = { 20, 20 }, container = "null" }
    group:entry { item = "ibuprofen", count = { 20, 20 }, container = "null" }
    group:entry { item = "acetaminophen", count = { 20, 20 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "bottle_otc_painkiller_1_20",
        kind = "distribution",
        container = "bottle_plastic_pill_painkiller",
    }
    group:entry { item = "aspirin", count = { 1, 20 }, container = "null" }
    group:entry { item = "ibuprofen", count = { 1, 20 }, container = "null" }
    group:entry { item = "acetaminophen", count = { 1, 20 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "bottle_otc_painkiller_10",
        kind = "distribution",
        container = "bottle_plastic_pill_painkiller",
    }
    group:entry { item = "aspirin", count = { 10, 10 }, container = "null" }
    group:entry { item = "acetaminophen", count = { 10, 10 }, container = "null" }
    group:entry { item = "ibuprofen", count = { 10, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "bottle_otc_painkiller_0_10",
        kind = "distribution",
        container = "bottle_plastic_pill_painkiller",
    }
    group:entry { item = "aspirin", count = { 0, 10 }, container = "null" }
    group:entry { item = "acetaminophen", count = { 0, 10 }, container = "null" }
    group:entry { item = "ibuprofen", count = { 0, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "aspirin_ad_group",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "aspirin", count = { 5, 60 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "aspirin_bottle_full",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "aspirin", count = { 20, 20 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "acetaminophen_ad_group",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "acetaminophen", count = { 5, 60 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "acetaminophen_bottle_full",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "acetaminophen", count = { 20, 20 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ibuprofen_ad_group",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "ibuprofen", count = { 5, 60 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ibuprofen_bottle_full",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "ibuprofen", count = { 20, 20 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "naproxen_ad_group",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "naproxen", count = { 5, 60 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "naproxen_bottle_full",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "naproxen", count = { 20, 20 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "codeine_ad_group",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "codeine", count = { 1, 21 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "codeine_bottle_plastic_pill_painkiller_10",
        kind = "collection",
        container = "bottle_plastic_pill_painkiller",
    }
    group:entry { item = "codeine", count = { 10, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "codeine_bottle_plastic_pill_painkiller_1_10",
        kind = "collection",
        container = "bottle_plastic_pill_painkiller",
    }
    group:entry { item = "codeine", count = { 1, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "tramadol_ad_group",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "tramadol", count = { 1, 120 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "tramadol_bottle_plastic_pill_prescription_10",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "tramadol", count = { 10, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "tramadol_bottle_plastic_pill_prescription_1_10",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "tramadol", count = { 1, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "oxycodone_ad_group",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "oxycodone", count = { 1, 30 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "oxycodone_bottle_plastic_pill_prescription_10",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "oxycodone", count = { 10, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "oxycodone_bottle_plastic_pill_prescription_1_10",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "oxycodone", count = { 1, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "adderall_dr_group",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "adderall", count = { 15, 60 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "adderall_bottle_plastic_pill_prescription_1_10",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "adderall", count = { 1, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "adderall_bottle_plastic_pill_prescription_10",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "adderall", count = { 10, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "antibiotics_dr_group",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "antibiotics", count = { 15, 60 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "antibiotics_bottle_plastic_pill_prescription_15",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "antibiotics", count = { 15, 15 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "antibiotics_bottle_plastic_pill_prescription_1_15",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "antibiotics", count = { 1, 15 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "strong_antibiotics_dr_group",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "strong_antibiotic", count = { 15, 60 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "strong_antibiotic_bottle_plastic_pill_prescription_5",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "strong_antibiotic", count = { 5, 5 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "strong_antibiotic_bottle_plastic_pill_prescription_1_5",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "strong_antibiotic", count = { 1, 5 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "weak_antibiotic_bottle_plastic_pill_prescription_5",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "weak_antibiotic", count = { 5, 5 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "weak_antibiotic_bottle_plastic_pill_prescription_1_5",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "weak_antibiotic", count = { 1, 5 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "weak_antibiotic_bottle_plastic_pill_prescription_1",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "weak_antibiotic", container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "antifungal_dr_group",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "antifungal", count = { 15, 60 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "antifungal_bottle_plastic_pill_prescription_1_10",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "antifungal", count = { 1, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "antifungal_bottle_plastic_pill_prescription_1_5",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "antifungal", count = { 1, 5 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "antiparasitic_dr_group",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "antiparasitic", count = { 15, 60 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "antiparasitic_bottle_plastic_pill_prescription_1_10",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "antiparasitic", count = { 1, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "antiparasitic_bottle_plastic_pill_prescription_5",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "antiparasitic", count = { 5, 5 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "diazepam_dr_group",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "diazepam", count = { 15, 60 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "diazepam_bottle_plastic_pill_prescription_1_10",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "diazepam", count = { 1, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "calcium_dr_group",
        kind = "collection",
        container = "bottle_plastic_pill_supplement",
        overflow = "spill",
    }
    group:entry { item = "calcium_tablet", count = { 15, 60 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "calcium_tablet_bottle_plastic_pill_supplement_1_20",
        kind = "collection",
        container = "bottle_plastic_pill_supplement",
    }
    group:entry { item = "calcium_tablet", count = { 1, 20 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "calcium_tablet_bottle_full",
        kind = "collection",
        container = "bottle_plastic_pill_supplement",
    }
    group:entry { item = "calcium_tablet", count = { 20, 20 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "iron_dr_group",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
        overflow = "spill",
    }
    group:entry { item = "inj_iron", count = { 15, 60 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "prozac_dr_group",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "prozac", count = { 15, 60 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "prozac_bottle_plastic_pill_prescription_1_15",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "prozac", count = { 1, 15 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "thorazine_dr_group",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "thorazine", count = { 15, 60 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "thorazine_bottle_plastic_pill_prescription_1_10",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "thorazine", count = { 1, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "thorazine_bottle_plastic_pill_prescription_10",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "thorazine", count = { 10, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xanax_dr_group", kind = "collection", container = "bottle_plastic_pill_prescription" }
    group:entry { item = "xanax", count = { 15, 60 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "xanax_bottle_plastic_pill_prescription_1_10",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "xanax", count = { 1, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "vitc_tablet_bottle_plastic_pill_supplement_1_20",
        kind = "collection",
        container = "bottle_plastic_pill_supplement",
    }
    group:entry { item = "vitc_tablet", count = { 1, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "vitc_tablet_bottle_full",
        kind = "collection",
        container = "bottle_plastic_pill_supplement",
    }
    group:entry { item = "vitc_tablet", count = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "vitamins_bottle_plastic_pill_supplement_20",
        kind = "collection",
        container = "bottle_plastic_pill_supplement",
    }
    group:entry { item = "vitamins", count = { 20, 20 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "vitamins_bottle_plastic_pill_supplement_1_20",
        kind = "collection",
        container = "bottle_plastic_pill_supplement",
    }
    group:entry { item = "vitamins", count = { 1, 20 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "vitamins_bottle_plastic_pill_supplement_1_10",
        kind = "collection",
        container = "bottle_plastic_pill_supplement",
    }
    group:entry { item = "vitamins", count = { 1, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "caffeine_bottle_plastic_pill_supplement_10",
        kind = "collection",
        container = "bottle_plastic_pill_supplement",
    }
    group:entry { item = "caffeine", count = { 10, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "caffeine_bottle_plastic_pill_supplement_1_10",
        kind = "collection",
        container = "bottle_plastic_pill_supplement",
    }
    group:entry { item = "caffeine", count = { 1, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "caffeine_bottle_full",
        kind = "collection",
        container = "bottle_plastic_pill_supplement",
    }
    group:entry { item = "caffeine", count = { 20, 20 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "homeopathic_pills_bottle_plastic_pill_supplement_20",
        kind = "collection",
        container = "bottle_plastic_pill_supplement",
    }
    group:entry { item = "homeopathic_pills", count = { 20, 20 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "homeopathic_pills_bottle_plastic_pill_supplement_1_20",
        kind = "collection",
        container = "bottle_plastic_pill_supplement",
    }
    group:entry { item = "homeopathic_pills", count = { 1, 20 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "tums_bottle_plastic_small_1_20",
        kind = "collection",
        container = "bottle_plastic_small",
    }
    group:entry { item = "tums", count = { 1, 20 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "morphine_bottle_plastic_pill_prescription_4",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "morphine", count = { 4, 4 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bfipowder_bottle_plastic_5_60", kind = "collection", container = "bottle_plastic" }
    group:entry { item = "bfipowder", count = { 5, 60 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "bfipowder_bottle_plastic_small_4",
        kind = "collection",
        container = "bottle_plastic_small",
    }
    group:entry { item = "bfipowder", count = { 4, 4 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "bfipowder_bottle_plastic_small_1_4",
        kind = "collection",
        container = "bottle_plastic_small",
    }
    group:entry { item = "bfipowder", count = { 1, 4 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "pills_sleep_bottle_full",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "pills_sleep", count = { 15, 15 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "pills_sleep_bottle_plastic_pill_prescription_10",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "pills_sleep", count = { 10, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "pills_sleep_bottle_plastic_pill_prescription_1_10",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "pills_sleep", count = { 1, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "melatonin_bottle_full",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "melatonin_tablet", count = { 30, 30 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "melatonin_tablet_bottle_plastic_pill_supplement_1_30",
        kind = "collection",
        container = "bottle_plastic_pill_supplement",
    }
    group:entry { item = "melatonin_tablet", count = { 1, 30 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "melatonin_tablet_bottle_plastic_pill_supplement_10",
        kind = "collection",
        container = "bottle_plastic_pill_supplement",
    }
    group:entry { item = "melatonin_tablet", count = { 10, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "antihistamine_bottle_plastic_pill_supplement_1_30",
        kind = "collection",
        container = "bottle_plastic_pill_supplement",
    }
    group:entry { item = "antihistamine", count = { 1, 30 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "iodine_bottle_plastic_pill_supplement_10",
        kind = "collection",
        container = "bottle_plastic_pill_supplement",
    }
    group:entry { item = "iodine", count = { 10, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "iodine_bottle_plastic_pill_supplement_1_10",
        kind = "collection",
        container = "bottle_plastic_pill_supplement",
    }
    group:entry { item = "iodine", count = { 1, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "prussian_blue_bottle_plastic_pill_supplement_10",
        kind = "collection",
        container = "bottle_plastic_pill_supplement",
    }
    group:entry { item = "prussian_blue", count = { 10, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "prussian_blue_bottle_plastic_pill_supplement_1_10",
        kind = "collection",
        container = "bottle_plastic_pill_supplement",
    }
    group:entry { item = "prussian_blue", count = { 1, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "protein_bottle_full", kind = "collection", container = "bottle_plastic" }
    group:entry { item = "protein_powder", count = { 10, 10 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "protein_powder_bottle_plastic_small_1_9",
        kind = "collection",
        container = "bottle_plastic_small",
    }
    group:entry { item = "protein_powder", count = { 1, 9 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "protein_powder_bottle_plastic_small_9",
        kind = "collection",
        container = "bottle_plastic_small",
    }
    group:entry { item = "protein_powder", count = { 9, 9 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "saline_bottle_random", kind = "distribution" }
    group:item("saline_bag_250", 50)
    group:item("saline_bag_500")
    group:item("saline_bag_1000", 25)
    group:item("saline_bag_2000", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "estrogen_hrt", kind = "collection", container = "bottle_plastic_pill_prescription" }
    group:entry { item = "estrogen", count = { 1, 200 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "testosterone_hrt", kind = "collection", container = "box_paper_small" }
    group:entry { item = "testosterone", count = { 1, 13 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sunscreen_bottle", kind = "distribution" }
    group:entry { item = "sunscreen", container = "bottle_plastic_small" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "nondrowsy_cough_syrup_in_bottle_full", kind = "distribution" }
    group:entry { item = "dayquil", container = "bottle_plastic_small" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "any_cough_syrup_in_bottle_full", kind = "distribution" }
    group:entry { item = "nyquil", container = "bottle_plastic_small" }
    group:group("nondrowsy_cough_syrup_in_bottle_full")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "nondrowsy_cough_syrup_in_bottle", kind = "distribution" }
    group:entry { item = "dayquil", charges = { 1, -1 }, container = "bottle_plastic_small" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "any_cough_syrup_in_bottle", kind = "distribution" }
    group:entry { item = "nyquil", charges = { 1, -1 }, container = "bottle_plastic_small" }
    group:group("nondrowsy_cough_syrup_in_bottle")
    content.add(group)
end
