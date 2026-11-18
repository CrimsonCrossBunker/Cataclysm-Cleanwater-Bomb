local content = require("ccb").content

do
    local group = content.ItemGroup { id = "REFUGEE_John_worn", kind = "collection" }
    group:item("briefs")
    group:item("socks")
    group:item("tshirt", 100, "flag_shirt")
    group:item("jeans")
    group:item("leather_belt")
    group:item("bandana")
    group:item("holster")
    group:item("duster_leather")
    group:item("sunglasses")
    group:item("cowboy_hat")
    group:item("boots_western")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "REFUGEE_John_carried", kind = "collection" }
    group:item("novel_western")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "REFUGEE_John_wield", kind = "collection" }
    group:item("colt_army")
    content.add(group)
end
