local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_AUGUSTMOON_TOOL_TRADER_worn", kind = "collection" }
    group:item("afs_hazard_suit_casual")
    group:item("boots_combat")
    group:item("under_armor")
    group:item("under_armor_shorts")
    content.add(group)
end
