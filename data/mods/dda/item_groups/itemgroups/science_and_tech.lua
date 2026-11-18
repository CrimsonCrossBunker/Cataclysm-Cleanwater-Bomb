local content = require("ccb").content

do
    -- odds of serum kit is so low for there is only three at this moment, would be very repetitive.  TODO increase odds to get serum once there would be more of them.
    local group = content.ItemGroup { id = "mutagen_or_serum_kit", kind = "distribution" }
    group:group("mutagen_kits")
    group:group("serum_kits", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mutagen_kits", kind = "distribution" }
    group:group("mutagenic_field_kit", 15)
    group:group("mutagen_catalyst_kit", 35)
    group:group("mutagen_primer_kit", 55)
    group:group("mutagen_kit", 55)
    group:group("mutagen_slurry_kit", 75)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mutagen_slurry_kit", kind = "collection" }
    group:entry { item = "mutagen", charges = { 30, 50 }, container = "30gal_barrel_mutagen" }
    group:item("lab_file_mutagen_guide")
    group:item("lab_file_mutation_testing")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "serum_kits", kind = "distribution" }
    group:group("regen_serum_kit", 1)
    group:group("super_soldier_serum_kit", 1)
    group:group("resilience_serum_kit", 1)
    group:group("learning_serum_kit", 1)
    group:group("speed_serum_kit", 1)
    group:group("night_ops_serum_kit", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regen_serum_kit", kind = "collection", container = "box_small_plastic" }
    group:entry { item = "syringe", count = { 1, 1 } }
    group:entry { item = "serum_regen", count = { 8, 12 } }
    group:entry { item = "bubblewrap", count = { 12, 20 } }
    group:item("lab_file_serum_testing", 100, "lab_file_serum_testing_regen")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "super_soldier_serum_kit", kind = "collection", container = "box_small_plastic" }
    group:entry { item = "syringe", count = { 1, 1 } }
    group:entry { item = "serum_super_soldier", count = { 8, 12 } }
    group:entry { item = "bubblewrap", count = { 12, 20 } }
    group:item("lab_file_serum_testing", 100, "lab_file_serum_testing_super_soldier")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "resilience_serum_kit", kind = "collection", container = "box_small_plastic" }
    group:entry { item = "syringe", count = { 1, 1 } }
    group:entry { item = "serum_resilience", count = { 8, 12 } }
    group:entry { item = "bubblewrap", count = { 12, 20 } }
    group:item("lab_file_serum_testing", 100, "lab_file_serum_testing_resilience")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "learning_serum_kit", kind = "collection", container = "box_small_plastic" }
    group:entry { item = "syringe", count = { 1, 1 } }
    group:entry { item = "serum_learning", count = { 8, 12 } }
    group:entry { item = "bubblewrap", count = { 12, 20 } }
    group:item("lab_file_serum_testing", 100, "lab_file_serum_testing_learning")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "speed_serum_kit", kind = "collection", container = "box_small_plastic" }
    group:entry { item = "syringe", count = { 1, 1 } }
    group:entry { item = "serum_speed", count = { 8, 12 } }
    group:entry { item = "bubblewrap", count = { 12, 20 } }
    group:item("lab_file_serum_testing", 100, "lab_file_serum_testing_speed")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "night_ops_serum_kit", kind = "collection", container = "box_small_plastic" }
    group:entry { item = "syringe", count = { 1, 1 } }
    group:entry { item = "serum_night_operations", count = { 8, 12 } }
    group:entry { item = "bubblewrap", count = { 12, 20 } }
    group:item("lab_file_serum_testing", 100, "lab_file_serum_testing_night_ops")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "goo", kind = "distribution" }
    group:group("supplies_reagents_lab", 20)
    group:item("jumpsuit", 20)
    group:item("jumpsuit_pocketless", 1, "orange")
    group:item("gloves_rubber", 20)
    group:item("apron_plastic", 20)
    group:entry { item = "mask_filter", charges = { 0, 100 }, probability = 30 }
    group:item("goggles_chem", 35)
    group:item("glasses_safety", 5)
    group:entry { item = "lighter", charges = { 0, 100 }, probability = 60 }
    group:item("boots_rubber", 20)
    group:item("recipe_medicalmut", 2)
    group:item("canister_goo", 16)
    group:item("recipe_labchem", 2)
    group:item("recipe_creepy", 2)
    group:item("recipe_animal", 1)
    group:item("recipe_chimera", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cloning_vat", kind = "distribution" }
    group:item("fetus", 1)
    group:item("arm", 4)
    group:item("leg", 4)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "yrax_scrap", kind = "distribution" }
    group:item("yrax_sensor", 5)
    group:item("yrax_robotics", 20)
    group:item("yrax_computer", 5)
    group:item("yrax_scrap", 40)
    group:item("yrax_metal", 40)
    group:item("yrax_electronics", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "any_centrifuge", kind = "distribution" }
    group:item("microcentrifuge", 1)
    group:item("centrifuge", 1)
    content.add(group)
end
