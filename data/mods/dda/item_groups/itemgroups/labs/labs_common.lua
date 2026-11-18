local content = require("ccb").content

do
    local group = content.ItemGroup { id = "lab_glassware", kind = "collection" }
    group:entry { item = "test_tube", count = { 2, 6 }, probability = 50 }
    group:entry { item = "glass_prism", count = { 1, 3 }, probability = 5 }
    group:entry { item = "bottle_glass", count = { 1, 3 }, probability = 20 }
    group:entry { item = "glass_tube_small", count = { 1, 6 }, probability = 40 }
    group:entry { item = "flask_glass", count = { 1, 6 }, probability = 60 }
    group:entry { item = "canister_empty", count = { 1, 6 }, probability = 40 }
    group:entry { item = "jar_3l_glass_sealed", count = { 1, 3 }, probability = 5 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "lab_files_biology", kind = "collection" }
    group:entry { item = "lab_postit_bio", count = { 1, 2 }, probability = 50 }
    group:item("lab_file_bio", 33)
    group:item("bio_file", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "lab_files_psychology", kind = "collection" }
    group:item("lab_file_psych", 33)
    group:item("psych_file", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "lab_files_security", kind = "collection" }
    group:item("lab_file_sec", 33)
    group:item("security_file", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ID_supplies", kind = "collection" }
    group:entry {
        distribution = {
            { item = "camera", charges = { 0, 50 }, probability = 70 },
            { item = "camera_pro", charges = { 0, 50 }, probability = 30 },
        },
        probability = 10,
    }
    group:entry {
        group = "used_memory_cards",
        count = { 2, 4 },
        contents = {
            { group = "efiles_science" },
        },
        probability = 15,
    }
    group:entry { item = "badge_doctor", count = { 1, 2 }, probability = 5 }
    group:entry { item = "wrapped_rad_badge", count = { 1, 3 }, probability = 7 }
    group:entry { item = "plastic_chunk", count = { 1, 3 }, probability = 30 }
    group:item("vac_sealer", 20)
    group:entry { item = "id_science", count = { 1, 3 }, probability = 5 }
    group:item("id_science_visitor_1", 10)
    group:item("id_science_transport_1", 10)
    group:item("id_science_maintenance_green", 10)
    group:item("id_science_maintenance_yellow", 5)
    group:item("id_science_maintenance_blue", 1)
    group:item("id_science_security_yellow", 3)
    group:item("id_science_security_magenta", 2)
    group:item("id_science_mutagen_pink", 2)
    group:item("id_science_mutagen_cyan", 1)
    group:item("id_science_medical_red", 7)
    group:item("id_military", 1)
    group:entry { item = "lanyard", count = { 1, 6 } }
    group:entry { item = "canister_empty", count = { 1, 6 }, probability = 30 }
    group:entry { item = "string_36", count = { 2, 8 }, probability = 60 }
    content.add(group)
end

do
    -- A generic group for all not-eoc notes and files to add some random clutter to old/microlabs.  Prefer more selective placement.
    local group = content.ItemGroup { id = "lab_files_generic", kind = "distribution" }
    group:item("lab_postit_bio", 3)
    group:item("lab_postit_blob", 3)
    group:item("lab_postit_migo", 3)
    group:item("lab_postit_portal", 3)
    group:item("lab_postit_tech", 3)
    group:item("lab_file_bio", 1)
    group:item("lab_file_portal", 1)
    group:item("lab_file_psych", 1)
    group:item("lab_file_sec", 1)
    content.add(group)
end
