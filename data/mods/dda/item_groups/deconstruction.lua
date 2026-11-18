local content = require("ccb").content

do
    local group = content.ItemGroup { id = "wall_deconstruction_results", kind = "collection" }
    group:entry { item = "rock", count = { 0, 4 } }
    group:entry { item = "wood_panel", count = { 0, 2 } }
    group:entry { item = "nail", charges = { 8, 32 } }
    group:entry { item = "splinter", count = { 0, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "concrete_deconstruction_results", kind = "collection" }
    group:entry { item = "rock", count = { 5, 10 } }
    group:entry { item = "scrap", count = { 5, 8 } }
    group:entry { item = "rebar", count = { 0, 2 } }
    group:entry { item = "material_sand", count = { 50, 125 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "road_deconstruction_results", kind = "collection" }
    group:entry { item = "rock", count = { 10, 30 } }
    group:entry { item = "pebble", count = { 50, 200 } }
    group:entry { item = "material_sand", count = { 50, 400 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "metal_door_deconstruction_results", kind = "collection" }
    group:entry { item = "scrap", count = { 15, 30 } }
    group:entry { item = "sheet_metal", count = { 4, 8 } }
    group:entry { item = "hinge", count = { 0, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "teeth_deconstruction_result", kind = "collection" }
    group:entry { item = "nm_teeth", count = { 30, 50 } }
    content.add(group)
end
