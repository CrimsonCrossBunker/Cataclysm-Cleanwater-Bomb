local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_SOLDIER_QMASTER_storage", kind = "distribution" }
    group:item("duffelbag")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_SOLDIER_QMASTER_coat", kind = "distribution" }
    group:item("trenchcoat", 80)
    group:item("vest", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_SOLDIER_QMASTER_misc", kind = "collection" }
    group:entry { item = "RobofacCoin", count = { 5, 30 }, probability = 30 }
    group:entry { item = "FMCNote", count = { 30, 300 }, probability = 10 }
    group:entry { group = "ammo_milspec", count = { 2, 5 } }
    group:entry { group = "mags_milspec", count = { 1, 3 } }
    group:entry { group = "mags_military", count = { 3, 7 } }
    group:entry { group = "mil_accessories", count = { 1, 3 } }
    group:entry { group = "tools_mechanic", count = { 1, 3 }, probability = 20 }
    group:entry { group = "ammo_any_batteries_full", count = { 1, 3 }, probability = 20 }
    group:item("vest", 40)
    group:item("kevlar", 15)
    group:item("jacket_army", 30)
    group:item("pants_army", 30)
    group:item("gloves_tactical", 15)
    group:item("boots", 20)
    group:item("boots_steel", 20)
    group:item("boots_hiking", 30)
    group:item("knee_high_boots", 5)
    group:item("boots_combat", 15)
    group:item("boots_larmor", 10)
    group:item("helmet_army", 25)
    group:item("tac_helmet", 20)
    group:item("helmet_riot", 20)
    group:item("tac_fullhelmet", 10)
    group:item("helmet_larmor", 15)
    group:item("firehelmet", 5)
    group:item("hood_rain", 15)
    group:item("molle_pack", 20)
    group:item("backpack", 35)
    group:item("backpack_denim", 15)
    group:item("backpack_leather", 25)
    group:item("mask_gas", 25)
    group:item("mask_filter", 20)
    group:item("glasses_safety", 15)
    group:item("goggles_ski", 5)
    group:item("tacvest", 20)
    group:item("legrig", 15)
    group:item("tool_belt", 15)
    group:item("dump_pouch", 15)
    group:item("wristwatch", 30)
    group:item("diving_watch", 5)
    group:item("holster", 25)
    group:item("bandana", 20)
    group:item("balclava", 10, "black")
    group:item("small_repairkit", 20)
    group:item("grapnel", 5)
    group:item("misc_repairkit", 15)
    group:group("tools_toolbox", 20)
    group:item("crowbar", 25)
    group:item("machete", 25)
    group:item("tarp", 25)
    group:item("rope_30", 25)
    group:item("rope_6", 25)
    group:group("ammo_common_boxed")
    group:group("guns_common")
    group:item("laser_sight", 15)
    group:item("rail_laser_sight", 10)
    group:item("rifle_scope", 20)
    group:item("pistol_scope", 10)
    group:item("improve_sights", 20)
    group:item("ashot", 5)
    content.add(group)
end
