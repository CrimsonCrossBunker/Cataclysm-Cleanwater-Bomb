local content = require("ccb").content

do
    local group = content.ItemGroup { id = "quiver_geas_knight", kind = "collection" }
    group:entry { item = "iso_bolt_blackwood_bodkin", charges = { 16, 16 } }
    content.add(group)
end
