local content = require("ccb").content

do
    local group = content.ItemGroup { id = "boxed_9mm_20", kind = "distribution", container = "9mm_ammo_box_20" }
    group:entry { item = "9mmfmj", charges = { 20, 20 }, probability = 1 }
    group:entry { item = "9mm", charges = { 20, 20 }, probability = 351 }
    group:entry { item = "9mmP", charges = { 20, 20 }, probability = 60 }
    group:entry { item = "9mmP2", charges = { 20, 20 }, probability = 5 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_9mm_50", kind = "distribution", container = "9mm_ammo_box_50" }
    group:entry { item = "9mmfmj", charges = { 50, 50 }, probability = 168 }
    group:entry { item = "9mm", charges = { 50, 50 }, probability = 182 }
    group:entry { item = "9mmP", charges = { 50, 50 }, probability = 37 }
    group:entry { item = "9mmP2", charges = { 50, 50 }, probability = 12 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_9mm_100", kind = "distribution", container = "9mm_ammo_box_100" }
    group:entry { item = "9mmfmj", charges = { 100, 100 }, probability = 99 }
    group:entry { item = "9mm", charges = { 100, 100 }, probability = 27 }
    group:entry { item = "9mmP", charges = { 100, 100 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_9mm_250", kind = "distribution", container = "9mm_ammo_box_250" }
    group:entry { item = "9mmfmj", charges = { 250, 250 }, probability = 55 }
    group:entry { item = "9mm", charges = { 250, 250 }, probability = 11 }
    group:entry { item = "9mmP", charges = { 250, 250 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "22lr_tray_full", kind = "distribution", container = "22lr_ammo_tray" }
    group:entry { item = "22_lr", charges = { 50, 50 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_22lr_50",
        kind = "distribution",
        container = "9mm_ammo_box_20",
        container_variant = "22lr_ammo_box_50",
    }
    group:group("22lr_tray_full")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_22lr_100", kind = "distribution", container = "22lr_ammo_box_100" }
    group:entry { group = "22lr_tray_full", count = { 2, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_22lr_500", kind = "distribution", container = "22lr_ammo_box_500" }
    group:entry { group = "22lr_tray_full", count = { 10, 10 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_22lr_1000", kind = "distribution", container = "22lr_ammo_box_1000" }
    group:entry { group = "boxed_22lr_500", count = { 2, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_223_20", kind = "distribution", container = "223_ammo_box_20" }
    group:entry { item = "223", charges = { 20, 20 }, probability = 4 }
    group:entry { item = "556", charges = { 20, 20 }, probability = 3 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_223_50", kind = "distribution", container = "223_ammo_box_50" }
    group:entry { item = "223", charges = { 50, 50 }, probability = 11 }
    group:entry { item = "556", charges = { 50, 50 }, probability = 8 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_223_200", kind = "distribution", container = "223_ammo_box_200" }
    group:entry { item = "223", charges = { 200, 200 }, probability = 42 }
    group:entry { item = "556", charges = { 200, 200 }, probability = 25 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_45_20", kind = "distribution", container = "45_ammo_box_20" }
    group:entry { item = "45_jhp", charges = { 20, 20 }, probability = 34 }
    group:entry { item = "45_super", charges = { 20, 20 }, probability = 13 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_45_50", kind = "distribution", container = "45_ammo_box_50" }
    group:entry { item = "45_jhp", charges = { 50, 50 }, probability = 35 }
    group:entry { item = "45_super", charges = { 50, 50 }, probability = 5 }
    group:entry { item = "45_acp", charges = { 50, 50 }, probability = 42 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_45_200", kind = "distribution", container = "45_ammo_box_200" }
    group:entry { item = "45_jhp", charges = { 200, 200 }, probability = 18 }
    group:entry { item = "45_super", charges = { 200, 200 }, probability = 13 }
    group:entry { item = "45_acp", charges = { 200, 200 }, probability = 44 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_45_500", kind = "distribution", container = "45_ammo_box_500" }
    group:entry { item = "45_jhp", charges = { 500, 500 }, probability = 27 }
    group:entry { item = "45_super", charges = { 500, 500 }, probability = 8 }
    group:entry { item = "45_acp", charges = { 500, 500 }, probability = 14 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_380_20", kind = "distribution", container = "380_ammo_box_20" }
    group:entry { item = "380_JHP", charges = { 20, 20 }, probability = 92 }
    group:entry { item = "380_p", charges = { 20, 20 }, probability = 17 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_380_50",
        kind = "distribution",
        container = "22lr_ammo_box_100",
        container_variant = "380_ammo_box_50",
    }
    group:entry { item = "380_JHP", charges = { 50, 50 }, probability = 37 }
    group:entry { item = "380_p", charges = { 50, 50 }, probability = 1 }
    group:entry { item = "380_FMJ", charges = { 50, 50 }, probability = 41 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_380_500", kind = "distribution", container = "380_ammo_box_500" }
    group:entry { item = "380_JHP", charges = { 500, 500 }, probability = 47 }
    group:entry { item = "380_p", charges = { 500, 500 }, probability = 5 }
    group:entry { item = "380_FMJ", charges = { 500, 500 }, probability = 78 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_40_20", kind = "distribution", container = "40_ammo_box_20" }
    group:entry { item = "40sw", charges = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_40_50", kind = "distribution", container = "40_ammo_box_50" }
    group:entry { item = "40sw", charges = { 50, 50 }, probability = 5 }
    group:entry { item = "40fmj", charges = { 50, 50 }, probability = 8 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_40_500", kind = "distribution", container = "40_ammo_box_500" }
    group:entry { item = "40sw", charges = { 500, 500 } }
    group:entry { item = "40fmj", charges = { 500, 500 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_762_20", kind = "distribution", container = "762_ammo_box_20" }
    group:entry { item = "762_m87", charges = { 20, 20 }, probability = 91 }
    group:entry { item = "762_jhp", charges = { 20, 20 }, probability = 11 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_762_50", kind = "distribution", container = "762_ammo_box_50" }
    group:entry { item = "762_m87", charges = { 50, 50 }, probability = 85 }
    group:entry { item = "762_jhp", charges = { 50, 50 }, probability = 23 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_762_500", kind = "distribution", container = "762_ammo_box_500" }
    group:entry { item = "762_m87", charges = { 500, 500 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_357_20", kind = "distribution", container = "357_ammo_box_20" }
    group:entry { item = "357mag_jhp", charges = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_357_50", kind = "distribution", container = "357_ammo_box_50" }
    group:entry { item = "357mag_jhp", charges = { 50, 50 }, probability = 73 }
    group:entry { item = "357mag_fmj", charges = { 50, 50 }, probability = 57 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_357_200", kind = "distribution", container = "357_ammo_box_200" }
    group:entry { item = "357mag_jhp", charges = { 200, 200 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_12_5", kind = "distribution", container = "12_ammo_box_5" }
    group:entry { item = "shot_slug", charges = { 5, 5 }, probability = 24 }
    group:entry { item = "shot_00", charges = { 5, 5 }, probability = 25 }
    group:entry { item = "shot_bird", charges = { 5, 5 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_12_10", kind = "distribution", container = "12_ammo_box_10" }
    group:entry { item = "shot_slug", charges = { 10, 10 }, probability = 7 }
    group:entry { item = "shot_00", charges = { 10, 10 }, probability = 15 }
    group:entry { item = "shot_bird", charges = { 10, 10 }, probability = 3 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_12_25", kind = "distribution", container = "12_ammo_box_25" }
    group:entry { item = "shot_slug", charges = { 25, 25 }, probability = 1 }
    group:entry { item = "shot_00", charges = { 25, 25 }, probability = 3 }
    group:entry { item = "shot_bird", charges = { 25, 25 }, probability = 48 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_12_100", kind = "distribution", container = "12_ammo_box_100" }
    group:entry { item = "shot_slug", charges = { 100, 100 }, probability = 1 }
    group:entry { item = "shot_00", charges = { 100, 100 }, probability = 4 }
    group:entry { item = "shot_bird", charges = { 100, 100 }, probability = 13 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_308_20", kind = "distribution", container = "308_ammo_box_20" }
    group:entry { item = "308", charges = { 20, 20 }, probability = 83 }
    group:entry { item = "762_51", charges = { 20, 20 }, probability = 24 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_308_100", kind = "distribution", container = "308_ammo_box_100" }
    group:entry { item = "308", charges = { 100, 100 }, probability = 7 }
    group:entry { item = "762_51", charges = { 100, 100 }, probability = 2 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_308_200", kind = "distribution", container = "ammunition_can_30" }
    group:entry { item = "308", charges = { 200, 200 }, probability = 22 }
    group:entry { item = "762_51", charges = { 200, 200 }, probability = 7 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_38_20", kind = "distribution", container = "38_ammo_box_20" }
    group:entry { item = "38_special", charges = { 20, 20 }, probability = 19 }
    group:entry { item = "38_special_p", charges = { 20, 20 }, probability = 47 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_38_50", kind = "distribution", container = "38_ammo_box_50" }
    group:entry { item = "38_special", charges = { 50, 50 }, probability = 61 }
    group:entry { item = "38_special_p", charges = { 50, 50 }, probability = 11 }
    group:entry { item = "38_fmj", charges = { 50, 50 }, probability = 26 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_38_200", kind = "distribution", container = "38_ammo_box_200" }
    group:entry { item = "38_special", charges = { 200, 200 }, probability = 11 }
    group:entry { item = "38_special_p", charges = { 200, 200 }, probability = 12 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_38_500", kind = "distribution", container = "38_ammo_box_500" }
    group:entry { item = "38_special", charges = { 500, 500 }, probability = 17 }
    group:entry { item = "38_special_p", charges = { 500, 500 }, probability = 6 }
    group:entry { item = "38_fmj", charges = { 500, 500 }, probability = 2 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_44_20", kind = "distribution", container = "44_ammo_box_20" }
    group:entry { item = "44magnum", charges = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_44_100", kind = "distribution", container = "44_ammo_box_100" }
    group:entry { item = "44magnum", charges = { 100, 100 }, probability = 12 }
    group:entry { item = "44fmj", charges = { 100, 100 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_44_200", kind = "distribution", container = "44_ammo_box_200" }
    group:entry { item = "44magnum", charges = { 200, 200 }, probability = 17 }
    group:entry { item = "44fmj", charges = { 200, 200 }, probability = 3 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_3006_20", kind = "distribution", container = "3006_ammo_box_20" }
    group:entry { item = "3006", charges = { 20, 20 }, probability = 1 }
    group:entry { item = "3006_jsp", charges = { 20, 20 }, probability = 20 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_3006_100", kind = "distribution", container = "3006_ammo_box_100" }
    group:entry { item = "3006", charges = { 100, 100 }, probability = 1 }
    group:entry { item = "3006_jsp", charges = { 100, 100 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_3006_200", kind = "distribution", container = "3006_ammo_box_200" }
    group:entry { item = "3006", charges = { 200, 200 } }
    group:entry { item = "3006_jsp", charges = { 200, 200 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_45colt_20", kind = "distribution", container = "45colt_ammo_box_20" }
    group:entry { item = "45colt_jhp", charges = { 20, 20 } }
    group:entry { item = "45colt_cowboy", charges = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_45colt_50", kind = "distribution", container = "45colt_ammo_box_50" }
    group:entry { item = "45colt_jhp", charges = { 50, 50 } }
    group:entry { item = "45colt_cowboy", charges = { 50, 50 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_762R_20",
        kind = "distribution",
        container = "3006_ammo_box_20",
        container_variant = "762R_ammo_box_20",
    }
    group:entry { item = "762_54R", charges = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_762R_200",
        kind = "distribution",
        container = "762_ammo_box_500",
        container_variant = "762R_ammo_box_200",
    }
    group:entry { group = "boxed_762R_20", count = { 5, 5 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_270_20",
        kind = "distribution",
        container = "3006_ammo_box_20",
        container_variant = "270_ammo_box_20",
    }
    group:entry { item = "270win_jsp", charges = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_270_100",
        kind = "distribution",
        container = "3006_ammo_box_100",
        container_variant = "270_ammo_box_100",
    }
    group:entry { item = "270win_jsp", charges = { 100, 100 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_270_200",
        kind = "distribution",
        container = "3006_ammo_box_200",
        container_variant = "270_ammo_box_200",
    }
    group:entry { item = "270win_jsp", charges = { 200, 200 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_20_5",
        kind = "distribution",
        container = "12_ammo_box_5",
        container_variant = "20_ammo_box_5",
    }
    group:entry { item = "20shot_slug", charges = { 5, 5 }, probability = 21 }
    group:entry { item = "20shot_buck", charges = { 5, 5 }, probability = 6 }
    group:entry { item = "20shot_bird", charges = { 5, 5 }, probability = 8 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_20_10",
        kind = "distribution",
        container = "12_ammo_box_10",
        container_variant = "20_ammo_box_10",
    }
    group:entry { item = "20shot_slug", charges = { 10, 10 }, probability = 3 }
    group:entry { item = "20shot_buck", charges = { 10, 10 }, probability = 5 }
    group:entry { item = "20shot_bird", charges = { 10, 10 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_20_25",
        kind = "distribution",
        container = "12_ammo_box_25",
        container_variant = "20_ammo_box_25",
    }
    group:entry { item = "20shot_slug", charges = { 25, 25 }, probability = 17 }
    group:entry { item = "20shot_buck", charges = { 25, 25 }, probability = 4 }
    group:entry { item = "20shot_bird", charges = { 25, 25 }, probability = 35 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_410_5", kind = "distribution", container = "410_ammo_box_5" }
    group:entry { item = "410shot_slug", charges = { 5, 5 }, probability = 21 }
    group:entry { item = "410shot_000", charges = { 5, 5 }, probability = 6 }
    group:entry { item = "410shot_bird", charges = { 5, 5 }, probability = 8 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_410_10",
        kind = "distribution",
        container = "44_ammo_box_20",
        container_variant = "410_ammo_box_10",
    }
    group:entry { item = "410shot_slug", charges = { 10, 10 }, probability = 3 }
    group:entry { item = "410shot_000", charges = { 10, 10 }, probability = 5 }
    group:entry { item = "410shot_bird", charges = { 10, 10 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_410_25", kind = "distribution", container = "410_ammo_box_25" }
    group:entry { item = "410shot_slug", charges = { 25, 25 }, probability = 17 }
    group:entry { item = "410shot_000", charges = { 25, 25 }, probability = 4 }
    group:entry { item = "410shot_bird", charges = { 25, 25 }, probability = 35 }
    content.add(group)
end

do
    -- +P 10mm doesn't seem to actually exist as a factory spec, so it's excluded from these groups
    local group = content.ItemGroup { id = "boxed_10mm_20", kind = "distribution", container = "10mm_ammo_box_20" }
    group:entry { item = "10mm_fmj", charges = { 20, 20 }, probability = 1 }
    group:entry { item = "10mm_jhp", charges = { 20, 20 }, probability = 6 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_10mm_50", kind = "distribution", container = "10mm_ammo_box_50" }
    group:entry { item = "10mm_fmj", charges = { 50, 50 }, probability = 17 }
    group:entry { item = "10mm_jhp", charges = { 50, 50 }, probability = 22 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_10mm_500", kind = "distribution", container = "10mm_ammo_box_500" }
    group:entry { item = "10mm_fmj", charges = { 500, 500 }, probability = 7 }
    group:entry { item = "10mm_jhp", charges = { 500, 500 }, probability = 12 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_300_20", kind = "distribution", container = "300_ammo_box_20" }
    group:entry { item = "300_winmag", charges = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_300_200", kind = "distribution", container = "ammunition_can_30" }
    group:entry { group = "boxed_300_20", count = { 10, 10 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_460", kind = "distribution", container = "460_ammo_box_20" }
    group:entry { item = "460sw", charges = { 20, 20 }, probability = 7 }
    group:entry { item = "460sw_jhp", charges = { 20, 20 }, probability = 8 }
    content.add(group)
end

do
    -- Charges are set to 1 to avoid spawning all the rounds outside of the box, instead of some inside and some outside
    local group = content.ItemGroup {
        id = "boxed_9mm_20_used",
        kind = "distribution",
        container = "9mm_ammo_box_20",
        overflow = "spill",
    }
    group:entry { item = "9mmfmj", count = { 10, 30 }, charges = { 1, 1 }, probability = 1 }
    group:entry { item = "9mm", count = { 10, 30 }, charges = { 1, 1 }, probability = 351 }
    group:entry { item = "9mmP", count = { 10, 30 }, charges = { 1, 1 }, probability = 60 }
    group:entry { item = "9mmP2", count = { 10, 30 }, charges = { 1, 1 }, probability = 5 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_9mm_50_used",
        kind = "distribution",
        container = "9mm_ammo_box_50",
        overflow = "spill",
    }
    group:entry { item = "9mmfmj", count = { 35, 65 }, charges = { 1, 1 }, probability = 168 }
    group:entry { item = "9mm", count = { 35, 65 }, charges = { 1, 1 }, probability = 182 }
    group:entry { item = "9mmP", count = { 35, 65 }, charges = { 1, 1 }, probability = 37 }
    group:entry { item = "9mmP2", count = { 35, 65 }, charges = { 1, 1 }, probability = 12 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_9mm_100_used",
        kind = "distribution",
        container = "9mm_ammo_box_100",
        overflow = "spill",
    }
    group:entry { item = "9mmfmj", count = { 50, 150 }, charges = { 1, 1 }, probability = 99 }
    group:entry { item = "9mm", count = { 50, 150 }, charges = { 1, 1 }, probability = 27 }
    group:entry { item = "9mmP", count = { 50, 150 }, charges = { 1, 1 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_9mm_250_used",
        kind = "distribution",
        container = "9mm_ammo_box_250",
        overflow = "spill",
    }
    group:entry { item = "9mmfmj", count = { 125, 300 }, charges = { 1, 1 }, probability = 55 }
    group:entry { item = "9mm", count = { 125, 300 }, charges = { 1, 1 }, probability = 11 }
    group:entry { item = "9mmP", count = { 125, 300 }, charges = { 1, 1 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "22lr_tray_used",
        kind = "distribution",
        container = "22lr_ammo_tray",
        overflow = "spill",
    }
    group:entry { item = "22_lr", count = { 25, 60 }, charges = { 1, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_22lr_50_used",
        kind = "distribution",
        container = "9mm_ammo_box_20",
        container_variant = "22lr_ammo_box_50",
        overflow = "spill",
    }
    group:group("22lr_tray_used")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_22lr_100_used",
        kind = "distribution",
        container = "22lr_ammo_box_100",
        overflow = "spill",
    }
    group:entry { group = "22lr_tray_used", count = { 1, 1 } }
    group:entry { group = "22lr_tray_full", count = { 1, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_22lr_500_used",
        kind = "distribution",
        container = "22lr_ammo_box_500",
        overflow = "spill",
    }
    group:entry { group = "22lr_tray_used", count = { 1, 6 } }
    group:entry { group = "22lr_tray_full", count = { 0, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_22lr_1000_used",
        kind = "distribution",
        container = "22lr_ammo_box_1000",
        overflow = "spill",
    }
    group:entry { group = "boxed_22lr_500_used", count = { 1, 1 } }
    group:entry { group = "boxed_22lr_500", count = { 1, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_223_20_used",
        kind = "distribution",
        container = "223_ammo_box_20",
        overflow = "spill",
    }
    group:entry { item = "223", count = { 10, 30 }, charges = { 1, 1 }, probability = 4 }
    group:entry { item = "556", count = { 10, 30 }, charges = { 1, 1 }, probability = 3 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_223_50_used",
        kind = "distribution",
        container = "223_ammo_box_50",
        overflow = "spill",
    }
    group:entry { item = "223", count = { 25, 75 }, charges = { 1, 1 }, probability = 11 }
    group:entry { item = "556", count = { 25, 75 }, charges = { 1, 1 }, probability = 8 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_223_200_used",
        kind = "distribution",
        container = "223_ammo_box_200",
        overflow = "spill",
    }
    group:entry { item = "223", count = { 150, 250 }, charges = { 1, 1 }, probability = 42 }
    group:entry { item = "556", count = { 150, 250 }, charges = { 1, 1 }, probability = 25 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_223_500_used",
        kind = "distribution",
        container = "box_small",
        container_variant = "223_ammo_box_500",
        overflow = "spill",
    }
    group:entry { item = "223", count = { 200, 600 }, charges = { 1, 1 }, probability = 10 }
    group:entry { item = "556", count = { 200, 600 }, charges = { 1, 1 }, probability = 9 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_45_20_used",
        kind = "distribution",
        container = "45_ammo_box_20",
        overflow = "spill",
    }
    group:entry { item = "45_jhp", count = { 10, 30 }, charges = { 1, 1 }, probability = 34 }
    group:entry { item = "45_super", count = { 10, 30 }, charges = { 1, 1 }, probability = 13 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_45_50_used",
        kind = "distribution",
        container = "45_ammo_box_50",
        overflow = "spill",
    }
    group:entry { item = "45_jhp", count = { 35, 65 }, charges = { 1, 1 }, probability = 35 }
    group:entry { item = "45_super", count = { 35, 65 }, charges = { 1, 1 }, probability = 5 }
    group:entry { item = "45_acp", count = { 35, 65 }, charges = { 1, 1 }, probability = 42 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_45_200_used",
        kind = "distribution",
        container = "45_ammo_box_200",
        overflow = "spill",
    }
    group:entry { item = "45_jhp", count = { 150, 250 }, charges = { 1, 1 }, probability = 18 }
    group:entry { item = "45_super", count = { 150, 250 }, charges = { 1, 1 }, probability = 13 }
    group:entry { item = "45_acp", count = { 150, 250 }, charges = { 1, 1 }, probability = 44 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_45_500_used",
        kind = "distribution",
        container = "45_ammo_box_500",
        overflow = "spill",
    }
    group:entry { item = "45_jhp", count = { 200, 600 }, charges = { 1, 1 }, probability = 27 }
    group:entry { item = "45_super", count = { 200, 600 }, charges = { 1, 1 }, probability = 8 }
    group:entry { item = "45_acp", count = { 200, 600 }, charges = { 1, 1 }, probability = 14 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_380_20_used",
        kind = "distribution",
        container = "380_ammo_box_20",
        overflow = "spill",
    }
    group:entry { item = "380_JHP", count = { 10, 30 }, charges = { 1, 1 }, probability = 92 }
    group:entry { item = "380_p", count = { 10, 30 }, charges = { 1, 1 }, probability = 17 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_380_50_used",
        kind = "distribution",
        container = "22lr_ammo_box_100",
        container_variant = "380_ammo_box_50",
        overflow = "spill",
    }
    group:entry { item = "380_JHP", count = { 35, 65 }, charges = { 1, 1 }, probability = 37 }
    group:entry { item = "380_p", count = { 35, 65 }, charges = { 1, 1 }, probability = 1 }
    group:entry { item = "380_FMJ", count = { 35, 65 }, charges = { 1, 1 }, probability = 41 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_380_500_used",
        kind = "distribution",
        container = "380_ammo_box_500",
        overflow = "spill",
    }
    group:entry { item = "380_JHP", count = { 200, 600 }, charges = { 1, 1 }, probability = 47 }
    group:entry { item = "380_p", count = { 200, 600 }, charges = { 1, 1 }, probability = 5 }
    group:entry { item = "380_FMJ", count = { 200, 600 }, charges = { 1, 1 }, probability = 78 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_40_20_used",
        kind = "distribution",
        container = "40_ammo_box_20",
        overflow = "spill",
    }
    group:entry { item = "40sw", count = { 10, 30 }, charges = { 1, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_40_50_used",
        kind = "distribution",
        container = "40_ammo_box_50",
        overflow = "spill",
    }
    group:entry { item = "40sw", count = { 35, 65 }, charges = { 1, 1 }, probability = 5 }
    group:entry { item = "40fmj", count = { 35, 65 }, charges = { 1, 1 }, probability = 8 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_40_500_used",
        kind = "distribution",
        container = "40_ammo_box_500",
        overflow = "spill",
    }
    group:entry { item = "40sw", count = { 200, 600 }, charges = { 1, 1 } }
    group:entry { item = "40fmj", count = { 200, 600 }, charges = { 1, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_762_20_used",
        kind = "distribution",
        container = "762_ammo_box_20",
        overflow = "spill",
    }
    group:entry { item = "762_m87", count = { 10, 30 }, charges = { 1, 1 }, probability = 91 }
    group:entry { item = "762_jhp", count = { 10, 30 }, charges = { 1, 1 }, probability = 11 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_762_50_used",
        kind = "distribution",
        container = "762_ammo_box_50",
        overflow = "spill",
    }
    group:entry { item = "762_m87", count = { 35, 65 }, charges = { 1, 1 }, probability = 85 }
    group:entry { item = "762_jhp", count = { 35, 65 }, charges = { 1, 1 }, probability = 23 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_762_500_used",
        kind = "distribution",
        container = "762_ammo_box_500",
        overflow = "spill",
    }
    group:entry { item = "762_m87", count = { 200, 600 }, charges = { 1, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_357_20_used",
        kind = "distribution",
        container = "357_ammo_box_20",
        overflow = "spill",
    }
    group:entry { item = "357mag_jhp", count = { 10, 30 }, charges = { 1, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_357_50_used",
        kind = "distribution",
        container = "357_ammo_box_50",
        overflow = "spill",
    }
    group:entry { item = "357mag_jhp", count = { 35, 65 }, charges = { 1, 1 }, probability = 73 }
    group:entry { item = "357mag_fmj", count = { 35, 65 }, charges = { 1, 1 }, probability = 57 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_357_200_used",
        kind = "distribution",
        container = "357_ammo_box_200",
        overflow = "spill",
    }
    group:entry { item = "357mag_jhp", count = { 150, 250 }, charges = { 1, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_12_5_used",
        kind = "distribution",
        container = "12_ammo_box_5",
        overflow = "spill",
    }
    group:entry { item = "shot_slug", count = { 3, 7 }, charges = { 1, 1 }, probability = 24 }
    group:entry { item = "shot_00", count = { 3, 7 }, charges = { 1, 1 }, probability = 25 }
    group:entry { item = "shot_bird", count = { 3, 7 }, charges = { 1, 1 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_12_10_used",
        kind = "distribution",
        container = "12_ammo_box_10",
        overflow = "spill",
    }
    group:entry { item = "shot_slug", count = { 5, 15 }, charges = { 1, 1 }, probability = 7 }
    group:entry { item = "shot_00", count = { 5, 15 }, charges = { 1, 1 }, probability = 15 }
    group:entry { item = "shot_bird", count = { 5, 15 }, charges = { 1, 1 }, probability = 3 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_12_25_used",
        kind = "distribution",
        container = "12_ammo_box_25",
        overflow = "spill",
    }
    group:entry { item = "shot_slug", count = { 15, 30 }, charges = { 1, 1 }, probability = 1 }
    group:entry { item = "shot_00", count = { 15, 30 }, charges = { 1, 1 }, probability = 3 }
    group:entry { item = "shot_bird", count = { 15, 30 }, charges = { 1, 1 }, probability = 48 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_12_100_used",
        kind = "distribution",
        container = "12_ammo_box_100",
        overflow = "spill",
    }
    group:entry { item = "shot_slug", count = { 50, 150 }, charges = { 1, 1 }, probability = 1 }
    group:entry { item = "shot_00", count = { 50, 150 }, charges = { 1, 1 }, probability = 4 }
    group:entry { item = "shot_bird", count = { 50, 150 }, charges = { 1, 1 }, probability = 13 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_308_20_used",
        kind = "distribution",
        container = "308_ammo_box_20",
        overflow = "spill",
    }
    group:entry { item = "308", count = { 10, 30 }, charges = { 1, 1 }, probability = 83 }
    group:entry { item = "762_51", count = { 10, 30 }, charges = { 1, 1 }, probability = 24 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_308_100_used",
        kind = "distribution",
        container = "308_ammo_box_100",
        overflow = "spill",
    }
    group:entry { item = "308", count = { 50, 150 }, charges = { 1, 1 }, probability = 7 }
    group:entry { item = "762_51", count = { 50, 150 }, charges = { 1, 1 }, probability = 2 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_308_200_used",
        kind = "distribution",
        container = "ammunition_can_30",
        overflow = "spill",
    }
    group:entry { item = "308", count = { 150, 250 }, charges = { 1, 1 }, probability = 22 }
    group:entry { item = "762_51", count = { 150, 250 }, charges = { 1, 1 }, probability = 7 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_38_20_used",
        kind = "distribution",
        container = "38_ammo_box_20",
        overflow = "spill",
    }
    group:entry { item = "38_special", count = { 10, 30 }, charges = { 1, 1 }, probability = 19 }
    group:entry { item = "38_special_p", count = { 10, 30 }, charges = { 1, 1 }, probability = 47 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_38_50_used",
        kind = "distribution",
        container = "38_ammo_box_50",
        overflow = "spill",
    }
    group:entry { item = "38_special", count = { 35, 65 }, charges = { 1, 1 }, probability = 61 }
    group:entry { item = "38_special_p", count = { 35, 65 }, charges = { 1, 1 }, probability = 11 }
    group:entry { item = "38_fmj", count = { 35, 65 }, charges = { 1, 1 }, probability = 26 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_38_200_used",
        kind = "distribution",
        container = "38_ammo_box_200",
        overflow = "spill",
    }
    group:entry { item = "38_special", count = { 150, 250 }, charges = { 1, 1 }, probability = 11 }
    group:entry { item = "38_special_p", count = { 150, 250 }, charges = { 1, 1 }, probability = 12 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_38_500_used",
        kind = "distribution",
        container = "38_ammo_box_500",
        overflow = "spill",
    }
    group:entry { item = "38_special", count = { 150, 250 }, charges = { 1, 1 }, probability = 17 }
    group:entry { item = "38_special_p", count = { 150, 250 }, charges = { 1, 1 }, probability = 6 }
    group:entry { item = "38_fmj", count = { 150, 250 }, charges = { 1, 1 }, probability = 2 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_44_20_used",
        kind = "distribution",
        container = "44_ammo_box_20",
        overflow = "spill",
    }
    group:entry { item = "44magnum", count = { 10, 30 }, charges = { 1, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_44_100_used",
        kind = "distribution",
        container = "44_ammo_box_100",
        overflow = "spill",
    }
    group:entry { item = "44magnum", count = { 50, 150 }, charges = { 1, 1 }, probability = 12 }
    group:entry { item = "44fmj", count = { 50, 150 }, charges = { 1, 1 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_44_200_used",
        kind = "distribution",
        container = "44_ammo_box_200",
        overflow = "spill",
    }
    group:entry { item = "44magnum", count = { 150, 250 }, charges = { 1, 1 }, probability = 17 }
    group:entry { item = "44fmj", count = { 150, 250 }, charges = { 1, 1 }, probability = 3 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_3006_20_used",
        kind = "distribution",
        container = "3006_ammo_box_20",
        overflow = "spill",
    }
    group:entry { item = "3006", count = { 10, 30 }, charges = { 1, 1 }, probability = 1 }
    group:entry { item = "3006_jsp", count = { 10, 30 }, charges = { 1, 1 }, probability = 20 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_3006_100_used",
        kind = "distribution",
        container = "3006_ammo_box_100",
        overflow = "spill",
    }
    group:entry { item = "3006", count = { 50, 150 }, charges = { 1, 1 }, probability = 1 }
    group:entry { item = "3006_jsp", count = { 50, 150 }, charges = { 1, 1 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_3006_200_used",
        kind = "distribution",
        container = "3006_ammo_box_200",
        overflow = "spill",
    }
    group:entry { item = "3006", count = { 150, 250 }, charges = { 1, 1 } }
    group:entry { item = "3006_jsp", count = { 150, 250 }, charges = { 1, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_45colt_20_used",
        kind = "distribution",
        container = "45colt_ammo_box_20",
        overflow = "spill",
    }
    group:entry { item = "45colt_jhp", count = { 15, 25 }, charges = { 1, 1 } }
    group:entry { item = "45colt_cowboy", count = { 15, 25 }, charges = { 1, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_45colt_50_used",
        kind = "distribution",
        container = "45colt_ammo_box_50",
        overflow = "spill",
    }
    group:entry { item = "45colt_jhp", count = { 35, 65 }, charges = { 1, 1 } }
    group:entry { item = "45colt_cowboy", count = { 35, 65 }, charges = { 1, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_762R_20_used",
        kind = "distribution",
        container = "3006_ammo_box_20",
        container_variant = "762R_ammo_box_20",
        overflow = "spill",
    }
    group:entry { item = "762_54R", count = { 10, 30 }, charges = { 1, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_762R_200_used",
        kind = "distribution",
        container = "762_ammo_box_500",
        container_variant = "762R_ammo_box_200",
        overflow = "spill",
    }
    group:entry { group = "boxed_762R_20_used", count = { 1, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_270_20_used",
        kind = "distribution",
        container = "3006_ammo_box_20",
        container_variant = "270_ammo_box_20",
        overflow = "spill",
    }
    group:entry { item = "270win_jsp", count = { 15, 30 }, charges = { 1, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_270_100_used",
        kind = "distribution",
        container = "3006_ammo_box_100",
        container_variant = "270_ammo_box_100",
        overflow = "spill",
    }
    group:entry { item = "270win_jsp", count = { 50, 150 }, charges = { 1, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_270_200_used",
        kind = "distribution",
        container = "3006_ammo_box_200",
        container_variant = "270_ammo_box_200",
        overflow = "spill",
    }
    group:entry { item = "270win_jsp", count = { 150, 250 }, charges = { 1, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_410_5_used",
        kind = "distribution",
        container = "410_ammo_box_5",
        overflow = "spill",
    }
    group:entry { item = "410shot_slug", count = { 3, 7 }, charges = { 1, 1 }, probability = 21 }
    group:entry { item = "410shot_000", count = { 3, 7 }, charges = { 1, 1 }, probability = 6 }
    group:entry { item = "410shot_bird", count = { 3, 7 }, charges = { 1, 1 }, probability = 8 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_410_10_used",
        kind = "distribution",
        container = "44_ammo_box_20",
        container_variant = "410_ammo_box_10",
        overflow = "spill",
    }
    group:entry { item = "410shot_slug", count = { 5, 15 }, charges = { 1, 1 }, probability = 3 }
    group:entry { item = "410shot_000", count = { 5, 15 }, charges = { 1, 1 }, probability = 5 }
    group:entry { item = "410shot_bird", count = { 5, 15 }, charges = { 1, 1 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_410_25_used",
        kind = "distribution",
        container = "410_ammo_box_25",
        overflow = "spill",
    }
    group:entry { item = "410shot_slug", count = { 15, 35 }, charges = { 1, 1 }, probability = 17 }
    group:entry { item = "410shot_000", count = { 15, 35 }, charges = { 1, 1 }, probability = 4 }
    group:entry { item = "410shot_bird", count = { 15, 35 }, charges = { 1, 1 }, probability = 35 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_20_used", kind = "distribution" }
    group:group("boxed_20_5_used", 214)
    group:group("boxed_20_10_used", 5)
    group:group("boxed_20_25_used", 13)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_20_5_used",
        kind = "distribution",
        container = "12_ammo_box_5",
        container_variant = "20_ammo_box_5",
        overflow = "spill",
    }
    group:entry { item = "20shot_slug", count = { 3, 7 }, charges = { 1, 1 }, probability = 21 }
    group:entry { item = "20shot_buck", count = { 3, 7 }, charges = { 1, 1 }, probability = 6 }
    group:entry { item = "20shot_bird", count = { 3, 7 }, charges = { 1, 1 }, probability = 8 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_20_10_used",
        kind = "distribution",
        container = "12_ammo_box_10",
        container_variant = "20_ammo_box_10",
        overflow = "spill",
    }
    group:entry { item = "20shot_slug", count = { 5, 15 }, charges = { 1, 1 }, probability = 3 }
    group:entry { item = "20shot_buck", count = { 5, 15 }, charges = { 1, 1 }, probability = 5 }
    group:entry { item = "20shot_bird", count = { 5, 15 }, charges = { 1, 1 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_20_25_used",
        kind = "distribution",
        container = "12_ammo_box_25",
        container_variant = "20_ammo_box_25",
        overflow = "spill",
    }
    group:entry { item = "20shot_slug", count = { 15, 35 }, charges = { 1, 1 }, probability = 17 }
    group:entry { item = "20shot_buck", count = { 15, 35 }, charges = { 1, 1 }, probability = 4 }
    group:entry { item = "20shot_bird", count = { 15, 35 }, charges = { 1, 1 }, probability = 35 }
    content.add(group)
end

do
    -- +P 10mm doesn't seem to actually exist as a factory spec, so it's excluded from these groups
    local group = content.ItemGroup {
        id = "boxed_10mm_20_used",
        kind = "distribution",
        container = "10mm_ammo_box_20",
        overflow = "spill",
    }
    group:entry { item = "10mm_fmj", count = { 10, 30 }, charges = { 1, 1 }, probability = 1 }
    group:entry { item = "10mm_jhp", count = { 10, 30 }, charges = { 1, 1 }, probability = 6 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_10mm_50_used",
        kind = "distribution",
        container = "10mm_ammo_box_50",
        overflow = "spill",
    }
    group:entry { item = "10mm_fmj", count = { 25, 75 }, charges = { 1, 1 }, probability = 17 }
    group:entry { item = "10mm_jhp", count = { 25, 75 }, charges = { 1, 1 }, probability = 22 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_10mm_500_used",
        kind = "distribution",
        container = "10mm_ammo_box_500",
        overflow = "spill",
    }
    group:entry { item = "10mm_fmj", count = { 200, 600 }, charges = { 1, 1 }, probability = 7 }
    group:entry { item = "10mm_jhp", count = { 200, 600 }, charges = { 1, 1 }, probability = 12 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_300_20_used",
        kind = "distribution",
        container = "300_ammo_box_20",
        overflow = "spill",
    }
    group:entry { item = "300_winmag", count = { 10, 30 }, charges = { 1, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_300_200_used", kind = "distribution", container = "ammunition_can_30" }
    group:entry { group = "boxed_300_20", count = { 0, 1 } }
    group:entry { group = "boxed_300_20_used", count = { 0, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_460_used",
        kind = "distribution",
        container = "460_ammo_box_20",
        overflow = "spill",
    }
    group:entry { item = "460sw", count = { 10, 30 }, charges = { 1, 1 }, probability = 7 }
    group:entry { item = "460sw_jhp", count = { 10, 30 }, charges = { 1, 1 }, probability = 8 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_9mm_20_looted", kind = "distribution", container = "9mm_ammo_box_20" }
    group:entry { item = "9mmfmj", charges = { 0, 4 }, probability = 1 }
    group:entry { item = "9mm", charges = { 0, 4 }, probability = 351 }
    group:entry { item = "9mmP", charges = { 0, 4 }, probability = 60 }
    group:entry { item = "9mmP2", charges = { 0, 4 }, probability = 5 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_9mm_50_looted", kind = "distribution", container = "9mm_ammo_box_50" }
    group:entry { item = "9mmfmj", charges = { 0, 10 }, probability = 168 }
    group:entry { item = "9mm", charges = { 0, 10 }, probability = 182 }
    group:entry { item = "9mmP", charges = { 0, 10 }, probability = 37 }
    group:entry { item = "9mmP2", charges = { 0, 10 }, probability = 12 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_9mm_100_looted", kind = "distribution", container = "9mm_ammo_box_100" }
    group:entry { item = "9mmfmj", charges = { 0, 10 }, probability = 99 }
    group:entry { item = "9mm", charges = { 0, 10 }, probability = 27 }
    group:entry { item = "9mmP", charges = { 0, 10 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_9mm_250_looted", kind = "distribution", container = "9mm_ammo_box_250" }
    group:entry { item = "9mmfmj", charges = { 0, 25 }, probability = 55 }
    group:entry { item = "9mm", charges = { 0, 25 }, probability = 11 }
    group:entry { item = "9mmP", charges = { 0, 25 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "22lr_tray_looted", kind = "distribution", container = "22lr_ammo_tray" }
    group:entry { item = "22_lr", charges = { 0, 24 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_22lr_50_looted",
        kind = "distribution",
        container = "9mm_ammo_box_20",
        container_variant = "22lr_ammo_box_50",
    }
    group:group("22lr_tray_looted", 80)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_22lr_100_looted", kind = "distribution", container = "22lr_ammo_box_100" }
    group:entry { group = "22lr_tray_looted", count = { 0, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_22lr_500_looted", kind = "distribution", container = "22lr_ammo_box_500" }
    group:entry { group = "22lr_tray_looted", count = { 0, 2 } }
    group:entry { group = "22lr_tray_full", count = { 0, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_22lr_1000_looted", kind = "distribution", container = "22lr_ammo_box_1000" }
    group:entry { group = "boxed_22lr_500_looted", count = { 0, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_223_20_looted", kind = "distribution", container = "223_ammo_box_20" }
    group:entry { item = "223", charges = { 0, 4 }, probability = 4 }
    group:entry { item = "556", charges = { 0, 4 }, probability = 3 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_223_50_looted", kind = "distribution", container = "223_ammo_box_50" }
    group:entry { item = "223", charges = { 0, 10 }, probability = 11 }
    group:entry { item = "556", charges = { 0, 10 }, probability = 8 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_223_200_looted", kind = "distribution", container = "223_ammo_box_200" }
    group:entry { item = "223", charges = { 0, 10 }, probability = 42 }
    group:entry { item = "556", charges = { 0, 10 }, probability = 25 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_223_500_looted",
        kind = "distribution",
        container = "box_small",
        container_variant = "223_ammo_box_500",
    }
    group:entry { item = "223", charges = { 0, 15 }, probability = 10 }
    group:entry { item = "556", charges = { 0, 15 }, probability = 9 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_45_20_looted", kind = "distribution", container = "45_ammo_box_20" }
    group:entry { item = "45_jhp", charges = { 0, 4 }, probability = 34 }
    group:entry { item = "45_super", charges = { 0, 4 }, probability = 13 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_45_50_looted", kind = "distribution", container = "45_ammo_box_50" }
    group:entry { item = "45_jhp", charges = { 0, 10 }, probability = 35 }
    group:entry { item = "45_super", charges = { 0, 10 }, probability = 5 }
    group:entry { item = "45_acp", charges = { 0, 10 }, probability = 42 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_45_200_looted", kind = "distribution", container = "45_ammo_box_200" }
    group:entry { item = "45_jhp", charges = { 0, 15 }, probability = 18 }
    group:entry { item = "45_super", charges = { 0, 15 }, probability = 13 }
    group:entry { item = "45_acp", charges = { 0, 15 }, probability = 44 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_45_500_looted", kind = "distribution", container = "45_ammo_box_500" }
    group:entry { item = "45_jhp", charges = { 0, 20 }, probability = 27 }
    group:entry { item = "45_super", charges = { 0, 20 }, probability = 8 }
    group:entry { item = "45_acp", charges = { 0, 20 }, probability = 14 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_380_20_looted", kind = "distribution", container = "380_ammo_box_20" }
    group:entry { item = "380_JHP", charges = { 0, 4 }, probability = 92 }
    group:entry { item = "380_p", charges = { 0, 4 }, probability = 17 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_380_50_looted",
        kind = "distribution",
        container = "22lr_ammo_box_100",
        container_variant = "380_ammo_box_50",
    }
    group:entry { item = "380_JHP", charges = { 0, 10 }, probability = 37 }
    group:entry { item = "380_p", charges = { 0, 10 }, probability = 1 }
    group:entry { item = "380_FMJ", charges = { 0, 10 }, probability = 41 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_380_500_looted", kind = "distribution", container = "380_ammo_box_500" }
    group:entry { item = "380_JHP", charges = { 0, 25 }, probability = 47 }
    group:entry { item = "380_p", charges = { 0, 25 }, probability = 5 }
    group:entry { item = "380_FMJ", charges = { 0, 25 }, probability = 78 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_40_20_looted", kind = "distribution", container = "40_ammo_box_20" }
    group:entry { item = "40sw", charges = { 0, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_40_50_looted", kind = "distribution", container = "40_ammo_box_50" }
    group:entry { item = "40sw", charges = { 0, 10 }, probability = 5 }
    group:entry { item = "40fmj", charges = { 0, 10 }, probability = 8 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_40_500_looted", kind = "distribution", container = "40_ammo_box_500" }
    group:entry { item = "40sw", charges = { 0, 25 } }
    group:entry { item = "40fmj", charges = { 0, 25 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_762_20_looted", kind = "distribution", container = "762_ammo_box_20" }
    group:entry { item = "762_m87", charges = { 0, 4 }, probability = 91 }
    group:entry { item = "762_jhp", charges = { 0, 4 }, probability = 11 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_762_50_looted", kind = "distribution", container = "762_ammo_box_50" }
    group:entry { item = "762_m87", charges = { 0, 10 }, probability = 85 }
    group:entry { item = "762_jhp", charges = { 0, 10 }, probability = 23 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_762_500_looted", kind = "distribution", container = "762_ammo_box_500" }
    group:entry { item = "762_m87", charges = { 0, 25 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_357_20_looted", kind = "distribution", container = "357_ammo_box_20" }
    group:entry { item = "357mag_jhp", charges = { 0, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_357_50_looted", kind = "distribution", container = "357_ammo_box_50" }
    group:entry { item = "357mag_jhp", charges = { 0, 10 }, probability = 73 }
    group:entry { item = "357mag_fmj", charges = { 0, 10 }, probability = 57 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_357_200_looted", kind = "distribution", container = "357_ammo_box_200" }
    group:entry { item = "357mag_jhp", charges = { 0, 25 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_12_5_looted", kind = "distribution", container = "12_ammo_box_5" }
    group:entry { item = "shot_slug", charges = { 0, 2 }, probability = 24 }
    group:entry { item = "shot_00", charges = { 0, 2 }, probability = 25 }
    group:entry { item = "shot_bird", charges = { 0, 2 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_12_10_looted", kind = "distribution", container = "12_ammo_box_10" }
    group:entry { item = "shot_slug", charges = { 0, 4 }, probability = 7 }
    group:entry { item = "shot_00", charges = { 0, 4 }, probability = 15 }
    group:entry { item = "shot_bird", charges = { 0, 4 }, probability = 3 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_12_25_looted", kind = "distribution", container = "12_ammo_box_25" }
    group:entry { item = "shot_slug", charges = { 0, 6 }, probability = 1 }
    group:entry { item = "shot_00", charges = { 0, 6 }, probability = 3 }
    group:entry { item = "shot_bird", charges = { 0, 6 }, probability = 48 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_12_100_looted", kind = "distribution", container = "12_ammo_box_100" }
    group:entry { item = "shot_slug", charges = { 0, 10 }, probability = 1 }
    group:entry { item = "shot_00", charges = { 0, 10 }, probability = 4 }
    group:entry { item = "shot_bird", charges = { 0, 10 }, probability = 13 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_308_20_looted", kind = "distribution", container = "308_ammo_box_20" }
    group:entry { item = "308", charges = { 0, 4 }, probability = 83 }
    group:entry { item = "762_51", charges = { 0, 4 }, probability = 24 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_308_100_looted", kind = "distribution", container = "308_ammo_box_100" }
    group:entry { item = "308", charges = { 0, 10 }, probability = 7 }
    group:entry { item = "762_51", charges = { 0, 10 }, probability = 2 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_308_200_looted", kind = "distribution", container = "ammunition_can_30" }
    group:entry { item = "308", charges = { 0, 20 }, probability = 22 }
    group:entry { item = "762_51", charges = { 0, 20 }, probability = 7 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_38_20_looted", kind = "distribution", container = "38_ammo_box_20" }
    group:entry { item = "38_special", charges = { 0, 4 }, probability = 19 }
    group:entry { item = "38_special_p", charges = { 0, 4 }, probability = 47 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_38_50_looted", kind = "distribution", container = "38_ammo_box_50" }
    group:entry { item = "38_special", charges = { 0, 10 }, probability = 61 }
    group:entry { item = "38_special_p", charges = { 0, 10 }, probability = 11 }
    group:entry { item = "38_fmj", charges = { 0, 10 }, probability = 26 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_38_200_looted", kind = "distribution", container = "38_ammo_box_200" }
    group:entry { item = "38_special", charges = { 0, 20 }, probability = 11 }
    group:entry { item = "38_special_p", charges = { 0, 20 }, probability = 12 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_38_500_looted", kind = "distribution", container = "38_ammo_box_500" }
    group:entry { item = "38_special", charges = { 0, 25 }, probability = 17 }
    group:entry { item = "38_special_p", charges = { 0, 25 }, probability = 6 }
    group:entry { item = "38_fmj", charges = { 0, 25 }, probability = 2 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_44_20_looted", kind = "distribution", container = "44_ammo_box_20" }
    group:entry { item = "44magnum", charges = { 0, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_44_100_looted", kind = "distribution", container = "44_ammo_box_100" }
    group:entry { item = "44magnum", charges = { 0, 10 }, probability = 12 }
    group:entry { item = "44fmj", charges = { 0, 10 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_44_200_looted", kind = "distribution", container = "44_ammo_box_200" }
    group:entry { item = "44magnum", charges = { 0, 15 }, probability = 17 }
    group:entry { item = "44fmj", charges = { 0, 15 }, probability = 3 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_3006_20_looted", kind = "distribution", container = "3006_ammo_box_20" }
    group:entry { item = "3006", charges = { 0, 4 }, probability = 1 }
    group:entry { item = "3006_jsp", charges = { 0, 4 }, probability = 20 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_3006_100_looted", kind = "distribution", container = "3006_ammo_box_100" }
    group:entry { item = "3006", charges = { 0, 10 }, probability = 1 }
    group:entry { item = "3006_jsp", charges = { 0, 10 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_3006_200_looted", kind = "distribution", container = "3006_ammo_box_200" }
    group:entry { item = "3006", charges = { 0, 10 } }
    group:entry { item = "3006_jsp", charges = { 0, 10 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_45colt_20_looted", kind = "distribution", container = "45colt_ammo_box_20" }
    group:entry { item = "45colt_jhp", charges = { 0, 4 } }
    group:entry { item = "45colt_cowboy", charges = { 0, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_45colt_50_looted", kind = "distribution", container = "45colt_ammo_box_50" }
    group:entry { item = "45colt_jhp", charges = { 0, 10 } }
    group:entry { item = "45colt_cowboy", charges = { 0, 10 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_762R_20_looted",
        kind = "distribution",
        container = "3006_ammo_box_20",
        container_variant = "762R_ammo_box_20",
    }
    group:entry { item = "762_54R", charges = { 0, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_762R_200_looted",
        kind = "distribution",
        container = "762_ammo_box_500",
        container_variant = "762R_ammo_box_200",
    }
    group:entry { group = "boxed_762R_20_looted", count = { 0, 1 } }
    group:entry { item = "762_54R", charges = { 0, 12 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_270_20_looted",
        kind = "distribution",
        container = "3006_ammo_box_20",
        container_variant = "270_ammo_box_20",
    }
    group:entry { item = "270win_jsp", charges = { 0, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_270_100_looted",
        kind = "distribution",
        container = "3006_ammo_box_100",
        container_variant = "270_ammo_box_100",
    }
    group:entry { item = "270win_jsp", charges = { 0, 10 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_270_200_looted",
        kind = "distribution",
        container = "3006_ammo_box_200",
        container_variant = "270_ammo_box_200",
    }
    group:entry { item = "270win_jsp", charges = { 0, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_410_5_looted", kind = "distribution", container = "410_ammo_box_5" }
    group:entry { item = "410shot_slug", charges = { 0, 2 }, probability = 21 }
    group:entry { item = "410shot_000", charges = { 0, 2 }, probability = 6 }
    group:entry { item = "410shot_bird", charges = { 0, 2 }, probability = 8 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_410_10_looted",
        kind = "distribution",
        container = "44_ammo_box_20",
        container_variant = "410_ammo_box_10",
    }
    group:entry { item = "410shot_slug", charges = { 0, 4 }, probability = 3 }
    group:entry { item = "410shot_000", charges = { 0, 4 }, probability = 5 }
    group:entry { item = "410shot_bird", charges = { 0, 4 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_410_25_looted", kind = "distribution", container = "410_ammo_box_25" }
    group:entry { item = "410shot_slug", charges = { 0, 6 }, probability = 17 }
    group:entry { item = "410shot_000", charges = { 0, 6 }, probability = 4 }
    group:entry { item = "410shot_bird", charges = { 0, 6 }, probability = 35 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_20_looted", kind = "distribution" }
    group:group("boxed_20_5_looted", 214)
    group:group("boxed_20_10_looted", 5)
    group:group("boxed_20_25_looted", 13)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_20_5_looted",
        kind = "distribution",
        container = "12_ammo_box_5",
        container_variant = "20_ammo_box_5",
    }
    group:entry { item = "20shot_slug", charges = { 0, 2 }, probability = 21 }
    group:entry { item = "20shot_buck", charges = { 0, 2 }, probability = 6 }
    group:entry { item = "20shot_bird", charges = { 0, 2 }, probability = 8 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_20_10_looted",
        kind = "distribution",
        container = "12_ammo_box_10",
        container_variant = "20_ammo_box_10",
    }
    group:entry { item = "20shot_slug", charges = { 0, 4 }, probability = 3 }
    group:entry { item = "20shot_buck", charges = { 0, 4 }, probability = 5 }
    group:entry { item = "20shot_bird", charges = { 0, 4 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_20_25_looted",
        kind = "distribution",
        container = "12_ammo_box_25",
        container_variant = "20_ammo_box_25",
    }
    group:entry { item = "20shot_slug", charges = { 0, 6 }, probability = 17 }
    group:entry { item = "20shot_buck", charges = { 0, 6 }, probability = 4 }
    group:entry { item = "20shot_bird", charges = { 0, 6 }, probability = 35 }
    content.add(group)
end

do
    -- +P 10mm doesn't seem to actually exist as a factory spec, so it's excluded from these groups
    local group = content.ItemGroup { id = "boxed_10mm_20_looted", kind = "distribution", container = "10mm_ammo_box_20" }
    group:entry { item = "10mm_fmj", charges = { 0, 4 }, probability = 1 }
    group:entry { item = "10mm_jhp", charges = { 0, 4 }, probability = 6 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_10mm_50_looted", kind = "distribution", container = "10mm_ammo_box_50" }
    group:entry { item = "10mm_fmj", charges = { 0, 10 }, probability = 17 }
    group:entry { item = "10mm_jhp", charges = { 0, 10 }, probability = 22 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_10mm_500_looted", kind = "distribution", container = "10mm_ammo_box_500" }
    group:entry { item = "10mm_fmj", charges = { 0, 20 }, probability = 7 }
    group:entry { item = "10mm_jhp", charges = { 0, 20 }, probability = 12 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_300_20_looted", kind = "distribution", container = "300_ammo_box_20" }
    group:entry { item = "300_winmag", charges = { 0, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_300_200_looted", kind = "distribution", container = "ammunition_can_30" }
    group:entry { group = "boxed_300_20_looted", count = { 0, 2 } }
    group:entry { item = "300_winmag", charges = { 0, 10 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_460_looted", kind = "distribution", container = "460_ammo_box_20" }
    group:entry { item = "460sw", charges = { 0, 4 }, probability = 7 }
    group:entry { item = "460sw_jhp", charges = { 0, 4 }, probability = 8 }
    content.add(group)
end
