local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_ARSONIST_pants_male", kind = "distribution" }
    group:item("jeans", 20)
    group:item("pants", 20)
    group:item("pants_leather", 20)
    group:item("pants_cargo", 20)
    group:item("bunker_pants", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ARSONIST_pants_female", kind = "distribution" }
    group:item("jeans", 20)
    group:item("pants", 20)
    group:item("pants_leather", 20)
    group:item("pants_cargo", 20)
    group:item("skirt", 20)
    group:item("bunker_pants", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ARSONIST_shirt_male", kind = "distribution" }
    group:item("tshirt", 20)
    group:item("polo_shirt", 20)
    group:item("dress_shirt", 20)
    group:item("tank_top", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ARSONIST_shirt_female", kind = "distribution" }
    group:item("tshirt", 20)
    group:item("polo_shirt", 20)
    group:item("dress_shirt", 20)
    group:item("tank_top", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ARSONIST_gloves", kind = "distribution" }
    group:item("null", 60)
    group:item("gloves_leather", 20)
    group:item("gloves_fingerless", 20)
    group:item("fire_gauntlets", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ARSONIST_coat", kind = "distribution" }
    group:item("null", 20)
    group:item("hoodie", 20)
    group:item("jacket_light", 20)
    group:item("jacket_leather", 20)
    group:item("trenchcoat", 20)
    group:item("jacket_jean", 20)
    group:item("bunker_coat", 10)
    group:item("jacket_windbreaker", 10)
    group:item("kevlar", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ARSONIST_shoes", kind = "distribution" }
    group:item("sneakers", 20)
    group:item("boots", 20)
    group:item("boots_bunker", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ARSONIST_eyes", kind = "distribution" }
    group:item("null", 80)
    group:item("glasses_safety", 20)
    group:item("sunglasses", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ARSONIST_hat", kind = "distribution" }
    group:item("null", 80)
    group:item("hat_ball", 10)
    group:item("hat_hard", 10)
    group:item("helmet_bike", 10)
    group:item("helmet_riot", 10)
    group:item("helmet_motor", 10)
    group:item("hat_hunting", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ARSONIST_extra", kind = "distribution" }
    group:item("null", 5)
    group:item("backpack", 20)
    group:item("backpack_denim", 5)
    group:item("backpack_leather", 25)
    group:item("rucksack", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ARSONIST_bashing", kind = "distribution" }
    group:item("hammer", 20)
    group:item("wrench", 20)
    group:item("hammer_sledge", 10)
    group:item("hammer_sledge_short", 10)
    group:item("pipe", 20)
    group:item("bat", 20)
    group:item("bat_metal", 20)
    group:item("crowbar", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ARSONIST_cutting", kind = "distribution" }
    group:item("knife_huge", 20, "knife_butcher")
    group:item("hatchet", 20)
    group:item("ax", 20)
    group:item("machete", 20)
    group:item("knife_combat", 20)
    group:item("katana", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ARSONIST_stabbing", kind = "distribution" }
    group:item("spear_knife", 50)
    group:item("spear_steel", 10)
    group:item("spear_rebar", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ARSONIST_throw", kind = "distribution" }
    group:item("throwing_knife", 50)
    group:item("throwing_axe", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ARSONIST_archery", kind = "distribution" }
    group:item("crossbow", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ARSONIST_pistols", kind = "distribution" }
    group:item("usp_9mm", 30)
    group:item("m9", 70)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ARSONIST_shotgun", kind = "distribution" }
    group:item("mossberg_500", 25)
    group:item("remington_870", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ARSONIST_smg", kind = "distribution" }
    group:item("uzi", 50)
    group:item("sten", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ARSONIST_rifle", kind = "distribution" }
    group:group("modular_m4a1", 35)
    group:item("m1a", 35)
    group:item("ak47", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ARSONIST_launcher", kind = "distribution" }
    group:item("flamethrower", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ARSONIST_weapon_random", kind = "distribution" }
    group:item("q_staff")
    content.add(group)
end
