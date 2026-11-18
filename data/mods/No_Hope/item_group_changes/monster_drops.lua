local content = require("ccb").content

do
    local group = content.ItemGroup { id = "feral_scientists_death_drops_scalpel", kind = "collection" }
    group:group("bionics", 10)
    content.extend_item_group(group)
end
