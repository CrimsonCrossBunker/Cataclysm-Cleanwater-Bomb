local content = require("ccb").content

do
    local group = content.ItemGroup { id = "cave_minerals", kind = "distribution" }
    group:entry { item = "coal_lump", count = { 1, 10 }, probability = 20 }
    group:entry { item = "rock", count = { 1, 10 }, probability = 40 }
    group:entry { item = "rock_large", count = { 1, 10 }, probability = 10 }
    group:entry { item = "rock_flaking", count = { 1, 10 }, probability = 20 }
    group:entry { item = "material_shrd_limestone", count = { 1, 10 }, probability = 40 }
    group:entry { item = "material_limestone", count = { 1, 10 }, probability = 40 }
    group:entry { item = "material_niter", count = { 1, 10 }, probability = 5 }
    group:entry { item = "chunk_sulfur", count = { 1, 10 }, probability = 5 }
    group:entry { item = "material_rocksalt", count = { 1, 10 }, probability = 5 }
    group:entry { item = "material_rhodonite", count = { 1, 10 }, probability = 5 }
    group:entry { item = "material_zincite", count = { 1, 10 }, probability = 5 }
    group:entry { item = "iron_ore", count = { 0, 5 }, probability = 5 }
    group:entry { item = "chunk_copper", count = { 0, 3 }, probability = 15 }
    group:entry { item = "chunk_silver", count = { 0, 2 }, probability = 5 }
    group:entry { item = "chunk_gold", count = { 0, 2 }, probability = 3 }
    group:entry { item = "chunk_aluminum", count = { 0, 3 }, probability = 3 }
    group:entry { item = "chunk_cassiterite", count = { 2, 4 }, probability = 10 }
    group:entry { item = "chunk_galena", count = { 2, 4 }, probability = 10 }
    group:entry { item = "chunk_hematite", count = { 2, 2 }, probability = 10 }
    group:entry { item = "chunk_magnetite", count = { 2, 2 }, probability = 5 }
    group:entry { item = "chunk_graphite", count = { 0, 1 }, probability = 2 }
    group:entry { item = "chunk_feldspar", count = { 2, 4 }, probability = 10 }
    content.extend_item_group(group)
end
