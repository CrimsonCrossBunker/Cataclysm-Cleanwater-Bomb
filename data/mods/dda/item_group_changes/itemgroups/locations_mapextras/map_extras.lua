local content = require("ccb").content

do
    local group = content.ItemGroup {
        id = "map_extra_college_camping_corpse",
        kind = "collection",
        container = "corpse_generic_human",
    }
    group:entry { group = "underwear", damage = { 1, 3 } }
    group:entry { group = "shirts", damage = { 1, 4 } }
    group:entry { group = "jackets", damage = { 1, 4 }, probability = 30 }
    group:entry { group = "pants", damage = { 1, 4 } }
    group:entry { group = "socks_unisex", damage = { 1, 4 } }
    group:entry { group = "shoes", damage = { 1, 4 } }
    group:entry { group = "hatstore_hats", damage = { 1, 4 }, probability = 40 }
    group:group("college_camping", 50)
    group:group("college_camping", 80)
    group:group("SUS_book_nonf_soft", 20)
    group:item("national_flag", 2)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "map_extra_college_sports_corpse",
        kind = "collection",
        container = "corpse_generic_human",
    }
    group:entry { group = "underwear", damage = { 1, 3 } }
    group:entry { group = "shirts", damage = { 1, 4 } }
    group:entry { group = "jackets", damage = { 1, 4 }, probability = 30 }
    group:entry { group = "pants", damage = { 1, 4 } }
    group:entry { group = "socks_unisex", damage = { 1, 4 } }
    group:entry { group = "shoes", damage = { 1, 4 } }
    group:entry { group = "hatstore_hats", damage = { 1, 4 }, probability = 40 }
    group:group("college_sports", 50)
    group:group("college_sports", 90)
    group:group("SUS_book_sports", 30)
    content.add(group)
end

do
    -- 3/4 times a wallet with an id card, all the time a lab coat
    local group = content.ItemGroup { id = "map_extra_science_corpse", kind = "collection", container = "corpse_generic_human" }
    group:group("wallets_science", 75)
    group:entry { item = "coat_lab", damage = { 1, 3 } }
    group:item("balthazar_radio", 10)
    group:item("xedra_field_notes", 10)
    group:entry { group = "mutagenic_field_kit", damage = { 1, 3 }, probability = 1 }
    group:entry { group = "lab_pants", damage = { 1, 3 } }
    group:entry { group = "socks_unisex", damage = { 1, 3 } }
    group:entry { group = "lab_shoes", damage = { 1, 3 } }
    group:entry { group = "lab_torso", damage = { 1, 3 } }
    group:entry { group = "underwear", damage = { 1, 3 } }
    group:group("papr_kit", 10)
    group:entry { item = "xedra_mobile_weather_station", charges = { 0, 1000 }, probability = 1 }
    content.upsert_item_group(group)
end
