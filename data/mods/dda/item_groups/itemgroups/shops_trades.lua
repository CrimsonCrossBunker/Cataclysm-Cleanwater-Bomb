local content = require("ccb").content

do
    local group = content.ItemGroup { id = "ceramics_workroom", kind = "distribution" }
    group:group("vegetable_oil_bottle", 15)
    group:item("mag_fabrication", 5)
    group:item("manual_fabrication", 5)
    group:item("mag_survival", 10)
    group:item("theater_props", 8)
    group:item("vac_mold", 20)
    group:item("polycarbonate_sheet", 20)
    group:item("wax", 30)
    group:item("wax_paraffin", 30)
    group:item("straw_pile", 15)
    group:group("charcoal_bag_part", 25)
    group:item("clay_lump")
    group:item("clay_kaolin", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "metal_workshop", kind = "distribution" }
    group:group("tools_blacksmith", 50)
    group:group("supplies_metal", 40)
    group:item("welding_book", 5)
    group:item("mag_fabrication", 15)
    group:item("manual_fabrication", 15)
    group:item("goggles_welding", 10)
    group:item("apron_leather", 15)
    group:item("apron_cut_resistant", 20)
    group:item("chaps_cut_resistant", 20)
    group:item("gloves_cut_resistant", 25)
    group:item("armguard_cut_resistant", 25)
    group:item("balaclava_cut_resistant", 5)
    group:item("throat_guard_cut_resistant", 5)
    group:item("gloves_leather", 25)
    group:item("vac_mold", 10)
    group:item("polycarbonate_sheet", 20)
    group:item("mask_dust", 15)
    group:item("gas_forge", 10)
    group:item("sandpaper", 75)
    group:entry { item = "ear_plugs", count = { 1, 3 }, probability = 25 }
    group:group("charcoal_bag_part", 25)
    group:entry { item = "small_propane_tank", count = { 1, 5 }, probability = 10 }
    group:entry { item = "medium_propane_tank", count = { 1, 3 }, probability = 20 }
    group:entry { item = "large_propane_tank", count = { 1, 2 }, probability = 15 }
    group:entry { item = "lc_steel_lump", count = { 1, 3 }, probability = 5 }
    group:entry { item = "lc_steel_chunk", count = { 1, 5 }, probability = 15 }
    group:entry { item = "mc_steel_lump", count = { 1, 3 }, probability = 5 }
    group:entry { item = "mc_steel_chunk", count = { 1, 5 }, probability = 15 }
    group:entry { item = "hc_steel_lump", count = { 1, 3 }, probability = 5 }
    group:entry { item = "hc_steel_chunk", count = { 1, 5 }, probability = 15 }
    group:entry {
        collection = {
            { item = "oxy_torch" },
            {
                distribution = {
                    { item = "weldtank", count = { 1, 2 } },
                    { item = "tinyweldtank", count = { 1, 3 } },
                    { item = "smallweldtank", count = { 1, 3 } },
                },
            },
            {
                distribution = {
                    { item = "brazing_rod_bronze", charges = { 100, 360 }, probability = 75 },
                    { item = "brazing_rod_alloy", charges = { 80, 360 }, probability = 50 },
                },
            },
        },
        probability = 6,
    }
    group:item("oxy_torch", 5)
    group:entry { item = "weldtank", count = { 1, 2 }, probability = 2 }
    group:entry { item = "tinyweldtank", count = { 1, 3 }, probability = 2 }
    group:entry { item = "oxygen_cylinder", count = { 1, 2 }, probability = 10 }
    group:entry { item = "polisher", charges = { 0, 100 }, probability = 1 }
    group:item("welder", 2)
    group:entry { item = "welding_blanket", count = { 0, 1 }, probability = 10 }
    group:item("welding_papr_helmet", 10)
    group:group("papr_kit", 10)
    group:entry {
        distribution = {
            { item = "welding_rod_steel", charges = { 50, 360 }, wrapper = "tube_welding_rod", probability = 20 },
            { item = "welding_rod_alloy", charges = { 50, 360 }, wrapper = "tube_welding_rod", probability = 10 },
            { item = "welding_wire_steel", charges = { 50, 360 }, wrapper = "spool_welding", probability = 15 },
            { item = "welding_wire_alloy", charges = { 50, 360 }, wrapper = "spool_welding", probability = 5 },
            { item = "brazing_rod_bronze", charges = { 50, 200 }, wrapper = "tube_welding_rod", probability = 5 },
            { item = "brazing_rod_alloy", charges = { 50, 200 }, wrapper = "tube_welding_rod", probability = 5 },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "glass_workroom", kind = "distribution" }
    group:item("pipe", 90)
    group:item("glassblowing_book", 50)
    group:item("tongs", 30)
    group:item("crucible", 30)
    group:item("chisel", 30)
    group:item("glass_cutter", 30)
    group:item("vac_mold", 10)
    group:item("polycarbonate_sheet", 20)
    group:item("glasses_safety", 25)
    group:group("charcoal_bag_part", 50)
    group:entry { item = "glass_shard", count = { 1, 8 }, probability = 90 }
    group:group("sandbag_any", 5)
    group:item("chemistry_set", 5)
    group:item("sandpaper", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "gift_shop", kind = "distribution" }
    group:entry {
        collection = {
            { item = "hairpin", count = { 3, 4 }, probability = 25 },
            { item = "touristmap", count = { 0, 1 }, probability = 2 },
            { item = "UPS_OFF", count = { 0, 2 }, probability = 5 },
            { item = "pockknife", count = { 0, 5 }, probability = 20 },
            { item = "fork", count = { 3, 10 }, probability = 60 },
            { item = "spoon", count = { 3, 10 }, probability = 60 },
            { item = "novel_pulp", count = { 1, 5 }, probability = 30 },
        },
    }
    group:entry {
        collection = {
            { item = "bottle_glass", count = { 1, 10 }, probability = 60 },
            { item = "glass_bowl", count = { 1, 6 }, probability = 65 },
            { item = "malachite", count = { 3, 15 }, probability = 75 },
            { item = "citrine", count = { 3, 15 }, probability = 75 },
            { item = "jar_glass_sealed", count = { 1, 5 }, probability = 60 },
            { item = "glass", count = { 1, 7 }, probability = 60 },
            { item = "shot_glass", count = { 2, 6 }, probability = 45 },
        },
    }
    group:entry {
        collection = {
            { item = "toy_figurine", count = { 1, 10 }, probability = 75 },
            { group = "decks_of_cards", count = { 1, 5 }, probability = 60 },
            { item = "monopoly", count = { 1, 2 }, probability = 5 },
            { item = "teddy_bear", count = { 1, 5 }, probability = 10 },
            { item = "creepy_doll", count = { 1, 5 }, probability = 5 },
            { item = "straw_doll", count = { 1, 5 }, probability = 5 },
        },
    }
    group:entry {
        collection = {
            { item = "chalice", count = { 1, 10 }, probability = 40 },
            { item = "candle", count = { 25, 75 }, charges = { 100, 100 }, probability = 90 },
            { item = "candlestick", count = { 1, 5 }, probability = 40 },
            { item = "incense", count = { 5, 20 }, container = "box_small", probability = 75 },
            { item = "lighter", count = { 3, 10 }, charges = { 100, 100 }, probability = 90 },
            { item = "marble", charges = { 10, 50 }, probability = 30 },
            { item = "menorah", probability = 3 },
            { group = "small_candles_in_box", probability = 35 },
        },
    }
    group:entry {
        collection = {
            { item = "box_small", count = { 1, 10 }, probability = 60 },
            { item = "bath_toy", count = { 1, 2 }, probability = 60 },
            { item = "liquid_soap", count = { 1, 4 }, probability = 60 },
            { item = "towel", count = { 1, 2 }, probability = 60 },
            { item = "soap", count = { 1, 3 }, charges = { 100, 100 }, probability = 60 },
        },
    }
    content.add(group)
end
