local content = require("ccb").content

do
    local group = content.ItemGroup { id = "tyrant_sample_single", kind = "collection" }
    group:item("tyrant_sample")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "tyrant_sample_small", kind = "collection" }
    group:entry { item = "tyrant_sample", count = { 1, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "tyrant_sample_large", kind = "collection" }
    group:entry { item = "tyrant_sample", count = { 3, 6 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "tyrant_sample_huge", kind = "collection" }
    group:entry { item = "tyrant_sample", count = { 10, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "stego_sample_single", kind = "collection" }
    group:item("stego_sample")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "stego_sample_small", kind = "collection" }
    group:entry { item = "stego_sample", count = { 1, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "stego_sample_large", kind = "collection" }
    group:entry { item = "stego_sample", count = { 3, 6 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "stego_sample_huge", kind = "collection" }
    group:entry { item = "stego_sample", count = { 10, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "horns_sample_single", kind = "collection" }
    group:item("horns_sample")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "horns_sample_small", kind = "collection" }
    group:entry { item = "horns_sample", count = { 1, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "horns_sample_large", kind = "collection" }
    group:entry { item = "horns_sample", count = { 3, 6 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "horns_sample_huge", kind = "collection" }
    group:entry { item = "horns_sample", count = { 10, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "office_DinoLab", kind = "distribution", with_ammo = 75, with_magazine = 100 }
    group:group("SUS_office_desk")
    group:item("newest_newspaper")
    group:item("egg_dino", 75)
    group:item("egg_dino_theropod", 75)
    group:item("mutagen_tyrant", 30)
    group:item("mutagen_stego", 30)
    group:item("mutagen_horns", 30)
    group:item("kiernans_notes", 10)
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
    group:item("dino_carrier", 10)
    group:item("dino_carrier_wooden", 10)
    content.add(group)
end
