local content = require("ccb").content

do
    local group = content.ItemGroup { id = "MILITIA_MERCHANT_misc", kind = "collection" }
    group:entry { item = "jerky", count = { 3, 8 }, probability = 30 }
    group:entry { group = "tools_general", count = { 1, 3 }, probability = 80 }
    group:entry { group = "tools_home", count = { 1, 3 }, probability = 80 }
    group:entry { group = "tools_carpentry", count = { 1, 3 }, probability = 30 }
    group:entry { group = "tools_earthworking", count = { 1, 3 }, probability = 30 }
    group:entry { group = "tools_electronics", count = { 1, 3 }, probability = 20 }
    group:entry { group = "tools_mechanic", count = { 1, 3 }, probability = 20 }
    group:entry { group = "tools_plumbing", count = { 1, 3 }, probability = 20 }
    group:entry { group = "supplies_electronics", count = { 1, 3 }, probability = 20 }
    group:entry { group = "supplies_plumbing", count = { 1, 3 }, probability = 20 }
    group:entry { group = "supplies_hardware", count = { 1, 3 }, probability = 20 }
    group:entry { group = "supplies_fuel", count = { 1, 3 }, probability = 20 }
    group:entry { group = "supplies_metal", count = { 1, 3 }, probability = 20 }
    group:entry { group = "ammo_any_batteries_full", count = { 1, 3 }, probability = 20 }
    group:entry { group = "magazines", count = { 1, 3 }, probability = 30 }
    group:group("book_gunref", 15)
    group:entry { group = "hardware_books", count = { 1, 3 }, probability = 30 }
    group:entry { group = "religious_books", count = { 1, 3 }, probability = 30 }
    group:entry { group = "homebooks", count = { 1, 3 }, probability = 40 }
    group:group("manuals", 30)
    group:group("book_survival", 15)
    group:entry { group = "novels", count = { 1, 3 }, probability = 50 }
    group:group("textbooks", 30)
    group:group("cigar_box_unopened", 10)
    group:item("case_cigar", 5)
    group:item("trenchcoat", 25)
    group:item("trenchcoat_leather", 20)
    group:item("trenchcoat_fur", 10)
    group:item("vest_leather", 15)
    group:item("football_armor", 30)
    group:item("jacket_leather", 25)
    group:item("jacket_jean", 15)
    group:item("jacket_flannel", 15)
    group:item("pants_cargo", 40)
    group:item("shorts_cargo", 25)
    group:item("pants_army", 30)
    group:item("pants_leather", 15)
    group:item("gloves_fingerless", 30)
    group:item("gloves_tactical", 15)
    group:item("gauntlets_larmor", 25)
    group:item("gloves_fur", 5)
    group:item("gloves_leather", 35)
    group:item("gloves_work", 20)
    group:item("boots", 20)
    group:item("boots_steel", 20)
    group:item("sneakers_steel", 15)
    group:item("boots_hiking", 30)
    group:item("knee_high_boots", 5)
    group:item("boots_combat", 15)
    group:item("boots_larmor", 10)
    group:item("boots_fur", 10)
    group:item("helmet_larmor", 15)
    group:item("hood_rain", 15)
    group:item("dive_bag", 10)
    group:item("runner_bag", 20)
    group:item("backpack", 40)
    group:item("backpack_leather", 35)
    group:item("mbag", 25)
    group:item("slingpack", 15)
    group:item("rucksack", 10)
    group:item("duffelbag", 10)
    group:item("mask_hockey", 15)
    group:item("sunglasses", 15)
    group:item("glasses_safety", 10)
    group:item("goggles_chem", 5)
    group:item("goggles_ski", 5)
    group:item("tool_belt", 15)
    group:item("fanny", 5)
    group:item("dump_pouch", 5)
    group:item("ragpouch", 15)
    group:item("leather_pouch", 15)
    group:item("quiver", 15)
    group:item("quiver_large", 5)
    group:item("wristwatch", 30)
    group:item("diving_watch", 5)
    group:item("pocketwatch", 10)
    group:item("holster", 25)
    group:item("bandana", 20)
    group:item("scarf", 15)
    group:item("hat_boonie", 20)
    group:item("balclava", 10, "black")
    group:item("pickaxe", 20)
    group:item("makeshift_machete", 15)
    group:item("fungicide", 20)
    group:item("insecticide", 20)
    group:item("antifungal", 20)
    group:item("antiparasitic", 20)
    group:item("diazepam", 15)
    group:item("grapnel", 5)
    group:item("misc_repairkit", 15)
    group:group("tools_toolbox", 20)
    group:item("crowbar", 25)
    group:item("machete", 25)
    group:item("ax", 25)
    group:item("spear_knife", 30)
    content.add(group)
end
