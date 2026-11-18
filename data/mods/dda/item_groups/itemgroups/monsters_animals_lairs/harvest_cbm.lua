local content = require("ccb").content

do
    local group = content.ItemGroup { id = "Zomborg_CBM_harvest", kind = "collection" }
    group:group("Zomborg_CBM_harvest_utility", 80)
    group:group("Zomborg_CBM_harvest_structural", 50)
    group:group("Zomborg_CBM_harvest_combat", 30)
    content.add(group)
end
