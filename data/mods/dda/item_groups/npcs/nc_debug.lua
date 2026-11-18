local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_DEBUG_worn", kind = "distribution" }
    group:item("towel")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_DEBUG_carried", kind = "distribution" }
    group:item("mininuke")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_DEBUG_weapon", kind = "distribution" }
    group:item("soap")
    content.add(group)
end
