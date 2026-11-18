local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_BEGGAR_4_worn", kind = "collection" }
    group:item("socks")
    group:item("briefs")
    group:item("tank_top")
    group:item("long_underpants")
    group:item("slippers")
    group:item("house_coat")
    content.add(group)
end
