local content = require("ccb").content

do
    local group = content.ItemGroup { id = "bookstore_misc", kind = "distribution" }
    group:item("immortal_path_manual_breathing", 5)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "grave_contents", kind = "distribution" }
    group:item("immortal_path_manual_blood_fiend", 2)
    content.extend_item_group(group)
end

do
    -- 血煞炼尸功（魔功残篇）：邪典，只现于神秘学藏书与墓穴枯骨之间，概率极低。不进任何寻常书类组——邪道传承不该轻易得手。/ The demonic fragment: appears only among occult books and in graves, at very low probability. Never in ordinary book groups.
    local group = content.ItemGroup { id = "SUS_book_nonf_soft_occult", kind = "distribution" }
    group:item("immortal_path_manual_blood_fiend", 3)
    content.extend_item_group(group)
end

do
    -- 把吐纳功法残卷、火弹术法术残卷与五行练气期功法低概率塞进世间书类物品组，让玩家能在武术馆、宗教场所、书店、豪宅藏书等处偶遇——散落人间的修仙传承。概率刻意压低：传承应稀有，不该随手可得。残卷=入门吐纳（较常见）;火弹术=无门槛法术（比整套功法常见、比入门吐纳略稀）;五行功法=完整传承（更罕见）。用 copy-from + extend 追加，不覆盖原组内容。/ Scatter the breathing scroll, the Fireball spell scroll, and the five elemental arts into world book groups at low probability. The breathing scroll is the most common; Fireball (a no-prerequisite art) is more common than the full elemental transmissions; the elemental arts are the rarest. copy-from + extend appends without overwriting.
    local group = content.ItemGroup { id = "book_martial_rare", kind = "distribution" }
    group:item("immortal_path_manual_breathing", 30)
    group:item("immortal_path_manual_fireball", 14)
    group:item("immortal_path_manual_water_burst", 14)
    group:item("immortal_path_manual_evergreen", 10)
    group:item("immortal_path_manual_blazing_sun", 10)
    group:item("immortal_path_manual_deep_earth", 10)
    group:item("immortal_path_manual_true_metal", 10)
    group:item("immortal_path_manual_cold_pool", 10)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "religious_books", kind = "distribution" }
    group:item("immortal_path_manual_breathing", 8)
    content.extend_item_group(group)
end

do
    -- 豪宅藏书：火弹术与五行功法在此低概率出现（藏家收罗的奇书），火弹术略常见。/ Mansion libraries: Fireball and the elemental arts appear here at low probability; Fireball a touch more common.
    local group = content.ItemGroup { id = "mansion_books", kind = "distribution" }
    group:item("immortal_path_manual_fireball", 6)
    group:item("immortal_path_manual_water_burst", 6)
    group:item("immortal_path_manual_evergreen", 4)
    group:item("immortal_path_manual_blazing_sun", 4)
    group:item("immortal_path_manual_deep_earth", 4)
    group:item("immortal_path_manual_true_metal", 4)
    group:item("immortal_path_manual_cold_pool", 4)
    content.extend_item_group(group)
end
