local content = require("ccb").content

do
    -- Golden krar for Luliya.
    local group = content.ItemGroup { id = "NC_EXODII_TYPE_2_carried", kind = "distribution" }
    group:item("krar_golden")
    content.add(group)
end
