local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_GREAT_LIBRARY_LIBRARIAN_worn", kind = "collection" }
    group:item("panties")
    group:item("skirt")
    group:item("dress_shirt")
    group:item("heels")
    group:item("purse")
    group:item("diamond_ring")
    group:item("pearl_gold_earring")
    group:item("gold_bracelet")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_GREAT_LIBRARY_LIBRARIAN_carried", kind = "collection" }
    group:item("magnifying_glass")
    content.add(group)
end
