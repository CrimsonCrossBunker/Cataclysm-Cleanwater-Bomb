local content = require("ccb").content

do
    -- Very rare high level loot. This list doesn't spawn anywhere directly, it is used to create the recipes inside nanofabricator templates.
    local group = content.ItemGroup { id = "nanofab_recipes", kind = "distribution", with_magazine = 100 }
    group:item("emp_gun", 10)
    group:item("laser_rifle", 10)
    group:item("optical_cloak", 10)
    group:item("holo_cloak", 10)
    group:item("portal", 10)
    group:item("rm13_armor", 10)
    group:item("high_density_capacitor", 10)
    group:item("beam_scatterer", 10)
    group:item("rm11b_sniper_rifle", 10)
    group:item("v29", 10)
    content.add(group)
end
