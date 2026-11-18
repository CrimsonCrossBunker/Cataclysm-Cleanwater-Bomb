local content = require("ccb").content

do
    local group = content.ItemGroup { id = "REFUGEE_Guneet_worn", kind = "collection" }
    group:item("boxer_shorts")
    group:item("socks")
    group:item("tshirt")
    group:item("jeans")
    group:item("turban")
    group:item("sneakers")
    group:item("scabbard")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "REFUGEE_Guneet_carried", kind = "collection" }
    group:item("portable_game")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "REFUGEE_Guneet_wield", kind = "distribution" }
    group:item("scimitar_inferior", 3)
    group:item("scimitar", 2)
    content.add(group)
end
