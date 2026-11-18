local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_BEGGAR_1_worn", kind = "collection" }
    group:item("bra")
    group:item("panties")
    group:item("socks")
    group:item("jeans")
    group:item("sweater")
    group:item("sneakers")
    group:item("blanket")
    content.add(group)
end
