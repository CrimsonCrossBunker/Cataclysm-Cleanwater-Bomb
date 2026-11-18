local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_BEGGAR_3_worn", kind = "collection" }
    group:item("bra")
    group:item("socks")
    group:item("panties")
    group:item("camisole")
    group:item("hoodie")
    group:item("jeans")
    group:item("lowtops")
    group:item("gloves_light")
    group:item("jacket_evac")
    content.add(group)
end
