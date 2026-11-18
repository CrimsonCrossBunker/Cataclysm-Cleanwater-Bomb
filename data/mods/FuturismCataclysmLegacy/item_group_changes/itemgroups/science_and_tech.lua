local content = require("ccb").content

do
    local group = content.ItemGroup { id = "schematics", kind = "distribution" }
    group:item("fcl_schematics_copbot", 50)
    group:item("fcl_schematics_eyebot", 50)
    group:item("fcl_schematics_riotbot", 50)
    group:item("fcl_schematics_molebot", 20)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "teleport", kind = "distribution" }
    group:item("bio_time_freeze", 1)
    group:item("bio_teleport", 1)
    group:item("bio_probability_travel", 1)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "science", kind = "distribution" }
    group:entry { group = "bionics_common", count = { 0, 1 }, probability = 1 }
    group:item("solar_panel_v3", 1)
    content.extend_item_group(group)
end
