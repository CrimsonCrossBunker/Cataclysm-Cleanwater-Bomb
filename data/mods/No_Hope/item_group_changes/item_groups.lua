local content = require("ccb").content

do
    local group = content.ItemGroup { id = "hospital_medical_items", kind = "distribution" }
    group:group("bionics_common", 5)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "sewage_plant", kind = "distribution" }
    group:item("bio_tools", 10)
    group:item("bio_flashlight", 10)
    group:item("bio_lighter", 10)
    group:item("bio_magnet", 10)
    group:item("bio_purifier", 10)
    group:item("bio_heatsink", 10)
    group:item("bio_blood_filter", 10)
    group:item("bio_meteorologist", 10)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "toxic_dump_equipment", kind = "distribution" }
    group:item("bio_tools", 10)
    group:item("bio_flashlight", 10)
    group:item("bio_lighter", 10)
    group:item("bio_magnet", 10)
    group:item("bio_purifier", 10)
    group:item("bio_heatsink", 10)
    group:item("bio_blood_filter", 10)
    group:item("bio_meteorologist", 10)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "vault", kind = "distribution" }
    group:item("bio_time_freeze", 4)
    group:item("bio_teleport", 4)
    group:item("bio_probability_travel", 4)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "drugdealer", kind = "distribution" }
    group:item("bio_shotgun", 10)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "robofac_basic_trade", kind = "distribution" }
    group:group("bionics_common")
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

do
    local group = content.ItemGroup { id = "tripod", kind = "distribution" }
    group:entry { item = "flamethrower", charges = { 0, 3000 }, probability = 1 }
    group:item("sheet_kevlar_layered", 10)
    group:item("ceramic_armor", 15)
    group:item("alloy_plate", 10)
    group:item("robot_controls", 3)
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "chickenbot", kind = "distribution" }
    group:item("robot_controls", 5)
    group:item("ai_module", 5)
    group:item("sensor_module", 5)
    group:item("memory_module", 5)
    group:item("pathfinding_module", 5)
    group:item("identification_module", 5)
    group:item("reverse_jointed_legs", 40)
    group:item("chickenbot_chassis", 40)
    group:item("targeting_module", 5)
    group:item("gun_module", 30)
    group:item("mark19", 5)
    group:item("tazer", 5)
    group:item("m249", 5)
    group:item("storage_battery", 5)
    group:item("plut_cell", 5)
    group:item("mil_plate", 2)
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "tankbot", kind = "distribution" }
    group:item("tazer", 3)
    group:entry { item = "flamethrower", charges = { 0, 3000 }, probability = 1 }
    group:item("556", 8)
    group:item("alloy_plate", 10)
    group:item("sheet_kevlar_layered", 10)
    group:item("ceramic_armor", 10)
    group:item("hard_plate", 30)
    group:item("robot_controls", 5)
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "science", kind = "distribution" }
    group:item("bio_purifier", 10)
    group:item("bio_sunglasses", 10)
    group:item("bio_eye_optic", 10)
    group:item("bio_climate", 10)
    group:item("bio_heatsink", 10)
    group:item("bio_blood_filter", 10)
    group:item("bio_watch", 10)
    group:item("bio_leukocyte", 10)
    group:item("bio_faraday", 10)
    group:item("bio_remote", 10)
    group:item("bio_soporific", 5)
    group:item("bio_surgical_razor", 5)
    group:item("bio_syringe", 8)
    content.extend_item_group(group)
end
