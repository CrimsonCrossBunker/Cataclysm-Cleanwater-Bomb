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
