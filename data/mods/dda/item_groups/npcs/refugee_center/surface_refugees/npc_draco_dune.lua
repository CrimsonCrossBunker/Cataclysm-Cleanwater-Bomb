local content = require("ccb").content

do
    local group = content.ItemGroup { id = "REFUGEE_Draco_worn", kind = "collection" }
    group:item("boxer_shorts")
    group:item("socks")
    group:item("sweater")
    group:item("jeans")
    group:item("jacket_leather")
    group:item("hat_ball")
    group:item("sunglasses")
    group:item("boots_combat")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "REFUGEE_Draco_carried", kind = "collection" }
    group:item("lc_wire")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "REFUGEE_Draco_wield", kind = "collection" }
    group:item("crowbar")
    content.add(group)
end
