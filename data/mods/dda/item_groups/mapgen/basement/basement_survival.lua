local content = require("ccb").content

do
    local group = content.ItemGroup { id = "basement_survival_last_stand", kind = "collection" }
    group:entry { group = "clothing_outdoor_set", damage = { 1, 4 } }
    group:entry {
        distribution = {
            { item = "m240", damage = { 2, 4 } },
            { item = "m60", damage = { 2, 4 } },
        },
    }
    group:entry { item = "corpse", damage = { 4, 4 }, probability = 50 }
    content.add(group)
end
