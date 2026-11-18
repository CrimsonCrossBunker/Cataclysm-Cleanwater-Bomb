local content = require("ccb").content

do
    local group = content.ItemGroup { id = "mon_zombie_hulk_death_drops", kind = "collection" }
    group:entry { item = "cotton_patchwork", count = { 1, 4 }, damage = { 1, 4 } }
    group:entry { group = "pants", damage = { 1, 4 } }
    group:group("default_zombie_items")
    group:entry { group = "wallets", damage = { 1, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mon_dog_death_drops", kind = "collection" }
    group:entry { group = "dog_clothes", damage = { 1, 4 }, probability = 5 }
    group:entry { item = "dog_tag_dog", damage = { 0, 2 }, probability = 40 }
    content.add(group)
end
