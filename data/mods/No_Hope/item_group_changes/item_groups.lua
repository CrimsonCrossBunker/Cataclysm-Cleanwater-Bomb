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
