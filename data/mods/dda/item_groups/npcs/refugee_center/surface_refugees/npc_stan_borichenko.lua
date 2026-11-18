local content = require("ccb").content

do
    local group = content.ItemGroup { id = "REFUGEE_Stan_worn", kind = "collection" }
    group:item("briefs")
    group:item("socks")
    group:item("tie_skinny")
    group:item("dress_shirt")
    group:item("pants")
    group:item("blazer")
    group:item("glasses_eye")
    group:item("sneakers")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "REFUGEE_Stan_carried", kind = "collection" }
    group:item("photo_album")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "REFUGEE_Stan_wield", kind = "collection" }
    group:item("camera_pro")
    content.add(group)
end
