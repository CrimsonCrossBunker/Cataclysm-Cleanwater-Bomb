local content = require("ccb").content

do
    local group = content.ItemGroup { id = "pouch_wild_druid", kind = "collection" }
    group:entry { item = "fur", count = { 3, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "quiver_mooserider", kind = "collection" }
    group:entry { item = "arrow_heavy_fire_hardened_fletched", charges = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "quiver_elven_ceremonial_guard", kind = "collection" }
    group:entry { item = "arrow_cf", count = { 40, 40 } }
    content.add(group)
end
