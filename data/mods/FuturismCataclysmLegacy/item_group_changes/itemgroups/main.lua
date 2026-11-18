local content = require("ccb").content

do
    local group = content.ItemGroup { id = "nanofab_recipes", kind = "distribution" }
    group:item("fcl_atomic_coffeemaker", 10)
    group:item("fcl_plasma_gun", 10)
    group:item("fcl_plasma_rifle", 10)
    group:item("fcl_heavy_rail_rifle", 10)
    group:item("fcl_ftk93", 10)
    group:item("fcl_fusion_pack", 10)
    group:item("fcl_fusion_pellet", 10)
    group:item("fcl_ftk29", 10)
    group:item("fcl_ftk07", 10)
    group:item("fcl_bio_neurosoft_aeronautics", 10)
    group:item("fcl_bio_neurosoft_aircraft_mechanic", 10)
    group:item("fcl_bio_missiles", 10)
    group:item("fcl_bio_melee_counteraction", 10)
    group:item("fcl_bio_melee_optimization_unit", 10)
    group:item("fcl_bio_dopamine_stimulators", 10)
    group:item("fcl_bio_monowhip", 10)
    content.extend_item_group(group)
end
