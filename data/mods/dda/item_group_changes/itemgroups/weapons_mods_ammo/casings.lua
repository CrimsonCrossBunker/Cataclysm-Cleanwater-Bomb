local content = require("ccb").content

do
    local group = content.ItemGroup { id = "ammo_casings", kind = "distribution" }
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
    group:item("300_casing", 1)
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
    group:item("338lapua_casing", 1)
    group:item("303_casing", 1)
    group:item("77arisaka_casing", 1)
    group:item("57mm_casing", 1)
    group:item("458wm_casing", 1)
    group:item("762_25_casing", 1)
    group:item("9x18mm_casing", 1)
    group:item("300blk_casing", 1)
    group:item("30carbine_casing", 1)
    group:item("460sw_casing", 1)
    content.add(group)
end

do
    -- Casings for setpieces implying military shootouts
    local group = content.ItemGroup { id = "ammo_casings_milspec", kind = "distribution" }
    group:entry { item = "9mm_casing", count = { 1, 8 }, probability = 50 }
    group:entry { item = "223_casing", count = { 1, 30 }, probability = 300 }
    group:entry { item = "762_51_casing", count = { 1, 30 }, probability = 25 }
    group:entry { item = "50_casing", count = { 1, 3 }, probability = 25 }
    content.add(group)
end
