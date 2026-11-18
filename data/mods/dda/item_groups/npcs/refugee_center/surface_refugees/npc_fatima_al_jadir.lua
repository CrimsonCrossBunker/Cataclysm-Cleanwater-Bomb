local content = require("ccb").content

do
    local group = content.ItemGroup { id = "REFUGEE_Fatima_worn", kind = "collection" }
    group:item("bra")
    group:item("panties")
    group:item("socks")
    group:item("technician_pants_gray")
    group:item("technician_shirt_gray")
    group:item("jacket_evac")
    group:item("headscarf")
    group:item("sneakers_steel")
    group:item("slingpack")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "REFUGEE_Fatima_carried", kind = "collection" }
    group:item("weldtank")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "REFUGEE_Fatima_wield", kind = "collection" }
    group:item("oxy_torch")
    content.add(group)
end
