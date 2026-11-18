local content = require("ccb").content

do
    -- Survival skill books weighted according to level
    local group = content.ItemGroup { id = "book_survival_2", kind = "distribution" }
    group:item("atomic_survival", 12)
    group:item("plastics_book", 20)
    group:item("fun_survival", 33)
    group:item("mag_dude")
    group:item("mag_survival")
    group:item("manual_survival", 33)
    group:item("pocket_survival", 50)
    group:item("survival_book", 12)
    group:item("textbook_survival", 17)
    group:item("textbook_botany", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "clothes_unisex_survival", kind = "collection" }
    group:group("underwear_unisex")
    group:group("pants_unisex")
    group:group("shoes_unisex")
    group:group("shirts_unisex")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "corpse_child_survival", kind = "collection" }
    group:entry { group = "corpse_child_survival_undam", damage = { 3, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "corpse_child_survival_undam", kind = "collection", container = "corpse_child_calm" }
    group:item("childnote")
    group:entry { group = "child_items", damage = { 1, 3 } }
    group:entry { group = "child_items", damage = { 1, 3 }, probability = 50 }
    group:entry { group = "child_bugout", damage = { 1, 3 } }
    group:entry { group = "clothes_unisex_survival", damage = { 1, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "corpse_female_survival", kind = "collection" }
    group:entry { group = "corpse_female_survival_undam", damage = { 3, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "corpse_female_survival_undam",
        kind = "collection",
        container = "corpse_generic_female",
    }
    group:entry { group = "clothes_unisex_survival", damage = { 1, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "corpses_unisex_survival", kind = "collection" }
    group:entry { group = "corpses_unisex_survival_undam", damage = { 3, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "corpses_bones_only", kind = "collection" }
    group:entry { item = "skull_human", damage = { 3, 4 }, probability = 75 }
    group:entry { item = "bone_human", count = { 10, 20 }, damage = { 3, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "corpses_unisex_survival_undam",
        kind = "collection",
        container = "corpse_generic_human",
    }
    group:entry { group = "clothes_unisex_survival", damage = { 1, 3 } }
    content.add(group)
end
