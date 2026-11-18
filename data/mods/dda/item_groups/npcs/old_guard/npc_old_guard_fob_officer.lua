local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_OG_OFFICER_misc", kind = "collection" }
    group:item("two_way_radio")
    group:item("p320mag_17rd_9x19mm", 45)
    group:entry { item = "pencil", count = { 2, 2 } }
    group:item("pen")
    group:item("cotton_patchwork")
    group:item("red_pen")
    content.add(group)
end
