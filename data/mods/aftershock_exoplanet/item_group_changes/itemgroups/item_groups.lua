local content = require("ccb").content

do
    local group = content.ItemGroup { id = "swat_gear", kind = "distribution" }
    group:item("xlswat_armor", 12)
    group:item("afs_military_vestxl", 9)
    group:item("xlboots_combat", 15)
    group:item("xlgloves_tactical", 10)
    group:item("tripaw_xlgloves_tactical", 8)
    content.extend_item_group(group)
end

do
    -- This group is for an area storing diving equipment.  SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    local group = content.ItemGroup { id = "SUS_scuba_gear", kind = "collection" }
    group:item("combat_wetsuit_cecalia", 20)
    group:item("wetsuit_cecalia", 70)
    group:item("trident", 70)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "lab_dorm", kind = "distribution" }
    group:item("afs_atomic_smartphone", 5)
    group:item("afs_atomic_light", 3)
    group:item("STEED_registry", 1)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "drugdealer", kind = "distribution" }
    group:item("afs_atomic_smartphone", 3)
    group:item("afs_bio_missiles", 8)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "crate_sports", kind = "collection" }
    group:item("q_solarpack", 1)
    group:item("alien_battery", 1)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "SUS_oven", kind = "collection" }
    group:item("afs_atompot", 3)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "camping_lighting_electric", kind = "distribution" }
    group:item("afs_atomic_light", 1)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "book_military", kind = "distribution" }
    group:item("recipe_unusual_ammos", 7)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "textbooks", kind = "distribution" }
    group:item("textbook_atomic", 8)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "newspaper", kind = "distribution" }
    group:item("afs_personal_card", 8)
    group:item("afs_welcome1_book", 4)
    group:item("afs_welcome2_book", 4)
    group:item("afs_welcome3_book", 4)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "livingroom", kind = "distribution" }
    group:item("afs_atomic_smartphone", 1)
    group:item("afs_atomic_light", 2)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "hardware", kind = "distribution" }
    group:item("afs_power_cutter", 5)
    group:item("afs_imager", 5)
    group:item("atomic_butterchurn", 1)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "mischw", kind = "collection" }
    group:item("afs_power_cutter", 5)
    group:group("afs_machinery_maintenance_scrapgroup", 20)
    content.extend_item_group(group)
end

do
    -- override of vanilla schematics, includes tripod, chickenbot, tankbot
    local group = content.ItemGroup { id = "schematics", kind = "distribution" }
    group:item("schematics_nursebot", 10)
    group:item("schematics_grocerybot", 20)
    group:item("schematics_copbot", 50)
    group:item("schematics_eyebot", 50)
    group:item("schematics_secubot", 50)
    group:item("schematics_skitterbot", 50)
    group:item("schematics_chickenbot", 5)
    group:item("schematics_hazmatbot", 50)
    group:item("schematics_riotbot", 50)
    group:item("schematics_sciencebot", 10)
    group:item("schematics_tankbot", 5)
    group:item("schematics_tripod", 5)
    group:item("schematics_dispatch", 25)
    group:item("schematics_dispatch_military", 20)
    group:item("schematics_antimateriel", 20)
    group:item("schematics_searchlight", 50)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "chem_lab", kind = "distribution" }
    group:item("panacea", 1)
    group:item("afs_calorie_pill", 5)
    group:item("afs_sundew", 8)
    group:item("iv_mutagen_mastodon", 1)
    group:item("mutagen_mastodon", 2)
    group:item("recipe_unusual_ammos", 3)
    group:item("recipes_resistance", 2)
    group:item("recipe_uplift", 2)
    group:item("recipes_cryolab", 1)
    content.extend_item_group(group)
end

do
    -- extension of vanilla itemgroup
    -- This file is for expanding vanilla item groups with Aftershock scrap
    local group = content.ItemGroup { id = "surgery", kind = "distribution" }
    group:item("bionic_maintenance_toolkit", 20)
    group:item("bionic_maintenance_toolkit", 20)
    group:group("afs_biomedical_scrapgroup", 30)
    group:group("afs_advanced_biomaterial_scrapgroup", 5)
    group:group("afs_advanced_neural_io_scrapgroup", 5)
    content.extend_item_group(group)
end

do
    -- Not something you get in bulk, but it makes sense to be out in the back area
    local group = content.ItemGroup { id = "hardware_bulk", kind = "distribution" }
    group:item("afs_power_cutter", 1)
    content.extend_item_group(group)
end

do
    -- extension of vanilla itemgroup
    local group = content.ItemGroup { id = "tools_medical", kind = "collection" }
    group:item("bionic_maintenance_toolkit", 20)
    content.extend_item_group(group)
end
