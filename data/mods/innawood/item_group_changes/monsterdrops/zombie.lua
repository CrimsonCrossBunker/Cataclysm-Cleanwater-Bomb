local content = require("ccb").content

do
    local group = content.ItemGroup { id = "mon_zombie_hulk_death_drops", kind = "collection" }
    group:entry { item = "cotton_patchwork", count = { 1, 4 }, damage = { 1, 4 } }
    group:entry { group = "pants", damage = { 1, 4 } }
    group:group("default_zombie_items")
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "mon_dog_death_drops", kind = "collection" }
    content.replace(group)
end
