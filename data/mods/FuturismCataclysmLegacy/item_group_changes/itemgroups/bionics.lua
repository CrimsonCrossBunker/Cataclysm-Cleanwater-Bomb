local content = require("ccb").content

do
    local group = content.ItemGroup { id = "bionics_common", kind = "distribution" }
    group:item("fcl_bio_linguistic_coprocessor", 8)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "bionics_mil", kind = "distribution" }
    group:item("bio_shock_absorber", 2)
    group:item("fcl_bio_neurosoft_aeronautics", 10)
    group:item("fcl_bio_neurosoft_aircraft_mechanic", 10)
    group:item("fcl_bio_railgun", 5)
    group:item("fcl_bio_melee_counteraction", 10)
    group:item("fcl_bio_melee_optimization_unit", 10)
    group:item("fcl_bio_monowhip", 10)
    group:item("fcl_bio_blood_brain", 10)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "bionics_op", kind = "distribution" }
    group:item("bio_betavoltaic", 5)
    group:item("bio_claws", 10)
    group:item("fcl_bio_missiles", 10)
    group:item("fcl_bio_melee_counteraction", 10)
    group:item("fcl_bio_monowhip", 10)
    group:item("fcl_bio_melee_optimization_unit", 10)
    group:item("fcl_bio_neurosoft_aeronautics", 10)
    group:item("fcl_bio_neurosoft_aircraft_mechanic", 10)
    group:item("fcl_bio_dopamine_stimulators", 10)
    group:item("bio_shock_absorber", 2)
    content.upsert_item_group(group)
end
