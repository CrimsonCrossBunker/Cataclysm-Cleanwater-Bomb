local content = require("ccb").content

do
    local group = content.ItemGroup { id = "ranch_nurse_clinic_aspirin", kind = "distribution" }
    group:group("bottle_otc_painkiller_20", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ranch_doctor_filing_cabinets", kind = "distribution" }
    group:entry { item = "book_binder", charges = { 25, 50 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ranch_bartender_shot_brandy", kind = "distribution" }
    group:entry { item = "brandy", container = "shot_glass", probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ranch_bartender_shot_rum", kind = "distribution" }
    group:entry { item = "rum", container = "shot_glass", probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ranch_bartender_shot_whiskey", kind = "distribution" }
    group:entry { item = "whiskey", container = "shot_glass", probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ranch_bartender_glass_water", kind = "distribution" }
    group:entry { item = "water_clean", container = "glass", probability = 1 }
    content.add(group)
end

do
    -- Subset of surgery item_group with only basic and non quest conflicting items
    local group = content.ItemGroup { id = "ranch_nurse_clinic_surgery", kind = "distribution" }
    group:group("saline_bottle_random", 20)
    group:group("iodine_bottle_plastic_pill_supplement_1_10", 5)
    group:group("prussian_blue_bottle_plastic_pill_supplement_1_10", 5)
    group:entry { item = "bandages", count = { 1, 3 }, probability = 50 }
    group:group("adhesive_bandages_box_used", 20)
    group:group("cotton_ball_bag_used", 50)
    group:group("cotton_ball_bag_full", 25)
    group:item("mask_dust", 65)
    group:item("towel", 40)
    group:item("vacutainer", 10)
    group:item("cotton_patchwork", 1)
    group:entry { item = "disinfectant", charges = { 1, 10 }, probability = 35 }
    group:item("medical_gauze", 10)
    group:group("medical_tape_roll_part", 45)
    group:item("jar_glass_sealed", 20)
    group:item("jar_3l_glass_sealed", 15)
    group:entry { item = "oxygen_tank", charges = { 0, 24 }, probability = 50 }
    group:entry { item = "smoxygen_tank", charges = { 0, 12 }, probability = 25 }
    group:item("bfipowder", 15)
    group:group("quikclot_bag_plastic_1_6", 10)
    content.add(group)
end
