local content = require("ccb").content

do
    local group = content.ItemGroup { id = "map_extra_science_corpse", kind = "collection" }
    group:group("mutagenic_field_kit", 1)
    group:group("bionics_common", 1)
    content.extend_item_group(group)
end
