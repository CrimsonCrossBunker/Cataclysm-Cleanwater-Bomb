local content = require("ccb").content

do
    local group = content.ItemGroup { id = "mon_zombie_brute_string_dimension_drops", kind = "collection" }
    group:entry { item = "string_dimension_chainmail_suit", damage = { 0, 4 } }
    group:entry { item = "footrags", damage = { 0, 4 } }
    group:entry { item = "string_dimension_helmet_conical", damage = { 0, 4 }, probability = 33 }
    group:entry { item = "string_dimension_mirror_cuirass", damage = { 0, 4 }, probability = 33 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mon_zomborg_boss_string_dimension_death_drops", kind = "collection" }
    group:item("id_exodii_string_dimension")
    content.add(group)
end
