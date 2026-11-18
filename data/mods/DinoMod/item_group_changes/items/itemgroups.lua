local content = require("ccb").content

do
    local group = content.ItemGroup { id = "raptor_sample_single", kind = "collection" }
    group:item("raptor_sample")
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "raptor_sample_small", kind = "collection" }
    group:entry { item = "raptor_sample", count = { 1, 3 } }
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "raptor_sample_large", kind = "collection" }
    group:entry { item = "raptor_sample", count = { 3, 6 } }
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "raptor_sample_huge", kind = "collection" }
    group:entry { item = "raptor_sample", count = { 10, 20 } }
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "lab_mutagen_ingredients_fridge", kind = "collection" }
    group:entry { item = "raptor_sample", count = { 1, 3 }, probability = 40 }
    group:entry { item = "tyrant_sample", count = { 1, 3 }, probability = 40 }
    group:entry { item = "stego_sample", count = { 1, 3 }, probability = 40 }
    group:entry { item = "horns_sample", count = { 1, 3 }, probability = 40 }
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "museum_armor_pet", kind = "distribution" }
    group:item("kevlar_armor_elephant", 10)
    group:item("acidchitin_armor_elephant", 10)
    group:item("chitin_armor_elephant", 10)
    group:item("chainmail_armor_elephant", 10)
    group:item("leather_armor_elephant", 10)
    group:item("leatherbone_armor_elephant", 10)
    group:item("rubber_armor_elephant", 10)
    group:entry { item = "sweater_armor_elephant", event = "christmas", probability = 10 }
    group:item("iron_armor_elephant", 10)
    group:item("steel_armor_elephant", 10)
    group:item("bronze_armor_elephant", 10)
    group:item("kevlar_armor_ostrich", 10)
    group:item("acidchitin_armor_ostrich", 10)
    group:item("chitin_armor_ostrich", 10)
    group:item("chainmail_armor_ostrich", 10)
    group:item("leather_armor_ostrich", 10)
    group:item("leatherbone_armor_ostrich", 10)
    group:item("rubber_armor_ostrich", 10)
    group:entry { item = "sweater_armor_ostrich", event = "christmas", probability = 10 }
    group:item("iron_armor_ostrich", 10)
    group:item("steel_armor_ostrich", 10)
    group:item("bronze_armor_ostrich", 10)
    content.extend_item_group(group)
end
