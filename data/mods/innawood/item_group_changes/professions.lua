local content = require("ccb").content

do
    local group = content.ItemGroup { id = "quiver_bow_hunter", kind = "collection" }
    group:entry { item = "arrow_heavy_fire_hardened_fletched", charges = { 20, 20 } }
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "quiver_crossbow_hunter", kind = "collection" }
    group:entry { item = "bolt_simple_wood", charges = { 20, 20 } }
    content.replace(group)
end
