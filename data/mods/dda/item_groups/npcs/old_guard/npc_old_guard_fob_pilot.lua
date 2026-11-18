local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_OG_PILOT_misc", kind = "collection" }
    group:item("whistle")
    group:item("matches")
    group:item("flashlight")
    group:entry { item = "handflare", count = { 2, 2 } }
    group:item("glock17_17", 25)
    group:item("goggles_nv")
    group:group("knife_rambo_cont", 85)
    content.add(group)
end
