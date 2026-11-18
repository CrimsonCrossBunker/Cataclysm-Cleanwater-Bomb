local content = require("ccb").content

do
    -- Nested group to damage the container-item
    local group = content.ItemGroup { id = "map_extra_fallen_adventurer", kind = "collection" }
    group:entry { group = "map_extra_fallen_adventurer_corpse", damage = { 3, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "map_extra_fallen_adventurer_corpse", kind = "collection", container = "corpse_fae" }
    group:group("changeling_bannerman_death_drops")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "basement_safehouse", kind = "collection" }
    group:entry { group = "clothing_outdoor_set", damage = { 1, 4 } }
    group:entry {
        distribution = {
            { item = "m240", damage = { 2, 4 } },
            { item = "m60", damage = { 2, 4 } },
        },
    }
    content.add(group)
end
