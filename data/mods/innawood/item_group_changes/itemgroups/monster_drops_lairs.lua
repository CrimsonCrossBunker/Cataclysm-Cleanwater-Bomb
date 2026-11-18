local content = require("ccb").content

do
    local group = content.ItemGroup { id = "hive", kind = "distribution" }
    group:item("honeycomb", 10)
    content.replace(group)
end

do
    -- Override for mx_Trapdoor_spider_den, no loot value but even more warning
    local group = content.ItemGroup { id = "wasp_lair", kind = "distribution", with_ammo = 10 }
    group:group("human_parts", 1)
    content.replace(group)
end
