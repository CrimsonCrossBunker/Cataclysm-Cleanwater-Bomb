local content = require("ccb").content

do
    local group = content.ItemGroup { id = "npc_underwear_bottom_male", kind = "collection" }
    group:group("male_underwear_bottom", 95)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_underwear_bottom_female", kind = "collection" }
    group:group("female_underwear_bottom", 95)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_underwear_top_male", kind = "collection" }
    group:group("male_underwear_top", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_underwear_top_female", kind = "collection" }
    group:group("female_underwear_top", 95)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_underwear_feet_male", kind = "distribution" }
    group:item("socks", 80)
    group:item("socks_ankle", 60)
    group:item("socks_wool", 20)
    group:item("null", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_underwear_feet_female", kind = "distribution" }
    group:item("socks", 50)
    group:item("socks_ankle", 30)
    group:item("socks_wool", 10)
    group:item("stockings", 20)
    group:item("tights", 20)
    group:item("null", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_pants_male", kind = "distribution" }
    group:item("jeans", 20)
    group:item("pants", 20)
    group:item("pants_leather", 20)
    group:item("shorts", 5)
    group:item("shorts_cargo", 10)
    group:item("pants_cargo", 20)
    group:item("b_shorts", 10)
    group:item("motorbike_pants", 5)
    group:item("jeans_mod", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_pants_female", kind = "distribution" }
    group:item("jeans", 20)
    group:item("pants", 20)
    group:item("pants_leather", 20)
    group:item("shorts", 5)
    group:item("shorts_cargo", 10)
    group:item("pants_cargo", 20)
    group:item("b_shorts", 10)
    group:item("motorbike_pants", 5)
    group:item("jeans_mod", 5)
    group:item("skirt", 20)
    group:item("skirt_long", 10)
    group:item("skirt_denim", 10)
    group:item("skirt_leather", 10)
    group:item("nanoskirt", 5)
    group:item("hot_pants", 20)
    group:item("shorts_denim", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_shirt_male", kind = "distribution" }
    group:item("tshirt", 25)
    group:item("polo_shirt", 20)
    group:item("dress_shirt", 20)
    group:item("longshirt", 20)
    group:item("denim_shirt", 10)
    group:item("sweatshirt", 20)
    group:item("buttonshirt", 10, "striped")
    group:item("sweater", 20)
    group:item("jersey", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_shirt_female", kind = "distribution" }
    group:item("tshirt", 25)
    group:item("polo_shirt", 20)
    group:item("dress_shirt", 20)
    group:item("longshirt", 20)
    group:item("denim_shirt", 10)
    group:item("sweatshirt", 20)
    group:item("buttonshirt", 10, "striped")
    group:item("sweater", 20)
    group:item("jersey", 10)
    group:item("tank_top", 20)
    group:item("halter_top", 20)
    group:item("camisole", 20)
    group:item("dress", 10)
    group:item("sundress", 10)
    group:item("corset", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_gloves", kind = "distribution" }
    group:item("null", 60)
    group:item("gloves_leather", 20)
    group:item("gloves_fingerless", 20)
    group:item("fire_gauntlets", 20)
    group:item("gloves_work", 10)
    group:item("gloves_fingerless_mod", 5)
    group:item("gloves_medical", 10)
    group:item("gloves_winter", 5)
    group:item("gloves_wool", 20)
    group:item("gloves_light", 20)
    group:item("gloves_tactical", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_coat", kind = "distribution" }
    group:item("null", 20)
    group:item("hoodie", 20)
    group:item("wool_hoodie", 20)
    group:item("jacket_light", 20)
    group:item("jacket_leather", 20)
    group:item("trenchcoat", 20)
    group:item("jacket_jean", 20)
    group:item("jacket_jean_mod", 5)
    group:item("jacket_windbreaker", 10)
    group:item("folding_poncho", 10)
    group:item("jacket_leather_mod", 5)
    group:item("american_flag", 5)
    group:item("jacket_army", 3)
    group:item("jacket_army_modern", 7)
    group:item("jacket_flannel", 10)
    group:item("jacket_evac", 20)
    group:item("winter_jacket_army", 5)
    group:item("coat_winter", 10)
    group:item("peacoat", 10)
    group:item("greatcoat", 5)
    group:item("cloak", 5)
    group:item("cloak_wool", 5)
    group:item("house_coat", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_shoes_male", kind = "distribution" }
    group:item("boots", 20)
    group:item("boots_combat", 10)
    group:item("boots_hiking", 20)
    group:item("boots_western", 10)
    group:item("boots_winter", 5)
    group:item("motorbike_boots", 5)
    group:item("dress_shoes", 20)
    group:item("sneakers", 20)
    group:item("lowtops", 20)
    group:item("flip_flops", 10)
    group:item("leathersandals", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_shoes_female", kind = "distribution" }
    group:item("boots", 10)
    group:item("boots_combat", 10)
    group:item("boots_hiking", 20)
    group:item("boots_western", 20)
    group:item("boots_winter", 5)
    group:item("motorbike_boots", 5)
    group:item("dress_shoes", 20)
    group:item("sneakers", 20)
    group:item("lowtops", 20)
    group:item("flip_flops", 10)
    group:item("leathersandals", 5)
    group:item("heels", 5)
    group:item("thigh_high_boots", 10)
    group:item("knee_high_boots", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_masks", kind = "distribution" }
    group:item("null", 80)
    group:item("mask_dust", 10)
    group:item("bandana", 10)
    group:item("mask_filter", 10)
    group:item("mask_gas", 5)
    group:item("mask_bunker", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_scarf", kind = "distribution" }
    group:item("null", 20)
    group:item("knit_scarf", 30)
    group:item("long_knit_scarf", 15)
    group:item("scarf", 30)
    group:item("scarf_long", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_eyes", kind = "distribution" }
    group:item("null", 80)
    group:item("glasses_safety", 20)
    group:item("sunglasses", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_hat", kind = "distribution" }
    group:item("null", 20)
    group:item("hat_ball", 20)
    group:item("hat_hard", 5)
    group:item("hat_boonie", 5)
    group:item("hat_cotton", 20)
    group:item("hat_fur", 5)
    group:item("hat_knit", 20)
    group:item("hat_newsboy", 10)
    group:item("cowboy_hat", 10)
    group:item("hat_sombrero", 5)
    group:item("10gal_hat", 5)
    group:item("straw_hat", 5)
    group:item("hat_hunting", 10)
    group:item("hat_hard_hooded", 5)
    group:item("helmet_bike", 10)
    group:item("helmet_riot", 5)
    group:item("helmet_motor", 5)
    group:item("helmet_skid", 5)
    group:item("helmet_ball", 5)
    group:item("helmet_football", 5)
    group:item("pot_helmet", 10)
    group:item("firehelmet", 5)
    group:item("helmet_army", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_extra", kind = "distribution" }
    group:item("null", 20)
    group:item("gold_ring", 20)
    group:item("diamond_ring", 2)
    group:item("copper_bracelet", 10)
    group:item("gold_bracelet", 10)
    group:item("silver_bracelet", 10)
    group:item("silver_necklace", 5)
    group:item("silver_locket", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_wrist", kind = "distribution" }
    group:item("null", 20)
    group:item("diving_watch", 10)
    group:item("game_watch", 5)
    group:item("gold_watch", 5)
    group:item("wristwatch", 20)
    group:item("sf_watch", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_storage", kind = "distribution" }
    group:item("null", 10)
    group:item("backpack", 20)
    group:item("backpack_denim", 5)
    group:item("backpack_leather", 20)
    group:item("rucksack", 5)
    group:item("mbag", 20)
    group:item("runner_bag", 5)
    group:item("duffelbag", 5)
    group:item("dive_bag", 5)
    group:item("slingpack", 10)
    group:item("molle_pack", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_belt", kind = "distribution" }
    group:item("null", 20)
    group:item("leather_belt", 50)
    group:item("tool_belt", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_holster", kind = "distribution" }
    group:item("null", 50)
    group:item("sholster", 10)
    group:item("sheath", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_stabbing", kind = "distribution" }
    group:group("survivor_knife", 20)
    group:group("survivor_stabbing", 80)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_throw", kind = "distribution" }
    group:item("throwing_knife", 7)
    group:item("throwing_axe", 4)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_archery", kind = "distribution" }
    group:item("crossbow", 50)
    content.add(group)
end
