local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_BEGGAR_5_worn", kind = "collection" }
    group:item("socks")
    group:item("boxer_briefs")
    group:item("hoodie")
    group:item("pants_cargo")
    group:item("jacket_jean")
    group:item("boots")
    group:item("backpack")
    content.add(group)
end
