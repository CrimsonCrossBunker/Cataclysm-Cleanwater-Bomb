local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_SOLDIER_pants", kind = "distribution" }
    group:item("pants_army", 80)
    group:item("winter_pants_army", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_SOLDIER_shirt", kind = "distribution" }
    group:item("tank_top", 20, "tank_top_camo")
    group:item("tshirt", 20)
    group:item("polo_shirt", 20)
    group:item("longshirt", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_SOLDIER_gloves", kind = "distribution" }
    group:item("null", 20)
    group:item("gloves_tactical", 50)
    group:item("gloves_fingerless", 30)
    group:item("winter_gloves_army", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_SOLDIER_coat", kind = "distribution" }
    group:item("null", 20)
    group:item("jacket_army_modern", 50)
    group:item("winter_jacket_army", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_SOLDIER_vest", kind = "distribution" }
    group:item("null", 10)
    group:item("jacket_army", 50)
    group:item("kevlar", 10)
    group:group("military_ballistic_vest", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_SOLDIER_shoes", kind = "distribution" }
    group:item("boots_combat", 90)
    group:item("boots", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_SOLDIER_masks", kind = "distribution" }
    group:item("null", 50)
    group:entry { item = "mask_gas", charges = { 10, -1 }, probability = 20 }
    group:item("mask_bal", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_SOLDIER_eyes", kind = "distribution" }
    group:item("null", 20)
    group:item("glasses_safety", 10)
    group:item("glasses_bal", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_SOLDIER_hat", kind = "distribution" }
    group:item("null", 10)
    group:item("tac_helmet", 50)
    group:item("helmet_army", 50)
    group:item("helmet_skid", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_SOLDIER_storage", kind = "distribution" }
    group:item("null", 5)
    group:item("molle_pack", 40)
    group:item("rucksack", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_SOLDIER_holster", kind = "distribution" }
    group:item("null", 20)
    group:item("holster", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_SOLDIER_cutting", kind = "distribution" }
    group:item("knife_combat", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_SOLDIER_stabbing", kind = "distribution" }
    group:item("knife_combat", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_SOLDIER_pistols", kind = "distribution" }
    group:item("m9")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_SOLDIER_smg", kind = "distribution" }
    group:item("hk_mp5")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_SOLDIER_rifle", kind = "distribution" }
    group:group("modular_m4a1", 90)
    group:item("m14ebr", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_SOLDIER_weapon_random", kind = "distribution" }
    group:group("modular_m4a1", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_SOLDIER_misc", kind = "distribution" }
    group:item("grenade", 10)
    group:item("flashbang", 2)
    group:item("c4", 5)
    group:item("goggles_nv", 1)
    group:item("goggles_ir", 1)
    group:item("optical_cloak", 1)
    group:item("UPS_OFF", 8)
    group:item("tacvest", 10)
    group:item("backpack", 8)
    group:item("backpack_denim", 2)
    group:item("dump_pouch", 20)
    group:item("legrig", 10)
    group:item("under_armor", 20)
    group:item("elbow_pads", 20)
    group:item("knee_pads", 20)
    group:item("mess_kit", 30)
    group:item("e_tool", 15)
    group:group("chocolate_wrapper_3", 30)
    group:group("beans_in_can", 20)
    group:entry { group = "any_MRE", count = { 2, 3 }, probability = 45 }
    group:group("full_ifak", 35)
    group:item("saline", 10)
    group:item("con_milk", 10)
    group:item("sports_drink", 40)
    group:item("water_clean", 90)
    content.add(group)
end
