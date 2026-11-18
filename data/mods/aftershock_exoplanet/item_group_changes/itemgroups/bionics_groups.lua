local content = require("ccb").content

do
    local group = content.ItemGroup { id = "bionics_common", kind = "distribution" }
    group:item("afs_bio_linguistic_coprocessor", 8)
    group:item("afs_bio_beavy_batteries", 20)
    group:item("bio_shield_weak", 25)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "bionics_mil", kind = "distribution" }
    group:item("afs_bio_neurosoft_aeronautics", 10)
    group:item("afs_bio_neurosoft_aircraft_mechanic", 10)
    group:item("afs_bio_beavy_batteries", 10)
    group:item("afs_bio_melee_counteraction", 10)
    group:item("afs_bio_melee_optimization_unit", 10)
    group:item("afs_bio_monowhip", 10)
    group:item("afs_bio_blood_plus", 10)
    group:item("bio_shield_heavy", 3)
    group:item("bio_shield_weak", 10)
    group:item("bio_shield_medium", 26)
    group:item("afs_bio_translocator", 5)
    group:item("afs_bio_blood_brain", 1)
    group:item("bio_shock_absorber", 2)
    group:item("afs_bio_skullgun", 2)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "nanofab_recipes", kind = "distribution" }
    group:item("afs_bio_missiles", 10)
    group:item("afs_bio_melee_counteraction", 10)
    group:item("afs_bio_melee_optimization_unit", 10)
    group:item("afs_bio_neurosoft_aeronautics", 10)
    group:item("afs_bio_neurosoft_aircraft_mechanic", 10)
    group:item("afs_bio_dopamine_stimulators", 10)
    group:item("afs_bio_monowhip", 10)
    group:item("afs_bio_blood_plus", 10)
    group:item("afs_bio_translocator", 5)
    group:item("afs_bio_skullgun", 2)
    group:item("afs_archeotech_cartridge", 10)
    group:item("afs_translocation_device", 10)
    content.extend_item_group(group)
end
