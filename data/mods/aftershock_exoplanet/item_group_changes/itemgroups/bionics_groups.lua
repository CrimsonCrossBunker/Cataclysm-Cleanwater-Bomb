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

do
    local group = content.ItemGroup { id = "bionics_op", kind = "distribution" }
    group:item("bio_microgen", 3)
    group:item("afs_bio_missiles", 10)
    group:item("afs_bio_melee_counteraction", 10)
    group:item("afs_bio_monowhip", 10)
    group:item("afs_bio_melee_optimization_unit", 10)
    group:item("afs_bio_neurosoft_aeronautics", 10)
    group:item("afs_bio_neurosoft_aircraft_mechanic", 10)
    group:item("afs_bio_dopamine_stimulators", 10)
    group:item("bio_shield_heavy", 1)
    group:item("afs_bio_translocator", 5)
    group:item("bio_shock_absorber", 2)
    group:item("afs_bio_skullgun", 2)
    content.upsert_item_group(group)
end

do
    -- High-tech bionics, handy for the harried researcher.  They get access to classified toys too, but only stuff a scientist would have use for.
    local group = content.ItemGroup { id = "bionics_sci", kind = "distribution" }
    group:item("burnt_out_bionic", 60)
    group:item("bio_batteries", 30)
    group:item("bio_power_storage", 30)
    group:item("bio_metabolics", 5)
    group:item("bio_ethanol", 5)
    group:item("bio_ups", 10)
    group:item("bio_torsionratchet", 30)
    group:item("bio_tools", 10)
    group:item("bio_flashlight", 30)
    group:item("bio_lighter", 25)
    group:item("bio_magnet", 20)
    group:item("bio_memory", 15)
    group:item("bio_ears", 10)
    group:item("bio_sunglasses", 10)
    group:item("bio_eye_optic", 10)
    group:item("bio_eye_enhancer", 5)
    group:item("bio_dex_enhancer", 5)
    group:item("bio_int_enhancer", 10)
    group:item("bio_night_vision", 1)
    group:item("bio_infrared", 2)
    group:item("bio_synaptic_regen", 12)
    group:item("bio_gills", 5)
    group:item("bio_climate", 2)
    group:item("bio_heatsink", 2)
    group:item("bio_blood_filter", 10)
    group:item("bio_fingerhack", 2)
    group:item("bio_lockpick", 2)
    group:item("bio_surgical_razor", 8)
    group:item("bio_nanobots", 15)
    group:item("bio_blood_anal", 10)
    group:item("bio_geiger", 15)
    group:item("bio_radscrubber", 10)
    group:item("bio_watch", 40)
    group:item("bio_leukocyte", 15)
    group:item("bio_syringe", 2)
    group:item("bio_jointservo", 10)
    group:item("bio_soporific", 2)
    group:item("bio_microgen", 2)
    content.upsert_item_group(group)
end
