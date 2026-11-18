local content = require("ccb").content

do
    local group = content.ItemGroup { id = "REFUGEE_Vanessa_worn", kind = "collection" }
    group:item("panties")
    group:item("socks")
    group:item("sneakers")
    group:item("bra")
    group:item("dress")
    group:item("jacket_jean")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "REFUGEE_Vanessa_carried", kind = "collection" }
    group:item("lighter")
    group:entry { item = "ecig", count = { 40, 40 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "REFUGEE_Vanessa_wield", kind = "collection" }
    group:item("scissors")
    content.add(group)
end
