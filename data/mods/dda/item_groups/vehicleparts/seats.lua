local content = require("ccb").content

do
    local group = content.ItemGroup { id = "ig_vp_seat", kind = "collection" }
    group:entry { item = "nylon", count = { 2, 8 } }
    group:entry { item = "pipe", count = { 1, 3 } }
    group:entry { item = "spring", count = { 0, 2 } }
    group:entry { item = "scrap", count = { 3, 5 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ig_vp_seat_leather", kind = "collection" }
    group:entry { item = "leather", count = { 1, 5 } }
    group:entry { item = "nylon", count = { 1, 3 } }
    group:entry { item = "pipe", count = { 1, 3 } }
    group:entry { item = "spring", count = { 0, 2 } }
    group:entry { item = "scrap", count = { 3, 5 } }
    content.add(group)
end
