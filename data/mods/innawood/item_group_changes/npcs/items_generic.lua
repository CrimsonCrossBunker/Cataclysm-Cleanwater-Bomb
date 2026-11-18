local content = require("ccb").content

do
    -- Override for hardcoded reference in npc::starting_weapon
    local group = content.ItemGroup { id = "survivor_bashing", kind = "distribution" }
    group:item("cudgel", 1)
    group:item("stick_long", 2)
    group:item("rock", 5)
    group:item("q_staff", 1)
    content.replace(group)
end

do
    -- Override for hardcoded reference in npc::starting_weapon
    local group = content.ItemGroup { id = "survivor_cutting", kind = "distribution" }
    group:item("sharp_rock", 5)
    group:item("bone_knife", 2)
    content.replace(group)
end

do
    -- Override for hardcoded reference in npc::starting_weapon
    local group = content.ItemGroup { id = "survivor_stabbing", kind = "distribution" }
    group:item("pointy_stick", 5)
    group:item("pointy_stick_long", 2)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "npc_underwear_bottom_male", kind = "collection" }
    group:group("male_underwear_bottom", 95)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "npc_underwear_bottom_female", kind = "collection" }
    group:group("female_underwear_bottom", 95)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "npc_underwear_top_male", kind = "collection" }
    group:group("male_underwear_top", 50)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "npc_underwear_top_female", kind = "collection" }
    group:group("female_underwear_top", 95)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "npc_underwear_feet_male", kind = "distribution" }
    group:item("null", 5)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "npc_underwear_feet_female", kind = "distribution" }
    group:item("null", 5)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "npc_pants_male", kind = "distribution" }
    group:item("null", 50)
    group:item("pants_leather", 10)
    group:item("skirt_leather", 10)
    group:item("skirt_grass", 20)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "npc_pants_female", kind = "distribution" }
    group:item("null", 50)
    group:item("pants_leather", 10)
    group:item("skirt_leather", 20)
    group:item("skirt_grass", 30)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "npc_shirt_male", kind = "distribution" }
    group:item("null", 70)
    group:item("shirt_straw", 30)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "npc_shirt_female", kind = "distribution" }
    group:item("null", 70)
    group:item("shirt_straw", 30)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "npc_gloves", kind = "distribution" }
    group:item("null", 70)
    group:item("gloves_leather", 10)
    group:item("gloves_wraps_leather", 20)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "npc_coat", kind = "distribution" }
    group:item("null", 40)
    group:item("grass_cloak", 30)
    group:item("cloak_leather", 10)
    group:item("cloak_fur", 10)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "npc_shoes_male", kind = "distribution" }
    group:item("null", 50)
    group:item("leathersandals", 5)
    group:item("footrags_leather", 15)
    group:item("footrags_fur", 15)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "npc_shoes_female", kind = "distribution" }
    group:item("null", 50)
    group:item("leathersandals", 5)
    group:item("footrags_leather", 15)
    group:item("footrags_fur", 15)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "npc_masks", kind = "distribution" }
    group:item("null", 80)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "npc_scarf", kind = "distribution" }
    group:item("null", 20)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "npc_eyes", kind = "distribution" }
    group:item("null", 80)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "npc_hat", kind = "distribution" }
    group:item("null", 40)
    group:item("straw_hat", 5)
    group:item("grass_keffiyeh", 10)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "npc_extra", kind = "distribution" }
    group:item("null", 20)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "npc_wrist", kind = "distribution" }
    group:item("null", 20)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "npc_storage", kind = "distribution" }
    group:item("null", 50)
    group:group("pottery", 25)
    group:item("wicker_backpack", 50)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "npc_belt", kind = "distribution" }
    group:item("null", 20)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "npc_holster", kind = "distribution" }
    group:item("null", 50)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "npc_stabbing", kind = "distribution" }
    group:item("null", 50)
    group:item("primitive_knife", 50)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "npc_throw", kind = "distribution" }
    group:item("null", 50)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "npc_archery", kind = "distribution" }
    group:item("selfbow", 50)
    content.replace(group)
end
