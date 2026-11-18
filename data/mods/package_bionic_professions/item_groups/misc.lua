local content = require("ccb").content

do
    local group = content.ItemGroup { id = "quiver_bionic_prepper", kind = "collection" }
    group:entry { item = "bolt_steel", charges = { 20, 20 } }
    content.add(group)
end
