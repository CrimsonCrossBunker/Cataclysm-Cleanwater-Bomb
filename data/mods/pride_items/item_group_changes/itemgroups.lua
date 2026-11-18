local content = require("ccb").content

do
    local group = content.ItemGroup { id = "accesories_personal_unisex", kind = "collection" }
    group:item("pride_flag", 1)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "costume_cloacks", kind = "distribution" }
    group:item("pride_flag", 2)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "music_shop", kind = "distribution" }
    group:item("pride_flag", 1)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "clutter_yard", kind = "distribution" }
    group:item("pride_flag", 3)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "clutter_ballroom", kind = "distribution" }
    group:item("pride_flag", 1)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "map_extra_college_camping_corpse", kind = "collection" }
    group:item("pride_flag", 5)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "map_extra_college_sports_corpse", kind = "collection" }
    group:item("pride_flag", 2)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "roof_sign", kind = "distribution" }
    group:item("pride_flag", 2)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "bugout_memento", kind = "distribution" }
    group:item("pride_flag", 20)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "flags_pride_and_other", kind = "distribution" }
    group:item("pride_flag", 70)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "clutter_bedroom", kind = "distribution" }
    group:item("pride_flag", 5)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "nightstand", kind = "distribution" }
    group:item("pride_flag", 5)
    content.extend_item_group(group)
end
