local content = require("ccb").content

do
    local group = content.ItemGroup { id = "mon_zombie_survivor_death_drops", kind = "collection" }
    group:group("concentrated_matrix_elixirs", 2)
    group:item("grenade_inferno_makeshift", 2)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "mon_zombie_survivor_elite_death_drops", kind = "collection" }
    group:group("concentrated_matrix_elixirs", 3)
    group:item("grenade_inferno_makeshift", 2)
    content.extend_item_group(group)
end
