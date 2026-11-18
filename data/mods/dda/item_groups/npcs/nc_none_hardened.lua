local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_NONE_HARDENED_foot", kind = "distribution" }
    group:group("survivorzed_boots")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_NONE_HARDENED_arm", kind = "distribution" }
    group:item("null")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_NONE_HARDENED_hand", kind = "distribution" }
    group:group("survivorzed_gloves")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_NONE_HARDENED_head", kind = "distribution" }
    group:group("survivorzed_head")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_NONE_HARDENED_leg", kind = "distribution" }
    group:group("survivorzed_bottoms")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_NONE_HARDENED_mouth", kind = "distribution" }
    group:group("hatstore_accessories", 50)
    group:group("clothing_work_mask", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_NONE_HARDENED_sensor", kind = "distribution" }
    group:group("clothing_work_glasses")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_NONE_HARDENED_torso", kind = "distribution" }
    group:group("military_ballistic_vest", 25)
    group:item("kevlar", 25)
    group:item("chestguard_hard", 10)
    group:group("survivorzed_tops", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_NONE_HARDENED_stabbing", kind = "distribution" }
    group:group("melee_stabbing_rare")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_NONE_HARDENED_bashing", kind = "distribution" }
    group:group("melee_bashing_rare")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_NONE_HARDENED_cutting", kind = "distribution" }
    group:group("melee_cutting_rare")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_NONE_HARDENED_throw", kind = "distribution" }
    group:group("NC_NONE_throw", 50)
    group:item("javelin_fletched", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_NONE_HARDENED_archery", kind = "distribution" }
    group:group("archery_rare")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_NONE_HARDENED_quiver", kind = "distribution" }
    group:group("NC_NONE_quiver")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_NONE_HARDENED_pistol", kind = "distribution" }
    group:group("guns_pistol_common")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_NONE_HARDENED_shotgun", kind = "distribution" }
    group:group("guns_shotgun_common")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_NONE_HARDENED_smg", kind = "distribution" }
    group:group("guns_smg_milspec")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_NONE_HARDENED_rifle", kind = "distribution" }
    group:group("guns_rifle_common")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_NONE_HARDENED_storage", kind = "distribution" }
    group:group("bags")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_NONE_HARDENED_extra", kind = "distribution" }
    group:group("NC_NONE_extra", 50)
    group:group("electronics", 10)
    group:group("swat_gear", 5)
    group:group("gear_eod", 5)
    group:group("fireman_gear", 5)
    group:group("rad_gear", 5)
    group:group("grenades", 5)
    content.add(group)
end
