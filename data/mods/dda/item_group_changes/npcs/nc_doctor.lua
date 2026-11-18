local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_DOCTOR_pants_male", kind = "distribution" }
    group:item("jeans", 20)
    group:item("pants", 60)
    group:item("pants_leather", 20)
    group:item("pants_cargo", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_DOCTOR_pants_female", kind = "distribution" }
    group:item("jeans", 20)
    group:item("pants", 80)
    group:item("pants_leather", 20)
    group:item("pants_cargo", 20)
    group:item("skirt", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_DOCTOR_shirt_male", kind = "distribution" }
    group:item("polo_shirt", 50)
    group:item("dress_shirt", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_DOCTOR_shirt_female", kind = "distribution" }
    group:item("polo_shirt", 50)
    group:item("dress_shirt", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_DOCTOR_gloves", kind = "distribution" }
    group:item("null", 60)
    group:item("gloves_leather", 10)
    group:item("gloves_fingerless", 10)
    group:item("gloves_medical", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_DOCTOR_coat", kind = "distribution" }
    group:item("coat_lab", 90)
    group:item("hoodie", 5)
    group:item("jacket_light", 5)
    group:item("jacket_leather", 5)
    group:item("trenchcoat", 5)
    group:item("jacket_jean", 5)
    group:item("kevlar", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_DOCTOR_masks", kind = "distribution" }
    group:item("null", 5)
    group:item("mask_dust", 80)
    group:item("bandana", 10)
    group:entry { item = "mask_filter", charges = { 10, -1 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_DOCTOR_eyes", kind = "distribution" }
    group:item("null", 50)
    group:item("glasses_safety", 50)
    group:item("sunglasses", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_DOCTOR_misc", kind = "distribution" }
    group:entry { item = "bandages", count = { 1, 3 }, probability = 30 }
    group:group("adhesive_bandages_box_used", 30)
    group:group("cotton_ball_bag_used", 50)
    group:group("cotton_ball_bag_full", 50)
    group:group("used_1st_aid", 35)
    group:item("saline", 25)
    group:group("box_of_contact_lens_any", 10)
    group:group("vitamins_bottle_plastic_pill_supplement_20", 75)
    group:group("calcium_tablet_bottle_plastic_pill_supplement_20", 75)
    group:group("vitc_tablet_bottle_full", 75)
    group:group("bottle_otc_painkiller_20", 85)
    group:group("caffeine_bottle_plastic_pill_supplement_10", 25)
    group:group("pills_sleep_bottle_plastic_pill_prescription_10", 15)
    group:group("iodine_bottle_plastic_pill_supplement_10", 5)
    group:item("dayquil", 70)
    group:item("nyquil", 70)
    group:item("disinfectant", 35)
    group:group("protein_powder_bottle_plastic_small_9", 7)
    group:entry { item = "caff_gum", count = { 10, 10 }, probability = 10 }
    group:item("oxygen_tank", 20)
    group:item("smoxygen_tank", 5)
    group:entry { item = "eyedrops", count = { 10, 10 }, probability = 35 }
    group:entry { item = "steroid_eyedrops", count = { 10, 10 }, probability = 35 }
    group:entry { item = "nic_gum", count = { 10, 10 }, probability = 25 }
    group:entry { item = "inhaler", charges = { 10, 100 }, probability = 20 }
    group:group("codeine_bottle_plastic_pill_painkiller_10", 25)
    group:group("oxycodone_bottle_plastic_pill_prescription_10", 20)
    group:group("tramadol_bottle_plastic_pill_prescription_10", 20)
    group:group("xanax_bottle_plastic_pill_prescription_10", 20)
    group:group("adderall_bottle_plastic_pill_prescription_10", 20)
    group:group("thorazine_bottle_plastic_pill_prescription_10", 15)
    group:group("prozac_bottle_plastic_pill_prescription_15", 20)
    group:group("antibiotics_bottle_plastic_pill_prescription_15", 35)
    group:group("antifungal_bottle_plastic_pill_prescription_5", 10)
    group:group("antiparasitic_bottle_plastic_pill_prescription_5", 10)
    group:item("survnote", 5)
    group:group("diazepam_bottle_plastic_pill_prescription_10", 10)
    group:item("syringe", 20)
    content.add(group)
end
