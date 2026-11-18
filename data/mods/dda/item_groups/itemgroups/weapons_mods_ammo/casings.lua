local content = require("ccb").content

do
    -- Bulk casings found in gunstore locations, neatly packaged.  Follows rough values from ammoseek.
    local group = content.ItemGroup { id = "ammo_casings_gunsmith", kind = "distribution", container = "bag_plastic" }
    group:entry { item = "unprimed_9mm_casing", count = { 500, 500 }, probability = 250 }
    group:entry { item = "unprimed_223_casing", count = { 500, 500 }, probability = 287 }
    group:entry { item = "unprimed_45_casing", count = { 500, 500 }, probability = 176 }
    group:entry { item = "unprimed_380_casing", count = { 500, 500 }, probability = 98 }
    group:entry { item = "unprimed_40_casing", count = { 500, 500 }, probability = 164 }
    group:entry { item = "unprimed_762_casing", count = { 250, 250 }, probability = 81 }
    group:entry { item = "unprimed_357mag_casing", count = { 500, 500 }, probability = 79 }
    group:entry { item = "unprimed_308_casing", count = { 100, 100 }, probability = 110 }
    group:entry { item = "unprimed_762_51_casing", count = { 100, 100 }, probability = 110 }
    group:entry { item = "unprimed_38_casing", count = { 500, 500 }, probability = 116 }
    group:entry { item = "unprimed_44_casing", count = { 100, 100 }, probability = 73 }
    group:entry { item = "unprimed_3006_casing", count = { 50, 50 }, probability = 110 }
    group:entry { item = "unprimed_45colt_casing", count = { 100, 100 }, probability = 92 }
    group:entry { item = "unprimed_762R_casing", count = { 50, 50 }, probability = 6 }
    group:entry { item = "unprimed_270win_casing", count = { 50, 50 }, probability = 114 }
    group:entry { item = "unprimed_10mm_casing", count = { 100, 100 }, probability = 50 }
    group:entry { item = "unprimed_300_casing", count = { 50, 50 }, probability = 99 }
    group:entry { item = "unprimed_357sig_casing", count = { 250, 250 }, probability = 21 }
    group:entry { item = "unprimed_38super_casing", count = { 100, 100 }, probability = 39 }
    group:entry { item = "unprimed_454_casing", count = { 100, 100 }, probability = 38 }
    group:entry { item = "unprimed_4570_casing", count = { 50, 50 }, probability = 38 }
    group:entry { item = "unprimed_500_casing", count = { 50, 50 }, probability = 35 }
    group:entry { item = "unprimed_50ae_casing", count = { 50, 50 }, probability = 38 }
    group:entry { item = "unprimed_50beowulf_casing", count = { 100, 100 }, probability = 12 }
    group:entry { item = "unprimed_450_casing", count = { 50, 50 }, probability = 28 }
    group:entry { item = "unprimed_338lapua_casing", count = { 25, 25 }, probability = 56 }
    group:entry { item = "unprimed_303_casing", count = { 50, 50 }, probability = 7 }
    group:entry { item = "unprimed_77arisaka_casing", count = { 50, 50 }, probability = 4 }
    group:entry { item = "unprimed_57mm_casing", count = { 500, 500 }, probability = 12 }
    group:entry { item = "unprimed_762_25_casing", count = { 100, 100 }, probability = 6 }
    group:entry { item = "unprimed_9x18mm_casing", count = { 100, 100 }, probability = 3 }
    group:entry { item = "unprimed_300blk_casing", count = { 250, 250 }, probability = 160 }
    group:entry { item = "unprimed_30carbine_casing", count = { 100, 100 }, probability = 29 }
    group:entry { item = "unprimed_460sw_casing", count = { 50, 50 }, probability = 25 }
    group:entry { item = "unprimed_3030_casing", count = { 50, 50 }, probability = 43 }
    content.add(group)
end

do
    -- casings list for shooting range.
    local group = content.ItemGroup { id = "casings", kind = "distribution" }
    group:item("9mm_casing", 209)
    group:item("22_casing", 204)
    group:item("223_casing", 125)
    group:item("45_casing", 49)
    group:item("380_casing", 48)
    group:item("40_casing", 40)
    group:item("762_casing", 34)
    group:item("357mag_casing", 34)
    group:item("shot_hull", 26)
    group:item("308_casing", 15)
    group:item("762_51_casing", 10)
    group:item("38_casing", 19)
    group:item("44_casing", 15)
    group:item("3006_casing", 8)
    group:item("45colt_casing", 8)
    group:item("3030_casing", 5)
    group:item("762R_casing", 4)
    group:item("270win_casing", 3)
    group:item("410shot_hull", 3)
    group:item("10mm_casing", 1)
    group:item("32_casing", 1)
    group:item("357sig_casing", 1)
    group:item("38super_casing", 1)
    group:item("454_casing", 1)
    group:item("4570_casing", 1)
    group:item("500_casing", 1)
    group:item("50ae_casing", 1)
    group:item("545_casing", 1)
    group:item("50beowulf_casing", 1)
    group:item("450_casing", 1)
    group:item("303_casing", 1)
    group:item("77arisaka_casing", 1)
    group:item("57mm_casing", 1)
    group:item("762_25_casing", 1)
    group:item("9x18mm_casing", 1)
    group:item("300blk_casing", 1)
    group:item("30carbine_casing", 1)
    group:item("460sw_casing", 1)
    content.add(group)
end
