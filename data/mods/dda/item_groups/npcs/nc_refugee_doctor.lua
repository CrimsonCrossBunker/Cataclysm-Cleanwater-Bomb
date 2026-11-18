local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_REFUGEE_DOCTOR_pants_male", kind = "distribution" }
    group:item("jeans", 20)
    group:item("pants", 60)
    group:item("pants_leather", 20)
    group:item("pants_cargo", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_REFUGEE_DOCTOR_pants_female", kind = "distribution" }
    group:item("jeans", 20)
    group:item("pants", 80)
    group:item("pants_leather", 20)
    group:item("pants_cargo", 20)
    group:item("skirt", 20)
    group:item("skirt_denim", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_REFUGEE_DOCTOR_shirt_male", kind = "distribution" }
    group:item("polo_shirt", 50)
    group:item("dress_shirt", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_REFUGEE_DOCTOR_shirt_female", kind = "distribution" }
    group:item("polo_shirt", 50)
    group:item("dress_shirt", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_REFUGEE_DOCTOR_gloves", kind = "distribution" }
    group:item("null", 60)
    group:item("gloves_leather", 10)
    group:item("gloves_fingerless", 10)
    group:item("gloves_medical", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_REFUGEE_DOCTOR_coat", kind = "distribution" }
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
    local group = content.ItemGroup { id = "NC_REFUGEE_DOCTOR_eyes", kind = "distribution" }
    group:item("null", 50)
    group:item("glasses_safety", 50)
    group:item("sunglasses", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_REFUGEE_DOCTOR_misc", kind = "distribution" }
    group:item("bandages", 30)
    group:entry { item = "adhesive_bandages", count = { 1, 20 }, probability = 30 }
    group:item("cotton_ball", 50)
    group:group("used_1st_aid", 35)
    group:item("saline", 25)
    group:group("box_of_contact_lens_any", 10)
    group:item("vitamins", 75)
    group:item("calcium_tablet", 75)
    group:item("caffeine", 25)
    group:item("aspirin", 60)
    group:item("ibuprofen", 70)
    group:item("acetaminophen", 70)
    group:item("naproxen", 35)
    group:item("pills_sleep", 15)
    group:item("iodine", 5)
    group:item("dayquil", 70)
    group:item("nyquil", 70)
    group:item("disinfectant", 35)
    group:item("protein_powder", 7)
    group:item("caff_gum", 10)
    group:item("oxygen_tank", 20)
    group:item("smoxygen_tank", 5)
    group:item("eyedrops", 35)
    group:item("steroid_eyedrops", 35)
    group:item("nic_gum", 25)
    group:entry { item = "inhaler", charges = { 10, 100 }, probability = 20 }
    group:item("codeine", 25)
    group:item("oxycodone", 20)
    group:item("tramadol", 20)
    group:item("xanax", 20)
    group:item("adderall", 20)
    group:item("thorazine", 15)
    group:item("prozac", 20)
    group:item("antibiotics", 35)
    group:item("antifungal", 10)
    group:item("antiparasitic", 10)
    group:item("survnote", 5)
    group:item("diazepam", 10)
    group:item("syringe", 20)
    group:group("birth_control", 25)
    group:group("estrogen_hrt", 1)
    group:group("testosterone_hrt", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_REFUGEE_DOCTOR_masks", kind = "distribution" }
    group:item("null", 5)
    group:item("mask_dust", 80)
    group:item("bandana", 10)
    group:entry { item = "mask_filter", charges = { 10, -1 }, probability = 10 }
    content.add(group)
end
