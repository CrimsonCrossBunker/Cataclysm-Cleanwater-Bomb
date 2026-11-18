local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_NONE_foot", kind = "distribution" }
    group:group("clothing_outdoor_shoes", 50)
    group:group("shoes", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_NONE_arm", kind = "distribution" }
    group:item("null")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_NONE_hand", kind = "distribution" }
    group:group("clothing_work_gloves", 25)
    group:group("common_gloves", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_NONE_head", kind = "distribution" }
    group:group("hatstore_hats", 50)
    group:group("clothing_work_hat", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_NONE_leg", kind = "distribution" }
    group:group("clothing_outdoor_pants", 50)
    group:group("pants", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_NONE_mouth", kind = "distribution" }
    group:group("hatstore_accessories", 50)
    group:group("masks_unisex", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_NONE_sensor", kind = "distribution" }
    group:group("clothing_glasses")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_NONE_torso", kind = "distribution" }
    group:group("clothing_outdoor_torso", 50)
    group:group("jackets", 25)
    group:group("shirts", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_NONE_stabbing", kind = "distribution" }
    group:group("melee_stabbing_common")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_NONE_bashing", kind = "distribution" }
    group:group("melee_bashing_common")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_NONE_cutting", kind = "distribution" }
    group:group("melee_cutting_common")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_NONE_throw", kind = "distribution" }
    group:item("throwing_knife", 50)
    group:item("throwing_axe", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_NONE_archery", kind = "distribution" }
    group:group("archery_common")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_NONE_quiver", kind = "distribution" }
    group:group("archery_quivers")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_NONE_pistol", kind = "distribution" }
    group:group("guns_pistol_common")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_NONE_shotgun", kind = "distribution" }
    group:group("guns_shotgun_common")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_NONE_smg", kind = "distribution" }
    group:group("guns_smg_milspec")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_NONE_rifle", kind = "distribution" }
    group:group("guns_rifle_common")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_NONE_storage", kind = "distribution" }
    group:group("bags")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_NONE_extra", kind = "distribution" }
    group:group("vending_drink_items", 70)
    group:group("cannedfood", 50)
    group:group("drugs_heal_simple", 10)
    group:group("big_canned_food", 10)
    group:group("produce", 5)
    group:group("harddrugs", 5)
    content.add(group)
end
