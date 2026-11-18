local content = require("ccb").content

do
    local group = content.ItemGroup { id = "hardware_plumbing", kind = "distribution" }
    group:group("plumbing_clothing")
    group:group("tools_plumbing")
    group:group("supplies_plumbing", 50)
    group:item("survnote", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "horse_stable_riding_gear", kind = "distribution" }
    group:item("horse_tack", 35)
    group:item("book_horse_tack", 20)
    group:item("saddlebag", 30)
    group:item("horse_bridle", 35)
    group:item("horse_stirrups", 20)
    group:item("fitted_horseshoes", 25)
    group:item("horseshoe", 20)
    content.add(group)
end

do
    -- Set of mostly fluff farrier tools.
    local group = content.ItemGroup { id = "farrier_tools", kind = "collection" }
    group:item("hoof_pick", 75)
    group:item("horseshoe_pliers", 75)
    group:item("nail_puller", 75)
    group:item("hoof_tester", 75)
    group:item("hoof_nippers", 75)
    group:item("pockknife", 65)
    group:item("hoof_rasp", 65)
    group:item("hammer_peen", 65, "peen_ball")
    group:item("hammer_peen", 65, "peen_straight")
    group:item("hammer_peen", 65, "peen_cross")
    group:item("hammer_peen", 65, "rounding")
    group:item("hammer", 65)
    group:item("pritchel", 65)
    group:item("clinch_block", 65)
    group:item("clinch_pliers", 65)
    group:item("clinch_cutter", 65)
    group:item("hoof_stand", 65)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dentist_supplies", kind = "collection" }
    group:entry { item = "dental_tools", count = { 1, 2 }, probability = 80 }
    group:entry { item = "string_floss", count = { 1, 3 }, probability = 75 }
    group:entry { item = "toothbrush_plain", count = { 1, 4 }, probability = 75 }
    group:item("toothbrush_electric", 20)
    group:entry { item = "dentures", count = { 1, 2 }, probability = 40 }
    group:entry { item = "medical_gauze", count = { 1, 4 }, probability = 20 }
    group:item("syringe", 30)
    group:item("mask_dust", 60)
    group:item("gloves_medical", 70)
    group:entry { item = "disinfectant", charges = { 1, 10 }, probability = 30 }
    group:entry { item = "anesthetic_kit", charges = { 0, -1 }, probability = 10 }
    group:item("gold_dental_grill", 1)
    content.add(group)
end
