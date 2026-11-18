local content = require("ccb").content

do
    local group = content.ItemGroup { id = "REFUGEE_Boris_worn", kind = "collection" }
    group:item("briefs")
    group:item("socks")
    group:item("tank_top")
    group:item("technician_shirt_gray")
    group:item("technician_pants_gray")
    group:item("jacket_flannel")
    group:item("hat_knit")
    group:item("boots")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "REFUGEE_Boris_carried", kind = "collection" }
    group:item("multitool")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "REFUGEE_Boris_wield", kind = "collection" }
    group:group("tools_toolbox")
    content.add(group)
end
