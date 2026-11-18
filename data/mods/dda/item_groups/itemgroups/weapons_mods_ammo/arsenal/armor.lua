local content = require("ccb").content

do
    local group = content.ItemGroup { id = "arsenal_armor_collection", kind = "collection" }
    group:entry { group = "arsenal_armor_armor", count = { 2, 4 } }
    group:entry { group = "pristine_esapi_plates", count = { 2, 6 } }
    group:entry { group = "arsenal_mics_carrying", count = { 2, 8 }, probability = 80 }
    group:group("arsenal_mics_rare", 10)
    group:entry { group = "full_ifak", count = { 1, 2 }, probability = 80 }
    group:entry { group = "arsenal_mics_tools", count = { 1, 4 } }
    group:item("large_repairkit", 2)
    group:item("small_repairkit", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "arsenal_armor_armor", kind = "collection" }
    group:entry { group = "military_ballistic_vest_pristine", count = { 1, 4 } }
    group:entry { item = "helmet_army", count = { 1, 4 } }
    group:entry { item = "tac_fullhelmet", count = { 1, 2 }, probability = 60 }
    group:entry { item = "glasses_bal", count = { 1, 2 }, probability = 60 }
    group:entry { item = "mask_bal", count = { 1, 2 }, probability = 30 }
    group:entry { item = "powered_earmuffs", count = { 1, 2 }, probability = 60 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "arsenal_armor+plates", kind = "collection" }
    group:entry { group = "arsenal_armor_armor", count = { 2, 4 } }
    group:entry { group = "pristine_esapi_plates", count = { 2, 6 } }
    content.add(group)
end
