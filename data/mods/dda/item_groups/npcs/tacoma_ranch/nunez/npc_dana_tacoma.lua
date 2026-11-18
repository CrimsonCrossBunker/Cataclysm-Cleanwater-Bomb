local content = require("ccb").content

do
    local group = content.ItemGroup { id = "TACOMA_Dana_carried", kind = "collection" }
    group:entry { item = "bandages", count = { 3, 3 } }
    content.add(group)
end
