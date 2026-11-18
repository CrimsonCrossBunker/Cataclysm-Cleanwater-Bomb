local content = require("ccb").content

do
    local group = content.ItemGroup { id = "radiation_equipment", kind = "collection" }
    group:group("hazmat_torso", 30)
    group:group("papr_kit", 20)
    group:group("hazmat_full", 10)
    group:group("clothing_work_set", 20)
    group:group("lab_torso", 20)
    group:group("hazmat_mask", 30)
    group:group("rad_gear", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "repair_storage", kind = "collection" }
    group:group("tools_common", 50)
    group:group("tools_electronics", 50)
    group:group("tools_lighting_industrial", 20)
    group:group("supplies_electronics", 50)
    group:group("hardware", 75)
    group:group("hardware_plumbing", 75)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "decontamination", kind = "collection" }
    group:item("soap", 20)
    group:item("towel", 20)
    group:item("saline", 20)
    group:group("detergent_small_box", 20)
    group:item("mop", 10)
    group:item("boots_rubber", 10)
    group:item("gloves_rubber", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "packaging", kind = "collection" }
    group:item("bag_plastic", 90)
    group:item("bubblewrap", 60)
    group:item("bag_canvas", 50)
    group:item("bag_canvas_small", 50)
    group:item("box_small", 40)
    group:item("wrapper", 60)
    group:entry { item = "paper", count = { 5, 10 }, probability = 10 }
    group:item("cup_plastic", 10)
    group:item("styrofoam_cup", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "radiation_meds", kind = "collection" }
    group:group("iodine_bottle_plastic_pill_supplement_10", 50)
    group:group("prussian_blue_bottle_plastic_pill_supplement_10", 75)
    group:group("full_1st_aid", 50)
    group:item("gloves_medical", 20)
    group:entry {
        item = "cotton_patchwork",
        flags = {
            "FILTHY",
        },
        probability = 30,
    }
    group:group("drugs_emergency", 30)
    group:group("drugs_heal_simple", 20)
    group:group("drugs_analgesic", 10)
    content.add(group)
end
