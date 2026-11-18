local content = require("ccb").content

do
    local group = content.ItemGroup { id = "portal_storm_dungeon_items", kind = "distribution" }
    group:item("unstable_rift", 1)
    group:item("escape_stone", 1)
    group:item("calming_stone", 1)
    content.add(group)
end
