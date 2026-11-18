local content = require("ccb").content

do
    local group = content.ItemGroup { id = "TACOMA_Pablo_worn", kind = "collection" }
    group:item("boxer_briefs")
    group:item("socks")
    group:item("tank_top")
    group:item("buttonshirt", 100, "striped")
    group:item("pants")
    group:item("armor_scrapsuit")
    group:item("helmet_scrap")
    group:item("motorbike_boots")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "TACOMA_Pablo_carried", kind = "collection" }
    group:item("knife_swissarmy")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "TACOMA_Pablo_wield", kind = "collection" }
    group:item("bat_metal")
    content.add(group)
end
