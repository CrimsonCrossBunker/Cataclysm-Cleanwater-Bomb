local content = require("ccb").content

do
    local group = content.ItemGroup { id = "mags_milspec", kind = "distribution" }
    group:item("fcl_5x50_50_mag", 5)
    group:item("fcl_5x50_100_mag", 5)
    content.extend_item_group(group)
end
