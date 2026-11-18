local content = require("ccb").content

do
    local group = content.ItemGroup { id = "REFUGEE_Aleesha_worn", kind = "collection" }
    group:item("sports_bra")
    group:item("boxer_shorts")
    group:item("socks")
    group:item("tshirt")
    group:item("skirt")
    group:item("sneakers")
    group:item("mbag")
    group:item("blanket")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "REFUGEE_Aleesha_wield", kind = "collection" }
    group:item("cudgel")
    content.add(group)
end
