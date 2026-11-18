local content = require("ccb").content

do
    local group = content.ItemGroup { id = "vehicle_scrapped", kind = "distribution" }
    group:item("chain", 10)
    group:item("lc_steel_chunk", 30)
    group:item("spring", 5)
    group:item("lc_steel_lump", 30)
    group:item("steel_plate", 30)
    group:item("hard_plate", 30)
    group:item("frame", 20)
    group:item("bearing", 5)
    group:item("cu_pipe", 5)
    group:item("scrap", 20)
    group:entry { item = "glass_shard", count = { 1, 8 }, probability = 10 }
    group:item("lc_wire", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dead_vegetation", kind = "distribution" }
    group:entry { item = "twig", count = { 5, 20 }, probability = 15 }
    group:item("withered", 60)
    group:item("stick_long", 15)
    group:item("stick", 30)
    content.add(group)
end

do
    -- A building has collapsed. Perhaps from a bomb, perhaps from a fire
    -- This stuff survived and lies inside the ruins but is really crude and damaged.
    local group = content.ItemGroup { id = "collapsed_building_rubble", kind = "collection" }
    group:entry { item = "string_36", count = { 5, 40 }, damage = { 0, 3 }, probability = 2 }
    group:entry { item = "frame", count = { 0, 1 }, damage = { 0, 3 }, probability = 2 }
    group:entry { item = "hdframe", count = { 0, 1 }, damage = { 0, 3 }, probability = 2 }
    group:entry { item = "metal_tank", count = { 0, 1 }, damage = { 0, 3 }, probability = 2 }
    group:entry { item = "screen_mesh", count = { 1, 2 }, damage = { 0, 3 }, probability = 2 }
    group:entry { item = "metal_tank_little", count = { 0, 1 }, damage = { 0, 3 }, probability = 2 }
    group:entry { item = "water_faucet", count = { 1, 2 }, damage = { 0, 3 }, probability = 2 }
    group:entry { item = "peephole", count = { 0, 1 }, damage = { 0, 3 }, probability = 2 }
    group:entry { item = "cu_pipe", count = { 2, 4 }, damage = { 0, 3 }, probability = 2 }
    group:entry { item = "chain", count = { 0, 1 }, damage = { 0, 3 }, probability = 2 }
    group:entry { item = "rope_6", count = { 1, 2 }, damage = { 0, 3 }, probability = 2 }
    group:entry { item = "rope_30", count = { 0, 1 }, damage = { 0, 3 }, probability = 2 }
    group:entry { item = "rebar", count = { 2, 6 }, damage = { 0, 3 }, probability = 8 }
    group:entry { item = "brick", count = { 10, 20 }, damage = { 0, 3 }, probability = 20 }
    group:entry { item = "pipe", count = { 2, 6 }, damage = { 0, 3 }, probability = 5 }
    group:entry { item = "nail", count = { 0, 1 }, charges = { 3, 15 }, probability = 2 }
    group:entry { item = "lc_wire", count = { 2, 6 }, damage = { 0, 3 }, probability = 3 }
    group:entry { item = "charcoal", charges = { 3, 7 }, probability = 3 }
    group:entry { item = "scrap_copper", count = { 2, 4 }, damage = { 0, 3 }, probability = 2 }
    group:entry { item = "sheet_metal", count = { 1, 4 }, damage = { 0, 3 }, probability = 2 }
    group:entry { item = "sheet_metal_small", count = { 1, 4 }, damage = { 0, 3 }, probability = 2 }
    group:entry { item = "spike", count = { 2, 4 }, damage = { 0, 3 }, probability = 5 }
    group:entry { item = "hinge", count = { 1, 2 }, damage = { 0, 3 }, probability = 2 }
    group:entry { item = "lc_steel_lump", count = { 2, 5 }, probability = 5 }
    group:entry { item = "lc_steel_chunk", count = { 5, 10 }, probability = 5 }
    content.add(group)
end

do
    -- A building has collapsed. Perhaps from a bomb, perhaps from a fire
    -- This is the stuff that fell outside and lies on the ground in the open.
    local group = content.ItemGroup { id = "collapsed_building_outside", kind = "collection" }
    group:entry { item = "rebar", count = { 5, 10 }, damage = { 0, 3 }, probability = 2 }
    group:entry { item = "brick", count = { 15, 30 }, damage = { 0, 3 }, probability = 20 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "table_destruction", kind = "collection" }
    group:entry { item = "2x4", count = { 2, 4 } }
    group:entry { item = "wood_panel", count = { 0, 1 } }
    group:entry { item = "nail", charges = { 4, 8 } }
    group:entry { item = "splinter", count = { 1, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "door_destruction", kind = "collection" }
    group:entry { item = "2x4", count = { 1, 2 } }
    group:entry { item = "nail", charges = { 1, 4 } }
    group:entry { item = "splinter", count = { 1, 4 } }
    group:entry { item = "hinge", count = { 1, 2 } }
    group:group("door_damage")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "door_damage", kind = "collection" }
    group:item("2x4", 25)
    group:item("wood_panel", 10)
    group:entry { item = "splinter", count = { 1, 2 } }
    group:entry { item = "nail", charges = { 0, 2 } }
    content.add(group)
end
