local content = require("ccb").content

do
    local group = content.ItemGroup { id = "quiver_arbalist", kind = "collection" }
    group:entry { item = "bolt_simple_wood", charges = { 60, 60 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bag_javelin_hunter", kind = "collection" }
    group:entry { item = "javelin", count = { 5, 5 } }
    content.add(group)
end
