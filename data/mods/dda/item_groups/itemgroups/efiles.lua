local content = require("ccb").content

do
    local group = content.ItemGroup { id = "efiles_science", kind = "collection" }
    group:entry { group = "textbooks", count = { 1, 2 }, probability = 40 }
    group:entry { group = "lab_bookshelves", count = { 1, 3 }, probability = 60 }
    group:item("software_hacking", 20)
    group:item("software_electronics_reference", 20)
    group:item("efile_lore", 60)
    group:item("efile_map", 10)
    group:item("efile_recipes_science", 80)
    group:entry { item = "efile_junk", count = { 12, 24 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "efiles_software", kind = "collection" }
    group:item("software_useless", 25)
    group:item("software_math", 15)
    group:item("software_medical", 5)
    group:item("software_hacking", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "efiles_medical", kind = "collection" }
    group:entry { group = "doctors_books", count = { 1, 2 }, probability = 40 }
    group:item("software_medical", 20)
    group:item("record_patient", 80)
    group:item("efile_lore", 60)
    group:item("efile_map", 10)
    group:item("efile_recipes_science", 80)
    group:entry { item = "efile_junk", count = { 12, 24 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "SUS_efiles_sewage", kind = "collection" }
    group:entry { group = "textbooks", count = { 1, 2 }, probability = 40 }
    group:item("decoy_elfa")
    group:item("efile_lore", 10)
    group:item("efile_map", 10)
    group:item("efile_recipes", 80)
    group:entry { item = "efile_junk", count = { 12, 24 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "efiles_scrap", kind = "collection" }
    group:item("software_hacking", 1)
    group:item("efile_lore", 10)
    group:item("efile_map", 5)
    group:item("efile_recipes", 5)
    group:entry { item = "efile_junk", count = { 24, 36 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "efiles_school", kind = "collection" }
    group:entry { group = "book_school", count = { 1, 3 }, probability = 80 }
    group:item("efile_map", 10)
    group:item("efile_recipes", 5)
    group:entry { item = "efile_junk", count = { 24, 36 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "efiles_contraband", kind = "collection" }
    group:group("book_manual_combat", 25)
    group:item("software_hacking", 25)
    group:item("efile_lore", 70)
    group:item("efile_map", 5)
    group:item("efile_recipes", 50)
    group:entry { item = "efile_junk", count = { 24, 36 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "civilian_portable_efiles", kind = "collection" }
    group:item("efile_lore", 20)
    group:group("novels", 50)
    group:group("literature", 50)
    group:entry { item = "photo_album", count = { 1, 5 }, probability = 25 }
    group:item("efile_recipes", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "civilian_smartphone_efiles", kind = "collection" }
    group:item("efile_map", 75)
    group:item("efile_lore", 50)
    group:entry { group = "novels", count = { 1, 3 }, probability = 50 }
    group:entry { group = "literature", count = { 1, 3 }, probability = 50 }
    group:item("efile_recipes", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "civilian_laptop_efiles", kind = "collection" }
    group:item("efile_map", 20)
    group:item("efile_lore", 60)
    group:entry { group = "novels", count = { 1, 3 }, probability = 50 }
    group:entry { group = "literature", count = { 1, 3 }, probability = 50 }
    group:item("efile_recipes", 40)
    group:item("software_useless", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "civilian_einktablet_efiles", kind = "collection" }
    group:item("efile_map", 20)
    group:item("efile_lore", 20)
    group:entry { group = "novels", count = { 1, 3 }, probability = 50 }
    group:entry { group = "literature", count = { 1, 3 }, probability = 50 }
    group:item("efile_recipes", 15)
    content.add(group)
end
