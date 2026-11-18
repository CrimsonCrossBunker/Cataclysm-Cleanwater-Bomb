local content = require("ccb").content

do
    local group = content.ItemGroup { id = "military_standard_pistols", kind = "distribution" }
    group:entry { item = "m9", charges = { 0, 15 }, variant = "m9", probability = 30 }
    group:entry { item = "m11", charges = { 0, 13 }, probability = 3 }
    group:entry { item = "m17", charges = { 0, 17 }, probability = 65 }
    group:entry { item = "m18", charges = { 0, 17 }, probability = 30 }
    group:entry { item = "glock_19", charges = { 0, 15 }, probability = 3 }
    group:entry { item = "m1911", charges = { 0, 7 }, variant = "m1911_MEU", probability = 2 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "army_personal_locker", kind = "distribution" }
    group:item("jumpsuit", 40, "green")
    group:item("military_poncho", 40)
    group:item("military_poncho_heavy", 40)
    group:item("military_poncho_liner", 40)
    group:item("officer_uniform", 20)
    group:entry { item = "flight_helmet", charges = { 0, 100 }, probability = 5 }
    group:item("mil_flight_suit", 30)
    group:group("military_papr_kit", 15)
    group:group("molle_papr_kit", 15)
    group:item("combo_cover", 20)
    group:item("pants_army", 70)
    group:item("combat_shirt", 35)
    group:item("jacket_army_modern", 35)
    group:item("socks", 40)
    group:item("winter_pants_army", 20)
    group:item("winter_jacket_army", 20)
    group:item("winter_gloves_army", 20)
    group:item("tank_top", 70, "tank_top_camo")
    group:group("eod_armor", 15)
    group:group("box_of_batteries_random", 40)
    group:item("laptop_hard_case", 20)
    group:entry { item = "radio", charges = { 10, 95 }, probability = 10 }
    group:item("boots_combat", 50)
    group:entry { item = "bandages", count = { 1, 3 }, probability = 10 }
    group:group("adhesive_bandages_box_used", 10)
    group:group("cig_box_cigarette_1_20", 60)
    group:item("knife_combat_marine", 10)
    group:item("knife_combat_army", 30, "m9bayonet")
    group:item("pockknife", 30)
    group:item("knife_folding", 20)
    group:item("glasses_safety", 45)
    group:entry { item = "eyedrops", count = { 1, 10 }, probability = 10 }
    group:entry { item = "steroid_eyedrops", count = { 1, 10 }, probability = 10 }
    group:item("screwdriver", 5)
    group:item("glasses_eye", 30)
    group:item("tool_belt", 20)
    group:item("bra", 40)
    group:item("undershirt", 50)
    group:item("boxer_shorts", 50)
    group:item("briefs", 50)
    group:item("canteen", 40)
    group:item("2lcanteen", 20)
    group:item("camelbak", 10)
    group:item("rucksack", 30)
    group:group("molle_backpacks_and_accessories", 15)
    group:item("heatpack", 30)
    group:item("sleeping_bag_roll", 20)
    group:item("duffelbag", 15)
    group:item("seabag", 10)
    group:item("mess_kit", 50)
    group:entry { item = "flashlight", charges = { 0, 300 }, probability = 50 }
    group:entry { item = "heavy_flashlight", charges = { 0, 300 }, probability = 10 }
    group:item("mag_fieldrepair", 20)
    group:item("mag_comic", 20)
    group:group("book_gunmags", 20)
    group:item("thermos", 15)
    group:item("kevlar_nape_protector", 5)
    group:item("counterweight_pouch", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "helicopter", kind = "distribution", with_magazine = 100 }
    group:group("guns_launcher_milspec", 5)
    group:group("guns_launcher_rocket", 44)
    group:group("guns_rifle_milspec", 10)
    group:entry { item = "human_flesh", count = { 1, 10 }, probability = 4 }
    group:entry { item = "bone_human", count = { 1, 5 }, probability = 10 }
    group:entry {
        item = "cotton_patchwork",
        count = { 1, 10 },
        flags = {
            "FILTHY",
        },
        probability = 10,
    }
    group:item("sheet_metal", 22)
    group:item("seat", 4)
    group:item("chain", 20)
    group:item("power_supply", 16)
    group:item("antenna", 18)
    group:item("lc_steel_chunk", 30)
    group:item("spring", 50)
    group:item("lc_steel_lump", 30)
    group:item("frame", 20)
    group:item("steel_plate", 30)
    group:item("mil_plate", 30)
    group:item("wheel_armor", 15)
    group:item("spiked_plate", 15)
    group:item("hard_plate", 30)
    group:item("motor", 2)
    group:item("motor_large", 1)
    group:item("laptop_hard_case", 10)
    group:item("motor_small", 1)
    group:item("hose", 15)
    group:item("pants_army", 30)
    group:entry { item = "flight_helmet", charges = { 0, 100 }, probability = 10 }
    group:item("mil_flight_suit", 30)
    group:item("combat_shirt", 15)
    group:item("jacket_army_modern", 15)
    group:item("winter_pants_army", 10)
    group:item("winter_jacket_army", 10)
    group:item("winter_gloves_army", 10)
    group:item("tank_top", 30, "tank_top_camo")
    group:item("boots_combat", 10)
    group:item("gloves_tactical", 10)
    group:item("jumpsuit", 20, "green")
    group:item("military_poncho", 20)
    group:item("military_poncho_heavy", 20)
    group:item("military_poncho_liner", 20)
    group:item("kevlar", 10)
    group:item("officer_uniform", 5)
    group:item("combo_cover", 5)
    group:group("military_ballistic_vest", 40)
    group:item("sheet_kevlar_layered", 10)
    group:group("gasmask_bag_full", 10)
    group:item("helmet_army", 40)
    group:item("helmet_liner", 10)
    group:group("box_of_batteries_random", 50)
    group:entry { item = "m249", charges = { 0, 30 }, probability = 1 }
    group:entry { item = "m240", charges = { 0, 200 }, probability = 1 }
    group:entry { item = "m134", charges = { 0, 200 }, probability = 1 }
    group:item("atgm_launcher", 1)
    group:item("atgm_heat", 3)
    group:entry { item = "extinguisher", charges = { 100, 100 }, probability = 20 }
    group:entry { item = "radio", charges = { 0, 100 }, probability = 20 }
    group:entry { item = "UPS_OFF", charges = { 0, 1000 }, probability = 8 }
    group:group("papr_kit", 5)
    group:item("tacvest", 10)
    group:group("molle_backpacks_and_accessories", 15)
    group:item("legrig", 10)
    group:item("rucksack", 20)
    group:group("bugout_bag", 2)
    group:group("full_survival_kit", 3)
    group:item("tac_helmet", 5)
    group:item("tac_fullhelmet", 2)
    group:group("molle_papr_kit", 5)
    group:item("cowboy_hat", 4)
    group:item("mask_bal", 1)
    group:entry { item = "sm_extinguisher", charges = { 10, 10 }, probability = 10 }
    group:item("flaregun", 20)
    group:item("signal_flare", 25)
    group:item("glasses_bal", 10)
    group:item("mask_bal", 2)
    group:item("55gal_drum", 1)
    group:item("30gal_drum", 2)
    group:item("grapnel", 1)
    group:item("briefcase", 5)
    group:item("survnote", 2)
    group:entry { item = "flight_helmet", charges = { 0, 150 }, ammo = { item = "light_battery_cell" }, probability = 20 }
    group:item("mil_flight_suit", 20)
    content.add(group)
end
