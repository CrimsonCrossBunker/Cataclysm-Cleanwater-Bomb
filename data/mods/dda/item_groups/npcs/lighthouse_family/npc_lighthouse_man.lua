local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NPC_lighthouse_man_shop", kind = "collection" }
    group:entry { item = "fish_bait", count = { 15, 35 } }
    group:entry { item = "fish", count = { 5, 20 } }
    group:entry { item = "fish_smoked", count = { 1, 4 } }
    group:entry { item = "fish_cooked", count = { 4, 14 } }
    group:entry { item = "salted_fish", count = { 2, 6 } }
    group:entry { item = "fish_fried", count = { 2, 6 } }
    group:entry { item = "soup_fish", count = { 35, 50 }, container = "bottle_plastic" }
    group:entry { item = "fishspear", count = { 4, 8 }, probability = 20 }
    group:item("doublespeargun", 20)
    group:item("fish_trap", 55)
    group:item("fishing_hook_bone")
    group:item("fishing_rod_basic")
    content.add(group)
end
