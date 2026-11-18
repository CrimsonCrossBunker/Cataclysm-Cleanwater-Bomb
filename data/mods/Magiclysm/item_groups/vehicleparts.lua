local content = require("ccb").content

do
    local group = content.ItemGroup { id = "orichalcum_frame_break", kind = "collection" }
    group:entry { item = "orichalcum_lump", count = { 4, 6 } }
    group:entry { item = "orichalcum_sliver", count = { 4, 6 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "light_orichalcum_frame_break", kind = "collection" }
    group:entry { item = "orichalcum_lump", count = { 2, 3 } }
    group:entry { item = "orichalcum_sliver", count = { 1, 5 } }
    content.add(group)
end
