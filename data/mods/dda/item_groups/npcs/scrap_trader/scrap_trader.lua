local content = require("ccb").content

do
    local group = content.ItemGroup { id = "SCRAP_MERCHANT_carried", kind = "collection" }
    group:entry { item = "flashlight", charges = { 0, 300 } }
    group:item("multitool")
    group:item("hammer")
    group:item("boltcutters")
    group:entry { item = "homemade_grenade", count = { 0, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "SCRAP_MERCHANT_weapon", kind = "collection" }
    group:item("heavy_crowbar")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "no_sell", kind = "collection" }
    group:entry { item = "cash_register", count = { 0, 0 } }
    group:entry { item = "wheel_wide", count = { 0, 0 } }
    group:entry { group = "SUS_fridge_survivor", count = { 0, 0 } }
    group:entry { group = "SUS_utensils", count = { 0, 0 } }
    group:entry { item = "microwave", count = { 0, 0 } }
    group:entry { group = "used_1st_aid", count = { 0, 0 } }
    group:entry { item = "coffee", count = { 0, 0 } }
    group:entry { item = "hd_tow_cable", count = { 0, 0 } }
    group:entry { item = "roadmap", count = { 0, 0 } }
    group:entry { item = "folding_poncho", count = { 0, 0 } }
    group:entry { item = "rope_6", count = { 0, 0 } }
    group:entry { item = "handflare", count = { 0, 0 } }
    group:entry { item = "sm_extinguisher", count = { 0, 0 } }
    group:entry { item = "towel", count = { 0, 0 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "SCRAPPER_Shop", kind = "collection" }
    group:entry { item = "scrap", count = { 125, 250 } }
    group:entry { item = "nuts_bolts", count = { 10, 25 } }
    group:entry { item = "sheet_metal_small", count = { 50, 100 } }
    group:entry { item = "lc_steel_chunk", count = { 100, 200 } }
    group:entry { item = "lc_steel_lump", count = { 50, 100 } }
    group:entry { item = "sheet_metal", count = { 25, 50 } }
    group:entry { item = "lc_steel_lump", count = { 25, 50 } }
    group:entry { item = "mc_steel_lump", count = { 25, 50 } }
    group:entry { item = "hc_steel_lump", count = { 25, 50 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "SCRAPPER_Shop_Bismuth", kind = "collection" }
    group:entry { item = "bismuth", count = { 100, 100 }, wrapper = "bag_zipper_gallon" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "SCRAPPER_Shop_Zinc", kind = "collection" }
    group:entry { item = "zinc_metal", count = { 100, 100 }, wrapper = "jar_glass_sealed" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "SCRAPPER_Shop_Lead", kind = "collection" }
    group:entry { item = "lead", count = { 100, 100 }, wrapper = "bag_zipper_gallon" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "SCRAPPER_Shop_Tin", kind = "collection" }
    group:entry { item = "tin", count = { 100, 100 }, wrapper = "bag_zipper_gallon" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "SCRAPPER_Shop_Magnesium", kind = "collection" }
    group:entry { item = "magnesium", count = { 100, 100 }, wrapper = "bag_zipper_gallon" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "SCRAPPER_Shop_Silver", kind = "collection" }
    group:entry { item = "silver_small", count = { 100, 100 }, wrapper = "bag_zipper_gallon" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "SCRAPPER_Shop_Gold", kind = "collection" }
    group:entry { item = "gold_small", count = { 100, 100 }, wrapper = "bag_zipper_gallon" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "SCRAPPER_Shop_Platinum", kind = "collection" }
    group:entry { item = "platinum_small", count = { 100, 100 }, wrapper = "bag_zipper_gallon" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "SCRAPPER_Shop_Specialty_Metals", kind = "collection" }
    group:entry { item = "scrap_aluminum", count = { 100, 200 } }
    group:entry { item = "scrap_bronze", count = { 20, 50 } }
    group:entry { group = "SCRAPPER_Shop_Bismuth", count = { 0, 3 } }
    group:entry { group = "SCRAPPER_Shop_Zinc", count = { 0, 3 } }
    group:entry { group = "SCRAPPER_Shop_Lead", count = { 0, 3 } }
    group:entry { item = "scrap_copper", count = { 100, 200 } }
    group:entry { group = "SCRAPPER_Shop_Tin", count = { 0, 3 } }
    group:entry { group = "SCRAPPER_Shop_Magnesium", count = { 0, 3 } }
    group:entry { group = "SCRAPPER_Shop_Silver", count = { 0, 3 } }
    group:entry { group = "SCRAPPER_Shop_Gold", count = { 0, 3 } }
    group:entry { group = "SCRAPPER_Shop_Platinum", count = { 0, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "SCRAP_MERCHANT_worn", kind = "collection" }
    group:item("glasses_safety")
    group:item("helmet_liner")
    group:item("hat_hard")
    group:item("turtleneck_shirt")
    group:item("jacket_jean")
    group:item("vest")
    group:item("boxer_briefs")
    group:item("jeans")
    group:item("gloves_work")
    group:item("socks")
    group:item("boots")
    group:item("gold_ring")
    group:item("tool_belt")
    group:item("spearsling")
    group:entry { group = "modular_ar15", charges = { 30, 30 }, container = "back_holster", ammo = { item = "223" } }
    content.add(group)
end
