local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_meteorologist_worn", kind = "collection" }
    group:item("briefs")
    group:item("coat_lab")
    group:item("dress_shirt")
    group:item("pants")
    group:item("socks")
    group:item("boots")
    group:item("gloves_rubber")
    group:item("wristwatch")
    group:item("glasses_safety")
    content.add(group)
end
