local content = require("ccb").content

do
    local group = content.ItemGroup { id = "mon_labyrinth_buoy_turret_1_1_drops", kind = "collection" }
    group:item("nl_chem_thrower")
    group:entry { item = "nl_chem_thrower_mag", charges = { 1, 57 } }
    group:entry { item = "nl_chem_thrower_mag", charges = { 57, 57 }, probability = 66 }
    content.add(group)
end
