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

do
    local group = content.ItemGroup { id = "npc_misc", kind = "distribution", with_ammo = 75, with_magazine = 50 }
    group:item("ant_egg", 5)
    group:item("apple", 2)
    group:item("apricot", 2)
    group:item("bacon", 2)
    group:item("banana", 1)
    group:item("biscuit", 3)
    group:item("blackberries", 3)
    group:item("blueberries", 3)
    group:item("bread", 5)
    group:item("broccoli", 1)
    group:item("carrot", 3)
    group:item("cherries", 5)
    group:item("coconut", 1)
    group:item("coffee_raw", 5)
    group:item("corn", 3)
    group:item("cornbread", 1)
    group:item("cranberries", 5)
    group:item("dry_beans", 7)
    group:item("dry_fish", 3)
    group:item("dry_fruit", 15)
    group:item("dry_meat", 3)
    group:item("dry_rice", 8)
    group:item("dry_veggy", 5)
    group:item("fish_smoked", 1)
    group:item("fur", 5)
    group:item("grapefruit", 1)
    group:item("grapes", 2)
    group:item("honeycomb", 2)
    group:item("hops", 1)
    group:item("lemon", 3)
    group:item("lettuce", 3)
    group:item("meat", 10)
    group:item("meat_smoked", 2)
    group:item("melon", 3)
    group:item("mushroom", 5)
    group:item("onion", 4)
    group:item("orange", 2)
    group:item("peach", 3)
    group:item("pear", 3)
    group:item("pickle", 5)
    group:item("plums", 2)
    group:item("potato", 4)
    group:item("raspberries", 4)
    group:item("rhubarb", 1)
    group:item("rope_30", 4)
    group:item("rope_6", 4)
    group:item("royal_jelly", 1)
    group:item("salt", 10)
    group:item("salted_fish", 5)
    group:item("seed_barley", 3)
    group:item("seed_blueberries", 3)
    group:item("seed_cotton_boll", 3)
    group:item("seed_hops", 3)
    group:item("seed_strawberries", 3)
    group:item("seed_sugar_beet", 3)
    group:item("seed_tomato", 3)
    group:item("seed_weed", 3)
    group:item("seed_tobacco", 3)
    group:item("seed_wheat", 3)
    group:item("stick", 5)
    group:item("strawberries", 3)
    group:item("string_36", 4)
    group:item("string_6", 4)
    group:item("sugar_beet", 2)
    group:item("thread", 8)
    group:item("tobacco", 8)
    group:item("tomato", 3)
    group:item("veggy", 8)
    group:item("watermelon", 4)
    group:item("weed", 12)
    group:item("wheat", 3)
    group:item("yeast", 5)
    group:item("zucchini", 3)
    content.replace(group)
end
