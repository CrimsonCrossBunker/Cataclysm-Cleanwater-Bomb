local content = require("ccb").content

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given spot.
    -- This group is for trash in a trashcan, contained in a trashbag
    local group = content.ItemGroup { id = "SUS_trash_trashcan", kind = "distribution" }
    group:group("SUS_trash_trashcan_full", 25)
    group:group("SUS_trash_trashcan_half", 60)
    group:group("SUS_trash_trashcan_empty", 15)
    content.add(group)
end
