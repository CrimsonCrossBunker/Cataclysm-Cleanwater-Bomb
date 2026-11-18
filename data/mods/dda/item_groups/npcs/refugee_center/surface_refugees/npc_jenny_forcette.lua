local content = require("ccb").content

do
    local group = content.ItemGroup { id = "REFUGEE_Jenny_worn", kind = "collection" }
    group:item("sports_bra")
    group:item("panties")
    group:item("socks")
    group:item("tshirt")
    group:item("jeans")
    group:item("hoodie")
    group:item("sneakers")
    group:item("backpack")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "REFUGEE_Jenny_wield", kind = "collection" }
    group:item("laptop")
    content.add(group)
end
