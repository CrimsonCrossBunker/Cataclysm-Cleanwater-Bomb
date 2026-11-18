local content = require("ccb").content

do
    -- Uses same weights as the variant weights
    local group = content.ItemGroup { id = "bikini_matching", kind = "distribution" }
    group:entry {
        collection = {
            { item = "bikini_top", variant = "generic_bikini_top" },
            { item = "bikini_bottom", variant = "generic_bikini_bottom" },
        },
        probability = 30,
    }
    group:entry {
        collection = {
            { item = "bikini_top", variant = "black_bikini_top" },
            { item = "bikini_bottom", variant = "black_bikini_bottom" },
        },
        probability = 10,
    }
    group:entry {
        collection = {
            { item = "bikini_top", variant = "white_bikini_top" },
            { item = "bikini_bottom", variant = "white_bikini_bottom" },
        },
        probability = 10,
    }
    group:entry {
        collection = {
            { item = "bikini_top", variant = "red_bikini_top" },
            { item = "bikini_bottom", variant = "red_bikini_bottom" },
        },
        probability = 10,
    }
    group:entry {
        collection = {
            { item = "bikini_top", variant = "blue_bikini_top" },
            { item = "bikini_bottom", variant = "blue_bikini_bottom" },
        },
        probability = 10,
    }
    group:entry {
        collection = {
            { item = "bikini_top", variant = "flag_bikini_top" },
            { item = "bikini_bottom", variant = "flag_bikini_bottom" },
        },
        probability = 7,
    }
    group:entry {
        collection = {
            { item = "bikini_top", variant = "pink_bikini_top" },
            { item = "bikini_bottom", variant = "pink_bikini_bottom" },
        },
        probability = 6,
    }
    group:entry {
        collection = {
            { item = "bikini_top", variant = "tropical_bikini_top" },
            { item = "bikini_bottom", variant = "tropical_bikini_bottom" },
        },
        probability = 5,
    }
    group:entry {
        collection = {
            { item = "bikini_top", variant = "floral_bikini_top" },
            { item = "bikini_bottom", variant = "floral_bikini_bottom" },
        },
        probability = 5,
    }
    group:entry {
        collection = {
            { item = "bikini_top", variant = "camo_bikini_top" },
            { item = "bikini_bottom", variant = "camo_bikini_bottom" },
        },
        probability = 4,
    }
    group:entry {
        collection = {
            { item = "bikini_top", variant = "skull_bikini_top" },
            { item = "bikini_bottom", variant = "skull_bikini_bottom" },
        },
        probability = 2,
    }
    group:entry {
        collection = {
            { item = "bikini_top", variant = "maid_bikini_top" },
            { item = "bikini_bottom", variant = "maid_bikini_bottom" },
        },
        probability = 1,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bikini_unmatching", kind = "collection" }
    group:item("bikini_top")
    group:item("bikini_bottom")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bikini_fur", kind = "collection" }
    group:item("bikini_top_fur")
    group:item("bikini_bottom")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bikini_leather", kind = "collection" }
    group:item("bikini_top_leather")
    group:item("bikini_bottom")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bikini_short", kind = "collection" }
    group:item("bikini_top_short")
    group:item("bikini_bottom_short")
    content.add(group)
end

do
    -- clothing sets for swimming
    local group = content.ItemGroup { id = "swimmer_set_any", kind = "distribution" }
    group:group("swimmer_accessories", 20)
    group:group("swimmer_glasses", 15)
    group:group("swimmer_head", 25)
    group:group("swimmer_torso", 50)
    group:group("swimmer_pants", 75)
    group:group("swimmer_gloves", 5)
    group:group("swimmer_shoes", 25)
    group:group("swimmer_wetsuit", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "swimmer_accessories", kind = "distribution" }
    group:item("dive_bag", 35)
    group:item("dry_bag", 35)
    group:item("dry_duffelbag", 35)
    group:item("dry_bag_large", 20)
    group:item("wicker_backpack", 10)
    group:item("flotation_vest", 30)
    group:item("swimming_kickboard", 5)
    group:item("diving_watch", 5)
    group:item("wristwatch", 5)
    group:item("scuba_regulator", 5)
    group:item("small_scuba_tank", 5)
    group:item("scuba_tank", 5)
    group:item("whistle", 3)
    group:entry { item = "camera", charges = { 0, 150 }, container = "camera_bag", probability = 2 }
    group:item("camera_bag", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "swimmer_glasses", kind = "distribution" }
    group:item("goggles_swim", 80)
    group:item("fitover_sunglasses", 5)
    group:item("sunglasses", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "swimmer_head", kind = "distribution" }
    group:item("swim_cap", 50)
    group:item("wetsuit_hood", 20)
    group:item("wetsuit_hood_thick", 5)
    group:item("rebreather", 5)
    group:item("straw_hat", 45)
    group:item("hat_sombrero", 10)
    content.add(group)
end

do
    -- For use in death drops where bikinis are paired separately
    local group = content.ItemGroup { id = "swimmer_pants_no_bikini", kind = "distribution" }
    group:item("trunks", 65)
    group:item("swim_briefs", 35)
    group:item("speedo", 10)
    group:item("wetsuit_pants", 25)
    group:item("wetsuit_shorts", 35)
    group:item("hot_pants", 30)
    group:item("under_armor_shorts", 15)
    group:item("skirt", 10)
    group:item("skirt_grass", 15)
    group:item("nanoskirt", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "swimmer_gloves", kind = "distribution" }
    group:item("wetsuit_gloves", 95)
    group:item("wetsuit_gloves_thick", 5)
    group:item("gloves_fingerless", 3)
    group:item("gloves_light", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "swimmer_shoes", kind = "distribution" }
    group:item("flip_flops", 50)
    group:item("flip_flops_exp", 5)
    group:item("swim_fins", 15)
    group:item("wetsuit_booties", 20)
    group:item("wetsuit_booties_thick", 5)
    group:item("bastsandals", 5)
    group:item("straw_sandals", 5)
    group:item("espadrilles", 5)
    content.add(group)
end

do
    -- Not really clothing, but connected to the swimmer sets of clothing.
    local group = content.ItemGroup { id = "swimmer_items", kind = "distribution" }
    group:item("towel", 60)
    group:item("beach_volleyball", 40)
    group:item("mag_swimming", 30)
    group:item("manual_swimming", 10)
    group:item("mag_porn", 5)
    group:item("mag_tv", 5)
    group:item("mag_glam", 5)
    group:item("mag_dude", 5)
    group:group("SUS_book_nonf_soft_sports", 5)
    group:item("diveknife", 5)
    group:item("sports_drink", 5)
    group:item("water_clean", 5)
    group:item("fish_sandwich", 2)
    group:item("mango", 1)
    group:item("hand_pump", 5)
    group:item("folded_inflatable_boat", 1)
    content.add(group)
end

do
    -- Only diving appropriate headgear, not including masks or glasses.
    local group = content.ItemGroup { id = "diving_head", kind = "distribution" }
    group:item("wetsuit_hood", 45)
    group:item("wetsuit_hood_thick", 45)
    group:item("swim_cap", 10)
    content.add(group)
end

do
    -- Only diving appropriate masks, it needs to let the user breath underwater.
    local group = content.ItemGroup { id = "diving_masks", kind = "distribution" }
    group:item("rebreather")
    group:item("rebreather_cartridge_o2")
    content.add(group)
end

do
    -- Only diving appropriate glasses, it needs to let the user see underwater.
    local group = content.ItemGroup { id = "diving_glasses", kind = "distribution" }
    group:item("goggles_swim")
    content.add(group)
end

do
    -- Only diving appropriate (even if not optimal) suits of torso + pants.
    local group = content.ItemGroup { id = "diving_suits", kind = "distribution" }
    group:group("diving_wetsuit", 95)
    group:entry {
        distribution = {
            { group = "diving_torso" },
            { group = "diving_pants" },
        },
        probability = 5,
    }
    content.add(group)
end

do
    -- Only diving appropriate torso clothing.
    local group = content.ItemGroup { id = "diving_torso", kind = "distribution" }
    group:item("wetsuit_top_sleeved", 60)
    group:item("wetsuit_top", 40)
    group:item("wetsuit_jacket", 30)
    group:item("bikini_top", 5)
    group:item("bikini_top_short", 1)
    content.add(group)
end

do
    -- Only diving appropriate legs clothing.  To be expanded later with rash guards.
    local group = content.ItemGroup { id = "diving_pants", kind = "distribution" }
    group:item("wetsuit_pants", 80)
    group:item("wetsuit_shorts", 20)
    group:item("bikini_bottom", 5)
    group:item("bikini_bottom_short", 1)
    group:item("swim_briefs", 5)
    group:item("speedo", 1)
    content.add(group)
end

do
    -- Only diving appropriate gloves.
    local group = content.ItemGroup { id = "diving_gloves", kind = "distribution" }
    group:item("wetsuit_gloves", 50)
    group:item("wetsuit_gloves_thick", 50)
    content.add(group)
end

do
    -- Only diving appropriate footgear.
    local group = content.ItemGroup { id = "diving_shoes", kind = "distribution" }
    group:item("swim_fins", 50)
    group:item("wetsuit_booties", 50)
    group:item("wetsuit_booties_thick", 50)
    content.add(group)
end

do
    -- Only diving appropriate accesories.
    local group = content.ItemGroup { id = "diving_accessories", kind = "distribution" }
    group:item("dive_bag", 25)
    group:item("dry_bag", 25)
    group:item("dry_duffelbag", 25)
    group:item("dry_bag_large", 15)
    group:item("diving_watch", 25)
    group:item("small_scuba_tank", 25)
    group:item("scuba_tank", 25)
    group:item("scuba_regulator", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bikini", kind = "distribution" }
    group:entry {
        collection = {
            { item = "bikini_top", variant = "flag_bikini_top" },
            { item = "bikini_bottom", variant = "flag_bikini_bottom" },
        },
        event = "independence_day",
        probability = 30,
    }
    group:group("bikini_matching", 10)
    group:group("bikini_unmatching", 1)
    group:group("bikini_fur", 1)
    group:group("bikini_leather", 1)
    group:group("bikini_short", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "swimmer_torso", kind = "distribution" }
    group:item("bikini_top", 85)
    group:item("bikini_top_fur", 5)
    group:item("bikini_top_leather", 5)
    group:item("bikini_top_short", 20)
    group:item("sports_bra", 10)
    group:item("wetsuit_jacket", 10)
    group:item("wetsuit_top", 25)
    group:item("wetsuit_top_sleeved", 25)
    group:item("rashguard", 25)
    group:item("thermal_shirt", 20)
    group:item("under_armor", 15)
    group:item("tank_top", 6, "tank_top_camo")
    group:item("tank_top", 6)
    group:item("halter_top", 6)
    group:item("tshirt", 15)
    group:entry { item = "rashguard", variant = "flag_rashguard_shirt", event = "independence_day", probability = 60 }
    group:entry { item = "tshirt", variant = "flag_shirt", event = "independence_day", probability = 20 }
    group:entry { item = "bikini_top", variant = "flag_bikini_top", event = "independence_day", probability = 50 }
    content.add(group)
end

do
    -- For use in death drops where bikinis are paired separately
    local group = content.ItemGroup { id = "swimmer_torso_no_bikini", kind = "distribution" }
    group:item("sports_bra", 10)
    group:item("wetsuit_jacket", 10)
    group:item("wetsuit_top", 25)
    group:item("wetsuit_top_sleeved", 25)
    group:item("rashguard", 25)
    group:item("thermal_shirt", 20)
    group:item("under_armor", 15)
    group:item("tank_top", 6, "tank_top_camo")
    group:item("tank_top", 6)
    group:item("halter_top", 6)
    group:item("tshirt", 15)
    group:entry { item = "rashguard", variant = "flag_rashguard_shirt", event = "independence_day", probability = 60 }
    group:entry { item = "tshirt", variant = "flag_shirt", event = "independence_day", probability = 20 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "swimmer_pants", kind = "distribution" }
    group:item("trunks", 65)
    group:item("bikini_bottom", 95)
    group:item("bikini_bottom_short", 20)
    group:item("swim_briefs", 35)
    group:item("speedo", 10)
    group:item("wetsuit_pants", 25)
    group:item("wetsuit_shorts", 35)
    group:item("hot_pants", 30)
    group:item("under_armor_shorts", 15)
    group:item("skirt", 10)
    group:item("skirt_grass", 15)
    group:item("nanoskirt", 5)
    group:entry { item = "bikini_bottom", variant = "flag_bikini_bottom", event = "independence_day", probability = 50 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "swimmer_wetsuit", kind = "distribution" }
    group:item("wetsuit", 35)
    group:item("wetsuit_thick", 5)
    group:item("wetsuit_spring", 25)
    group:item("wetsuit_spring_sleeveless", 25)
    group:item("flag_swimsuit", 65)
    group:entry { item = "flag_swimsuit", variant = "flag_swimsuit", event = "independence_day", probability = 60 }
    group:entry { item = "bodysuit_lycra", variant = "flag_suit", event = "independence_day", probability = 10 }
    content.add(group)
end

do
    -- Only diving appropriate suits.
    local group = content.ItemGroup { id = "diving_wetsuit", kind = "distribution" }
    group:item("wetsuit", 50)
    group:item("wetsuit_thick", 50)
    group:item("wetsuit_spring", 5)
    group:item("wetsuit_spring_sleeveless", 5)
    group:item("flag_swimsuit", 1)
    group:entry { item = "flag_swimsuit", variant = "flag_swimsuit", event = "independence_day", probability = 15 }
    content.add(group)
end
