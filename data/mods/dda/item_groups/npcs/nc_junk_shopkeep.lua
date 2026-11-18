local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_JUNK_SHOPKEEP_extra", kind = "distribution" }
    group:item("duffelbag")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_JUNK_SHOPKEEP_coat", kind = "distribution" }
    group:item("trenchcoat", 80)
    group:item("vest", 60)
    content.add(group)
end
