local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_CITY_COP_storage", kind = "distribution" }
    group:item("duffelbag")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_gloves", kind = "distribution" }
    group:item("gloves_leather", 45)
    group:item("gloves_medical", 20)
    group:item("gloves_tactical", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_helmet", kind = "distribution" }
    group:item("helmet_riot")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_pants", kind = "distribution" }
    group:item("pants", 75)
    group:item("pants_cargo", 70)
    group:item("leather_belt", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_shoes", kind = "distribution" }
    group:item("boots", 70)
    group:item("boots_steel", 50)
    group:item("sneakers_steel", 35)
    group:item("boots_hiking", 20)
    group:item("boots_western", 5)
    group:item("boots_combat", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_torso", kind = "distribution" }
    group:item("dress_shirt", 50)
    group:item("postman_shirt", 45, "sheriff")
    group:item("jacket_light", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_melee", kind = "distribution" }
    group:item("baton", 50)
    group:item("PR24-retracted", 30)
    group:item("tazer", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_weapons", kind = "distribution" }
    group:group("cop_melee")
    group:group("guns_cop")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_misc", kind = "distribution", with_ammo = 75, with_magazine = 100 }
    group:item("gold_ring", 30)
    group:item("gold_ear", 30)
    group:item("gold_bracelet", 30)
    group:item("gold_watch", 30)
    group:item("gold_dental_grill", 10)
    group:item("silver_ear", 40)
    group:item("silver_necklace", 40)
    group:item("silver_bracelet", 40)
    group:item("sf_watch", 10)
    group:item("diamond_ring", 10)
    group:item("diamond_dental_grill", 5)
    group:item("jade_brooch", 30)
    group:item("copper_ear", 50)
    group:item("pocketwatch", 30)
    group:item("tieclip", 35)
    group:item("pearl_collar", 30)
    group:item("diamond", 10)
    group:item("holy_symbol", 20)
    group:entry { item = "soldering_iron_portable", charges = { 0, 50 }, probability = 60 }
    group:group("solder_wire_spool_part", 60)
    group:entry { item = "inhaler", charges = { 10, 100 }, probability = 14 }
    group:group("codeine_bottle_plastic_pill_painkiller_10", 15)
    group:group("oxycodone_bottle_plastic_pill_prescription_10", 4)
    group:entry { item = "morphine", count = { 4, 4 }, probability = 4 }
    group:group("tramadol_bottle_plastic_pill_prescription_10", 11)
    group:group("xanax_bottle_plastic_pill_prescription_10", 10)
    group:group("adderall_bottle_plastic_pill_prescription_10", 10)
    group:group("thorazine_bottle_plastic_pill_prescription_10", 7)
    group:group("prozac_bottle_plastic_pill_prescription_15", 10)
    group:group("antibiotics_bottle_plastic_pill_prescription_15", 25)
    group:group("antifungal_bottle_plastic_pill_prescription_5", 2)
    group:group("antiparasitic_bottle_plastic_pill_prescription_5", 3)
    group:item("survnote", 1)
    group:group("diazepam_bottle_plastic_pill_prescription_10", 4)
    group:item("flu_shot", 5)
    group:item("syringe", 8)
    group:group("pills_sleep_bottle_plastic_pill_prescription_10", 15)
    group:group("oxycodone_bottle_plastic_pill_prescription_10", 4)
    group:entry { item = "morphine", count = { 4, 4 }, probability = 4 }
    group:group("xanax_bottle_plastic_pill_prescription_10", 10)
    group:group("adderall_bottle_plastic_pill_prescription_10", 10)
    group:item("pipe_tobacco", 2)
    group:group("tobacco_bag_plastic_20", 2)
    group:item("adrenaline_injector", 2)
    group:entry { item = "weed", count = { 5, 5 }, probability = 50 }
    group:item("joint", 10)
    group:entry { item = "seed_weed", count = { 2, 2 }, probability = 35 }
    group:item("seed_tobacco", 15)
    group:item("rolling_paper", 9)
    group:item("pipe_glass", 17)
    group:group("coke_bag_zipper_8", 8)
    group:group("meth_bag_zipper_6", 2)
    group:group("heroin_bag_zipper_4", 1)
    group:group("crack_bag_zipper_4", 4)
    group:group("antifungal_bottle_plastic_pill_prescription_5", 1)
    group:group("antiparasitic_bottle_plastic_pill_prescription_5", 2)
    group:group("diazepam_bottle_plastic_pill_prescription_10", 1)
    group:entry { item = "lsd", count = { 5, 5 }, probability = 6 }
    group:entry { item = "weed", count = { 5, 5 }, probability = 10 }
    group:entry { item = "electrohack", charges = { 0, -1 }, probability = 3 }
    group:item("textbook_gaswarfare", 1)
    group:item("textbook_anarch", 3)
    group:item("improvised_munition_handbook", 1)
    group:item("brewing_cookbook", 3)
    group:item("recipe_bullets", 1)
    group:item("knife_combat", 14)
    group:item("knife_rm42", 2)
    group:item("kukri", 2)
    group:item("knife_hunting", 4)
    group:group("knife_rambo_cont", 20)
    group:item("tanto", 3)
    group:item("throwing_knife", 7)
    group:item("punch_dagger", 12)
    group:item("crowbar", 18)
    group:item("tazer", 3)
    group:item("software_hacking", 10)
    group:item("spray_can", 50)
    group:entry { item = "lsd", count = { 5, 5 }, probability = 2 }
    group:item("pocketwatch", 5)
    group:item("sf_watch", 5)
    group:item("file", 5)
    group:item("RPG", 1)
    group:item("RPG-7_ammo", 1)
    group:item("clown_suit", 2)
    group:item("clownshoes", 2)
    group:item("bondage_suit", 1)
    group:item("gold_dental_grill", 1)
    group:item("knife_trench", 14)
    group:item("switchblade", 15)
    group:item("bondage_mask", 1)
    group:item("thermos", 25)
    group:item("antenna", 18)
    group:item("screwdriver", 40)
    group:item("RAM", 22)
    group:entry { item = "mp3", charges = { 0, -1 }, probability = 6 }
    group:entry { item = "portable_game", charges = { 0, -1 }, probability = 12 }
    group:entry { item = "game_watch", charges = { 0, -1 }, probability = 3 }
    group:group("sex_accessories_domestic", 10)
    group:entry { item = "flashlight", charges = { 0, 300 }, probability = 40 }
    group:entry { item = "heavy_flashlight", charges = { 0, 300 }, probability = 10 }
    group:entry { item = "radio", charges = { 0, -1 }, probability = 20 }
    group:item("mess_kit", 5)
    group:item("hotplate", 10)
    group:item("coffeemaker", 10)
    group:item("receiver", 10)
    group:item("transponder", 5)
    group:item("tazer", 3)
    group:item("usb_drive", 15)
    group:item("recipe_augs", 4)
    group:group("cable_roll_part", 60)
    group:item("vac_sealer", 10)
    group:entry { group = "civilian_phones", charges = { 0, -1 }, probability = 50 }
    group:item("eink_tablet_pc", 15)
    group:item("memory_card_unread", 15)
    group:entry { item = "camera", charges = { 0, 150 }, probability = 15 }
    group:entry { item = "camera_pro", charges = { 0, 150 }, probability = 5 }
    group:item("wristwatch", 15)
    group:group("toy_radio_car", 3)
    group:item("radiocontrol", 15)
    group:item("magnifying_glass", 4)
    group:item("omnicamera", 2)
    group:entry { item = "reading_light", charges = { 0, -1 }, probability = 6 }
    group:item("gold_anklet", 20)
    group:item("silver_anklet", 25)
    content.upsert_item_group(group)
end
