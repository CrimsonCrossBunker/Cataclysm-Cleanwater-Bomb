local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_THUG_bashing", kind = "distribution" }
    group:item("hammer_sledge", 10)
    group:item("hammer_sledge_short", 10)
    group:item("spear_rebar", 20)
    group:item("bat", 20)
    group:item("crowbar", 20)
    group:item("q_staff", 20)
    group:item("bwirebat", 20)
    group:item("bat_metal", 20)
    content.add(group)
end
