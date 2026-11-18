local content = require("ccb").content

do
    local group = content.ItemGroup { id = "hospital_medical_items", kind = "distribution" }
    group:item("left_leg_prosthetic", 5)
    group:item("right_leg_prosthetic", 5)
    group:item("right_arm_prosthetic", 5)
    group:item("right_arm_prosthetic", 5)
    group:item("right_arm_neuroprosthetic", 2)
    group:item("right_arm_neuroprosthetic", 2)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "museum_primitive", kind = "distribution" }
    group:entry { item = "left_peg_leg_old", damage = { 2, 4 }, probability = 10 }
    group:entry { item = "right_peg_leg_old", damage = { 2, 4 }, probability = 10 }
    group:entry { item = "left_arm_prosthetic_wood_old", damage = { 2, 4 }, probability = 10 }
    group:entry { item = "right_arm_prosthetic_wood_old", damage = { 2, 4 }, probability = 10 }
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "museum_misc", kind = "distribution" }
    group:entry { item = "left_peg_leg_old", damage = { 2, 4 }, probability = 15 }
    group:entry { item = "right_peg_leg_old", damage = { 2, 4 }, probability = 15 }
    group:entry { item = "right_leg_prosthetic_steel_old", damage = { 2, 4 }, probability = 15 }
    group:entry { item = "left_leg_prosthetic_steel_old", damage = { 2, 4 }, probability = 15 }
    group:entry { item = "left_arm_prosthetic_wood_old", damage = { 2, 4 }, probability = 15 }
    group:entry { item = "right_arm_prosthetic_wood_old", damage = { 2, 4 }, probability = 15 }
    group:entry { item = "left_arm_prosthetic_steel_old", damage = { 2, 4 }, probability = 15 }
    group:entry { item = "right_arm_prosthetic_steel_old", damage = { 2, 4 }, probability = 15 }
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "mil_base_bed_hospital", kind = "distribution" }
    group:item("left_leg_prosthetic", 2)
    group:item("right_leg_prosthetic", 2)
    group:item("left_arm_prosthetic", 2)
    group:item("right_arm_prosthetic", 2)
    group:item("left_arm_neuroprosthetic", 1)
    group:item("right_arm_neuroprosthetic", 1)
    content.extend_item_group(group)
end
