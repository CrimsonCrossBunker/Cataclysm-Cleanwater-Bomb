local content = require("ccb").content

do
    local group = content.ItemGroup { id = "quiver_bow_hunter", kind = "collection" }
    group:entry { item = "arrow_cf", count = { 10, 10 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "quiver_crossbow_hunter", kind = "collection" }
    group:entry { item = "bolt_steel", charges = { 4, 4 } }
    content.add(group)
end
