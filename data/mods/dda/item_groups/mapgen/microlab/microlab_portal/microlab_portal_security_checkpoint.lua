local content = require("ccb").content

do
    local group = content.ItemGroup { id = "mercenary_battle_traces", kind = "collection" }
    group:entry {
        distribution = {
            { item = "shot_hull", probability = 30 },
            { item = "223_casing", count = { 3, 5 }, probability = 70 },
        },
    }
    group:item("xedra40", 1)
    group:item("xedra10", 1)
    content.add(group)
end
