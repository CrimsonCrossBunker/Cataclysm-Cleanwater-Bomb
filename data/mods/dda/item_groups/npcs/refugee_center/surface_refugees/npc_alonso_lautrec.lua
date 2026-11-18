local content = require("ccb").content

do
    local group = content.ItemGroup { id = "REFUGEE_Alonso_worn", kind = "collection" }
    group:item("boxer_briefs")
    group:item("socks")
    group:item("tshirt")
    group:item("jacket_leather")
    group:item("sunglasses")
    group:item("dress_shoes")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "REFUGEE_Alonso_carried", kind = "collection" }
    group:item("mag_porn")
    group:group("sex_accessories_domestic")
    group:item("condom")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "REFUGEE_Alonso_wield", kind = "collection" }
    group:item("cudgel")
    content.add(group)
end
