local content = require("ccb").content

do
    local group = content.ItemGroup { id = "milspec_arsenal_atgm_gun", kind = "collection" }
    group:item("atgm_launcher", 80)
    group:item("atgm_launcher", 20)
    group:item("atgm_heat", 60)
    group:entry { item = "atgm_heat", count = { 1, 2 }, probability = 60 }
    group:entry { item = "atgm_heat", count = { 1, 2 }, probability = 30 }
    content.add(group)
end
