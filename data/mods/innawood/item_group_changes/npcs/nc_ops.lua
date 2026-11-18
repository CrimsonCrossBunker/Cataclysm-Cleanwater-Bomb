local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_OPS_pants_male", kind = "distribution" }
    group:group("npc_pants_male")
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "NC_OPS_pants_female", kind = "distribution" }
    group:group("npc_pants_female", 80)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "NC_OPS_shirt_male", kind = "distribution" }
    group:group("npc_shirt_male", 80)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "NC_OPS_shirt_female", kind = "distribution" }
    group:group("npc_shirt_female", 80)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "NC_OPS_gloves", kind = "distribution" }
    group:group("npc_gloves", 80)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "NC_OPS_coat", kind = "distribution" }
    group:group("npc_coat", 80)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "NC_OPS_shoes", kind = "distribution" }
    group:group("npc_shoes_male")
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "NC_OPS_masks", kind = "distribution" }
    group:item("null", 10)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "NC_OPS_eyes", kind = "distribution" }
    group:item("null", 60)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "NC_OPS_hat", kind = "distribution" }
    group:group("npc_hat", 80)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "NC_OPS_extra", kind = "distribution" }
    group:item("null", 30)
    group:item("wicker_backpack", 70)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "NC_OPS_bashing", kind = "distribution" }
    group:item("primitive_hammer", 20)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "NC_OPS_cutting", kind = "distribution" }
    group:item("stone_chopper", 20)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "NC_OPS_throw", kind = "distribution" }
    group:item("rock", 50)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "NC_OPS_archery", kind = "distribution" }
    group:item("selfbow", 50)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "NC_OPS_pistols", kind = "distribution" }
    group:group("guns_pistol_improvised", 35)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "NC_OPS_shotgun", kind = "distribution" }
    group:group("guns_shotgun_improvised", 22)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "NC_OPS_rifle", kind = "distribution" }
    group:group("guns_rifle_improvised")
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "NC_OPS_launcher", kind = "distribution" }
    group:group("guns_rifle_improvised", 10)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "NC_OPS_weapon_random", kind = "distribution" }
    group:item("q_staff")
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "NC_OPS_misc", kind = "distribution" }
    group:item("tobacco", 2)
    group:item("weed", 50)
    group:item("seed_weed", 35)
    group:item("seed_tobacco", 15)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "NC_OPS_stabbing", kind = "distribution" }
    group:item("pointy_stick", 50)
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "NC_OPS_smg", kind = "distribution" }
    group:group("guns_shotgun_improvised", 22)
    content.upsert_item_group(group)
end
