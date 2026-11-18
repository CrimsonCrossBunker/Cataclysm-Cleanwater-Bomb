local content = require("ccb").content

do
    local group = content.ItemGroup { id = "REFUGEE_Dana_worn", kind = "collection" }
    group:item("bra")
    group:item("panties")
    group:item("socks")
    group:item("longshirt")
    group:item("jeans")
    group:item("jacket_evac")
    group:item("boots")
    group:item("purse")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "REFUGEE_Dana_carried", kind = "collection" }
    group:item("emer_blanket")
    group:item("lighter")
    group:entry { item = "bandages", count = { 3, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "REFUGEE_Dana_wield", kind = "distribution" }
    content.add(group)
end
