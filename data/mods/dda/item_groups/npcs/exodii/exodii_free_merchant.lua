local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_EXODII_FREE_MERCHANT_storage", kind = "distribution" }
    group:item("duffelbag")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_EXODII_FREE_MERCHANT_coat", kind = "distribution" }
    group:item("trenchcoat", 80)
    group:item("vest", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_EXODII_FREE_MERCHANT_misc", kind = "collection" }
    group:entry { item = "jerky", count = { 10, 25 } }
    group:entry { item = "tallow", count = { 20, 50 } }
    group:entry { item = "pemmican", count = { 10, 25 } }
    group:entry { item = "dry_meat", count = { 10, 25 } }
    group:entry { item = "dry_fish", count = { 10, 25 } }
    group:entry { item = "dry_veggy", count = { 20, 50 } }
    group:entry { item = "dry_fruit", count = { 10, 25 } }
    group:entry { group = "solder_wire_spool", count = { 2, 5 } }
    group:entry { item = "welding_rod_steel", count = { 750, 4000 }, wrapper = "tube_welding_rod" }
    group:entry { item = "welding_rod_alloy", count = { 750, 4000 }, wrapper = "tube_welding_rod" }
    group:entry { item = "welding_wire_steel", count = { 333, 2000 }, wrapper = "spool_welding" }
    group:entry { item = "welding_wire_alloy", count = { 500, 3000 }, wrapper = "spool_welding" }
    group:entry { item = "brazing_rod_bronze", count = { 250, 2000 }, wrapper = "tube_welding_rod" }
    group:entry { item = "brazing_rod_alloy", count = { 250, 2000 }, wrapper = "tube_welding_rod" }
    group:entry { item = "scrap", count = { 125, 250 } }
    group:entry { item = "nuts_bolts", count = { 10, 25 } }
    group:entry { item = "sheet_metal_small", count = { 50, 100 } }
    group:entry { item = "lc_steel_chunk", count = { 100, 200 } }
    group:entry { item = "lc_steel_lump", count = { 50, 100 } }
    group:entry { item = "sheet_metal", count = { 25, 50 } }
    group:entry { item = "lc_steel_lump", count = { 25, 50 } }
    group:entry { item = "mc_steel_lump", count = { 25, 50 } }
    group:entry { item = "hc_steel_lump", count = { 25, 50 } }
    content.add(group)
end
