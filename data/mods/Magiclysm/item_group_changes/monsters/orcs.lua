local content = require("ccb").content

do
    local group = content.ItemGroup { id = "quiver_orc_archer", kind = "collection" }
    group:entry { item = "arrow_wood_heavy", count = { 1, 6 }, charges = { 1, 10 } }
    content.upsert_item_group(group)
end
