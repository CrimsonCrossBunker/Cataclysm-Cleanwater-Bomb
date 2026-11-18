local content = require("ccb").content

do
    local group = content.ItemGroup { id = "REFUGEE_Pablo_worn", kind = "collection" }
    group:item("boxer_briefs")
    group:item("socks")
    group:item("tank_top")
    group:item("buttonshirt", 100, "striped")
    group:item("pants")
    group:item("jacket_evac")
    group:item("porkpie")
    group:item("dress_shoes")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "REFUGEE_Pablo_carried", kind = "collection" }
    group:item("knife_swissarmy")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "REFUGEE_Pablo_wield", kind = "collection" }
    group:entry { item = "heavy_flashlight", charges = { 200, 200 } }
    content.add(group)
end
