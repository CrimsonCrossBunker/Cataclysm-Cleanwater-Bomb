local content = require("ccb").content

do
    local group = content.ItemGroup { id = "REFUGEE_Uyen_worn", kind = "collection" }
    group:item("bra")
    group:item("panties")
    group:item("socks")
    group:item("dress")
    group:item("leggings")
    group:item("jacket_leather")
    group:item("boots_combat")
    group:item("slingpack")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "REFUGEE_Uyen_carried", kind = "collection" }
    group:group("full_1st_aid")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "REFUGEE_Uyen_wield", kind = "collection" }
    group:item("scalpel")
    content.add(group)
end
