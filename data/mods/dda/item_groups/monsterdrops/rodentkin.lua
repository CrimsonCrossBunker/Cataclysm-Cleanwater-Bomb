local content = require("ccb").content

do
    local group = content.ItemGroup { id = "ratkin_death_drops_mausketeer", kind = "collection" }
    group:entry { group = "mausketeer_swords", damage = { 2, 4 } }
    group:group("ratkin_mausketeer_clothes")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ratkin_death_drops_teke", kind = "collection" }
    group:group("ratkin_teke_clothes")
    content.add(group)
end

do
    -- contains cloth for mausketeer
    local group = content.ItemGroup { id = "ratkin_mausketeer_clothes", kind = "collection" }
    group:entry { group = "mausketeer_coats", damage = { 0, 3 }, probability = 60 }
    group:entry { group = "gloves_unisex", damage = { 0, 4 }, probability = 20 }
    group:entry { group = "hatstore_hats", damage = { 0, 4 }, probability = 20 }
    group:entry { group = "scarfs_unisex", damage = { 0, 4 }, probability = 20 }
    group:entry { group = "mausketeer_swords", damage = { 0, 4 }, probability = 20 }
    group:entry { group = "accesories_personal_unisex", damage = { 0, 4 }, probability = 45 }
    content.add(group)
end

do
    -- contains cloth for a telekinetic rat
    local group = content.ItemGroup { id = "ratkin_teke_clothes", kind = "collection" }
    group:entry { item = "coat_lab", damage = { 0, 4 }, probability = 60 }
    group:entry { group = "drugs_emergency", damage = { 0, 2 }, probability = 20 }
    group:entry { group = "drugs_pharmacy", damage = { 0, 3 }, probability = 20 }
    group:entry { group = "chem_lab", damage = { 0, 2 }, probability = 20 }
    group:entry { group = "accesories_personal_unisex", damage = { 0, 2 }, probability = 45 }
    content.add(group)
end

do
    -- contains shiny drops from a pack rat's mouth
    local group = content.ItemGroup { id = "ratkin_death_drops_pack_rat", kind = "distribution" }
    group:entry { group = "coins", count = { 1, 10 }, damage = { 0, 1 }, probability = 25 }
    group:entry { group = "silverware", count = { 1, 3 }, damage = { 0, 2 }, probability = 25 }
    group:entry { group = "SUS_trash_floor", count = { 1, 2 }, damage = { 0, 2 }, probability = 25 }
    group:entry { group = "SUS_trash_hardware", count = { 1, 2 }, damage = { 0, 3 }, probability = 25 }
    content.add(group)
end

do
    -- contains coats for mausketeers
    local group = content.ItemGroup { id = "mausketeer_coats", kind = "distribution" }
    group:entry { item = "greatcoat", damage = { 0, 4 }, probability = 20 }
    group:entry { item = "duster_leather", damage = { 0, 4 }, probability = 20 }
    group:entry { item = "sleeveless_trenchcoat_leather", damage = { 0, 4 }, probability = 20 }
    group:entry { item = "trenchcoat_leather", damage = { 0, 4 }, probability = 20 }
    content.add(group)
end

do
    -- contains swords for mausketeers
    local group = content.ItemGroup { id = "mausketeer_swords", kind = "distribution" }
    group:entry { item = "sword_metal", damage = { 0, 4 }, probability = 20 }
    group:entry { item = "lc_cavalry_sabre", damage = { 0, 4 }, probability = 5 }
    group:entry { item = "lc_estoc", damage = { 0, 4 }, probability = 5 }
    group:entry { item = "estoc_inferior", damage = { 0, 4 }, probability = 10 }
    group:entry { item = "estoc_fake", damage = { 0, 4 }, probability = 20 }
    group:entry { item = "fencing_foil_sharpened", damage = { 0, 4 }, probability = 10 }
    group:entry { item = "fencing_sabre_sharpened", damage = { 0, 4 }, probability = 10 }
    group:entry { item = "cutlass_fake", damage = { 0, 4 }, probability = 20 }
    group:entry { item = "cutlass_inferior", damage = { 0, 4 }, probability = 10 }
    group:entry { item = "lc_cutlass", damage = { 0, 4 }, probability = 5 }
    group:entry { item = "lc_rapier", damage = { 0, 4 }, probability = 5 }
    group:entry { item = "cavalry_sabre_fake", damage = { 0, 4 }, probability = 20 }
    group:entry { item = "rapier_fake", damage = { 0, 4 }, probability = 20 }
    group:entry { item = "fencing_epee_sharpened", damage = { 0, 4 }, probability = 10 }
    content.add(group)
end
