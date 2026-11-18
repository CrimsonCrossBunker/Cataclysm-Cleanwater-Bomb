local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_ARSONIST_storage", kind = "distribution" }
    group:item("golf_bag")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "makayla_belt", kind = "collection" }
    group:item("gadget_pouch")
    group:entry { item = "bandages", count = { 5, 5 } }
    group:item("pockknife")
    group:entry { item = "lighter", charges = { 100, 100 } }
    group:item("hatchet")
    content.add(group)
end
