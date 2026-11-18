local content = require("ccb").content

do
    local group = content.ItemGroup { id = "raptor_sample_single", kind = "collection" }
    group:item("raptor_sample")
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "raptor_sample_small", kind = "collection" }
    group:entry { item = "raptor_sample", count = { 1, 3 } }
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "raptor_sample_large", kind = "collection" }
    group:entry { item = "raptor_sample", count = { 3, 6 } }
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "raptor_sample_huge", kind = "collection" }
    group:entry { item = "raptor_sample", count = { 10, 20 } }
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "lab_mutagen_ingredients_fridge", kind = "collection" }
    group:entry { item = "raptor_sample", count = { 1, 3 }, probability = 40 }
    group:entry { item = "tyrant_sample", count = { 1, 3 }, probability = 40 }
    group:entry { item = "stego_sample", count = { 1, 3 }, probability = 40 }
    group:entry { item = "horns_sample", count = { 1, 3 }, probability = 40 }
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "museum_armor_pet", kind = "distribution" }
    group:item("kevlar_armor_elephant", 10)
    group:item("acidchitin_armor_elephant", 10)
    group:item("chitin_armor_elephant", 10)
    group:item("chainmail_armor_elephant", 10)
    group:item("leather_armor_elephant", 10)
    group:item("leatherbone_armor_elephant", 10)
    group:item("rubber_armor_elephant", 10)
    group:entry { item = "sweater_armor_elephant", event = "christmas", probability = 10 }
    group:item("iron_armor_elephant", 10)
    group:item("steel_armor_elephant", 10)
    group:item("bronze_armor_elephant", 10)
    group:item("kevlar_armor_ostrich", 10)
    group:item("acidchitin_armor_ostrich", 10)
    group:item("chitin_armor_ostrich", 10)
    group:item("chainmail_armor_ostrich", 10)
    group:item("leather_armor_ostrich", 10)
    group:item("leatherbone_armor_ostrich", 10)
    group:item("rubber_armor_ostrich", 10)
    group:entry { item = "sweater_armor_ostrich", event = "christmas", probability = 10 }
    group:item("iron_armor_ostrich", 10)
    group:item("steel_armor_ostrich", 10)
    group:item("bronze_armor_ostrich", 10)
    content.extend_item_group(group)
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
    content.upsert_item_group(group)
end
