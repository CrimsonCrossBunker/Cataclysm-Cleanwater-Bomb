local content = require("ccb").content

do
    local group = content.ItemGroup { id = "mil_armor", kind = "distribution" }
    group:item("pants_army", 10)
    group:item("jacket_army_modern", 5)
    group:item("jacket_army_modern", 5)
    group:item("winter_pants_army", 30)
    group:item("winter_jacket_army", 30)
    group:item("winter_gloves_army", 30)
    group:item("tank_top", 30, "tank_top_camo")
    group:item("kevlar", 10)
    group:group("military_ballistic_vest", 30)
    group:item("vest", 15)
    group:group("gasmask_bag_full", 10)
    group:entry { item = "goggles_nv", charges = { 0, 100 }, probability = 1 }
    group:entry { item = "goggles_ir", charges = { 0, 100 }, probability = 1 }
    group:item("backpack", 38)
    group:entry { item = "UPS_OFF", charges = { 0, 1000 }, probability = 8 }
    group:item("tacvest", 10)
    group:group("molle_backpacks_and_accessories", 8)
    group:item("duffelbag", 15)
    group:group("large_duffelbags", 5)
    group:item("dump_pouch", 20)
    group:item("legrig", 10)
    group:item("under_armor", 20)
    group:item("boots", 70)
    group:item("boots_combat", 70)
    group:item("gloves_tactical", 30)
    group:item("glasses_bal", 40)
    group:item("chestguard_hard", 20)
    group:item("armguard_hard", 20)
    group:item("legguard_hard", 15)
    group:group("army_helmet_nvg", 1)
    group:item("helmet_army", 40)
    group:item("helmet_liner", 10)
    group:item("mask_bal", 5)
    group:item("beret", 50)
    group:item("beret_wool", 40)
    group:item("elbow_pads", 50)
    group:item("knee_pads", 50)
    group:item("folding_solar_panel_v2", 5)
    content.add(group)
end
