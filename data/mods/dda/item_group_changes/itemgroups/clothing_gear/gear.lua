local content = require("ccb").content

do
    local group = content.ItemGroup { id = "swat_gear", kind = "distribution" }
    group:group("cop_gear")
    group:item("40x46mm_m433", 5)
    group:item("40x46mm_m651", 10)
    group:item("ammo_satchel", 5)
    group:item("ammo_pouch", 5)
    group:item("bootstrap", 5)
    group:item("chestpouch", 5)
    group:item("flashbang", 30)
    group:entry { item = "goggles_ir", charges = { 0, 100 }, probability = 10 }
    group:entry { item = "goggles_nv", charges = { 0, 100 }, probability = 10 }
    group:item("helmet_riot", 5)
    group:item("holo_sight", 20)
    group:item("balclava", 10, "black")
    group:item("balaclava_cut_resistant", 5)
    group:item("nylon_holster", 10)
    group:item("holster", 5)
    group:item("bandolier_shotgun", 15)
    group:item("torso_bandolier_shotgun", 8)
    group:item("kevlar", 20)
    group:item("pockknife", 10)
    group:item("legpouch_large", 5)
    group:item("mask_bal", 10)
    group:group("gasmask_bag_full", 10)
    group:group("swat_ballistic_vest", 15)
    group:item("smokebomb", 5)
    group:item("suppressor", 25)
    group:item("suppressor_compact", 20)
    group:item("tac_fullhelmet", 5)
    group:item("tac_helmet", 10)
    group:entry { item = "teargas_sprayer", charges = { 1, 10 }, probability = 25 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fireman_gear", kind = "distribution" }
    group:entry { item = "extinguisher", charges = { 100, 100 }, probability = 10 }
    group:entry { item = "firefighter_scba_tank", charges = { 30, 30 }, probability = 60 }
    group:entry { item = "sm_extinguisher", charges = { 10, 10 }, probability = 20 }
    group:item("fire_ax", 60)
    group:item("halligan", 50)
    group:group("used_1st_aid", 10)
    group:entry { item = "bandages", count = { 1, 3 }, probability = 5 }
    group:group("cotton_ball_bag_used", 2)
    group:group("cotton_ball_bag_full", 1)
    group:item("crowbar", 15)
    group:item("entry_suit", 10)
    group:item("hammer_sledge", 5)
    group:item("hammer_sledge_short", 4)
    group:item("hammer_sledge_engineer", 5)
    group:item("hammer_sledge_heavy", 1)
    group:item("shovel", 20)
    group:group("civilian_phones", 20)
    group:item("airhorn", 5)
    group:item("boltcutters", 5)
    group:item("tacvest", 10)
    group:entry { item = "chainsaw_off", charges = { 0, -1 }, probability = 1 }
    group:item("backpack", 15)
    group:item("backpack_denim", 1)
    group:item("rope_30", 10)
    group:entry { item = "rx12_injector", charges = { 0, -1 }, probability = 1 }
    group:entry { item = "rx11_stimpack", charges = { 0, -1 }, probability = 1 }
    group:item("flaregun", 5)
    group:item("signal_flare", 5)
    group:entry { item = "handflare", charges = { 300, 300 }, probability = 20 }
    group:entry { item = "heavy_flashlight", charges = { 0, 300 }, probability = 30 }
    group:entry { item = "glowstick", charges = { 1400, 1400 }, probability = 10 }
    group:entry { item = "two_way_radio", charges = { 0, 100 }, probability = 20 }
    group:item("emergency_book", 1)
    group:item("textbook_firstaid", 5)
    group:item("manual_first_aid", 5)
    group:item("pocket_firstaid", 10)
    group:item("pocketwatch", 5)
    group:item("wristwatch", 10)
    group:group("tobacco_products", 32)
    group:entry { item = "ref_lighter", charges = { 0, -1 }, probability = 1 }
    group:item("flask_hip", 1)
    group:item("textbook_fireman", 10)
    group:item("knee_pads", 5)
    group:item("elbow_pads", 5)
    group:item("legrig", 5)
    group:entry { item = "UPS_OFF", charges = { 0, 1000 }, probability = 7 }
    group:item("emer_blanket", 5)
    group:group("ammo_pocket_batteries_full", 50)
    group:item("tool_belt", 5)
    group:entry { item = "oxygen_tank", charges = { 4, -1 }, probability = 15 }
    group:item("fireman_belt", 15)
    group:item("jack", 5)
    group:item("throw_extinguisher", 10)
    group:item("grapnel", 5)
    group:entry { item = "wearable_light", charges = { 0, -1 }, probability = 5 }
    group:group("tools_toolbox", 1)
    group:entry { item = "smoxygen_tank", charges = { 4, -1 }, probability = 35 }
    group:entry { item = "watercannon", charges = { 0, -1 }, probability = 10 }
    group:item("bag_body_bag", 5)
    content.add(group)
end

do
    -- This group is for an area storing diving equipment.  SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    local group = content.ItemGroup { id = "SUS_scuba_gear", kind = "collection" }
    group:entry {
        distribution = {
            { item = "c_fishspear", probability = 50 },
            { item = "m_fishspear", probability = 50 },
        },
        probability = 65,
    }
    group:entry {
        distribution = {
            { item = "fitness_band", probability = 50 },
            { item = "diving_watch", probability = 50 },
        },
    }
    group:group("swimmer_glasses")
    group:group("swimmer_head")
    group:group("swimmer_torso")
    group:group("swimmer_pants")
    group:group("swimmer_wetsuit")
    group:group("swimmer_accessories", 40)
    group:item("dive_bag")
    group:item("dry_bag")
    group:item("dry_duffelbag")
    group:item("dry_bag_large", 50)
    group:item("wetsuit_gloves", 70)
    group:item("wetsuit_booties", 70)
    group:item("swim_fins")
    group:item("scuba_regulator", 60)
    group:entry {
        distribution = {
            { item = "airspeargun", probability = 20 },
            { item = "doublespeargun", probability = 10 },
            { item = "speargun", probability = 40 },
        },
        probability = 65,
    }
    group:entry {
        collection = {
            { item = "small_scuba_tank", charges = { 5, 20 }, probability = 40 },
            { item = "scuba_tank", charges = { 10, 60 }, probability = 60 },
        },
        probability = 85,
    }
    group:entry {
        collection = {
            { item = "rebreather_cartridge_o2", charges = { 180, 180 }, probability = 50 },
            { item = "rebreather", probability = 90 },
        },
        probability = 20,
    }
    group:entry {
        collection = {
            { item = "folded_inflatable_boat", probability = 30 },
            { item = "hand_pump", probability = 60 },
        },
        probability = 15,
    }
    content.add(group)
end
