local content = require("ccb").content

do
    -- This itemgroup is intended to represent a stash of long-lasting food and water supplies that a survivor may have scavenged
    local group = content.ItemGroup { id = "stash_food", kind = "collection" }
    group:entry { group = "pantry_liquids", count = { 1, 3 }, probability = 30 }
    group:entry { group = "groce_pasta", count = { 1, 5 }, probability = 50 }
    group:entry { group = "cannedfood", count = { 1, 6 }, probability = 50 }
    group:entry { group = "big_canned_food", count = { 1, 3 }, probability = 25 }
    group:entry { group = "dry_goods", count = { 1, 4 }, probability = 30 }
    group:entry { group = "preserved_food", count = { 1, 5 }, probability = 30 }
    group:entry { item = "water_clean", count = { 4, 12 }, probability = 75 }
    group:entry { item = "water_mineral", count = { 1, 4 }, probability = 10 }
    group:entry { group = "soda_in_small_container", count = { 1, 4 }, probability = 5 }
    group:group("salt_various", 10)
    group:group("seasoning_salt_various", 5)
    group:entry { item = "instant_coffee", count = { 1, 12 }, probability = 25 }
    group:entry { group = "pemmican_bag_small", count = { 1, 7 }, probability = 10 }
    content.add(group)
end

do
    -- this list is for collectibles, antiques, sports memorablia, awards, etc. that a person might put on display in their home. This is just the small items.
    local group = content.ItemGroup { id = "bugout_memento", kind = "distribution" }
    group:group("coins", 40)
    group:item("collector_book", 40)
    group:item("classic_literature", 40)
    group:item("american_flag", 40)
    group:item("family_photo", 40)
    group:item("bronze_medal", 20)
    group:item("silver_medal", 15)
    group:item("gold_medal", 10)
    group:item("platinum_watch", 25)
    group:item("gold_watch", 25)
    group:item("silver_watch", 25)
    group:item("gold_ring", 25)
    group:item("silver_ring", 25)
    group:item("jade_brooch", 25)
    group:item("silver_locket", 25)
    group:item("gold_locket", 25)
    group:item("platinum_locket", 10)
    group:item("pearl_collar", 10)
    group:item("pocketwatch", 50)
    group:item("candlestick", 50)
    group:item("ring_signet", 40)
    group:item("cufflinks_intricate", 50)
    group:item("boxing_gloves", 25)
    group:item("hat_ball", 50)
    group:item("football", 50)
    group:item("baseball", 50)
    group:item("shuttlecock", 5)
    group:item("jersey", 50)
    group:item("helmet_football", 50)
    group:item("mask_hockey", 50)
    group:group("toy_radio_car", 50)
    group:item("bottle_glass", 40)
    group:item("creepy_doll", 40)
    group:item("holy_symbol", 40)
    group:item("national_flag", 5)
    group:item("state_flag", 15)
    group:item("spiral_stone", 5)
    group:item("petrified_eye", 5)
    group:item("talking_doll", 40)
    group:item("bondage_mask", 20)
    group:item("gold_anklet", 25)
    group:item("silver_anklet", 25)
    content.add(group)
end
