local content = require("ccb").content

do
    -- a collection of ammo that would be found with a loaded gun.
    local group = content.ItemGroup { id = "on_hand_9mm", kind = "collection" }
    group:group("boxed_9mm_used")
    group:entry { group = "9mm_loose", count = { 1, 4 } }
    group:group("boxed_9mm", 50)
    group:group("boxed_9mm", 25)
    content.add(group)
end

do
    -- a collection of ammo that would be found with a loaded gun.
    local group = content.ItemGroup { id = "on_hand_10mm", kind = "collection" }
    group:group("boxed_10mm_used")
    group:entry { group = "10mm_loose", count = { 1, 4 } }
    group:group("boxed_10mm", 50)
    group:group("boxed_10mm", 25)
    content.add(group)
end

do
    -- a collection of ammo that would be found with a loaded gun.
    local group = content.ItemGroup { id = "on_hand_32", kind = "collection" }
    group:group("boxed_32_used")
    group:entry { group = "32_loose", count = { 1, 4 } }
    group:group("boxed_32", 50)
    group:group("boxed_32", 25)
    content.add(group)
end

do
    -- a collection of ammo that would be found with a loaded gun.
    local group = content.ItemGroup { id = "on_hand_45colt", kind = "collection" }
    group:group("boxed_45colt_used")
    group:entry { group = "45colt_loose", count = { 1, 4 } }
    group:group("boxed_45colt", 50)
    group:group("boxed_45colt", 25)
    content.add(group)
end

do
    -- a collection of ammo that would be found with a loaded gun.
    local group = content.ItemGroup { id = "on_hand_38super", kind = "collection" }
    group:group("boxed_38super_used")
    group:entry { group = "38super_loose", count = { 1, 4 } }
    group:group("boxed_38super", 50)
    group:group("boxed_38super", 25)
    content.add(group)
end

do
    -- a collection of ammo that would be found with a loaded gun.
    local group = content.ItemGroup { id = "on_hand_57", kind = "collection" }
    group:group("boxed_57_used")
    group:entry { item = "57mm", charges = { 1, 40 } }
    group:group("boxed_57", 50)
    group:group("boxed_57", 25)
    content.add(group)
end

do
    -- a collection of ammo that would be found with a loaded gun.
    local group = content.ItemGroup { id = "on_hand_500", kind = "collection" }
    group:group("boxed_500_used")
    group:entry { item = "500_Magnum", charges = { 1, 5 } }
    group:group("boxed_500", 50)
    group:group("boxed_500", 25)
    content.add(group)
end

do
    -- a collection of ammo that would be found with a loaded gun.
    local group = content.ItemGroup { id = "on_hand_44paper", kind = "distribution" }
    group:entry { item = "44army", charges = { 1, 25 } }
    group:entry { item = "44army", charges = { 27, 50 }, probability = 75 }
    group:entry { item = "44army", charges = { 54, 100 }, probability = 30 }
    content.add(group)
end

do
    -- a collection of ammo that would be found with a loaded gun.
    local group = content.ItemGroup { id = "on_hand_flintlock", kind = "distribution" }
    group:entry { item = "flintlock_ammo", charges = { 1, 30 } }
    group:entry { item = "flintlock_ammo", charges = { 33, 60 }, probability = 75 }
    group:entry { item = "flintlock_ammo", charges = { 66, 120 }, probability = 30 }
    content.add(group)
end

do
    -- a collection of ammo that would be found with a loaded gun.
    local group = content.ItemGroup { id = "on_hand_454", kind = "collection" }
    group:group("boxed_454_used")
    group:entry { item = "454_Casull", charges = { 1, 10 } }
    group:group("boxed_454", 50)
    group:group("boxed_454", 25)
    content.add(group)
end

do
    -- a collection of ammo that would be found with a loaded gun.
    local group = content.ItemGroup { id = "on_hand_460sw", kind = "collection" }
    group:group("boxed_460_used")
    group:entry { item = "460sw", charges = { 1, 10 } }
    group:group("boxed_460", 50)
    group:group("boxed_460", 25)
    content.add(group)
end

do
    -- a collection of ammo that would be found with a loaded gun.
    local group = content.ItemGroup { id = "on_hand_8x40", kind = "distribution" }
    group:entry { item = "8mm_caseless", charges = { 1, 40 } }
    group:entry { item = "8mm_caseless", charges = { 44, 80 }, probability = 75 }
    group:entry { item = "8mm_caseless", charges = { 88, 160 }, probability = 30 }
    group:entry { item = "8mm_caseless", charges = { 1, 40 } }
    group:entry { item = "8mm_caseless", charges = { 44, 80 }, probability = 75 }
    group:entry { item = "8mm_caseless", charges = { 88, 160 }, probability = 30 }
    group:entry { item = "8mm_jhp", charges = { 1, 40 } }
    group:entry { item = "8mm_jhp", charges = { 44, 80 }, probability = 75 }
    group:entry { item = "8mm_jhp", charges = { 88, 160 }, probability = 30 }
    content.add(group)
end

do
    -- a collection of ammo that would be found with a loaded gun.
    local group = content.ItemGroup { id = "on_hand_9x18", kind = "collection" }
    group:group("boxed_9x18_used")
    group:entry { item = "9x18mm", charges = { 1, 40 } }
    group:group("boxed_9x18", 50)
    content.add(group)
end

do
    -- a collection of ammo that would be found with a loaded gun.
    local group = content.ItemGroup { id = "on_hand_45", kind = "collection" }
    group:group("boxed_45_used")
    group:entry { group = "45_loose", count = { 1, 4 } }
    group:group("boxed_45", 50)
    group:group("boxed_45", 25)
    content.add(group)
end

do
    -- a collection of ammo that would be found with a loaded gun.
    local group = content.ItemGroup { id = "on_hand_762", kind = "collection" }
    group:group("boxed_762_used")
    group:entry { group = "762_loose", count = { 1, 4 } }
    group:group("boxed_762", 50)
    group:group("boxed_762", 25)
    content.add(group)
end

do
    -- a collection of ammo that would be found with a loaded gun.
    local group = content.ItemGroup { id = "on_hand_762x25", kind = "collection" }
    group:group("boxed_762x25_used")
    group:entry { item = "762_25", charges = { 1, 10 } }
    group:group("boxed_762x25", 50)
    content.add(group)
end

do
    -- a collection of ammo that would be found with a loaded gun.
    local group = content.ItemGroup { id = "on_hand_40", kind = "collection" }
    group:group("boxed_40_used")
    group:entry { group = "40_loose", count = { 1, 4 } }
    group:group("boxed_40", 50)
    group:group("boxed_40", 25)
    content.add(group)
end

do
    -- a collection of ammo that would be found with a loaded gun.
    local group = content.ItemGroup { id = "on_hand_44", kind = "collection" }
    group:group("boxed_44_used")
    group:entry { group = "44_loose", count = { 1, 4 } }
    group:group("boxed_44", 50)
    group:group("boxed_44", 25)
    content.add(group)
end

do
    -- a collection of ammo that would be found with a loaded gun.
    local group = content.ItemGroup { id = "on_hand_357sig", kind = "collection" }
    group:group("boxed_357sig_used")
    group:entry { group = "357sig_loose", count = { 1, 4 } }
    group:group("boxed_357sig", 50)
    group:group("boxed_357sig", 25)
    content.add(group)
end

do
    -- a collection of ammo that would be found with a loaded gun.
    local group = content.ItemGroup { id = "on_hand_380", kind = "collection" }
    group:group("boxed_380_used")
    group:entry { group = "380_loose", count = { 1, 4 } }
    group:group("boxed_380", 50)
    group:group("boxed_380", 25)
    content.add(group)
end

do
    -- a collection of ammo that would be found with a loaded gun.
    local group = content.ItemGroup { id = "on_hand_38", kind = "collection" }
    group:group("boxed_38_used")
    group:entry { group = "38_loose", count = { 1, 4 } }
    group:group("boxed_38", 50)
    group:group("boxed_38", 25)
    content.add(group)
end

do
    -- a collection of ammo that would be found with a loaded gun.
    local group = content.ItemGroup { id = "on_hand_357", kind = "collection" }
    group:group("boxed_357_used")
    group:entry { group = "357_loose", count = { 1, 4 } }
    group:group("boxed_357", 50)
    group:group("boxed_357", 25)
    content.add(group)
end

do
    -- a mixed collection of 357mag and 38 ammo that would be found with a gun that is compatible with both calibers. favors spawning 357mag ammo but will rarely spawn more 38
    local group = content.ItemGroup { id = "on_hand_357_38mixed", kind = "collection" }
    group:entry {
        distribution = {
            { item = "357mag_fmj", charges = { 1, 40 } },
            { item = "357mag_jhp", charges = { 1, 40 } },
        },
    }
    group:entry {
        distribution = {
            { item = "357mag_fmj", charges = { 4, 40 }, probability = 30 },
            { item = "357mag_jhp", charges = { 4, 40 }, probability = 30 },
            { item = "38_fmj", charges = { 1, 40 }, probability = 15 },
            { item = "38_special", charges = { 1, 40 }, probability = 25 },
        },
        probability = 70,
    }
    group:entry {
        distribution = {
            { item = "357mag_fmj", charges = { 8, 80 }, probability = 30 },
            { item = "357mag_jhp", charges = { 8, 80 }, probability = 30 },
            { item = "38_fmj", charges = { 1, 80 }, probability = 15 },
            { item = "38_special", charges = { 1, 80 }, probability = 25 },
        },
        probability = 30,
    }
    content.add(group)
end

do
    -- a collection of ammo that would be found with a loaded gun.
    local group = content.ItemGroup { id = "on_hand_50ae", kind = "collection" }
    group:group("boxed_50AE_used")
    group:entry { group = "50AE_loose", count = { 1, 4 } }
    group:group("boxed_50AE", 50)
    group:group("boxed_50AE", 25)
    content.add(group)
end

do
    -- a collection of ammo that would be found with a loaded gun.
    local group = content.ItemGroup { id = "on_hand_22", kind = "collection" }
    group:group("boxed_22lr_used")
    group:entry { item = "22_lr", charges = { 1, 20 } }
    group:group("boxed_22lr", 50)
    group:group("boxed_22lr", 25)
    content.add(group)
end

do
    -- a collection of ammo that would be found with a loaded gun.
    local group = content.ItemGroup { id = "on_hand_4570", kind = "collection" }
    group:group("boxed_4570_used")
    group:entry { group = "4570_loose", count = { 1, 4 } }
    group:group("boxed_4570", 50)
    group:group("boxed_4570", 25)
    content.add(group)
end

do
    -- a collection of ammo that would be found with a loaded gun.
    local group = content.ItemGroup { id = "on_hand_308", kind = "collection" }
    group:group("boxed_308_20_used")
    group:entry { group = "308_loose", count = { 1, 4 } }
    group:group("boxed_308_20", 50)
    group:group("boxed_308_100", 20)
    content.add(group)
end

do
    -- a collection of ammo that would be found with a loaded gun.
    local group = content.ItemGroup { id = "on_hand_223", kind = "collection" }
    group:entry {
        distribution = {
            {
                collection = {
                    { group = "223_loose", count = { 1, 4 } },
                    { group = "boxed_223_20_used" },
                    { group = "boxed_223_20", probability = 50 },
                    { group = "boxed_223_50", probability = 25 },
                },
            },
            {
                collection = {
                    { group = "clip223_10rd_556", count = { 1, 5 } },
                },
                probability = 20,
            },
        },
    }
    content.add(group)
end

do
    -- a collection of ammo that would be found with a loaded gun.
    local group = content.ItemGroup { id = "on_hand_3006", kind = "collection" }
    group:group("boxed_3006_20_used")
    group:entry { group = "3006_loose", count = { 1, 4 } }
    group:group("boxed_3006_20", 50)
    content.add(group)
end

do
    -- a collection of ammo that would be found with a loaded gun.
    local group = content.ItemGroup { id = "on_hand_762R", kind = "collection" }
    group:group("boxed_762R_20_used")
    group:entry { item = "762_54R", charges = { 1, 10 } }
    group:group("boxed_762R_20", 50)
    content.add(group)
end

do
    -- a collection of ammo that would be found with a loaded gun.
    local group = content.ItemGroup { id = "on_hand_270win", kind = "collection" }
    group:group("boxed_270_20_used")
    group:entry { item = "270win_jsp", charges = { 1, 10 } }
    group:group("boxed_270_20", 50)
    content.add(group)
end

do
    -- a collection of ammo that would be found with a loaded gun.
    local group = content.ItemGroup { id = "on_hand_300", kind = "collection" }
    group:group("boxed_300_20_used")
    group:entry { item = "300_winmag", charges = { 1, 10 } }
    group:group("boxed_300_20", 50)
    content.add(group)
end

do
    -- a collection of ammo that would be found with a loaded gun.
    local group = content.ItemGroup { id = "on_hand_300BLK", kind = "collection" }
    group:group("boxed_300blk_used")
    group:entry { item = "300blk", charges = { 1, 10 } }
    group:group("boxed_300blk", 50)
    content.add(group)
end

do
    -- a collection of ammo that would be found with a loaded gun.
    local group = content.ItemGroup { id = "on_hand_30carbine", kind = "collection" }
    group:group("boxed_30carbine_used")
    group:entry { group = "30carbine_loose", count = { 1, 4 } }
    group:group("boxed_30carbine", 50)
    content.add(group)
end

do
    -- a collection of ammo that would be found with a loaded gun.
    local group = content.ItemGroup { id = "on_hand_50", kind = "distribution" }
    group:entry { item = "50bmg", charges = { 1, 25 } }
    group:entry { item = "50bmg", charges = { 27, 50 }, probability = 75 }
    group:entry { item = "50bmg", charges = { 55, 100 }, probability = 30 }
    group:entry { item = "50_incendiary", charges = { 1, 10 } }
    group:entry { item = "50_incendiary", charges = { 11, 20 }, probability = 75 }
    group:entry { item = "50_incendiary", charges = { 22, 40 }, probability = 30 }
    group:entry { item = "50match", charges = { 1, 10 } }
    group:entry { item = "50match", charges = { 11, 20 }, probability = 75 }
    group:entry { item = "50match", charges = { 22, 40 }, probability = 30 }
    group:entry { item = "50ss", charges = { 1, 10 } }
    group:entry { item = "50ss", charges = { 11, 20 }, probability = 75 }
    group:entry { item = "50ss", charges = { 22, 40 }, probability = 30 }
    group:entry { item = "50_mk211", charges = { 1, 10 }, probability = 30 }
    content.add(group)
end

do
    -- a collection of ammo that would be found with a loaded gun.
    local group = content.ItemGroup { id = "on_hand_545x39", kind = "collection" }
    group:group("boxed_545_used")
    group:entry { item = "545", charges = { 1, 4 } }
    group:group("boxed_545", 50)
    content.add(group)
end

do
    -- a collection of ammo that would be found with a loaded gun.
    local group = content.ItemGroup { id = "on_hand_458wm", kind = "collection" }
    group:group("boxed_458_used")
    group:entry { item = "458wm", charges = { 1, 4 } }
    group:group("boxed_458", 50)
    content.add(group)
end

do
    -- a collection of ammo that would be found with a loaded gun.
    local group = content.ItemGroup { id = "on_hand_50beowulf", kind = "collection" }
    group:group("boxed_50beowulf_used")
    group:entry { group = "50beowulf_loose", count = { 1, 4 } }
    group:group("boxed_50beowulf", 50)
    content.add(group)
end

do
    -- a collection of ammo that would be found with a loaded gun.
    local group = content.ItemGroup { id = "on_hand_450", kind = "collection" }
    group:group("boxed_450_used")
    group:entry { item = "450_ftx", charges = { 1, 4 } }
    group:group("boxed_450", 50)
    content.add(group)
end

do
    -- a collection of ammo that would be found with a loaded gun.
    local group = content.ItemGroup { id = "on_hand_338lapua", kind = "collection" }
    group:group("boxed_338_used")
    group:entry { item = "338lapua_hpbt", charges = { 1, 4 } }
    group:group("boxed_338", 50)
    content.add(group)
end

do
    -- a collection of ammo that would be found with a loaded military gun.
    local group = content.ItemGroup { id = "on_hand_military_338lapua", kind = "distribution" }
    group:entry { item = "338lapua_fmjbt", charges = { 1, 20 } }
    group:entry { item = "338lapua_api", charges = { 1, 20 } }
    group:entry { item = "338lapua_fmjbt", charges = { 22, 40 }, probability = 75 }
    group:entry { item = "338lapua_api", charges = { 22, 40 }, probability = 75 }
    group:entry { item = "338lapua_hpbt", charges = { 44, 80 }, probability = 30 }
    group:entry { item = "338lapua_api", charges = { 44, 80 }, probability = 30 }
    content.add(group)
end

do
    -- a collection of ammo that would be found with a loaded gun.
    local group = content.ItemGroup { id = "on_hand_303", kind = "collection" }
    group:group("boxed_303_used")
    group:entry { group = "303_loose", count = { 1, 4 } }
    group:group("boxed_303", 50)
    content.add(group)
end

do
    -- a collection of ammo that would be found with a loaded gun.
    local group = content.ItemGroup { id = "on_hand_77mm_arisaka", kind = "collection" }
    group:group("boxed_77x58_used")
    group:entry { item = "77mm_arisaka_jsp", charges = { 1, 10 } }
    group:group("boxed_77x58", 50)
    content.add(group)
end

do
    -- a collection of ammo that would be found with a loaded gun.
    local group = content.ItemGroup { id = "on_hand_3030", kind = "collection" }
    group:group("boxed_3030_used")
    group:entry { item = "3030", charges = { 1, 10 } }
    group:group("boxed_3030", 50)
    content.add(group)
end
