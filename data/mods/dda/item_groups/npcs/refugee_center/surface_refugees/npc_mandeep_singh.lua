local content = require("ccb").content

do
    local group = content.ItemGroup { id = "REFUGEE_Mandeep_worn", kind = "collection" }
    group:item("boxer_shorts")
    group:item("socks")
    group:item("sweatshirt")
    group:item("pants")
    group:item("turban")
    group:item("sneakers")
    group:group("REFUGEE_Mandeep_wield")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "REFUGEE_Mandeep_carried", kind = "collection" }
    group:group("used_1st_aid")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "REFUGEE_Mandeep_wield", kind = "distribution" }
    group:entry { item = "scimitar_inferior", container = "scabbard", probability = 3 }
    group:entry { item = "scimitar", container = "scabbard", probability = 1 }
    group:entry { item = "kirpan", container = "sheath", probability = 4 }
    group:entry { item = "kirpan_cheap", container = "sheath", probability = 2 }
    content.add(group)
end
