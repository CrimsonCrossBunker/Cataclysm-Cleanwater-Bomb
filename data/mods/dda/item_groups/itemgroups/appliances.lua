local content = require("ccb").content

do
    -- for traders
    local group = content.ItemGroup { id = "fridges_and_freezers_tradeable", kind = "distribution" }
    group:item("apartment_fridge")
    group:item("minifridge", 50)
    group:item("big_portable_fridge", 8)
    group:item("glass_fridge", 80)
    group:item("glass_fridge_double", 70)
    group:item("heavy_duty_fridge", 5)
    group:item("display_fridge", 25)
    group:item("apartment_freezer")
    group:item("minifreezer", 22)
    group:item("chest_minifreezer", 16)
    group:item("big_portable_freezer", 6)
    group:item("chest_freezer", 20)
    group:item("heavy_duty_freezer", 6)
    group:item("glass_freezer", 30)
    group:item("display_freezer", 30)
    content.add(group)
end

do
    -- allows both terrain/furniture and vehicle/appliances use the same drop list
    local group = content.ItemGroup { id = "apartment_fridge_destroyed", kind = "collection" }
    group:entry { item = "condensor_coil", count = { 0, 2 } }
    group:entry { item = "evaporator_coil", count = { 0, 2 } }
    group:entry { item = "compressor", count = { 0, 1 } }
    group:entry { item = "sheet_metal", count = { 0, 2 } }
    group:entry { item = "sheet_metal_small", count = { 0, 25 } }
    group:entry { item = "lc_steel_chunk", count = { 0, 5 } }
    group:entry { item = "pipe_fittings", count = { 0, 2 } }
    group:entry { item = "plastic_chunk", count = { 0, 294 } }
    group:entry { item = "chunk_rubber", count = { 0, 3 } }
    group:entry { item = "material_aluminium_ingot", count = { 0, 12 } }
    group:entry { item = "glass_shard", count = { 0, 5 } }
    group:entry { item = "cable", count = { 0, 14 } }
    group:entry { item = "hose", count = { 0, 1 } }
    group:entry { item = "cu_pipe", count = { 0, 1 } }
    group:entry { item = "refrigerant_tank", count = { 0, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "minifridge_destroyed", kind = "collection" }
    group:entry { item = "condensor_coil", count = { 0, 1 } }
    group:entry { item = "evaporator_coil", count = { 0, 1 } }
    group:entry { item = "sheet_metal", count = { 0, 1 } }
    group:entry { item = "sheet_metal_small", count = { 0, 16 } }
    group:entry { item = "lc_steel_chunk", count = { 0, 4 } }
    group:entry { item = "pipe_fittings", count = { 0, 1 } }
    group:entry { item = "plastic_chunk", count = { 0, 128 } }
    group:entry { item = "chunk_rubber", count = { 0, 1 } }
    group:entry { item = "material_aluminium_ingot", count = { 0, 5 } }
    group:entry { item = "glass_shard", count = { 0, 2 } }
    group:entry { item = "cable", count = { 0, 6 } }
    group:entry { item = "hose", count = { 0, 1 } }
    group:entry { item = "cu_pipe", count = { 0, 1 } }
    group:entry { item = "refrigerant_tank", count = { 0, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "big_portable_fridge_destroyed", kind = "collection" }
    group:entry { item = "condensor_coil", count = { 0, 2 } }
    group:entry { item = "evaporator_coil", count = { 0, 2 } }
    group:entry { item = "compressor", count = { 0, 1 } }
    group:entry { item = "sheet_metal", count = { 0, 3 } }
    group:entry { item = "sheet_metal_small", count = { 0, 28 } }
    group:entry { item = "lc_steel_chunk", count = { 0, 6 } }
    group:entry { item = "pipe_fittings", count = { 0, 2 } }
    group:entry { item = "plastic_chunk", count = { 0, 349 } }
    group:entry { item = "chunk_rubber", count = { 0, 3 } }
    group:entry { item = "material_aluminium_ingot", count = { 0, 14 } }
    group:entry { item = "glass_shard", count = { 0, 6 } }
    group:entry { item = "cable", count = { 0, 17 } }
    group:entry { item = "hose", count = { 0, 1 } }
    group:entry { item = "cu_pipe", count = { 0, 1 } }
    group:entry { item = "refrigerant_tank", count = { 0, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "glass_fridge_destroyed", kind = "collection" }
    group:entry { item = "condensor_coil", count = { 0, 2 } }
    group:entry { item = "evaporator_coil", count = { 0, 2 } }
    group:entry { item = "compressor", count = { 0, 1 } }
    group:entry { item = "sheet_metal", count = { 0, 2 } }
    group:entry { item = "sheet_metal_small", count = { 0, 14 } }
    group:entry { item = "lc_steel_chunk", count = { 0, 3 } }
    group:entry { item = "pipe_fittings", count = { 0, 2 } }
    group:entry { item = "plastic_chunk", count = { 0, 406 } }
    group:entry { item = "chunk_rubber", count = { 0, 4 } }
    group:entry { item = "material_aluminium_ingot", count = { 0, 16 } }
    group:entry { item = "glass_shard", count = { 0, 234 } }
    group:entry { item = "cable", count = { 0, 20 } }
    group:entry { item = "hose", count = { 0, 1 } }
    group:entry { item = "cu_pipe", count = { 0, 1 } }
    group:entry { item = "refrigerant_tank", count = { 0, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "glass_fridge_double_destroyed", kind = "collection" }
    group:entry { item = "condensor_coil", count = { 0, 3 } }
    group:entry { item = "evaporator_coil", count = { 0, 3 } }
    group:entry { item = "compressor", count = { 0, 1 } }
    group:entry { item = "sheet_metal", count = { 0, 8 } }
    group:entry { item = "sheet_metal_small", count = { 0, 15 } }
    group:entry { item = "lc_steel_chunk", count = { 0, 3 } }
    group:entry { item = "pipe_fittings", count = { 0, 3 } }
    group:entry { item = "plastic_chunk", count = { 0, 874 } }
    group:entry { item = "chunk_rubber", count = { 0, 7 } }
    group:entry { item = "material_aluminium_ingot", count = { 0, 34 } }
    group:entry { item = "glass_shard", count = { 0, 468 } }
    group:entry { item = "cable", count = { 0, 42 } }
    group:entry { item = "hose", count = { 0, 1 } }
    group:entry { item = "cu_pipe", count = { 0, 1 } }
    group:entry { item = "refrigerant_tank", count = { 0, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "heavy_duty_fridge_destroyed", kind = "collection" }
    group:entry { item = "condensor_coil", count = { 0, 3 } }
    group:entry { item = "evaporator_coil", count = { 0, 3 } }
    group:entry { item = "compressor", count = { 0, 1 } }
    group:entry { item = "sheet_metal", count = { 0, 11 } }
    group:entry { item = "sheet_metal_small", count = { 0, 65 } }
    group:entry { item = "lc_steel_chunk", count = { 0, 13 } }
    group:entry { item = "pipe_fittings", count = { 0, 3 } }
    group:entry { item = "plastic_chunk", count = { 0, 858 } }
    group:entry { item = "chunk_rubber", count = { 0, 7 } }
    group:entry { item = "material_aluminium_ingot", count = { 0, 33 } }
    group:entry { item = "glass_shard", count = { 0, 14 } }
    group:entry { item = "cable", count = { 0, 41 } }
    group:entry { item = "hose", count = { 0, 1 } }
    group:entry { item = "cu_pipe", count = { 0, 1 } }
    group:entry { item = "refrigerant_tank", count = { 0, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "display_fridge_destroyed", kind = "collection" }
    group:entry { item = "condensor_coil", count = { 0, 1 } }
    group:entry { item = "evaporator_coil", count = { 0, 1 } }
    group:entry { item = "compressor", count = { 0, 1 } }
    group:entry { item = "sheet_metal", count = { 0, 5 } }
    group:entry { item = "sheet_metal_small", count = { 0, 25 } }
    group:entry { item = "lc_steel_chunk", count = { 0, 5 } }
    group:entry { item = "pipe_fittings", count = { 0, 1 } }
    group:entry { item = "plastic_chunk", count = { 0, 531 } }
    group:entry { item = "chunk_rubber", count = { 0, 5 } }
    group:entry { item = "material_aluminium_ingot", count = { 0, 21 } }
    group:entry { item = "glass_shard", count = { 0, 236 } }
    group:entry { item = "cable", count = { 0, 25 } }
    group:entry { item = "hose", count = { 0, 1 } }
    group:entry { item = "cu_pipe", count = { 0, 1 } }
    group:entry { item = "refrigerant_tank", count = { 0, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "apartment_freezer_destroyed", kind = "collection" }
    group:entry { item = "condensor_coil", count = { 0, 2 } }
    group:entry { item = "evaporator_coil", count = { 0, 2 } }
    group:entry { item = "compressor", count = { 0, 1 } }
    group:entry { item = "sheet_metal", count = { 0, 2 } }
    group:entry { item = "sheet_metal_small", count = { 0, 25 } }
    group:entry { item = "lc_steel_chunk", count = { 0, 5 } }
    group:entry { item = "pipe_fittings", count = { 0, 2 } }
    group:entry { item = "plastic_chunk", count = { 0, 294 } }
    group:entry { item = "chunk_rubber", count = { 0, 3 } }
    group:entry { item = "material_aluminium_ingot", count = { 0, 12 } }
    group:entry { item = "glass_shard", count = { 0, 5 } }
    group:entry { item = "cable", count = { 0, 14 } }
    group:entry { item = "hose", count = { 0, 1 } }
    group:entry { item = "cu_pipe", count = { 0, 1 } }
    group:entry { item = "refrigerant_tank", count = { 0, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "minifreezer_destroyed", kind = "collection" }
    group:entry { item = "condensor_coil", count = { 0, 1 } }
    group:entry { item = "evaporator_coil", count = { 0, 1 } }
    group:entry { item = "sheet_metal", count = { 0, 1 } }
    group:entry { item = "sheet_metal_small", count = { 0, 21 } }
    group:entry { item = "lc_steel_chunk", count = { 0, 5 } }
    group:entry { item = "pipe_fittings", count = { 0, 1 } }
    group:entry { item = "plastic_chunk", count = { 0, 140 } }
    group:entry { item = "chunk_rubber", count = { 0, 2 } }
    group:entry { item = "material_aluminium_ingot", count = { 0, 6 } }
    group:entry { item = "glass_shard", count = { 0, 3 } }
    group:entry { item = "cable", count = { 0, 7 } }
    group:entry { item = "hose", count = { 0, 1 } }
    group:entry { item = "cu_pipe", count = { 0, 1 } }
    group:entry { item = "refrigerant_tank", count = { 0, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "chest_minifreezer_destroyed", kind = "collection" }
    group:entry { item = "condensor_coil", count = { 0, 1 } }
    group:entry { item = "evaporator_coil", count = { 0, 1 } }
    group:entry { item = "sheet_metal", count = { 0, 1 } }
    group:entry { item = "sheet_metal_small", count = { 0, 13 } }
    group:entry { item = "lc_steel_chunk", count = { 0, 3 } }
    group:entry { item = "pipe_fittings", count = { 0, 1 } }
    group:entry { item = "plastic_chunk", count = { 0, 120 } }
    group:entry { item = "chunk_rubber", count = { 0, 1 } }
    group:entry { item = "material_aluminium_ingot", count = { 0, 5 } }
    group:entry { item = "glass_shard", count = { 0, 2 } }
    group:entry { item = "cable", count = { 0, 6 } }
    group:entry { item = "hose", count = { 0, 1 } }
    group:entry { item = "cu_pipe", count = { 0, 1 } }
    group:entry { item = "refrigerant_tank", count = { 0, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "big_portable_freezer_destroyed", kind = "collection" }
    group:entry { item = "condensor_coil", count = { 0, 2 } }
    group:entry { item = "evaporator_coil", count = { 0, 2 } }
    group:entry { item = "compressor", count = { 0, 1 } }
    group:entry { item = "sheet_metal", count = { 0, 3 } }
    group:entry { item = "sheet_metal_small", count = { 0, 39 } }
    group:entry { item = "lc_steel_chunk", count = { 0, 8 } }
    group:entry { item = "pipe_fittings", count = { 0, 2 } }
    group:entry { item = "plastic_chunk", count = { 0, 375 } }
    group:entry { item = "chunk_rubber", count = { 0, 3 } }
    group:entry { item = "material_aluminium_ingot", count = { 0, 15 } }
    group:entry { item = "glass_shard", count = { 0, 6 } }
    group:entry { item = "cable", count = { 0, 18 } }
    group:entry { item = "hose", count = { 0, 1 } }
    group:entry { item = "cu_pipe", count = { 0, 1 } }
    group:entry { item = "refrigerant_tank", count = { 0, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "chest_freezer_destroyed", kind = "collection" }
    group:entry { item = "condensor_coil", count = { 0, 1 } }
    group:entry { item = "evaporator_coil", count = { 0, 1 } }
    group:entry { item = "compressor", count = { 0, 1 } }
    group:entry { item = "sheet_metal", count = { 0, 2 } }
    group:entry { item = "sheet_metal_small", count = { 0, 29 } }
    group:entry { item = "lc_steel_chunk", count = { 0, 6 } }
    group:entry { item = "pipe_fittings", count = { 0, 1 } }
    group:entry { item = "plastic_chunk", count = { 0, 260 } }
    group:entry { item = "chunk_rubber", count = { 0, 2 } }
    group:entry { item = "material_aluminium_ingot", count = { 0, 10 } }
    group:entry { item = "glass_shard", count = { 0, 4 } }
    group:entry { item = "cable", count = { 0, 13 } }
    group:entry { item = "hose", count = { 0, 1 } }
    group:entry { item = "cu_pipe", count = { 0, 1 } }
    group:entry { item = "refrigerant_tank", count = { 0, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "heavy_duty_freezer_destroyed", kind = "collection" }
    group:entry { item = "condensor_coil", count = { 0, 2 } }
    group:entry { item = "evaporator_coil", count = { 0, 2 } }
    group:entry { item = "compressor", count = { 0, 1 } }
    group:entry { item = "sheet_metal", count = { 0, 11 } }
    group:entry { item = "sheet_metal_small", count = { 0, 99 } }
    group:entry { item = "lc_steel_chunk", count = { 0, 20 } }
    group:entry { item = "pipe_fittings", count = { 0, 2 } }
    group:entry { item = "plastic_chunk", count = { 0, 895 } }
    group:entry { item = "chunk_rubber", count = { 0, 7 } }
    group:entry { item = "material_aluminium_ingot", count = { 0, 35 } }
    group:entry { item = "glass_shard", count = { 0, 14 } }
    group:entry { item = "cable", count = { 0, 43 } }
    group:entry { item = "hose", count = { 0, 1 } }
    group:entry { item = "cu_pipe", count = { 0, 1 } }
    group:entry { item = "refrigerant_tank", count = { 0, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "glass_freezer_destroyed", kind = "collection" }
    group:entry { item = "condensor_coil", count = { 0, 2 } }
    group:entry { item = "evaporator_coil", count = { 0, 2 } }
    group:entry { item = "compressor", count = { 0, 1 } }
    group:entry { item = "sheet_metal", count = { 0, 3 } }
    group:entry { item = "sheet_metal_small", count = { 0, 3 } }
    group:entry { item = "lc_steel_chunk", count = { 0, 1 } }
    group:entry { item = "pipe_fittings", count = { 0, 2 } }
    group:entry { item = "plastic_chunk", count = { 0, 416 } }
    group:entry { item = "chunk_rubber", count = { 0, 4 } }
    group:entry { item = "material_aluminium_ingot", count = { 0, 16 } }
    group:entry { item = "glass_shard", count = { 0, 234 } }
    group:entry { item = "cable", count = { 0, 20 } }
    group:entry { item = "hose", count = { 0, 1 } }
    group:entry { item = "cu_pipe", count = { 0, 1 } }
    group:entry { item = "refrigerant_tank", count = { 0, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "display_freezer_destroyed", kind = "collection" }
    group:entry { item = "condensor_coil", count = { 0, 1 } }
    group:entry { item = "evaporator_coil", count = { 0, 1 } }
    group:entry { item = "compressor", count = { 0, 1 } }
    group:entry { item = "sheet_metal", count = { 0, 2 } }
    group:entry { item = "sheet_metal_small", count = { 0, 7 } }
    group:entry { item = "lc_steel_chunk", count = { 0, 2 } }
    group:entry { item = "pipe_fittings", count = { 0, 1 } }
    group:entry { item = "plastic_chunk", count = { 0, 315 } }
    group:entry { item = "chunk_rubber", count = { 0, 3 } }
    group:entry { item = "material_aluminium_ingot", count = { 0, 13 } }
    group:entry { item = "glass_shard", count = { 0, 232 } }
    group:entry { item = "cable", count = { 0, 15 } }
    group:entry { item = "hose", count = { 0, 1 } }
    group:entry { item = "cu_pipe", count = { 0, 1 } }
    group:entry { item = "refrigerant_tank", count = { 0, 1 } }
    content.add(group)
end
