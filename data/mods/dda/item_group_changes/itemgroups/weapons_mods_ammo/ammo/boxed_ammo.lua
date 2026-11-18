local content = require("ccb").content

do
    local group = content.ItemGroup { id = "boxed_9mm", kind = "distribution" }
    group:group("boxed_9mm_20", 51)
    group:group("boxed_9mm_50", 49)
    group:group("boxed_9mm_100", 16)
    group:group("boxed_9mm_250", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_22lr", kind = "distribution" }
    group:group("boxed_22lr_50", 55)
    group:group("boxed_22lr_100", 150)
    group:group("boxed_22lr_500", 62)
    group:group("boxed_22lr_1000", 16)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_223", kind = "distribution" }
    group:group("boxed_223_20", 44)
    group:group("boxed_223_50", 14)
    group:group("boxed_223_200", 10)
    group:group("boxed_223_500", 9)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_223_500",
        kind = "distribution",
        container = "box_small",
        container_variant = "223_ammo_box_500",
    }
    group:entry { item = "223", charges = { 500, 500 }, probability = 10 }
    group:entry { item = "556", charges = { 500, 500 }, probability = 9 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_45", kind = "distribution" }
    group:group("boxed_45_20", 17)
    group:group("boxed_45_50", 13)
    group:group("boxed_45_200", 3)
    group:group("boxed_45_500", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_380", kind = "distribution" }
    group:group("boxed_380_20", 62)
    group:group("boxed_380_50", 24)
    group:group("boxed_380_500", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_40", kind = "distribution" }
    group:group("boxed_40_20", 10)
    group:group("boxed_40_50", 37)
    group:group("boxed_40_500", 4)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_762", kind = "distribution" }
    group:group("boxed_762_20", 91)
    group:group("boxed_762_50", 17)
    group:group("boxed_762_500", 11)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_357", kind = "distribution" }
    group:group("boxed_357_20", 91)
    group:group("boxed_357_50", 18)
    group:group("boxed_357_200", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_12", kind = "distribution" }
    group:group("boxed_12_5", 14)
    group:group("boxed_12_10", 12)
    group:group("boxed_12_25", 50)
    group:group("boxed_12_100", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_308", kind = "distribution" }
    group:group("boxed_308_20", 59)
    group:group("boxed_308_100", 2)
    group:group("boxed_308_200", 6)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_38", kind = "distribution" }
    group:group("boxed_38_20", 126)
    group:group("boxed_38_50", 77)
    group:group("boxed_38_200", 10)
    group:group("boxed_38_500", 13)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_44", kind = "distribution" }
    group:group("boxed_44_20", 189)
    group:group("boxed_44_100", 8)
    group:group("boxed_44_200", 13)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_3006", kind = "distribution" }
    group:group("boxed_3006_20", 51)
    group:group("boxed_3006_100", 3)
    group:group("boxed_3006_200", 4)
    content.add(group)
end

do
    -- Due to lack of factory JHP and FMJ .45 Colt in game, they're not weighted
    local group = content.ItemGroup { id = "boxed_45colt", kind = "distribution" }
    group:group("boxed_45colt_20", 3)
    group:group("boxed_45colt_50", 4)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_762R", kind = "distribution" }
    group:group("boxed_762R_20", 9)
    group:group("boxed_762R_200", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_270", kind = "distribution" }
    group:group("boxed_270_20", 214)
    group:group("boxed_270_100", 5)
    group:group("boxed_270_200", 13)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_20", kind = "distribution" }
    group:group("boxed_20_5", 214)
    group:group("boxed_20_10", 5)
    group:group("boxed_20_25", 13)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_10mm", kind = "distribution" }
    group:group("boxed_10mm_20", 174)
    group:group("boxed_10mm_50", 51)
    group:group("boxed_10mm_500", 11)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_300", kind = "distribution" }
    group:group("boxed_300_20", 15)
    group:group("boxed_300_200", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_303", kind = "distribution", container = "303_ammo_box_20" }
    group:entry { item = "303_sp", charges = { 20, 20 }, probability = 152 }
    group:entry { item = "303_fmjbt", charges = { 20, 20 }, probability = 50 }
    group:entry { item = "303_bthp", charges = { 20, 20 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_30carbine", kind = "distribution", container = "30carbine_ammo_box_50" }
    group:entry { item = "30carbine_jsp", charges = { 50, 50 }, probability = 21 }
    group:entry { item = "30carbine", charges = { 50, 50 }, probability = 79 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_32", kind = "distribution", container = "32_ammo_box_50" }
    group:entry { item = "32_acp", charges = { 50, 50 }, probability = 4 }
    group:entry { item = "32_acp_jhp", charges = { 50, 50 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_338", kind = "distribution", container = "338_ammo_box_20" }
    group:entry { item = "338lapua_hpbt", charges = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_357sig", kind = "distribution", container = "357sig_ammo_box_50" }
    group:entry { item = "357sig_jhp", charges = { 50, 50 }, probability = 13 }
    group:entry { item = "357sig_fmj", charges = { 50, 50 }, probability = 71 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_38super", kind = "distribution", container = "38super_ammo_box_50" }
    group:entry { item = "38_super", charges = { 50, 50 }, probability = 11 }
    group:entry { item = "38super_fmj", charges = { 50, 50 }, probability = 26 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_450", kind = "distribution", container = "450_ammo_box_20" }
    group:entry { item = "450_ftx", charges = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_454", kind = "distribution", container = "454_ammo_box_20" }
    group:entry { item = "454_Casull", charges = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_4570", kind = "distribution", container = "4570_ammo_box_20" }
    group:entry { item = "4570_sp", charges = { 20, 20 }, probability = 27 }
    group:entry { item = "4570_low", charges = { 20, 20 }, probability = 6 }
    group:entry { item = "4570_pen", charges = { 20, 20 }, probability = 6 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_500",
        kind = "distribution",
        container = "4570_ammo_box_20",
        container_variant = "500_ammo_box_20",
    }
    group:entry { item = "500_Magnum", charges = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_545",
        kind = "distribution",
        container = "44_ammo_box_20",
        container_variant = "545_ammo_box_20",
    }
    group:entry { item = "545", charges = { 20, 20 }, probability = 38 }
    group:entry { item = "545_ap", charges = { 20, 20 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_57", kind = "distribution", container = "57_ammo_box_50" }
    group:entry { item = "57mm_lf", charges = { 50, 50 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_762x25",
        kind = "distribution",
        container = "357sig_ammo_box_50",
        container_variant = "762x25_ammo_box_50",
    }
    group:entry { item = "762_25", charges = { 50, 50 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_300blk",
        kind = "distribution",
        container = "223_ammo_box_20",
        container_variant = "300blk_ammo_box_20",
    }
    group:entry { item = "300blk", charges = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_9x18",
        kind = "distribution",
        container = "45colt_ammo_box_20",
        container_variant = "9x18_ammo_box_50",
    }
    group:entry { item = "9x18mm", charges = { 50, 50 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_50beowulf",
        kind = "distribution",
        container = "45colt_ammo_box_50",
        container_variant = "50beowulf_ammo_box_20",
    }
    group:entry { item = "50beowulf_xtp", charges = { 20, 20 }, probability = 11 }
    group:entry { item = "50beowulf_penetrator", charges = { 20, 20 }, probability = 2 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_50AE",
        kind = "distribution",
        container = "57_ammo_box_50",
        container_variant = "50AE_ammo_box_20",
    }
    group:entry { item = "50ae_fmj", charges = { 20, 20 }, probability = 5 }
    group:entry { item = "50ae_jhp", charges = { 20, 20 }, probability = 21 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_77x58",
        kind = "distribution",
        container = "45_ammo_box_50",
        container_variant = "77x58_ammo_box_20",
    }
    group:entry { item = "77mm_arisaka_jsp", charges = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_458",
        kind = "distribution",
        container = "300_ammo_box_20",
        container_variant = "458_ammo_box_20",
    }
    group:entry { item = "458wm", charges = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_3030", kind = "distribution", container = "3030_ammo_box_20" }
    group:entry { item = "3030", charges = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_9mm_used", kind = "distribution" }
    group:group("boxed_9mm_20_used", 51)
    group:group("boxed_9mm_50_used", 49)
    group:group("boxed_9mm_100_used", 16)
    group:group("boxed_9mm_250_used", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_22lr_used", kind = "distribution" }
    group:group("boxed_22lr_50_used", 55)
    group:group("boxed_22lr_100_used", 150)
    group:group("boxed_22lr_500_used", 62)
    group:group("boxed_22lr_1000_used", 16)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_223_used", kind = "distribution" }
    group:group("boxed_223_20_used", 44)
    group:group("boxed_223_50_used", 14)
    group:group("boxed_223_200_used", 10)
    group:group("boxed_223_500_used", 9)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_45_used", kind = "distribution" }
    group:group("boxed_45_20_used", 17)
    group:group("boxed_45_50_used", 13)
    group:group("boxed_45_200_used", 3)
    group:group("boxed_45_500_used", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_380_used", kind = "distribution" }
    group:group("boxed_380_20_used", 62)
    group:group("boxed_380_50_used", 24)
    group:group("boxed_380_500_used", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_40_used", kind = "distribution" }
    group:group("boxed_40_20_used", 10)
    group:group("boxed_40_50_used", 37)
    group:group("boxed_40_500_used", 4)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_762_used", kind = "distribution" }
    group:group("boxed_762_20_used", 91)
    group:group("boxed_762_50_used", 17)
    group:group("boxed_762_500_used", 11)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_357_used", kind = "distribution" }
    group:group("boxed_357_20_used", 91)
    group:group("boxed_357_50_used", 18)
    group:group("boxed_357_200_used", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_12_used", kind = "distribution" }
    group:group("boxed_12_5_used", 14)
    group:group("boxed_12_10_used", 12)
    group:group("boxed_12_25_used", 50)
    group:group("boxed_12_100_used", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_308_used", kind = "distribution" }
    group:group("boxed_308_20_used", 59)
    group:group("boxed_308_100_used", 2)
    group:group("boxed_308_200_used", 6)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_38_used", kind = "distribution" }
    group:group("boxed_38_20_used", 126)
    group:group("boxed_38_50_used", 77)
    group:group("boxed_38_200_used", 10)
    group:group("boxed_38_500_used", 13)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_44_used", kind = "distribution" }
    group:group("boxed_44_20_used", 189)
    group:group("boxed_44_100_used", 8)
    group:group("boxed_44_200_used", 13)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_3006_used", kind = "distribution" }
    group:group("boxed_3006_20_used", 51)
    group:group("boxed_3006_100_used", 3)
    group:group("boxed_3006_200_used", 4)
    content.add(group)
end

do
    -- Due to lack of factory JHP and FMJ .45 Colt in game, they're not weighted
    local group = content.ItemGroup { id = "boxed_45colt_used", kind = "distribution" }
    group:group("boxed_45colt_20_used", 3)
    group:group("boxed_45colt_50_used", 4)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_762R_used", kind = "distribution" }
    group:group("boxed_762R_20_used", 9)
    group:group("boxed_762R_200_used", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_270_used", kind = "distribution" }
    group:group("boxed_270_20_used", 214)
    group:group("boxed_270_100_used", 5)
    group:group("boxed_270_200_used", 13)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_410_used", kind = "distribution" }
    group:group("boxed_410_5_used", 214)
    group:group("boxed_410_10_used", 5)
    group:group("boxed_410_25_used", 13)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_10mm_used", kind = "distribution" }
    group:group("boxed_10mm_20_used", 174)
    group:group("boxed_10mm_50_used", 51)
    group:group("boxed_10mm_500_used", 11)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_300_used", kind = "distribution" }
    group:group("boxed_300_20_used", 15)
    group:group("boxed_300_200_used", 2)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_303_used",
        kind = "distribution",
        container = "303_ammo_box_20",
        overflow = "spill",
    }
    group:entry { item = "303_sp", count = { 10, 30 }, charges = { 1, 1 }, probability = 152 }
    group:entry { item = "303_fmjbt", count = { 10, 30 }, charges = { 1, 1 }, probability = 50 }
    group:entry { item = "303_bthp", count = { 10, 30 }, charges = { 1, 1 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_30carbine_used",
        kind = "distribution",
        container = "30carbine_ammo_box_50",
        overflow = "spill",
    }
    group:entry { item = "30carbine_jsp", count = { 25, 75 }, charges = { 1, 1 }, probability = 21 }
    group:entry { item = "30carbine", count = { 25, 75 }, charges = { 1, 1 }, probability = 79 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_32_used",
        kind = "distribution",
        container = "32_ammo_box_50",
        overflow = "spill",
    }
    group:entry { item = "32_acp", count = { 25, 75 }, charges = { 1, 1 }, probability = 4 }
    group:entry { item = "32_acp_jhp", count = { 25, 75 }, charges = { 1, 1 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_338_used",
        kind = "distribution",
        container = "338_ammo_box_20",
        overflow = "spill",
    }
    group:entry { item = "338lapua_hpbt", count = { 10, 30 }, charges = { 1, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_357sig_used",
        kind = "distribution",
        container = "357sig_ammo_box_50",
        overflow = "spill",
    }
    group:entry { item = "357sig_jhp", count = { 25, 75 }, charges = { 1, 1 }, probability = 13 }
    group:entry { item = "357sig_fmj", count = { 25, 75 }, charges = { 1, 1 }, probability = 71 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_38super_used",
        kind = "distribution",
        container = "38super_ammo_box_50",
        overflow = "spill",
    }
    group:entry { item = "38_super", count = { 25, 75 }, charges = { 1, 1 }, probability = 11 }
    group:entry { item = "38super_fmj", count = { 25, 75 }, charges = { 1, 1 }, probability = 26 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_450_used",
        kind = "distribution",
        container = "450_ammo_box_20",
        overflow = "spill",
    }
    group:entry { item = "450_ftx", count = { 10, 30 }, charges = { 1, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_454_used",
        kind = "distribution",
        container = "454_ammo_box_20",
        overflow = "spill",
    }
    group:entry { item = "454_Casull", count = { 10, 30 }, charges = { 1, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_4570_used",
        kind = "distribution",
        container = "4570_ammo_box_20",
        overflow = "spill",
    }
    group:entry { item = "4570_sp", count = { 10, 30 }, charges = { 1, 1 }, probability = 27 }
    group:entry { item = "4570_low", count = { 10, 30 }, charges = { 1, 1 }, probability = 6 }
    group:entry { item = "4570_pen", count = { 10, 30 }, charges = { 1, 1 }, probability = 6 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_500_used",
        kind = "distribution",
        container = "4570_ammo_box_20",
        container_variant = "500_ammo_box_20",
        overflow = "spill",
    }
    group:entry { item = "500_Magnum", count = { 10, 30 }, charges = { 1, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_545_used",
        kind = "distribution",
        container = "44_ammo_box_20",
        container_variant = "545_ammo_box_20",
        overflow = "spill",
    }
    group:entry { item = "545", count = { 10, 30 }, charges = { 1, 1 }, probability = 38 }
    group:entry { item = "545_ap", count = { 10, 30 }, charges = { 1, 1 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_57_used",
        kind = "distribution",
        container = "57_ammo_box_50",
        overflow = "spill",
    }
    group:entry { item = "57mm_lf", count = { 25, 75 }, charges = { 1, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_762x25_used",
        kind = "distribution",
        container = "357sig_ammo_box_50",
        container_variant = "762x25_ammo_box_50",
        overflow = "spill",
    }
    group:entry { item = "762_25", count = { 25, 75 }, charges = { 1, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_300blk_used",
        kind = "distribution",
        container = "223_ammo_box_20",
        container_variant = "300blk_ammo_box_20",
        overflow = "spill",
    }
    group:entry { item = "300blk", count = { 10, 30 }, charges = { 1, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_9x18_used",
        kind = "distribution",
        container = "45colt_ammo_box_20",
        container_variant = "9x18_ammo_box_50",
        overflow = "spill",
    }
    group:entry { item = "9x18mm", count = { 25, 75 }, charges = { 1, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_50beowulf_used",
        kind = "distribution",
        container = "45colt_ammo_box_50",
        container_variant = "50beowulf_ammo_box_20",
        overflow = "spill",
    }
    group:entry { item = "50beowulf_xtp", count = { 10, 30 }, charges = { 1, 1 }, probability = 11 }
    group:entry { item = "50beowulf_penetrator", count = { 10, 30 }, charges = { 1, 1 }, probability = 2 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_50AE_used",
        kind = "distribution",
        container = "57_ammo_box_50",
        container_variant = "50AE_ammo_box_20",
        overflow = "spill",
    }
    group:entry { item = "50ae_fmj", count = { 10, 30 }, charges = { 1, 1 }, probability = 5 }
    group:entry { item = "50ae_jhp", count = { 10, 30 }, charges = { 1, 1 }, probability = 21 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_77x58_used",
        kind = "distribution",
        container = "45_ammo_box_50",
        container_variant = "77x58_ammo_box_20",
        overflow = "spill",
    }
    group:entry { item = "77mm_arisaka_jsp", count = { 10, 30 }, charges = { 1, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_458_used",
        kind = "distribution",
        container = "300_ammo_box_20",
        container_variant = "458_ammo_box_20",
        overflow = "spill",
    }
    group:entry { item = "458wm", count = { 10, 30 }, charges = { 1, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_3030_used",
        kind = "distribution",
        container = "3030_ammo_box_20",
        overflow = "spill",
    }
    group:entry { item = "3030", count = { 10, 30 }, charges = { 1, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_9mm_looted", kind = "distribution" }
    group:group("boxed_9mm_20_looted", 51)
    group:group("boxed_9mm_50_looted", 49)
    group:group("boxed_9mm_100_looted", 16)
    group:group("boxed_9mm_250_looted", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_22lr_looted", kind = "distribution" }
    group:group("boxed_22lr_50_looted", 55)
    group:group("boxed_22lr_100_looted", 150)
    group:group("boxed_22lr_500_looted", 62)
    group:group("boxed_22lr_1000_looted", 16)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_223_looted", kind = "distribution" }
    group:group("boxed_223_20_looted", 44)
    group:group("boxed_223_50_looted", 14)
    group:group("boxed_223_200_looted", 10)
    group:group("boxed_223_500_looted", 9)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_45_looted", kind = "distribution" }
    group:group("boxed_45_20_looted", 17)
    group:group("boxed_45_50_looted", 13)
    group:group("boxed_45_200_looted", 3)
    group:group("boxed_45_500_looted", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_380_looted", kind = "distribution" }
    group:group("boxed_380_20_looted", 62)
    group:group("boxed_380_50_looted", 24)
    group:group("boxed_380_500_looted", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_40_looted", kind = "distribution" }
    group:group("boxed_40_20_looted", 10)
    group:group("boxed_40_50_looted", 37)
    group:group("boxed_40_500_looted", 4)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_762_looted", kind = "distribution" }
    group:group("boxed_762_20_looted", 91)
    group:group("boxed_762_50_looted", 17)
    group:group("boxed_762_500_looted", 11)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_357_looted", kind = "distribution" }
    group:group("boxed_357_20_looted", 91)
    group:group("boxed_357_50_looted", 18)
    group:group("boxed_357_200_looted", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_12_looted", kind = "distribution" }
    group:group("boxed_12_5_looted", 14)
    group:group("boxed_12_10_looted", 12)
    group:group("boxed_12_25_looted", 50)
    group:group("boxed_12_100_looted", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_308_looted", kind = "distribution" }
    group:group("boxed_308_20_looted", 59)
    group:group("boxed_308_100_looted", 2)
    group:group("boxed_308_200_looted", 6)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_38_looted", kind = "distribution" }
    group:group("boxed_38_20_looted", 126)
    group:group("boxed_38_50_looted", 77)
    group:group("boxed_38_200_looted", 10)
    group:group("boxed_38_500_looted", 13)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_44_looted", kind = "distribution" }
    group:group("boxed_44_20_looted", 189)
    group:group("boxed_44_100_looted", 8)
    group:group("boxed_44_200_looted", 13)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_3006_looted", kind = "distribution" }
    group:group("boxed_3006_20_looted", 51)
    group:group("boxed_3006_100_looted", 3)
    group:group("boxed_3006_200_looted", 4)
    content.add(group)
end

do
    -- Due to lack of factory JHP and FMJ .45 Colt in game, they're not weighted
    local group = content.ItemGroup { id = "boxed_45colt_looted", kind = "distribution" }
    group:group("boxed_45colt_20_looted", 3)
    group:group("boxed_45colt_50_looted", 4)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_762R_looted", kind = "distribution" }
    group:group("boxed_762R_20_looted", 9)
    group:group("boxed_762R_200_looted", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_270_looted", kind = "distribution" }
    group:group("boxed_270_20_looted", 214)
    group:group("boxed_270_100_looted", 5)
    group:group("boxed_270_200_looted", 13)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_410_looted", kind = "distribution" }
    group:group("boxed_410_5_looted", 214)
    group:group("boxed_410_10_looted", 5)
    group:group("boxed_410_25_looted", 13)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_10mm_looted", kind = "distribution" }
    group:group("boxed_10mm_20_looted", 174)
    group:group("boxed_10mm_50_looted", 51)
    group:group("boxed_10mm_500_looted", 11)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_300_looted", kind = "distribution" }
    group:group("boxed_300_20_looted", 15)
    group:group("boxed_300_200_looted", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_303_looted", kind = "distribution", container = "303_ammo_box_20" }
    group:entry { item = "303_sp", charges = { 0, 4 }, probability = 152 }
    group:entry { item = "303_fmjbt", charges = { 0, 4 }, probability = 50 }
    group:entry { item = "303_bthp", charges = { 0, 4 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_30carbine_looted", kind = "distribution", container = "30carbine_ammo_box_50" }
    group:entry { item = "30carbine_jsp", charges = { 0, 10 }, probability = 21 }
    group:entry { item = "30carbine", charges = { 0, 10 }, probability = 79 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_32_looted", kind = "distribution", container = "32_ammo_box_50" }
    group:entry { item = "32_acp", charges = { 0, 10 }, probability = 4 }
    group:entry { item = "32_acp_jhp", charges = { 0, 10 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_338_looted", kind = "distribution", container = "338_ammo_box_20" }
    group:entry { item = "338lapua_hpbt", charges = { 0, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_357sig_looted", kind = "distribution", container = "357sig_ammo_box_50" }
    group:entry { item = "357sig_jhp", charges = { 0, 10 }, probability = 13 }
    group:entry { item = "357sig_fmj", charges = { 0, 10 }, probability = 71 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_38super_looted", kind = "distribution", container = "38super_ammo_box_50" }
    group:entry { item = "38_super", charges = { 0, 10 }, probability = 11 }
    group:entry { item = "38super_fmj", charges = { 0, 10 }, probability = 26 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_450_looted", kind = "distribution", container = "450_ammo_box_20" }
    group:entry { item = "450_ftx", charges = { 0, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_454_looted", kind = "distribution", container = "454_ammo_box_20" }
    group:entry { item = "454_Casull", charges = { 0, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_4570_looted", kind = "distribution", container = "4570_ammo_box_20" }
    group:entry { item = "4570_sp", charges = { 0, 4 }, probability = 27 }
    group:entry { item = "4570_low", charges = { 0, 4 }, probability = 6 }
    group:entry { item = "4570_pen", charges = { 0, 4 }, probability = 6 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_500_looted",
        kind = "distribution",
        container = "4570_ammo_box_20",
        container_variant = "500_ammo_box_20",
    }
    group:entry { item = "500_Magnum", charges = { 0, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_545_looted",
        kind = "distribution",
        container = "44_ammo_box_20",
        container_variant = "545_ammo_box_20",
    }
    group:entry { item = "545", charges = { 0, 4 }, probability = 38 }
    group:entry { item = "545_ap", charges = { 0, 4 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_57_looted", kind = "distribution", container = "57_ammo_box_50" }
    group:entry { item = "57mm_lf", charges = { 0, 10 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_762x25_looted",
        kind = "distribution",
        container = "357sig_ammo_box_50",
        container_variant = "762x25_ammo_box_50",
    }
    group:entry { item = "762_25", charges = { 0, 10 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_300blk_looted",
        kind = "distribution",
        container = "223_ammo_box_20",
        container_variant = "300blk_ammo_box_20",
    }
    group:entry { item = "300blk", charges = { 0, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_9x18_looted",
        kind = "distribution",
        container = "45colt_ammo_box_20",
        container_variant = "9x18_ammo_box_50",
    }
    group:entry { item = "9x18mm", charges = { 0, 10 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_50beowulf_looted",
        kind = "distribution",
        container = "45colt_ammo_box_50",
        container_variant = "50beowulf_ammo_box_20",
    }
    group:entry { item = "50beowulf_xtp", charges = { 0, 4 }, probability = 11 }
    group:entry { item = "50beowulf_penetrator", charges = { 0, 4 }, probability = 2 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_50AE_looted",
        kind = "distribution",
        container = "57_ammo_box_50",
        container_variant = "50AE_ammo_box_20",
    }
    group:entry { item = "50ae_fmj", charges = { 0, 4 }, probability = 5 }
    group:entry { item = "50ae_jhp", charges = { 0, 4 }, probability = 21 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_77x58_looted",
        kind = "distribution",
        container = "45_ammo_box_50",
        container_variant = "77x58_ammo_box_20",
    }
    group:entry { item = "77mm_arisaka_jsp", charges = { 0, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_458_looted",
        kind = "distribution",
        container = "300_ammo_box_20",
        container_variant = "458_ammo_box_20",
    }
    group:entry { item = "458wm", charges = { 0, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_3030_looted", kind = "distribution", container = "3030_ammo_box_20" }
    group:entry { item = "3030", charges = { 0, 4 } }
    content.add(group)
end
