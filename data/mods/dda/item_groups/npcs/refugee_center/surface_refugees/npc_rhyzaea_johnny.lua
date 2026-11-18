local content = require("ccb").content

do
    local group = content.ItemGroup { id = "REFUGEE_Rhyzaea_worn", kind = "collection" }
    group:item("bra")
    group:item("panties")
    group:item("socks")
    group:item("skirt")
    group:item("leggings")
    group:item("sweater")
    group:item("boots_hiking")
    group:item("purse")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "REFUGEE_Rhyzaea_wield", kind = "collection" }
    group:item("stick")
    content.add(group)
end
