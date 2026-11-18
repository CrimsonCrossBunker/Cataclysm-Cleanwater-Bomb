local content = require("ccb").content

do
    local group = content.ItemGroup { id = "energy_weapon_armory", kind = "distribution" }
    group:group("fcl_fusion_pellet", 2)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "hospital_medical_items", kind = "distribution" }
    group:group("bionics_common", 4)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "toxic_dump_equipment", kind = "distribution" }
    group:item("bio_tools", 2)
    group:item("bio_flashlight", 2)
    group:item("bio_lighter", 2)
    group:item("bio_magnet", 2)
    group:item("bio_power_storage", 2)
    group:item("bio_purifier", 2)
    group:item("bio_heatsink", 2)
    group:item("bio_blood_filter", 2)
    group:item("bio_meteorologist", 2)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "lab_dorm", kind = "distribution" }
    group:item("fcl_atomic_smartphone", 3)
    group:item("fcl_atomic_lamp", 1)
    group:item("fcl_atomic_light", 3)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "vault", kind = "distribution" }
    group:item("bio_time_freeze", 4)
    group:item("bio_teleport", 4)
    group:item("bio_probability_travel", 4)
    group:item("fcl_ftk93", 1)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "subway", kind = "distribution" }
    group:item("fcl_atomic_smartphone", 1)
    group:item("fcl_atomic_light", 1)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "hospital_lab", kind = "distribution" }
    group:group("bionics_common", 2)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "hospital_bed", kind = "distribution" }
    group:item("fcl_atomic_light", 1)
    content.extend_item_group(group)
end
