local content = require("ccb").content

do
    -- Makeshift or otherwise poor quality pistols.
    local group = content.ItemGroup { id = "guns_pistol_improvised", kind = "distribution" }
    group:item("pistol_flintlock")
    content.add(group)
end

do
    -- Imported or otherwise very obscure rifles.
    local group = content.ItemGroup { id = "guns_rifle_obscure", kind = "distribution" }
    group:group("guns_rifle_improvised", 22)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "outcrop_coal", kind = "collection" }
    group:entry { item = "pebble", count = { 50, 100 } }
    group:entry { item = "coal_lump", charges = { 10, 80 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "outcrop_hallite", kind = "collection" }
    group:entry { item = "pebble", count = { 50, 100 } }
    group:entry { item = "material_rocksalt", count = { 3, 10 }, probability = 30 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "outcrop_brimstone", kind = "collection" }
    group:entry { item = "pebble", count = { 50, 100 } }
    group:entry { item = "chunk_sulfur", count = { 0, 2 }, probability = 30 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "outcrop_copper", kind = "collection" }
    group:entry { item = "pebble", count = { 50, 100 } }
    group:entry { item = "chunk_copper", count = { 0, 2 }, probability = 30 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "outcrop_cassiterite", kind = "collection" }
    group:entry { item = "pebble", count = { 50, 100 } }
    group:entry { item = "chunk_cassiterite", count = { 0, 2 }, probability = 30 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "outcrop_galena", kind = "collection" }
    group:entry { item = "pebble", count = { 50, 100 } }
    group:entry { item = "chunk_galena", count = { 1, 3 }, probability = 30 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "outcrop_hematite", kind = "collection" }
    group:entry { item = "pebble", count = { 50, 100 } }
    group:entry { item = "chunk_hematite", count = { 1, 3 }, probability = 30 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "outcrop_feldspar", kind = "collection" }
    group:entry { item = "pebble", count = { 50, 100 } }
    group:entry { item = "chunk_feldspar", count = { 2, 4 }, probability = 30 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "outcrop_graphite", kind = "collection" }
    group:entry { item = "pebble", count = { 50, 100 } }
    group:entry { item = "chunk_graphite", count = { 2, 4 }, probability = 30 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "trash_forest", kind = "distribution" }
    group:entry { item = "twig", count = { 5, 40 } }
    group:entry { item = "rock", count = { 1, 3 }, probability = 80 }
    group:item("rock_flaking", 80)
    group:item("chunk_feldspar", 10)
    group:item("stick", 80)
    group:item("stick_long", 10)
    group:item("acorns", 80)
    group:item("pinecone", 80)
    group:entry { item = "withered", count = { 1, 10 }, probability = 80 }
    group:entry { item = "plant_fibre", count = { 1, 10 }, probability = 80 }
    group:item("straw_pile", 80)
    group:item("tanbark", 80)
    group:item("rock_large", 70)
    group:item("field_stone", 70)
    group:item("pine_bough", 70)
    group:entry { item = "splinter", count = { 1, 5 }, probability = 70 }
    group:item("hickory_root", 65)
    group:item("hickory_nut", 65)
    group:item("tinder", 50)
    group:entry { item = "feather", count = { 1, 10 }, probability = 40 }
    group:entry { item = "pebble", count = { 1, 5 }, probability = 30 }
    group:item("bone", 30)
    group:item("flint", 20)
    group:item("chunk_copper", 1)
    group:item("chunk_cassiterite", 1)
    group:item("log", 2)
    group:item("chunk_hematite", 2)
    content.add(group)
end
