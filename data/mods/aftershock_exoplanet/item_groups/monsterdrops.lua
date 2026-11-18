local content = require("ccb").content

do
    -- contains cloth for an average human moxie
    local group = content.ItemGroup { id = "default_moxie_human_clothes", kind = "collection" }
    group:entry { group = "afs_colonist_outfit", damage = { 1, 4 } }
    group:entry { group = "afs_scrap_armor_g", damage = { 1, 4 }, probability = 15 }
    content.add(group)
end

do
    -- items people could have carried in their bags prior to the moxification, that word is a WIP, haha
    local group = content.ItemGroup { id = "default_moxie_human_item_bags", kind = "collection" }
    group:entry { group = "afs_colonist_bags", damage = { 1, 4 } }
    group:group("default_moxie_human_items_pockets", 50)
    group:group("alcohol_bottled_canned", 10)
    group:group("vending_drink_items", 25)
    group:item("file", 10)
    group:item("thermos", 10)
    group:entry {
        distribution = {
            { group = "afs_tools_electric_repair", probability = 40 },
            { group = "afs_tools_scavenging", probability = 10 },
            { group = "afs_tools_programing", probability = 50 },
        },
        probability = 5,
    }
    group:entry {
        distribution = {
            { item = "camera", charges = { 0, 50 }, probability = 70 },
            { item = "camera_pro", charges = { 0, 50 }, probability = 30 },
        },
        probability = 10,
    }
    content.add(group)
end

do
    -- items people could have carried in their pockets prior to moxieification
    local group = content.ItemGroup { id = "default_moxie_human_items_pockets", kind = "collection" }
    group:group("afs_tools_pocket", 5)
    group:item("afs_glass_device", 15)
    group:entry {
        distribution = {
            { item = "cig", count = { 0, 20 }, wrapper = "box_cigarette", container = "null", probability = 65 },
            { item = "chaw", probability = 5 },
            { item = "cigar", probability = 10 },
            { item = "handrolled_cig", probability = 10 },
            { group = "chewing_gum_used_nic", probability = 20 },
            { item = "ecig", probability = 15 },
            {
                collection = {
                    { item = "advanced_ecig" },
                    { group = "nicotine_liquid_bottle_part" },
                },
                probability = 10,
            },
            {
                collection = {
                    { item = "crackpipe" },
                    { item = "crack" },
                },
                probability = 5,
            },
        },
        probability = 50,
    }
    group:entry {
        distribution = {
            { group = "chewing_gum_used" },
            { group = "chewing_gum_used_caff" },
        },
        probability = 30,
    }
    group:entry { item = "mp3", charges = { 0, 15 }, probability = 18 }
    group:entry { item = "portable_game", charges = { 0, 50 }, probability = 10 }
    group:entry { item = "game_watch", charges = { 0, 50 }, damage = { 1, 4 }, probability = 10 }
    group:item("usb_drive", 10)
    group:item("meth", 2)
    group:item("coke", 2)
    group:item("lsd", 2)
    group:item("heroin", 2)
    group:item("memory_card_unread", 10)
    group:item("flyer", 30)
    group:item("multitool", 5)
    group:entry { item = "permanent_marker", charges = { 0, 500 }, probability = 10 }
    group:group("softdrugs", 10)
    group:group("harddrugs", 5)
    content.add(group)
end

do
    -- items that an average zombie carries around and drops on death
    local group = content.ItemGroup {
        id = "default_moxie_human_items",
        kind = "distribution",
        with_ammo = 30,
        with_magazine = 100,
    }
    group:group("default_moxie_human_item_bags", 16)
    group:group("default_moxie_human_items_pockets", 20)
    content.add(group)
end

do
    -- contains cloth (always), a cash card (10% chance), and a random item (50% chance)
    local group = content.ItemGroup { id = "default_moxie_human_death_drops", kind = "collection" }
    group:group("default_moxie_human_clothes")
    group:group("default_moxie_human_items", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mon_afs_sentinel_lx_drops", kind = "collection" }
    group:item("afs_sentinel_cloak")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_bandits", kind = "collection" }
    group:item("boots_combat")
    group:entry { item = "technician_pants_gray", damage = { 0, 5 } }
    group:entry { item = "technician_shirt_gray", damage = { 0, 5 } }
    group:entry { item = "afs_magellan_suit", damage = { 0, 5 }, probability = 50 }
    group:group("afs_civilian_armory", 50)
    group:entry { group = "mil_food", damage = { 0, 5 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xl_uplift_death_drop", kind = "collection" }
    group:entry { item = "xlboots_combat", damage = { 0, 5 } }
    group:entry { item = "xl_technician_pants_gray", damage = { 0, 5 }, probability = 50 }
    group:entry { item = "xl_technician_shirt_gray", damage = { 0, 5 } }
    group:entry { item = "xl_jeans", damage = { 0, 5 }, probability = 50 }
    group:entry { group = "mil_food", damage = { 0, 5 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xl_uplift_zed_death_drop", kind = "collection" }
    group:entry { item = "xlboots_combat", damage = { 1, 5 } }
    group:entry { item = "xl_technician_pants_gray", damage = { 1, 5 }, probability = 50 }
    group:entry { item = "xl_technician_shirt_gray", damage = { 1, 5 } }
    group:entry { item = "xl_jeans", damage = { 1, 5 }, probability = 50 }
    group:item("mp5mag", 10)
    group:entry { group = "mil_food", damage = { 0, 5 } }
    content.add(group)
end
