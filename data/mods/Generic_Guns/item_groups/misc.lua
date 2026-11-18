local content = require("ccb").content

do
    local group = content.ItemGroup { id = "cz600", kind = "collection" }
    group:item("cz600")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cz600_762", kind = "collection" }
    group:item("cz600")
    content.add(group)
end
