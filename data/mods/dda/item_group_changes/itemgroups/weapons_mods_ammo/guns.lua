local content = require("ccb").content

do
    -- Makeshift or otherwise poor quality SMGs.
    local group = content.ItemGroup { id = "guns_smg_improvised", kind = "distribution" }
    group:entry { item = "smg_40", charges = { 0, 20 }, probability = 40 }
    group:entry { item = "smg_45", charges = { 0, 20 }, probability = 40 }
    group:entry { item = "smg_9mm", charges = { 0, 20 } }
    content.add(group)
end

do
    -- Rifles commonly owned by citizens and found in many locations.
    -- This is for worn items so ammo should be handled elsewhere so that mods can be added directly.
    local group = content.ItemGroup { id = "guns_rifle_common_worn", kind = "distribution" }
    group:entry { group = "guns_rifle_common_display", charges = { 1, 30 } }
    content.add(group)
end

do
    -- Makeshift or otherwise poor quality rifles.
    local group = content.ItemGroup { id = "guns_rifle_improvised", kind = "distribution" }
    group:item("rifle_22", 60)
    group:item("rifle_38", 30)
    group:item("rifle_44", 5)
    content.add(group)
end

do
    -- Shotguns commonly owned by citizens and found in many locations.
    -- Making the assumption any loaded gun will have additional ammo and mags with it.
    -- To-do, add in more 410 shotguns
    local group = content.ItemGroup { id = "guns_shotgun_common", kind = "distribution", with_magazine = 100 }
    group:group("12_gauge_semi", 48)
    group:group("12_gauge_pump", 34)
    group:group("12_gauge_break", 18)
    group:group("20_gauge_pump", 6)
    group:group("20_gauge_bolt", 5)
    group:group("20_gauge_break", 2)
    group:group("nested_mossberg_500_410", 5)
    content.add(group)
end

do
    -- Shotguns commonly owned by citizens and found in many locations.
    -- ammo handled elsewhere so these can be worn.
    local group = content.ItemGroup { id = "guns_shotgun_common_worn", kind = "distribution" }
    group:entry { group = "guns_shotgun_common_display", charges = { 1, 8 } }
    content.add(group)
end

do
    -- Makeshift or otherwise poor quality shotguns.
    local group = content.ItemGroup { id = "guns_shotgun_improvised", kind = "distribution" }
    group:item("blunderbuss", 10)
    group:item("pipe_double_shotgun", 10)
    group:item("pipe_shotgun", 20)
    group:item("revolver_shotgun", 1)
    group:item("slamfire_shotgun")
    group:item("slamfire_shotgun_d", 30)
    content.add(group)
end

do
    -- Factory manufactured incendiary liquid projectors (excludes improvised weapons)
    local group = content.ItemGroup { id = "guns_launcher_flame", kind = "distribution" }
    group:entry { item = "flamethrower", charges = { 100, 8000 }, probability = 50 }
    content.add(group)
end

do
    -- Factory manufactured rocket launchers (excludes improvised weapons)
    local group = content.ItemGroup { id = "guns_launcher_rocket", kind = "distribution" }
    group:item("LAW_Packed", 200)
    group:item("m202_flash")
    group:item("m74_clip", 150)
    group:entry { item = "m3_carlgustav", charges = { 1, 1 }, probability = 50 }
    group:entry { item = "m4_carlgustav", charges = { 1, 1 }, probability = 50 }
    group:entry { item = "AT4", charges = { 1, 1 }, probability = 50 }
    group:item("84x246mm_he")
    group:item("84x246mm_hedp", 80)
    group:item("84x246mm_smoke")
    content.add(group)
end

do
    -- Factory manufactured grenade and rocket launchers (excludes improvised weapons)
    local group = content.ItemGroup { id = "guns_launcher_milspec", kind = "distribution" }
    group:group("guns_launcher_flame", 20)
    group:group("guns_launcher_grenade", 70)
    group:group("guns_launcher_rocket", 30)
    content.add(group)
end

do
    -- Guns of all types commonly owned by citizens and found in many locations.
    local group = content.ItemGroup { id = "guns_common", kind = "distribution" }
    group:group("guns_pistol_common", 41)
    group:group("guns_rifle_common", 57)
    group:group("guns_shotgun_common", 1)
    content.add(group)
end

do
    -- Military specification guns of all types.
    local group = content.ItemGroup { id = "guns_milspec", kind = "distribution" }
    group:group("guns_pistol_milspec", 40)
    group:group("guns_smg_milspec", 25)
    group:group("guns_rifle_milspec")
    group:group("guns_shotgun_milspec", 1)
    group:group("guns_launcher_milspec", 1)
    content.add(group)
end

do
    -- Display pieces for guns that are more for decoration than actual purpose.
    local group = content.ItemGroup { id = "guns_display_pieces", kind = "distribution" }
    group:group("guns_pistol_display_pieces", 80)
    group:group("guns_rifle_display_pieces", 20)
    content.add(group)
end

do
    -- Historical guns that you may find at something like a gunshow.
    local group = content.ItemGroup { id = "guns_collectible", kind = "distribution" }
    group:group("guns_pistol_collectible", 80)
    group:group("guns_rifle_collectible", 20)
    content.add(group)
end

do
    -- Makeshift or otherwise poor quality guns of all types.
    local group = content.ItemGroup { id = "guns_improvised", kind = "distribution" }
    group:group("guns_smg_improvised", 1)
    group:group("guns_rifle_improvised", 56)
    group:group("guns_shotgun_improvised", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "longguns_cop", kind = "distribution" }
    group:entry {
        group = "ar15_223medium",
        charges = { 0, 30 },
        ammo = { item = "223" },
        contents = {
            { item = "shoulder_strap" },
        },
        probability = 90,
    }
    group:entry {
        group = "ar15_223short",
        charges = { 0, 30 },
        ammo = { item = "223" },
        contents = {
            { item = "shoulder_strap" },
        },
        probability = 70,
    }
    group:entry {
        group = "ar15_223long",
        charges = { 0, 30 },
        ammo = { item = "223" },
        contents = {
            { item = "shoulder_strap" },
        },
        probability = 40,
    }
    group:entry {
        group = "modular_m4a1",
        charges = { 0, 30 },
        ammo = { item = "556_mk318" },
        contents = {
            { item = "shoulder_strap" },
        },
        probability = 8,
    }
    group:entry {
        group = "modular_m4a1",
        charges = { 0, 30 },
        ammo = { item = "556_mk318" },
        contents = {
            { item = "shoulder_strap" },
        },
        probability = 8,
    }
    group:entry {
        group = "h&k416a5_any",
        charges = { 0, 30 },
        ammo = { item = "556_mk318" },
        contents = {
            { item = "shoulder_strap" },
        },
        probability = 3,
    }
    group:entry {
        item = "ruger_mini",
        charges = { 0, 20 },
        ammo = { item = "223" },
        contents = {
            { item = "shoulder_strap" },
        },
        probability = 5,
    }
    group:entry {
        item = "steyr_aug",
        charges = { 0, 30 },
        ammo = { item = "556_mk318" },
        contents = {
            { item = "shoulder_strap" },
        },
        probability = 1,
    }
    group:entry {
        item = "benelli_tsa",
        charges = { 0, 6 },
        contents = {
            { item = "shoulder_strap" },
        },
        probability = 4,
    }
    group:entry {
        item = "mossberg_590",
        charges = { 0, 9 },
        contents = {
            { item = "shoulder_strap" },
        },
        probability = 1,
    }
    group:entry {
        item = "mossberg_930",
        charges = { 0, 8 },
        contents = {
            { item = "shoulder_strap" },
        },
        probability = 7,
    }
    group:entry {
        item = "benelli_m4",
        charges = { 0, 5 },
        contents = {
            { item = "shoulder_strap" },
        },
        probability = 2,
    }
    group:entry {
        item = "remington_870_express",
        charges = { 0, 7 },
        contents = {
            { item = "shoulder_strap" },
        },
        probability = 7,
    }
    group:entry {
        item = "remington_700",
        charges = { 0, 4 },
        contents = {
            { item = "shoulder_strap" },
        },
        probability = 2,
    }
    group:entry {
        item = "M24",
        charges = { 0, 5 },
        contents = {
            { item = "shoulder_strap" },
        },
        probability = 10,
    }
    content.add(group)
end

do
    -- loaded in the back of a trunk or something (fully loaded, excluding sniper rifles)
    local group = content.ItemGroup { id = "longguns_cop_loaded", kind = "distribution" }
    group:entry {
        group = "ar15_223medium",
        charges = { 30, 30 },
        ammo = { item = "223" },
        contents = {
            { item = "shoulder_strap" },
        },
        probability = 90,
    }
    group:entry {
        group = "ar15_223short",
        charges = { 30, 30 },
        ammo = { item = "223" },
        contents = {
            { item = "shoulder_strap" },
        },
        probability = 70,
    }
    group:entry {
        group = "ar15_223long",
        charges = { 30, 30 },
        ammo = { item = "223" },
        contents = {
            { item = "shoulder_strap" },
        },
        probability = 40,
    }
    group:entry {
        group = "modular_m4a1",
        charges = { 30, 30 },
        ammo = { item = "556_mk318" },
        contents = {
            { item = "shoulder_strap" },
        },
        probability = 8,
    }
    group:entry {
        group = "modular_m4a1",
        charges = { 30, 30 },
        ammo = { item = "556_mk318" },
        contents = {
            { item = "shoulder_strap" },
        },
        probability = 8,
    }
    group:entry {
        group = "h&k416a5_any",
        charges = { 30, 30 },
        ammo = { item = "556_mk318" },
        contents = {
            { item = "shoulder_strap" },
        },
        probability = 3,
    }
    group:entry {
        item = "ruger_mini",
        charges = { 20, 20 },
        ammo = { item = "223" },
        contents = {
            { item = "shoulder_strap" },
        },
        probability = 5,
    }
    group:entry {
        item = "steyr_aug",
        charges = { 30, 30 },
        ammo = { item = "556_mk318" },
        contents = {
            { item = "shoulder_strap" },
        },
        probability = 1,
    }
    group:entry {
        item = "benelli_tsa",
        charges = { 6, 6 },
        contents = {
            { item = "shoulder_strap" },
        },
        probability = 2,
    }
    group:entry {
        item = "mossberg_590",
        charges = { 9, 9 },
        contents = {
            { item = "shoulder_strap" },
        },
        probability = 1,
    }
    group:entry {
        item = "mossberg_930",
        charges = { 8, 8 },
        contents = {
            { item = "shoulder_strap" },
        },
        probability = 5,
    }
    group:entry {
        item = "benelli_m4",
        charges = { 5, 5 },
        contents = {
            { item = "shoulder_strap" },
        },
        probability = 1,
    }
    group:entry {
        item = "remington_870_express",
        charges = { 7, 7 },
        contents = {
            { item = "shoulder_strap" },
        },
        probability = 3,
    }
    content.add(group)
end

do
    -- gun plus potential expended magazines
    local group = content.ItemGroup { id = "longguns_cop_in_field", kind = "distribution" }
    group:entry {
        collection = {
            {
                group = "ar15_223medium",
                charges = { 0, 30 },
                damage = { 0, 3 },
                dirt = { 0, 7050 },
                ammo = { item = "223" },
                contents = {
                    { item = "shoulder_strap" },
                },
            },
            {
                distribution = {
                    { group = "field_ar15_223", probability = 40 },
                    { group = "field_ar15_mk318", probability = 60 },
                },
            },
        },
        probability = 90,
    }
    group:entry {
        collection = {
            {
                group = "ar15_223short",
                charges = { 0, 30 },
                damage = { 0, 3 },
                dirt = { 0, 7050 },
                ammo = { item = "223" },
                contents = {
                    { item = "shoulder_strap" },
                },
            },
            {
                distribution = {
                    { group = "field_ar15_223", probability = 40 },
                    { group = "field_ar15_mk318", probability = 60 },
                },
            },
        },
        probability = 70,
    }
    group:entry {
        collection = {
            {
                group = "ar15_223long",
                charges = { 0, 30 },
                damage = { 0, 3 },
                dirt = { 0, 7050 },
                ammo = { item = "223" },
                contents = {
                    { item = "shoulder_strap" },
                },
            },
            {
                distribution = {
                    { group = "field_ar15_223", probability = 40 },
                    { group = "field_ar15_mk318", probability = 60 },
                },
            },
        },
        probability = 40,
    }
    group:entry {
        collection = {
            {
                group = "modular_m4a1",
                charges = { 0, 30 },
                damage = { 0, 3 },
                dirt = { 0, 7050 },
                ammo = { item = "556_mk318" },
                contents = {
                    { item = "shoulder_strap" },
                },
            },
            {
                distribution = {
                    { group = "field_ar15_223", probability = 40 },
                    { group = "field_ar15_mk318", probability = 60 },
                },
            },
        },
        probability = 8,
    }
    group:entry {
        collection = {
            {
                group = "m4_cqbr",
                charges = { 0, 30 },
                damage = { 0, 3 },
                dirt = { 0, 7050 },
                ammo = { item = "556_mk318" },
                contents = {
                    { item = "shoulder_strap" },
                },
            },
            {
                distribution = {
                    { group = "field_ar15_223", probability = 40 },
                    { group = "field_ar15_mk318", probability = 60 },
                },
            },
        },
        probability = 8,
    }
    group:entry {
        collection = {
            {
                group = "h&k416a5_any",
                charges = { 0, 30 },
                damage = { 0, 3 },
                dirt = { 0, 7050 },
                ammo = { item = "556_mk318" },
                contents = {
                    { item = "shoulder_strap" },
                },
            },
            {
                distribution = {
                    { group = "field_ar15_223", probability = 40 },
                    { group = "field_ar15_mk318", probability = 60 },
                },
            },
        },
        probability = 3,
    }
    group:entry {
        collection = {
            {
                item = "ruger_mini",
                charges = { 0, 20 },
                damage = { 0, 3 },
                dirt = { 0, 7050 },
                ammo = { item = "223" },
                contents = {
                    { item = "shoulder_strap" },
                },
            },
            { group = "field_mini14" },
        },
        probability = 5,
    }
    group:entry {
        collection = {
            {
                item = "steyr_aug",
                charges = { 0, 30 },
                damage = { 0, 3 },
                dirt = { 0, 7050 },
                ammo = { item = "556_mk318" },
                contents = {
                    { item = "shoulder_strap" },
                },
            },
            { group = "field_steyraug" },
        },
        probability = 1,
    }
    group:entry {
        collection = {
            {
                item = "benelli_tsa",
                charges = { 0, 6 },
                damage = { 0, 3 },
                dirt = { 0, 7050 },
                contents = {
                    { item = "shoulder_strap" },
                },
            },
            { group = "field_shotgun" },
        },
        probability = 1,
    }
    group:entry {
        collection = {
            {
                item = "mossberg_590",
                charges = { 0, 9 },
                damage = { 0, 3 },
                dirt = { 0, 7050 },
                contents = {
                    { item = "shoulder_strap" },
                },
            },
            { group = "field_shotgun" },
        },
        probability = 1,
    }
    group:entry {
        collection = {
            {
                item = "mossberg_930",
                charges = { 0, 8 },
                damage = { 0, 3 },
                dirt = { 0, 7050 },
                contents = {
                    { item = "shoulder_strap" },
                },
            },
            { group = "field_shotgun" },
        },
        probability = 1,
    }
    group:entry {
        collection = {
            {
                item = "benelli_m4",
                charges = { 0, 5 },
                damage = { 0, 3 },
                dirt = { 0, 7050 },
                contents = {
                    { item = "shoulder_strap" },
                },
            },
            { group = "field_shotgun" },
        },
        probability = 1,
    }
    group:entry {
        collection = {
            {
                item = "remington_870_express",
                charges = { 0, 7 },
                damage = { 0, 3 },
                dirt = { 0, 7050 },
                contents = {
                    { item = "shoulder_strap" },
                },
            },
            { group = "field_shotgun" },
        },
        probability = 1,
    }
    group:entry {
        collection = {
            {
                item = "remington_700",
                charges = { 0, 4 },
                damage = { 0, 3 },
                dirt = { 0, 7050 },
                contents = {
                    { item = "shoulder_strap" },
                },
            },
            { group = "field_3006" },
        },
        probability = 2,
    }
    group:entry {
        collection = {
            {
                item = "M24",
                charges = { 0, 4 },
                damage = { 0, 3 },
                dirt = { 0, 7050 },
                contents = {
                    { item = "shoulder_strap" },
                },
            },
            { group = "field_308" },
        },
        probability = 5,
    }
    content.add(group)
end

do
    -- guns lost but still have mags
    local group = content.ItemGroup { id = "longguns_cop_in_field_no_gun", kind = "distribution" }
    group:group("field_ar15_223", 70)
    group:group("field_ar15_mk318", 80)
    group:group("field_mini14", 5)
    group:group("field_steyraug", 1)
    group:group("field_shotgun", 10)
    group:group("field_308", 10)
    group:group("field_3006", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sidearms_cop", kind = "distribution" }
    group:entry { item = "glock_19", charges = { 0, 15 }, probability = 15 }
    group:entry { item = "glock_22", charges = { 0, 15 }, ammo = { item = "40sw" }, probability = 20 }
    group:entry { item = "m9", charges = { 0, 15 }, variant = "m9", probability = 5 }
    group:entry { item = "sig_40", charges = { 0, 12 }, probability = 20 }
    group:entry { item = "usp_45", charges = { 0, 12 }, probability = 10 }
    group:entry { item = "usp_9mm", charges = { 0, 15 }, probability = 10 }
    content.add(group)
end

do
    -- gun plus potential expended magazines
    local group = content.ItemGroup { id = "sidearms_cop_in_field", kind = "distribution" }
    group:entry {
        collection = {
            { item = "fn57", charges = { 0, 20 }, damage = { 0, 3 }, dirt = { 0, 7050 } },
            { group = "field_fn57" },
        },
        probability = 1,
    }
    group:entry {
        collection = {
            { item = "glock_19", charges = { 0, 15 }, damage = { 0, 3 }, dirt = { 0, 7050 } },
            { group = "field_glock_19" },
        },
        probability = 50,
    }
    group:entry {
        collection = {
            { item = "glock_17", charges = { 0, 17 }, damage = { 0, 3 }, dirt = { 0, 7050 } },
            { group = "field_glock_17" },
        },
        probability = 60,
    }
    group:entry {
        collection = {
            { item = "m9", charges = { 0, 15 }, damage = { 0, 3 }, dirt = { 0, 7050 }, variant = "m9" },
            { group = "field_m9" },
        },
        probability = 3,
    }
    group:entry {
        collection = {
            { item = "glock_34", charges = { 0, 15 }, damage = { 0, 3 }, dirt = { 0, 7050 } },
            { group = "field_glock_34" },
        },
        probability = 3,
    }
    group:entry {
        collection = {
            { item = "sp2022", charges = { 0, 15 }, damage = { 0, 3 }, dirt = { 0, 7050 } },
            { group = "field_sp2022_9mm" },
        },
        probability = 10,
    }
    group:entry {
        collection = {
            { item = "px4", charges = { 0, 17 }, damage = { 0, 3 }, dirt = { 0, 7050 } },
            { group = "field_px4_9mm" },
        },
        probability = 5,
    }
    group:entry {
        collection = {
            { item = "usp_9mm", charges = { 0, 15 }, damage = { 0, 3 }, dirt = { 0, 7050 } },
            { group = "field_usp_9mm" },
        },
        probability = 3,
    }
    group:entry {
        collection = {
            { item = "p226_357sig", charges = { 0, 12 }, damage = { 0, 3 }, dirt = { 0, 7050 } },
            { group = "field_p226_357sig" },
        },
        probability = 2,
    }
    group:entry {
        collection = {
            { item = "p320_357sig", charges = { 0, 13 }, damage = { 0, 3 }, dirt = { 0, 7050 } },
            { group = "field_p320_357sig" },
        },
        probability = 2,
    }
    group:entry {
        collection = {
            {
                item = "glock_22",
                charges = { 0, 15 },
                damage = { 0, 3 },
                dirt = { 0, 7050 },
                ammo = { item = "40sw" },
            },
            { group = "field_glock_22" },
        },
        probability = 30,
    }
    group:entry {
        collection = {
            { item = "px4_40", charges = { 0, 14 }, damage = { 0, 3 }, dirt = { 0, 7050 } },
            { group = "field_px4_40" },
        },
        probability = 5,
    }
    group:entry {
        collection = {
            { item = "sig_40", charges = { 0, 12 }, damage = { 0, 3 }, dirt = { 0, 7050 } },
            { group = "field_sig_40" },
        },
        probability = 10,
    }
    group:entry {
        collection = {
            { item = "glock_21", charges = { 0, 13 }, damage = { 0, 3 }, dirt = { 0, 7050 } },
            { group = "field_glock_21" },
        },
        probability = 10,
    }
    group:entry {
        collection = {
            { item = "usp_45", charges = { 0, 12 }, damage = { 0, 3 }, dirt = { 0, 7050 }, variant = "usp_45" },
            { group = "field_usp_45" },
        },
        probability = 2,
    }
    content.add(group)
end

do
    -- guns lost but still have mags
    local group = content.ItemGroup { id = "sidearms_cop_in_field_no_gun", kind = "distribution" }
    group:group("field_fn57", 1)
    group:group("field_glock_19", 50)
    group:group("field_glock_17", 60)
    group:group("field_m9", 3)
    group:group("field_glock_34", 3)
    group:group("field_sp2022_9mm", 10)
    group:group("field_px4_9mm", 5)
    group:group("field_usp_9mm", 3)
    group:group("field_p226_357sig", 2)
    group:group("field_p320_357sig", 2)
    group:group("field_glock_22", 30)
    group:group("field_px4_40", 5)
    group:group("field_sig_40", 10)
    group:group("field_glock_21", 10)
    group:group("field_usp_45", 2)
    content.add(group)
end

do
    -- Guns issued to paramilitary forces in addition to standard police issue.
    local group = content.ItemGroup { id = "guns_swat", kind = "distribution" }
    group:group("longguns_cop_in_field", 50)
    group:entry {
        collection = {
            {
                group = "modular_m4a1",
                charges = { 0, 30 },
                damage = { 0, 3 },
                dirt = { 0, 7050 },
                ammo = { item = "556_mk318" },
                contents = {
                    { item = "shoulder_strap" },
                },
            },
            {
                distribution = {
                    { group = "field_ar15_223", probability = 40 },
                    { group = "field_ar15_mk318", probability = 60 },
                },
            },
        },
        probability = 40,
    }
    group:entry {
        collection = {
            {
                group = "m4_cqbr",
                charges = { 0, 30 },
                damage = { 0, 3 },
                dirt = { 0, 7050 },
                ammo = { item = "556_mk318" },
                contents = {
                    { item = "shoulder_strap" },
                },
            },
            {
                distribution = {
                    { group = "field_ar15_223", probability = 40 },
                    { group = "field_ar15_mk318", probability = 60 },
                },
            },
        },
        probability = 30,
    }
    group:entry {
        collection = {
            {
                group = "h&k416a5_any",
                charges = { 0, 30 },
                damage = { 0, 3 },
                dirt = { 0, 7050 },
                ammo = { item = "556_mk318" },
                contents = {
                    { item = "shoulder_strap" },
                },
            },
            {
                distribution = {
                    { group = "field_ar15_223", probability = 40 },
                    { group = "field_ar15_mk318", probability = 60 },
                },
            },
        },
        probability = 10,
    }
    group:entry {
        collection = {
            {
                group = "modular_ump_9",
                charges = { 0, 30 },
                damage = { 0, 3 },
                dirt = { 0, 7050 },
                contents = {
                    { item = "shoulder_strap" },
                },
            },
            { group = "field_ump9" },
        },
        probability = 5,
    }
    group:entry {
        collection = {
            {
                group = "modular_ump_40",
                charges = { 0, 30 },
                damage = { 0, 3 },
                dirt = { 0, 7050 },
                contents = {
                    { item = "shoulder_strap" },
                },
            },
            { group = "field_ump40" },
        },
        probability = 20,
    }
    group:entry {
        collection = {
            {
                group = "modular_ump_45",
                charges = { 0, 25 },
                damage = { 0, 3 },
                dirt = { 0, 7050 },
                contents = {
                    { item = "shoulder_strap" },
                },
            },
            { group = "field_ump45" },
        },
        probability = 15,
    }
    group:entry {
        collection = {
            {
                item = "hk_mp5",
                charges = { 0, 30 },
                damage = { 0, 3 },
                dirt = { 0, 7050 },
                contents = {
                    { item = "shoulder_strap" },
                },
            },
            { group = "field_mp5" },
        },
        probability = 30,
    }
    group:entry {
        collection = {
            {
                item = "hk_mp5k",
                charges = { 0, 30 },
                damage = { 0, 3 },
                dirt = { 0, 7050 },
                contents = {
                    { item = "shoulder_strap" },
                },
            },
            { group = "field_mp5" },
        },
        probability = 5,
    }
    group:entry {
        collection = {
            {
                item = "hk_mp5sd",
                charges = { 0, 30 },
                damage = { 0, 3 },
                dirt = { 0, 7050 },
                contents = {
                    { item = "shoulder_strap" },
                },
            },
            { group = "field_mp5" },
        },
        probability = 5,
    }
    group:entry {
        collection = {
            {
                item = "colt_ro635",
                charges = { 0, 32 },
                damage = { 0, 3 },
                dirt = { 0, 7050 },
                contents = {
                    { item = "shoulder_strap" },
                },
            },
            { group = "field_uzi" },
        },
        probability = 5,
    }
    group:entry {
        collection = {
            {
                item = "bt_apc9k",
                charges = { 0, 32 },
                damage = { 0, 3 },
                dirt = { 0, 7050 },
                contents = {
                    { item = "shoulder_strap" },
                },
            },
            { group = "field_apc9" },
        },
        probability = 5,
    }
    group:entry {
        collection = {
            {
                item = "fn_p90",
                charges = { 0, 50 },
                damage = { 0, 3 },
                dirt = { 0, 7050 },
                contents = {
                    { item = "shoulder_strap" },
                },
            },
            { group = "field_p90" },
        },
        probability = 1,
    }
    group:entry {
        collection = {
            {
                item = "benelli_m4",
                charges = { 0, 5 },
                damage = { 0, 3 },
                dirt = { 0, 7050 },
                contents = {
                    { item = "shoulder_strap" },
                },
            },
            { group = "field_shotgun" },
        },
        probability = 1,
    }
    group:entry {
        collection = {
            {
                item = "m1014",
                charges = { 0, 7 },
                damage = { 0, 3 },
                dirt = { 0, 7050 },
                contents = {
                    { item = "shoulder_strap" },
                },
            },
            { group = "field_shotgun" },
        },
        probability = 1,
    }
    group:entry {
        collection = {
            {
                item = "hk417_13",
                charges = { 0, 20 },
                damage = { 0, 3 },
                dirt = { 0, 7050 },
                contents = {
                    { item = "shoulder_strap" },
                },
            },
            { group = "field_hk417" },
        },
        probability = 3,
    }
    group:entry {
        collection = {
            {
                item = "M24",
                charges = { 0, 5 },
                damage = { 0, 3 },
                dirt = { 0, 7050 },
                contents = {
                    { item = "shoulder_strap" },
                },
            },
            { group = "field_308" },
        },
        probability = 5,
    }
    group:entry {
        collection = {
            {
                group = "axmc_308",
                charges = { 0, 10 },
                damage = { 0, 3 },
                dirt = { 0, 7050 },
                contents = {
                    { item = "rifle_scope" },
                    { item = "bipod" },
                    { item = "shoulder_strap" },
                },
            },
            { group = "field_308" },
        },
        probability = 5,
    }
    group:entry {
        collection = {
            {
                group = "axmc_300",
                charges = { 0, 5 },
                damage = { 0, 3 },
                dirt = { 0, 7050 },
                contents = {
                    { item = "rifle_scope" },
                    { item = "bipod" },
                    { item = "shoulder_strap" },
                },
            },
            { group = "field_300" },
        },
        probability = 2,
    }
    group:entry {
        collection = {
            {
                item = "tac338",
                charges = { 0, 5 },
                damage = { 0, 3 },
                dirt = { 0, 7050 },
                contents = {
                    { item = "shoulder_strap" },
                },
            },
            { group = "field_338" },
        },
        probability = 1,
    }
    group:entry {
        collection = {
            {
                item = "mrad_smr",
                charges = { 0, 5 },
                damage = { 0, 3 },
                dirt = { 0, 7050 },
                contents = {
                    { item = "rifle_scope" },
                    { item = "bipod" },
                    { item = "shoulder_strap" },
                },
            },
            { group = "field_338" },
        },
        probability = 2,
    }
    group:entry {
        collection = {
            {
                item = "tac50",
                charges = { 0, 5 },
                damage = { 0, 3 },
                dirt = { 0, 7050 },
                contents = {
                    { item = "shoulder_strap" },
                },
            },
            { group = "field_50bmg" },
        },
        probability = 1,
    }
    group:entry {
        collection = {
            {
                item = "as50",
                charges = { 0, 5 },
                damage = { 0, 3 },
                dirt = { 0, 7050 },
                contents = {
                    { item = "shoulder_strap" },
                },
            },
            { group = "field_as50" },
        },
        probability = 1,
    }
    content.add(group)
end

do
    -- Police issue weapons of all types
    local group = content.ItemGroup { id = "guns_cop", kind = "distribution" }
    group:group("longguns_cop", 20)
    group:group("sidearms_cop", 80)
    content.add(group)
end

do
    -- Guns typically carried by survivors, more focused on common semi-auto guns with commonly available ammo.
    local group = content.ItemGroup { id = "guns_survival", kind = "distribution", with_magazine = 100 }
    group:entry { item = "glock_17", charges = { 0, 17 }, probability = 10 }
    group:entry { item = "glock_19", charges = { 0, 17 }, probability = 45 }
    group:entry { item = "m9", charges = { 0, 15 }, variant = "m9", probability = 20 }
    group:entry { item = "cz75", charges = { 0, 16 }, probability = 30 }
    group:entry { item = "m18", charges = { 0, 17 }, probability = 15 }
    group:entry { item = "ruger_mini", charges = { 0, 30 }, probability = 40 }
    group:entry { item = "rdb_223", charges = { 0, 30 }, probability = 30 }
    group:entry { item = "ruger_1022", charges = { 0, 25 }, probability = 20 }
    group:entry { group = "ar15_223long", charges = { 0, 30 }, probability = 110 }
    group:entry { group = "modular_ar15", charges = { 0, 30 }, probability = 155 }
    group:entry { group = "guns_rifle_common_display_762", charges = { 0, 30 }, probability = 50 }
    group:entry { group = "guns_rifle_common_display_308", charges = { 0, 20 }, probability = 80 }
    group:entry { group = "guns_rifle_common_display_3006", charges = { 0, 8 }, probability = 25 }
    group:entry { group = "guns_pistol_common_display_223", charges = { 0, 30 }, probability = 25 }
    group:entry { group = "guns_pistol_common_display_44", charges = { 0, 8 }, probability = 15 }
    group:entry { group = "guns_pistol_common_display_357mag", charges = { 0, 9 }, probability = 15 }
    group:entry { group = "guns_pistol_common_display_40", charges = { 0, 20 }, probability = 25 }
    content.add(group)
end
