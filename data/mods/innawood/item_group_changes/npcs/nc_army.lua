local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_ARMY_pants_male", kind = "distribution" }
    group:group("npc_pants_male")
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "NC_ARMY_pants_female", kind = "distribution" }
    group:group("npc_pants_female", 80)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "NC_ARMY_shirt_male", kind = "distribution" }
    group:group("npc_shirt_male", 80)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "NC_ARMY_shirt_female", kind = "distribution" }
    group:group("npc_shirt_female", 80)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "NC_ARMY_gloves", kind = "distribution" }
    group:group("npc_gloves", 80)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "NC_ARMY_coat", kind = "distribution" }
    group:group("npc_coat", 80)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "NC_ARMY_shoes", kind = "distribution" }
    group:group("npc_shoes_male", 80)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "NC_ARMY_masks", kind = "distribution" }
    group:item("null", 10)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "NC_ARMY_eyes", kind = "distribution" }
    group:item("null", 60)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "NC_ARMY_hat", kind = "distribution" }
    group:group("npc_hat", 80)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "NC_ARMY_extra", kind = "distribution" }
    group:item("null", 30)
    group:item("wicker_backpack", 70)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "NC_ARMY_bashing", kind = "distribution" }
    group:item("primitive_hammer", 20)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "NC_ARMY_cutting", kind = "distribution" }
    group:item("stone_chopper", 20)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "NC_ARMY_throw", kind = "distribution" }
    group:item("rock", 50)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "NC_ARMY_archery", kind = "distribution" }
    group:item("selfbow", 50)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "NC_ARMY_pistols", kind = "distribution" }
    group:group("guns_pistol_improvised", 35)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "NC_ARMY_shotgun", kind = "distribution" }
    group:group("guns_shotgun_improvised", 22)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "NC_ARMY_smg", kind = "distribution" }
    group:group("guns_shotgun_improvised", 22)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "NC_ARMY_rifle", kind = "distribution" }
    group:group("guns_rifle_improvised")
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "NC_ARMY_launcher", kind = "distribution" }
    group:group("guns_rifle_improvised", 10)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "NC_ARMY_weapon_random", kind = "distribution" }
    group:item("q_staff")
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "NC_ARMY_misc", kind = "distribution" }
    group:item("tobacco", 2)
    group:item("weed", 50)
    group:item("seed_weed", 35)
    group:item("seed_tobacco", 15)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "NC_ARMY_stabbing", kind = "distribution" }
    group:item("pointy_stick", 50)
    content.upsert_item_group(group)
end
