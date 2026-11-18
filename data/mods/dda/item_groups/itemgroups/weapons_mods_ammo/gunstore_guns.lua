local content = require("ccb").content

do
    local group = content.ItemGroup { id = "firearm_box_extras", kind = "collection" }
    group:item("gun_manual")
    group:item("gun_lock")
    content.add(group)
end

do
    -- This is for magazines with varying amounts <10, and lots of interchangability. If it's used in 3 or more guns it's best to have it as a group like this.
    -- Magazines should be 10 or less rounds, both to comply with MA firearm law, and also because it's just a cool balancing thing.  If not possible, lowest capacity.
    -- If a gun has more than 1 magazine that's less than 10 rounds, make the one that is default the most common, and if not, then make closest to 10 the most common.
    -- Eg, a 1911 would have 7 rounds be the most common magazine, while an M1A would have 10 rounds be the most common.
    local group = content.ItemGroup { id = "stanag_restricted", kind = "distribution" }
    group:entry { item = "stanag5", count = { 1, 2 }, probability = 10 }
    group:entry { item = "stanag10", count = { 1, 2 }, probability = 90 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common_boxed", kind = "distribution" }
    group:group("guns_pistol_common_boxed", 90)
    group:group("guns_rifle_common_boxed", 30)
    group:group("guns_shotgun_common_boxed", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_boxed", kind = "distribution" }
    group:group("guns_pistol_common_boxed_9mm", 74)
    group:group("guns_pistol_common_boxed_22", 64)
    group:group("guns_pistol_common_boxed_45", 20)
    group:group("guns_pistol_common_boxed_380", 28)
    group:group("guns_pistol_common_boxed_40", 19)
    group:group("guns_pistol_common_boxed_357mag", 12)
    group:group("guns_pistol_common_boxed_38", 11)
    group:group("guns_pistol_common_boxed_44", 1)
    group:group("guns_pistol_common_boxed_45colt", 5)
    group:group("guns_pistol_common_boxed_10mm", 1)
    group:group("guns_pistol_common_boxed_223", 17)
    group:group("guns_pistol_common_boxed_300", 8)
    group:group("guns_pistol_common_boxed_57", 2)
    group:group("guns_pistol_common_boxed_460", 2)
    group:group("guns_pistol_common_boxed_32", 1)
    group:group("guns_pistol_common_boxed_38super", 1)
    group:group("guns_pistol_common_boxed_other", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_boxed_9mm", kind = "distribution" }
    group:group("boxed_glock_17", 73)
    group:group("boxed_glock_19")
    group:group("boxed_glock_26", 14)
    group:group("boxed_glock_34", 11)
    group:group("boxed_glock_43", 13)
    group:group("boxed_glock_43x", 51)
    group:group("boxed_glock_48", 19)
    group:group("boxed_p365", 161)
    group:group("boxed_m9", 22)
    group:group("boxed_px4", 5)
    group:group("boxed_hi_power_9mm", 9)
    group:group("boxed_walther_ppq_9mm", 8)
    group:group("boxed_cz75", 65)
    group:group("boxed_walther_ccp", 2)
    group:group("boxed_hptc9", 12)
    group:group("boxed_m18m17", 48)
    group:group("boxed_m11", 6)
    group:group("boxed_hk_mp5_semi_pistol", 10)
    group:group("boxed_p226_9mm", 73)
    group:group("boxed_sp2022", 4)
    group:group("boxed_usp_9mm", 38)
    group:group("boxed_guns_pistol_rare_9mm", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_glock_17", kind = "collection", container = "box_pistol" }
    group:item("glock_17")
    group:group("firearm_box_extras")
    group:entry { item = "glock17_10", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_glock_19", kind = "collection", container = "box_pistol" }
    group:item("glock_19")
    group:group("firearm_box_extras")
    group:entry { item = "glockmag_10", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_glock_26", kind = "collection", container = "box_pistol" }
    group:item("glock_26")
    group:group("firearm_box_extras")
    group:entry { item = "glockmag_10", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_glock_34", kind = "collection", container = "box_pistol" }
    group:item("glock_34")
    group:group("firearm_box_extras")
    group:entry { item = "glock17_10", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_glock_43", kind = "collection", container = "box_pistol" }
    group:item("glock_43")
    group:group("firearm_box_extras")
    group:entry { item = "glock43_mag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_glock_43x", kind = "collection", container = "box_pistol" }
    group:item("glock_43x")
    group:group("firearm_box_extras")
    group:entry { item = "glock43x/48_mag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_glock_48", kind = "collection", container = "box_pistol" }
    group:item("glock_48")
    group:group("firearm_box_extras")
    group:entry { item = "glock43x/48_mag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_p365", kind = "collection", container = "box_pistol" }
    group:item("p365")
    group:group("firearm_box_extras")
    group:entry { item = "p365_mag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_m9", kind = "collection", container = "box_pistol" }
    group:item("m9")
    group:group("firearm_box_extras")
    group:entry { item = "m9mag_10rd", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_px4", kind = "collection", container = "box_pistol" }
    group:item("px4")
    group:group("firearm_box_extras")
    group:entry { item = "px4mag_10rd", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_hi_power_9mm", kind = "collection", container = "box_pistol" }
    group:item("hi_power_9mm")
    group:group("firearm_box_extras")
    group:entry { item = "bhp9mag_13rd", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_walther_ppq_9mm", kind = "collection", container = "box_pistol" }
    group:item("walther_ppq_9mm")
    group:group("firearm_box_extras")
    group:entry { item = "ppq9mag_10rd", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_cz75", kind = "collection", container = "box_pistol" }
    group:item("cz75")
    group:group("firearm_box_extras")
    group:entry { item = "cz75mag_10rd", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_walther_ccp", kind = "collection", container = "box_pistol" }
    group:item("walther_ccp")
    group:group("firearm_box_extras")
    group:entry {
        distribution = {
            { item = "ccpmag", count = { 1, 2 }, probability = 40 },
            { item = "ccpmag_9rd", count = { 1, 2 }, probability = 60 },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_hptc9", kind = "collection", container = "box_pistol" }
    group:item("hptc9")
    group:group("firearm_box_extras")
    group:entry {
        distribution = {
            { item = "hptc9mag_8rd", count = { 1, 2 }, probability = 40 },
            { item = "hptc9mag_10rd", count = { 1, 2 }, probability = 60 },
        },
    }
    content.add(group)
end

do
    -- If a gun shares the same magazine or has an internal magazine, it should be grouped together in one group with spawn weights adjusted both in the by caliber groups and the specific guns group
    local group = content.ItemGroup { id = "boxed_m18m17", kind = "collection", container = "box_pistol" }
    group:entry { item = "p320mag_10rd_9x19mm", count = { 1, 2 } }
    group:group("firearm_box_extras")
    group:entry {
        distribution = {
            { item = "m18", probability = 22 },
            { item = "m17", probability = 24 },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_m11", kind = "collection", container = "box_pistol" }
    group:item("m11")
    group:group("firearm_box_extras")
    group:entry { item = "p228mag_13rd_9x19mm", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_hk_mp5_semi_pistol", kind = "collection", container = "box_pistol" }
    group:item("hk_mp5_semi_pistol")
    group:group("firearm_box_extras")
    group:entry { item = "mp5mag_10rd", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_p226_9mm", kind = "collection", container = "box_pistol" }
    group:item("p226_9mm")
    group:group("firearm_box_extras")
    group:entry { item = "p226mag_10rd_9x19mm", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_sp2022", kind = "collection", container = "box_pistol" }
    group:item("sp2022")
    group:group("firearm_box_extras")
    group:entry { item = "sp2022mag_10rd_9mm", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_usp_9mm", kind = "collection", container = "box_pistol" }
    group:item("usp_9mm")
    group:group("firearm_box_extras")
    group:entry { item = "usp9mag_10rd", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_guns_pistol_rare_9mm", kind = "distribution" }
    group:entry {
        item = "box_pistol",
        contents = {
            { item = "p08" },
            { item = "p08mag_8rd" },
            { group = "firearm_box_extras" },
        },
        probability = 13,
    }
    group:entry {
        item = "box_pistol",
        contents = {
            { item = "mauser_c96" },
            { item = "clip9mm_10rd" },
            { group = "firearm_box_extras" },
        },
        probability = 11,
    }
    group:entry {
        item = "box_longarm",
        variant = "box_longarm_handgun",
        contents = {
            { item = "mp40semi" },
            { item = "mp40mag_32rd" },
            { group = "firearm_box_extras" },
        },
        probability = 1,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_boxed_22", kind = "distribution" }
    group:group("boxed_walther_p22", 45)
    group:group("boxed_sr22", 405)
    group:group("boxed_ruger_lcr_22", 2)
    group:group("boxed_22_revolver", 75)
    group:group("boxed_sig_mosquito", 65)
    group:group("boxed_ruger_mk4", 113)
    group:group("boxed_1911_22")
    group:group("boxed_sw617", 46)
    group:group("boxed_glock_44", 13)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_walther_p22", kind = "collection", container = "box_pistol" }
    group:item("walther_p22")
    group:group("firearm_box_extras")
    group:entry { item = "wp22mag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_sr22", kind = "collection", container = "box_pistol" }
    group:item("sr22")
    group:group("firearm_box_extras")
    group:entry { item = "sr22_mag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_ruger_lcr_22", kind = "collection", container = "box_pistol" }
    group:item("ruger_lcr_22")
    group:group("firearm_box_extras")
    group:item("22_speedloader8", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_22_revolver", kind = "collection", container = "box_pistol" }
    group:group("firearm_box_extras")
    group:entry {
        distribution = {
            { item = "rough_rider_pistol", probability = 61 },
            { item = "rough_rider_pistol_9", probability = 14 },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_sig_mosquito", kind = "collection", container = "box_pistol" }
    group:item("sig_mosquito")
    group:group("firearm_box_extras")
    group:entry { item = "mosquitomag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_glock_44", kind = "collection", container = "box_pistol" }
    group:item("glock_44")
    group:group("firearm_box_extras")
    group:entry { item = "glock44_mag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_ruger_mk4", kind = "collection", container = "box_pistol" }
    group:item("ruger_mk4")
    group:group("firearm_box_extras")
    group:entry { item = "ruger_mk4_mag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_1911_22", kind = "collection", container = "box_pistol" }
    group:item("1911_22")
    group:group("firearm_box_extras")
    group:entry { item = "1911_22_mag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_sw617", kind = "collection", container = "box_pistol" }
    group:item("sw617")
    group:group("firearm_box_extras")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_boxed_45", kind = "distribution" }
    group:group("boxed_glock_21", 14)
    group:group("boxed_glock_23", 10)
    group:group("boxed_glock_27", 3)
    group:group("boxed_m1911")
    group:group("boxed_walther_ppq_45", 1)
    group:group("boxed_hptjhp", 2)
    group:group("boxed_usp_45", 4)
    group:group("boxed_glock_30", 10)
    group:group("boxed_glock_36", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_glock_21", kind = "collection", container = "box_pistol" }
    group:item("glock_21")
    group:group("firearm_box_extras")
    group:entry { item = "glock_21mag_10", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_glock_30", kind = "collection", container = "box_pistol" }
    group:item("glock_30")
    group:group("firearm_box_extras")
    group:entry { item = "glock_21mag_10", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_glock_36", kind = "collection", container = "box_pistol" }
    group:item("glock_36")
    group:group("firearm_box_extras")
    group:entry { item = "glock36_mag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_m1911", kind = "collection", container = "box_pistol" }
    group:item("m1911")
    group:group("firearm_box_extras")
    group:entry { item = "m1911mag", count = { 1, 2 } }
    group:item("m1911bigmag", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_walther_ppq_45", kind = "collection", container = "box_pistol" }
    group:item("walther_ppq_45")
    group:group("firearm_box_extras")
    group:entry { item = "ppq45mag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_hptjhp", kind = "collection", container = "box_pistol" }
    group:item("hptjhp")
    group:group("firearm_box_extras")
    group:entry { item = "hptjhpmag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_usp_45", kind = "collection", container = "box_pistol" }
    group:item("usp_45")
    group:group("firearm_box_extras")
    group:entry { item = "usp45mag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_boxed_380", kind = "distribution" }
    group:group("boxed_rugerlcp", 231)
    group:group("boxed_hptcf380")
    group:group("boxed_swbodyguard", 1673)
    group:group("boxed_glock_42", 439)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_rugerlcp", kind = "collection", container = "box_pistol" }
    group:item("rugerlcp")
    group:group("firearm_box_extras")
    group:entry { item = "rugerlcpmag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_swbodyguard", kind = "collection", container = "box_pistol" }
    group:item("swbodyguard")
    group:group("firearm_box_extras")
    group:entry { item = "swbodyguard_mag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_hptcf380", kind = "collection", container = "box_pistol" }
    group:item("hptcf380")
    group:group("firearm_box_extras")
    group:entry {
        distribution = {
            { item = "hptcf380mag_8rd", probability = 80 },
            { item = "hptcf380mag_10rd", probability = 20 },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_glock_42", kind = "collection", container = "box_pistol" }
    group:item("glock_42")
    group:group("firearm_box_extras")
    group:entry { item = "glock42_mag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_boxed_40", kind = "distribution" }
    group:group("boxed_glock_22")
    group:group("boxed_glock_23", 61)
    group:group("boxed_glock_27", 75)
    group:group("boxed_px4_40", 20)
    group:group("boxed_hi_power_40", 3)
    group:group("boxed_hptjcp", 29)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_glock_22", kind = "collection", container = "box_pistol" }
    group:item("glock_22")
    group:group("firearm_box_extras")
    group:entry { item = "glock40mag_10", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_glock_23", kind = "collection", container = "box_pistol" }
    group:item("glock_23")
    group:group("firearm_box_extras")
    group:entry { item = "glock40mag_10", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_glock_27", kind = "collection", container = "box_pistol" }
    group:item("glock_27")
    group:group("firearm_box_extras")
    group:entry { item = "glock40mag_9", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_px4_40", kind = "collection", container = "box_pistol" }
    group:item("px4_40")
    group:group("firearm_box_extras")
    group:entry { item = "px4_40mag_10", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_hi_power_40", kind = "collection", container = "box_pistol" }
    group:item("hi_power_40")
    group:group("firearm_box_extras")
    group:entry { item = "bhp40mag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_hptjcp", kind = "collection", container = "box_pistol" }
    group:item("hptjcp")
    group:group("firearm_box_extras")
    group:entry { item = "hptjcpmag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_boxed_357mag", kind = "distribution" }
    group:group("boxed_357_revolver", 179)
    group:group("boxed_sw_619")
    group:group("boxed_deagle_357", 38)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_357_revolver", kind = "collection", container = "box_pistol" }
    group:item("38_speedloader6", 5)
    group:group("firearm_box_extras")
    group:entry {
        distribution = {
            { item = "rp63", probability = 11 },
            { item = "colt_python", probability = 96 },
            { item = "chiappa_rhino", probability = 72 },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_sw_619", kind = "collection", container = "box_pistol" }
    group:item("sw_619")
    group:group("firearm_box_extras")
    group:item("38_speedloader", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_deagle_357", kind = "collection", container = "box_pistol" }
    group:group("modular_deagle_357")
    group:group("firearm_box_extras")
    group:entry { item = "deaglemag_357", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_boxed_38", kind = "distribution" }
    group:group("boxed_ruger_lcr_38", 66)
    group:group("boxed_model_10_revolver")
    group:group("boxed_sw642", 81)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_ruger_lcr_38", kind = "collection", container = "box_pistol" }
    group:item("ruger_lcr_38")
    group:group("firearm_box_extras")
    group:item("38_speedloader5", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_sw642", kind = "collection", container = "box_pistol" }
    group:item("sw642")
    group:group("firearm_box_extras")
    group:item("38_speedloader5", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_model_10_revolver", kind = "collection", container = "box_pistol" }
    group:item("model_10_revolver")
    group:group("firearm_box_extras")
    group:item("38_speedloader6", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_boxed_44", kind = "distribution" }
    group:group("boxed_44_revolver", 147)
    group:group("boxed_deagle_44", 8)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_44_revolver", kind = "collection", container = "box_pistol" }
    group:item("44_speedloader6", 5)
    group:group("firearm_box_extras")
    group:entry {
        distribution = {
            { item = "sw629" },
            { item = "colt_anaconda_8", probability = 15 },
            { item = "colt_anaconda_6", probability = 24 },
            { item = "colt_anaconda_4", probability = 8 },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_deagle_44", kind = "collection", container = "box_pistol" }
    group:group("modular_deagle_44")
    group:group("firearm_box_extras")
    group:entry { item = "deaglemag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_boxed_45colt", kind = "distribution" }
    group:group("boxed_410_revolver", 109)
    group:group("boxed_colt_saa", 26)
    group:group("boxed_bond_410", 16)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_410_revolver", kind = "collection", container = "box_pistol" }
    group:item("454_speedloader5", 5)
    group:group("firearm_box_extras")
    group:entry {
        distribution = {
            { item = "raging_bull", probability = 9 },
            { item = "taurus_judge" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_colt_saa", kind = "collection", container = "box_pistol" }
    group:item("colt_saa")
    group:group("firearm_box_extras")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_bond_410", kind = "collection", container = "box_pistol" }
    group:item("bond_410")
    group:group("firearm_box_extras")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_boxed_10mm", kind = "distribution" }
    group:group("boxed_10mm_glocks", 466)
    group:group("boxed_m1911_10", 30)
    group:group("boxed_p220_10", 35)
    group:group("boxed_xd_10", 85)
    group:group("boxed_witness_10", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_10mm_glocks", kind = "collection", container = "box_pistol" }
    group:entry { item = "glock_20mag_10", count = { 1, 2 } }
    group:group("firearm_box_extras")
    group:entry {
        distribution = {
            { item = "glock_40" },
            { item = "glock_20", probability = 121 },
            { item = "glock_29", probability = 62 },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_m1911_10", kind = "collection", container = "box_pistol" }
    group:item("m1911_10")
    group:group("firearm_box_extras")
    group:entry { item = "m1911_10mag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_p220_10", kind = "collection", container = "box_pistol" }
    group:item("p220_10")
    group:group("firearm_box_extras")
    group:entry { item = "p220_10_mag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_xd_10", kind = "collection", container = "box_pistol" }
    group:item("xd_10")
    group:group("firearm_box_extras")
    group:entry { item = "xd_10_mag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_witness_10", kind = "collection", container = "box_pistol" }
    group:item("witness_10")
    group:group("firearm_box_extras")
    group:entry { item = "witness_mag_10", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "guns_pistol_common_boxed_223",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_handgun",
    }
    group:group("stanag_restricted")
    group:group("firearm_box_extras")
    group:entry {
        distribution = {
            { group = "ar_pistol", probability = 8 },
            { group = "ar_pistol_long", probability = 10 },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "guns_pistol_common_boxed_300",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_handgun",
    }
    group:group("stanag_restricted")
    group:group("firearm_box_extras")
    group:entry {
        distribution = {
            { group = "ar_pistol_300", probability = 2 },
            { group = "ar_pistol_300_long", probability = 5 },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_boxed_57", kind = "distribution" }
    group:group("boxed_ruger_57")
    group:group("boxed_fn57", 13)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_ruger_57", kind = "collection", container = "box_pistol" }
    group:item("ruger_57")
    group:group("firearm_box_extras")
    group:entry { item = "ruger_57_10_round_mag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_fn57", kind = "collection", container = "box_pistol" }
    group:item("fn57")
    group:group("firearm_box_extras")
    group:entry { item = "fn57mag_10rd", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_boxed_460", kind = "collection", container = "box_pistol" }
    group:item("460_xvr")
    group:group("firearm_box_extras")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_boxed_32", kind = "distribution" }
    group:group("boxed_walther_ppk", 71)
    group:group("boxed_lws32", 2000)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_walther_ppk", kind = "collection", container = "box_pistol" }
    group:item("walther_ppk")
    group:group("firearm_box_extras")
    group:entry { item = "ppkmag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_lws32", kind = "collection", container = "box_pistol" }
    group:item("lws32")
    group:group("firearm_box_extras")
    group:entry { item = "lws32mag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_boxed_38super", kind = "collection", container = "box_pistol" }
    group:item("m1911a1_38super")
    group:group("firearm_box_extras")
    group:entry { item = "m1911mag_10rd_38super", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_boxed_other", kind = "distribution" }
    group:group("boxed_bfr", 5)
    group:group("boxed_deagle_50", 10)
    group:group("boxed_sw_500", 29)
    group:group("boxed_makarov", 7)
    group:group("boxed_tokarev", 7)
    group:group("boxed_ar15_450short", 3)
    group:group("boxed_ar15_50short", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_bfr", kind = "collection", container = "box_pistol" }
    group:item("bfr")
    group:group("firearm_box_extras")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_deagle_50", kind = "collection", container = "box_pistol" }
    group:group("modular_deagle_50")
    group:group("firearm_box_extras")
    group:entry { item = "deaglemag_50", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_sw_500", kind = "collection", container = "box_pistol" }
    group:item("sw_500")
    group:group("firearm_box_extras")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_makarov", kind = "collection", container = "box_pistol" }
    group:item("makarov")
    group:group("firearm_box_extras")
    group:entry { item = "makarovmag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxed_tokarev", kind = "collection", container = "box_pistol" }
    group:item("tokarev")
    group:group("firearm_box_extras")
    group:entry { item = "tokarevmag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_ar15_450short",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_handgun",
    }
    group:group("ar15_450short")
    group:group("firearm_box_extras")
    group:entry { item = "450_ar15mag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_ar15_50short",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_handgun",
    }
    group:group("ar15_50short")
    group:group("firearm_box_extras")
    group:entry { item = "50beowulf_ar15mag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_boxed", kind = "distribution" }
    group:group("guns_rifle_common_boxed_22", 1760)
    group:group("guns_rifle_common_boxed_223", 1000)
    group:group("guns_rifle_common_boxed_308", 320)
    group:group("guns_rifle_common_boxed_45acp", 271)
    group:group("guns_rifle_common_boxed_762", 230)
    group:group("guns_rifle_common_boxed_9mm", 180)
    group:group("guns_rifle_common_boxed_3006", 149)
    group:group("guns_rifle_common_boxed_357", 108)
    group:group("guns_rifle_common_boxed_44", 81)
    group:group("guns_rifle_common_boxed_3030", 74)
    group:group("guns_rifle_common_boxed_762R", 70)
    group:group("guns_rifle_common_boxed_270win", 57)
    group:group("guns_rifle_common_boxed_300winmag", 32)
    group:group("guns_rifle_common_boxed_380", 24)
    group:group("guns_rifle_common_boxed_300blk", 19)
    group:group("guns_rifle_common_boxed_4570", 18)
    group:group("guns_rifle_common_boxed_30carbine", 17)
    group:group("guns_rifle_common_boxed_303", 16)
    group:group("guns_rifle_common_boxed_338", 14)
    group:group("guns_rifle_common_boxed_450", 3)
    group:group("guns_rifle_common_boxed_50beowulf", 3)
    group:group("guns_rifle_common_boxed_57", 3)
    group:group("guns_rifle_common_boxed_545", 3)
    group:group("guns_rifle_common_boxed_7mm_arisaka", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_boxed_22", kind = "distribution" }
    group:group("boxed_internal_magazine_22", 64)
    group:group("boxed_ruger_1022")
    group:group("boxed_ar15_22", 2)
    group:group("boxed_mp_15_22", 45)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_internal_magazine_22",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:group("firearm_box_extras")
    group:entry {
        distribution = {
            { item = "marlin_9a", probability = 3 },
            { item = "rossi_gallery", probability = 11 },
            { item = "rio_bravo", probability = 15 },
            { item = "henry_golden_boy", probability = 31 },
            { item = "marlin60", probability = 20 },
            { item = "savage_rascal", probability = 4 },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_ruger_1022",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:item("ruger_1022")
    group:group("firearm_box_extras")
    group:entry { item = "ruger1022mag", count = { 1, 2 } }
    content.add(group)
end

do
    -- on_overflow field is here to allow it to pass tests until #79341 is merged.  Please remove once fixed
    local group = content.ItemGroup {
        id = "boxed_ar15_22",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
        overflow = "spill",
    }
    group:group("ar15_22")
    group:group("firearm_box_extras")
    group:entry { item = "22_ar15mag_10", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_mp_15_22",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:item("mp_15_22")
    group:group("firearm_box_extras")
    group:entry { item = "mp1522_mag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_boxed_223", kind = "distribution" }
    group:group("boxed_stanag_223", 650)
    group:group("boxed_ruger_mini")
    group:group("boxed_sl8", 3)
    group:group("boxed_ak556", 19)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_stanag_223",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:group("firearm_box_extras")
    group:group("stanag_restricted")
    group:entry {
        distribution = {
            { group = "ar15_223long", probability = 71 },
            { group = "modular_ar15", probability = 263 },
            { item = "bren2_556", probability = 4 },
            { item = "rdb_223", probability = 44 },
            { group = "mdrx", probability = 5 },
            { group = "mdrx_223", probability = 4 },
            { item = "sig_assault_rifle", probability = 1 },
            { item = "scar_16s", probability = 14 },
            { item = "iwi_tavor_x95_300blk", probability = 27 },
            { item = "mp_15", probability = 213 },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_ruger_mini",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:item("ruger_mini")
    group:group("firearm_box_extras")
    group:entry {
        distribution = {
            { item = "ruger5", count = { 1, 2 }, probability = 10 },
            { item = "ruger10", count = { 1, 2 }, probability = 90 },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_sl8",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:item("sl8")
    group:group("firearm_box_extras")
    group:entry { item = "sl8mag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_ak556",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:item("ak556")
    group:group("firearm_box_extras")
    group:entry { item = "zpap85mag_10rd", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_boxed_308", kind = "distribution" }
    group:group("boxed_ar10", 89)
    group:group("boxed_scar17s", 20)
    group:group("boxed_m1a")
    group:group("boxed_falmag", 11)
    group:group("boxed_hk_g3", 1)
    group:group("boxed_ak308", 20)
    group:group("boxed_steyr_scout", 6)
    group:group("boxed_remington_700", 78)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_ar10",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:item("ar10")
    group:group("firearm_box_extras")
    group:entry { item = "ar10mag_10rd", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_scar17s",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:item("scar_17s")
    group:group("firearm_box_extras")
    group:entry { item = "scarhmag_10", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_m1a",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:item("m1a")
    group:group("firearm_box_extras")
    group:entry { item = "m14smallmag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_falmag",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:entry { item = "falmag", count = { 1, 2 } }
    group:group("firearm_box_extras")
    group:entry {
        distribution = {
            { item = "rfb_308", probability = 6 },
            { item = "fn_fal_semi", probability = 5 },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_hk_g3",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:item("hk_g3")
    group:group("firearm_box_extras")
    group:entry { item = "g3mag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_ak308",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:item("ak308")
    group:group("firearm_box_extras")
    group:entry { item = "papm77mag_10rd", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_steyr_scout",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:item("steyr_scout")
    group:group("firearm_box_extras")
    group:entry { item = "steyr_scout_mag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_remington_700",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:item("remington_700")
    group:group("firearm_box_extras")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_boxed_45acp", kind = "distribution" }
    group:group("boxed_hk_usc45")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_hk_usc45",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:item("hk_usc45")
    group:group("firearm_box_extras")
    group:entry { item = "usc10mag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_boxed_762", kind = "distribution" }
    group:group("boxed_sks", 34)
    group:group("boxed_akmag", 126)
    group:group("boxed_ar15_762", 5)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_sks",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:item("sks")
    group:group("firearm_box_extras")
    group:entry { item = "762x39_clip", count = { 0, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_akmag",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:entry { item = "akmag10", count = { 1, 2 } }
    group:group("firearm_box_extras")
    group:entry {
        distribution = {
            { item = "aksemi" },
            { item = "mk47", probability = 26 },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_ar15_762",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:group("ar15_762")
    group:group("firearm_box_extras")
    group:entry {
        distribution = {
            { item = "762_ar15mag_5rd", count = { 1, 2 }, probability = 10 },
            { item = "762_ar15mag_10rd", count = { 1, 2 }, probability = 90 },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_boxed_9mm", kind = "distribution" }
    group:group("boxed_ksub2000", 84)
    group:group("boxed_rugerpcc")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_ksub2000",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:item("ksub2000")
    group:group("firearm_box_extras")
    group:entry { item = "glock17_10", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_rugerpcc",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:item("rugerpcc")
    group:group("firearm_box_extras")
    group:entry { item = "glock17_10", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_boxed_3006", kind = "distribution" }
    group:group("boxed_browning_blr", 4)
    group:group("boxed_internal_magazine_3006", 305)
    group:group("boxed_garand")
    group:group("boxed_m1903", 26)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_browning_blr",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:item("browning_blr")
    group:group("firearm_box_extras")
    group:entry { item = "blrmag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_internal_magazine_3006",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:group("firearm_box_extras")
    group:entry {
        distribution = {
            { item = "remington_700", probability = 243 },
            { item = "ruger_m77", probability = 62 },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_garand",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:item("garand")
    group:group("firearm_box_extras")
    group:entry { item = "garandclip", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_m1903",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:item("m1903")
    group:group("firearm_box_extras")
    group:entry { item = "3006_clip", count = { 0, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "guns_rifle_common_boxed_357",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:group("firearm_box_extras")
    group:entry {
        distribution = {
            { item = "uberti_1873" },
            { item = "rossi_r92_357_16", probability = 18 },
            { item = "rossi_r92_357_20", probability = 37 },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "guns_rifle_common_boxed_44",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:group("firearm_box_extras")
    group:entry {
        distribution = {
            { item = "henry_big_boy" },
            { item = "rossi_r92_44_16", probability = 185 },
            { item = "rossi_r92_44_20", probability = 121 },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "guns_rifle_common_boxed_3030",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:group("firearm_box_extras")
    group:entry {
        distribution = {
            { item = "winchester_94_3030", probability = 93 },
            { item = "marlin_336_3030" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_boxed_762R", kind = "distribution" }
    group:group("boxed_mosin", 123)
    group:group("boxed_psl", 13)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_mosin",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:entry { item = "762R_clip", count = { 0, 2 } }
    group:group("firearm_box_extras")
    group:entry {
        distribution = {
            { item = "mosin44", probability = 23 },
            { item = "mosin91_30" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_psl",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:item("psl")
    group:group("firearm_box_extras")
    group:entry {
        distribution = {
            { item = "pslmag5", count = { 1, 2 }, probability = 10 },
            { item = "pslmag10", count = { 1, 2 }, probability = 90 },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_boxed_270win", kind = "distribution" }
    group:group("boxed_remington700_270")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_remington700_270",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:item("remington700_270")
    group:group("firearm_box_extras")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_boxed_300winmag", kind = "distribution" }
    group:group("boxed_internal_magazine_300winmag", 127)
    group:group("boxed_ruger_pr", 40)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_internal_magazine_300winmag",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:group("firearm_box_extras")
    group:entry {
        distribution = {
            { item = "weatherby_5" },
            { item = "win70", probability = 27 },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_ruger_pr",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:item("ruger_pr")
    group:group("firearm_box_extras")
    group:entry { item = "ruger_pr_mag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_boxed_380", kind = "distribution" }
    group:group("boxed_hpt3895")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_hpt3895",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:item("hpt3895")
    group:group("firearm_box_extras")
    group:entry { item = "hpt3895mag_10rd", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_boxed_300blk", kind = "distribution" }
    group:group("boxed_ar15_300")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_ar15_300",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:group("ar15_300")
    group:group("firearm_box_extras")
    group:group("stanag_restricted")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "guns_rifle_common_boxed_4570",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:group("firearm_box_extras")
    group:entry {
        distribution = {
            { item = "sharps" },
            { item = "1895sbl", probability = 67 },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "guns_rifle_common_boxed_30carbine",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:item("m1carbine")
    group:group("firearm_box_extras")
    group:entry { item = "m1carbinemag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "guns_rifle_common_boxed_303",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:entry { item = "enfield_303mag", count = { 1, 2 } }
    group:entry { item = "clip303_5rd", count = { 0, 2 } }
    group:group("firearm_box_extras")
    group:entry {
        distribution = {
            { item = "number4_mki" },
            { item = "smle_mk3", probability = 53 },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_boxed_338", kind = "distribution" }
    group:group("boxed_mrad_smr")
    group:group("boxed_savage112", 1)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_mrad_smr",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:item("mrad_smr")
    group:group("firearm_box_extras")
    group:entry { item = "mrad_338lapua_mag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_savage112",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:item("savage112")
    group:group("firearm_box_extras")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_boxed_450", kind = "distribution" }
    group:group("boxed_ar15_450")
    group:group("boxed_ruger_arr", 97)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_ar15_450",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:group("ar15_450")
    group:group("firearm_box_extras")
    group:entry { item = "450_ar15mag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_ruger_arr",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:item("ruger_arr")
    group:group("firearm_box_extras")
    group:entry { item = "ruger_arr_mag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "guns_rifle_common_boxed_50beowulf",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:group("ar15_50")
    group:group("firearm_box_extras")
    group:entry { item = "50beowulf_ar15mag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_boxed_57", kind = "distribution" }
    group:group("boxed_fn_ps90")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_fn_ps90",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:item("fn_ps90")
    group:group("firearm_box_extras")
    group:entry { item = "fnp90mag_10rd", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "guns_rifle_common_boxed_545",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:item("ak74_semi")
    group:group("firearm_box_extras")
    group:entry { item = "ak74mag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_boxed_7mm_arisaka", kind = "distribution" }
    group:group("boxed_type99")
    group:group("boxed_type99_sniper", 4)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_type99",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:item("type99")
    group:group("firearm_box_extras")
    group:entry { item = "clip_77mm_arisaka", count = { 0, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_type99_sniper",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:item("type99_sniper")
    group:group("firearm_box_extras")
    group:entry { item = "clip_77mm_arisaka", count = { 0, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_shotgun_common_boxed", kind = "distribution" }
    group:group("12_gauge_semi_boxed", 48)
    group:group("12_gauge_pump_boxed", 34)
    group:group("12_gauge_break_boxed", 18)
    group:group("20_gauge_manual_boxed", 12)
    group:group("20_gauge_break_boxed", 2)
    group:group("boxed_410", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "12_gauge_semi_boxed", kind = "distribution" }
    group:group("12_gauge_semi_internal_magazine_boxed", 415)
    group:group("boxed_saiga_12", 28)
    group:group("boxed_m1919_mag", 271)
    group:group("boxed_srm_1216", 2)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "12_gauge_semi_internal_magazine_boxed",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_shotgun",
    }
    group:group("firearm_box_extras")
    group:entry {
        distribution = {
            { item = "benelli_sa", variant = "m2", probability = 45 },
            { item = "benelli_sa", variant = "sbe", probability = 65 },
            { item = "remington_1100", probability = 85 },
            { item = "browning_a5" },
            { item = "benelli_tsa", probability = 24 },
            { item = "mossberg_930", probability = 31 },
            { item = "benelli_m4", probability = 11 },
            { item = "tavor_12", probability = 53 },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_saiga_12",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_shotgun",
    }
    group:item("saiga_12")
    group:group("firearm_box_extras")
    group:entry { item = "saiga10mag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_m1919_mag",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_shotgun",
    }
    group:group("firearm_box_extras")
    group:entry { item = "mka_1919_5", count = { 1, 2 } }
    group:entry {
        distribution = {
            { item = "gfy_1", probability = 17 },
            { item = "ar12_shotgun", probability = 254 },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_srm_1216",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_shotgun",
    }
    group:item("srm_1216")
    group:group("firearm_box_extras")
    group:entry { item = "srm_1216_mag_16", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "12_gauge_pump_boxed", kind = "distribution" }
    group:group("12_gauge_pump_internal_magazine_boxed", 520)
    group:group("boxed_mossberg_590m", 34)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "12_gauge_pump_internal_magazine_boxed",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_shotgun",
    }
    group:group("firearm_box_extras")
    group:entry {
        distribution = {
            { item = "mossberg_500" },
            { item = "winchester_1897", probability = 17 },
            { item = "remington_870_express", probability = 43 },
            { item = "remington_870", probability = 49 },
            { item = "ithaca37", probability = 28 },
            { item = "mossberg_590", probability = 170 },
            { item = "ksg", probability = 78 },
            { item = "dp_12", probability = 25 },
            { item = "mossberg_590_shockwave", probability = 12 },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_mossberg_590m",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_shotgun",
    }
    group:item("mossberg_590m")
    group:group("firearm_box_extras")
    group:entry { item = "mossberg_590m_mag_5", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "12_gauge_break_boxed",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_shotgun",
    }
    group:group("firearm_box_extras")
    group:entry {
        distribution = {
            { item = "shotgun_s", probability = 11 },
            { item = "shotgun_d", probability = 87 },
            { item = "shotgun_triple", probability = 1 },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "20_gauge_manual_boxed", kind = "distribution" }
    group:group("20_gauge_pump_internal_magazine_boxed")
    group:group("boxed_savage_model_220", 83)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "20_gauge_pump_internal_magazine_boxed",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_shotgun",
    }
    group:group("firearm_box_extras")
    group:entry {
        distribution = {
            { item = "mossberg_500_20" },
            { item = "remington_870_20" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_savage_model_220",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_shotgun",
    }
    group:item("savage_model_220")
    group:group("firearm_box_extras")
    group:entry { item = "savage_220_magazine", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "20_gauge_break_boxed",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_shotgun",
    }
    group:group("firearm_box_extras")
    group:entry {
        distribution = {
            { item = "browning_citori_20" },
        },
    }
    content.add(group)
end
