local content = require("ccb").content

do
    local group = content.ItemGroup { id = "REFUGEE_Mangalpreet_worn", kind = "collection" }
    group:item("breeches")
    group:item("tank_top")
    group:item("socks")
    group:item("leggings")
    group:item("robe")
    group:item("headscarf")
    group:item("boots")
    group:group("REFUGEE_Mangalpreet_wield")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "REFUGEE_Mangalpreet_carried", kind = "collection" }
    group:item("holybook_granth")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "REFUGEE_Mangalpreet_wield", kind = "distribution" }
    group:entry { item = "knife_small", variant = "knife_steak", container = "sheath", probability = 4 }
    group:entry { item = "knife_huge", variant = "knife_butcher", container = "sheath", probability = 2 }
    group:entry { item = "kukri", container = "sheath", probability = 1 }
    content.add(group)
end
