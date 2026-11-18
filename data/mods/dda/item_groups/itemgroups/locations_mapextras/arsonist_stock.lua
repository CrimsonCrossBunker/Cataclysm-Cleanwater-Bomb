local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_ARSONIST_STOCK", kind = "collection" }
    group:entry {
        distribution = {
            { item = "molotov", count = { 5, 5 } },
            { item = "gelled_molotov", count = { 5, 5 } },
        },
    }
    group:entry { item = "cotton_patchwork", count = { 25, 25 } }
    group:entry { item = "gasoline", count = { 1, 1 } }
    group:entry { item = "pipebomb", count = { 25, 25 } }
    group:entry { item = "fuse", count = { 5, 5 } }
    group:entry { item = "FMCNote", count = { 3, 3 } }
    group:entry { item = "nail", count = { 5, 5 }, charges = { 1, 100 } }
    group:entry { item = "rebar", count = { 5, 5 } }
    group:entry { item = "improvised_munition_handbook", count = { 1, 1 } }
    group:entry { item = "textbook_anarch", count = { 1, 1 } }
    group:entry { group = "fertilizer_commercial_bag_canvas_60", count = { 1, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fertilizer_commercial_bag_canvas_60", kind = "collection", container = "bag_canvas" }
    group:entry { item = "fertilizer_commercial", count = { 60, 60 }, container = "null" }
    content.add(group)
end
