local content = require("ccb").content

do
    -- Pistols that are able to be obtained legally, regardless of how rare they'd be.  Numbers are based off of Gunbroker, and any prob of 100 is the base gun that the other ones are compared to.
    -- Making the assumption any loaded gun will have additional ammo and mags with it.  The rare/other itemgroups are to handle firearms that are too rare to show up as a whole number, but would still exist in some capacity.
    local group = content.ItemGroup { id = "guns_pistol_common_9mm", kind = "distribution" }
    group:group("nested_glock_17", 73)
    group:group("nested_glock_19")
    group:group("nested_glock_26", 14)
    group:group("nested_glock_34", 11)
    group:group("nested_glock_43", 13)
    group:group("nested_glock_43x", 51)
    group:group("nested_glock_48", 19)
    group:group("nested_p365", 161)
    group:group("nested_m9", 22)
    group:group("nested_px4", 5)
    group:group("nested_hi_power_9mm", 9)
    group:group("nested_walther_ppq_9mm", 8)
    group:group("nested_cz75", 65)
    group:group("nested_hptc9", 12)
    group:group("nested_walther_ccp", 2)
    group:group("nested_m18", 22)
    group:group("nested_m11", 6)
    group:group("nested_hk_mp5_semi_pistol", 10)
    group:group("nested_m17", 24)
    group:group("nested_p226_9mm", 73)
    group:group("nested_sp2022", 4)
    group:group("nested_usp_9mm", 38)
    group:group("nested_walther_p38", 9)
    group:group("guns_pistol_rare_9mm", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_22", kind = "distribution" }
    group:group("nested_walther_p22", 45)
    group:group("nested_sr22", 405)
    group:group("nested_ruger_lcr_22", 2)
    group:group("nested_rough_rider_pistol", 61)
    group:group("nested_rough_rider_pistol_9", 14)
    group:group("nested_sig_mosquito", 65)
    group:group("nested_ruger_mk4", 113)
    group:group("nested_1911_22")
    group:group("nested_sw617", 46)
    group:group("nested_glock_44", 13)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_45", kind = "distribution" }
    group:group("nested_glock_21", 14)
    group:group("nested_glock_30", 10)
    group:group("nested_glock_36", 3)
    group:group("nested_m1911")
    group:group("nested_walther_ppq_45", 1)
    group:group("nested_hptjhp", 2)
    group:group("nested_usp_45", 4)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_380", kind = "distribution" }
    group:group("nested_rugerlcp", 231)
    group:group("nested_hptcf380")
    group:group("nested_swbodyguard", 1673)
    group:group("nested_glock_42", 439)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_40", kind = "distribution" }
    group:group("nested_glock_22")
    group:group("nested_glock_23", 61)
    group:group("nested_glock_27", 75)
    group:group("nested_px4_40", 20)
    group:group("nested_hi_power_40", 3)
    group:group("nested_hptjcp", 29)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_357mag", kind = "distribution" }
    group:group("nested_sw_619")
    group:group("nested_rp63", 11)
    group:group("nested_colt_python", 96)
    group:group("nested_chiappa_rhino", 72)
    group:group("nested_modular_deagle_357", 38)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_38", kind = "distribution" }
    group:group("nested_ruger_lcr_38", 66)
    group:group("nested_model_10_revolver")
    group:group("nested_sw642", 81)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_44", kind = "distribution" }
    group:group("nested_sw629")
    group:group("nested_colt_anaconda", 47)
    group:group("nested_modular_deagle_44", 52)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_10mm", kind = "distribution" }
    group:group("nested_glock_40")
    group:group("nested_m1911_10", 30)
    group:group("nested_p220_10", 35)
    group:group("nested_xd_10", 85)
    group:group("nested_witness_10", 10)
    group:group("nested_glock_20", 121)
    group:group("nested_glock_29", 62)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_223", kind = "distribution" }
    group:group("nested_ar_pistol", 8)
    group:group("nested_ar_pistol_long", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_300", kind = "distribution" }
    group:group("nested_ar_pistol_300", 2)
    group:group("nested_ar_pistol_300_long", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_57", kind = "distribution" }
    group:group("nested_ruger_57")
    group:group("nested_fn57", 13)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_460", kind = "distribution" }
    group:group("nested_460_xvr")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_32", kind = "distribution" }
    group:group("nested_walther_ppk", 71)
    group:group("nested_lws32", 2000)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_45colt", kind = "distribution" }
    group:group("nested_raging_bull", 9)
    group:group("nested_taurus_judge")
    group:group("nested_colt_saa", 26)
    group:group("nested_bond_410", 16)
    content.add(group)
end

do
    -- Yes it's a bit stupid to have a separate group for just 1 gun but it makes it look nicer and organized
    local group = content.ItemGroup { id = "guns_pistol_common_38super", kind = "distribution" }
    group:group("nested_m1911a1_38super")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_other", kind = "distribution" }
    group:group("nested_bfr", 5)
    group:group("nested_modular_deagle_50", 10)
    group:group("nested_sw_500", 29)
    group:group("nested_makarov", 7)
    group:group("nested_tokarev", 7)
    group:group("nested_ar15_retool_450bushmaster_7", 3)
    group:group("nested_ar15_retool_50beowulf_7", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_display_9mm", kind = "distribution" }
    group:item("glock_17", 73)
    group:item("glock_19")
    group:item("glock_26", 14)
    group:item("glock_34", 11)
    group:item("glock_43", 13)
    group:item("glock_43x", 51)
    group:item("glock_48", 19)
    group:item("p365", 161)
    group:item("m9", 22, "m9")
    group:item("px4", 5)
    group:item("hi_power_9mm", 9)
    group:item("walther_ppq_9mm", 8)
    group:item("cz75", 65)
    group:item("walther_ccp", 2)
    group:item("hptc9", 12)
    group:item("m18", 22)
    group:item("m11", 6)
    group:item("hk_mp5_semi_pistol", 10)
    group:item("m17", 24)
    group:item("p226_9mm", 73)
    group:item("sp2022", 4)
    group:item("usp_9mm", 38)
    group:item("walther_p38", 9)
    group:group("guns_pistol_rare_display_9mm", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_display_22", kind = "distribution" }
    group:item("walther_p22", 45)
    group:item("sr22", 405)
    group:item("ruger_lcr_22", 2)
    group:item("rough_rider_pistol", 61)
    group:item("rough_rider_pistol_9", 14)
    group:item("sig_mosquito", 65)
    group:item("ruger_mk4", 113)
    group:item("1911_22")
    group:item("sw617", 46)
    group:item("glock_44", 13)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_display_45", kind = "distribution" }
    group:item("glock_21", 14)
    group:item("glock_21", 10)
    group:item("glock_36", 3)
    group:item("m1911")
    group:item("walther_ppq_45", 1)
    group:item("hptjhp", 2)
    group:item("usp_45", 4)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_display_380", kind = "distribution" }
    group:item("rugerlcp", 231)
    group:item("hptcf380")
    group:item("swbodyguard", 1673)
    group:item("glock_42", 439)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_display_40", kind = "distribution" }
    group:item("glock_22")
    group:item("glock_23", 61)
    group:item("glock_27", 75)
    group:item("px4_40", 20)
    group:item("hi_power_40", 3)
    group:item("hptjcp", 29)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_display_357mag", kind = "distribution" }
    group:item("sw_619")
    group:item("rp63", 11)
    group:item("colt_python", 96)
    group:item("chiappa_rhino", 72)
    group:group("modular_deagle_357", 38)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_display_38", kind = "distribution" }
    group:item("ruger_lcr_38", 66)
    group:item("model_10_revolver")
    group:item("sw642", 81)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_display_44", kind = "distribution" }
    group:item("sw629")
    group:item("colt_anaconda_8", 15)
    group:item("colt_anaconda_6", 24)
    group:item("colt_anaconda_4", 8)
    group:group("modular_deagle_44", 52)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_display_45colt", kind = "distribution" }
    group:item("raging_bull", 9)
    group:item("taurus_judge")
    group:item("colt_saa", 26)
    group:item("bond_410", 16)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_display_10mm", kind = "distribution" }
    group:item("glock_40")
    group:item("m1911_10", 30)
    group:item("p220_10", 35)
    group:item("xd_10", 85)
    group:item("witness_10", 10)
    group:item("glock_20", 121)
    group:item("glock_29", 62)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_display_57", kind = "distribution" }
    group:item("ruger_57")
    group:item("fn57", 13)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_display_460", kind = "distribution" }
    group:item("460_xvr")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_display_223", kind = "distribution" }
    group:group("ar_pistol", 8)
    group:group("ar_pistol_long", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_display_300", kind = "distribution" }
    group:group("ar_pistol_300", 2)
    group:group("ar_pistol_300_long", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_display_32", kind = "distribution" }
    group:item("walther_ppk", 71)
    group:item("lws32", 2000)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_display_38super", kind = "distribution" }
    group:item("m1911a1_38super")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_display_other", kind = "distribution" }
    group:item("bfr", 5)
    group:group("modular_deagle_50", 10)
    group:item("sw_500", 29)
    group:item("makarov", 7)
    group:item("tokarev", 7)
    group:group("ar15_450short", 3)
    group:group("ar15_50short", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_rare_9mm", kind = "distribution" }
    group:group("nested_90two", 5)
    group:group("nested_p08", 13)
    group:group("nested_mauser_c96", 11)
    group:group("nested_mp40semi", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_rare_display_9mm", kind = "distribution" }
    group:item("m9", 5, "90two")
    group:item("p08", 13)
    group:item("mauser_c96", 11)
    group:item("mp40semi", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_22", kind = "distribution" }
    group:group("nested_marlin_9a", 3)
    group:group("nested_ruger_1022")
    group:group("nested_rossi_gallery", 11)
    group:group("nested_ar15_retool_22", 2)
    group:group("nested_rio_bravo", 15)
    group:group("nested_henry_golden_boy", 31)
    group:group("nested_marlin60", 20)
    group:group("nested_rascal", 4)
    group:group("nested_mp_15_22", 45)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_223", kind = "distribution" }
    group:group("nested_ar15_retool_223_20", 71)
    group:group("nested_ar15_retool_223_16", 263)
    group:group("nested_ruger_mini")
    group:group("nested_bren2_556", 4)
    group:group("nested_rdb_223", 44)
    group:group("nested_mdrx_retool_223rem_civilian", 9)
    group:group("nested_sl8", 3)
    group:group("nested_sig_assault_rifle", 1)
    group:group("nested_scar_16s", 14)
    group:group("nested_iwi_tavor_x95", 27)
    group:group("nested_mp_15", 213)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_308", kind = "distribution" }
    group:group("nested_ar10", 89)
    group:group("nested_scar_17s", 20)
    group:group("nested_m1a")
    group:group("nested_rfb_308", 6)
    group:group("nested_fn_fal", 5)
    group:group("nested_hk_g3", 1)
    group:group("nested_ak308", 20)
    group:group("nested_steyr_scout", 6)
    group:group("nested_remington_700_308", 83)
    content.add(group)
end

do
    -- Currently the only 45 acp rifle we have is quite rare.  Will be fixed soon
    local group = content.ItemGroup { id = "guns_rifle_common_45acp", kind = "distribution" }
    group:group("nested_hk_usc45", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_762", kind = "distribution" }
    group:group("nested_sks", 34)
    group:group("nested_aksemi")
    group:group("nested_mk47", 26)
    group:group("nested_ar15_retool_762", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_9mm", kind = "distribution" }
    group:group("nested_ksub2000", 84)
    group:group("nested_rugerpcc")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_3006", kind = "distribution" }
    group:group("nested_browning_blr", 4)
    group:group("nested_remington_700", 243)
    group:group("nested_ruger_m77", 62)
    group:group("nested_garand")
    group:group("nested_m1903", 26)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_357", kind = "distribution" }
    group:group("nested_uberti_1873")
    group:group("nested_rossi_r92_357_16", 18)
    group:group("nested_rossi_r92_357_20", 37)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_44", kind = "distribution" }
    group:group("nested_henry_big_boy")
    group:group("nested_rossi_r92_44_16", 185)
    group:group("nested_rossi_r92_44_20", 121)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_3030", kind = "distribution" }
    group:group("nested_winchester_94_3030", 93)
    group:group("nested_marlin_336_3030")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_762R", kind = "distribution" }
    group:group("nested_mosin44", 23)
    group:group("nested_mosin91_30")
    group:group("nested_psl", 13)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_270win", kind = "distribution" }
    group:group("nested_remington700_270")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_300winmag", kind = "distribution" }
    group:group("nested_weatherby_5")
    group:group("nested_ruger_pr", 40)
    group:group("nested_win70", 27)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_380", kind = "distribution" }
    group:group("nested_hpt3895", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_300blk", kind = "distribution" }
    group:group("nested_ar15_retool_300_16")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_4570", kind = "distribution" }
    group:group("nested_sharps")
    group:group("nested_1895sbl", 67)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_30carbine", kind = "distribution" }
    group:group("nested_m1carbine")
    content.add(group)
end

do
    -- To-do: convert enfields into variants
    local group = content.ItemGroup { id = "guns_rifle_common_303", kind = "distribution" }
    group:group("nested_number4")
    group:group("nested_mk3", 56)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_338", kind = "distribution" }
    group:group("nested_mrad_smr")
    group:group("nested_savage112", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_450", kind = "distribution" }
    group:group("nested_ar15_retool_450bushmaster_18")
    group:group("nested_ruger_arr", 97)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_50beowulf", kind = "distribution" }
    group:group("nested_ar15_retool_50beowulf_18", 26)
    group:group("nested_ar15_retool_50beowulf_16")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_57", kind = "distribution" }
    group:group("nested_fn_ps90")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_545", kind = "distribution" }
    group:group("nested_ak74")
    content.add(group)
end

do
    -- To-do: Convert sniper into variant
    local group = content.ItemGroup { id = "guns_rifle_common_7mm_arisaka", kind = "distribution" }
    group:group("nested_type99")
    group:group("nested_type99_sniper", 4)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_display_22", kind = "distribution" }
    group:item("ruger_1022")
    group:item("rossi_gallery", 11)
    group:item("marlin_9a", 3)
    group:group("ar15_22", 2)
    group:item("rio_bravo", 15)
    group:item("henry_golden_boy", 31)
    group:item("marlin60", 20)
    group:item("savage_rascal", 4)
    group:item("mp_15_22", 45)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_display_223", kind = "distribution" }
    group:group("ar15_223long", 71)
    group:group("modular_ar15", 263)
    group:item("ruger_mini")
    group:item("bren2_556", 4)
    group:item("rdb_223", 44)
    group:group("mdrx_223", 4)
    group:group("mdrx", 5)
    group:item("sl8", 3)
    group:item("sig_assault_rifle", 1)
    group:item("scar_16s", 14)
    group:item("iwi_tavor_x95_300blk", 27)
    group:item("mp_15", 213)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_display_308", kind = "distribution" }
    group:item("ar10", 89)
    group:item("scar_17s", 20)
    group:item("m1a")
    group:item("rfb_308", 7)
    group:item("fn_fal_semi", 5)
    group:item("hk_g3", 1)
    group:item("ak308", 20)
    group:item("steyr_scout", 6)
    group:item("remington_700_308", 83)
    content.add(group)
end

do
    -- Currently the only 45 acp rifle we have is quite rare.  Will be fixed soon
    local group = content.ItemGroup { id = "guns_rifle_common_display_45acp", kind = "distribution" }
    group:item("hk_usc45", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_display_762", kind = "distribution" }
    group:item("sks", 34)
    group:item("aksemi")
    group:item("mk47", 26)
    group:group("ar15_762", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_display_9mm", kind = "distribution" }
    group:item("ksub2000", 84)
    group:item("rugerpcc")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_display_3006", kind = "distribution" }
    group:item("browning_blr", 4)
    group:item("remington_700", 243)
    group:item("ruger_m77", 62)
    group:item("garand")
    group:item("m1903", 26)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_display_357", kind = "distribution" }
    group:item("uberti_1873")
    group:item("rossi_r92_357_16", 18)
    group:item("rossi_r92_357_20", 37)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_display_44", kind = "distribution" }
    group:item("henry_big_boy")
    group:item("rossi_r92_44_16", 185)
    group:item("rossi_r92_44_20", 121)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_display_3030", kind = "distribution" }
    group:item("winchester_94_3030", 93)
    group:item("marlin_336_3030")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_display_762R", kind = "distribution" }
    group:item("mosin44", 23)
    group:item("mosin91_30")
    group:item("psl", 13)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_display_270win", kind = "distribution" }
    group:item("remington700_270", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_display_300winmag", kind = "distribution" }
    group:item("weatherby_5")
    group:item("ruger_pr", 40)
    group:item("win70", 27)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_display_380", kind = "distribution" }
    group:item("hpt3895", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_display_300blk", kind = "distribution" }
    group:group("ar15_300")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_display_4570", kind = "distribution" }
    group:item("sharps")
    group:item("1895sbl", 67)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_display_30carbine", kind = "distribution" }
    group:item("m1carbine")
    content.add(group)
end

do
    -- To-do: convert enfields into variants
    local group = content.ItemGroup { id = "guns_rifle_common_display_303", kind = "distribution" }
    group:item("number4_mki")
    group:item("smle_mk3", 56)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_display_338", kind = "distribution" }
    group:item("mrad_smr")
    group:item("savage112", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_display_450", kind = "distribution" }
    group:group("ar15_450")
    group:item("ruger_arr", 97)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_display_50beowulf", kind = "distribution" }
    group:group("ar15_50")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_display_57", kind = "distribution" }
    group:item("fn_ps90")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_display_545", kind = "distribution" }
    group:item("ak74_semi")
    content.add(group)
end

do
    -- To-do: Convert sniper into variant
    local group = content.ItemGroup { id = "guns_rifle_common_display_7mm_arisaka", kind = "distribution" }
    group:item("type99")
    group:item("type99_sniper", 4)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "12_gauge_semi", kind = "distribution" }
    group:group("nested_benelli_m2", 45)
    group:group("nested_black_eagle", 65)
    group:group("nested_remington_1100", 85)
    group:group("nested_browning_a5")
    group:group("nested_benelli_m2_tac", 24)
    group:group("nested_mossberg_930", 31)
    group:group("nested_m1014", 6)
    group:group("nested_benelli_m4", 5)
    group:group("nested_saiga_12", 28)
    group:group("nested_tavor_12", 53)
    group:group("nested_gfy_1", 17)
    group:group("nested_srm_1216", 2)
    group:group("nested_ar12_shotgun", 254)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "12_gauge_pump", kind = "distribution" }
    group:group("nested_mossberg_500")
    group:group("nested_winchester_1897", 17)
    group:group("nested_remington_870_express", 43)
    group:group("nested_remington_870", 49)
    group:group("nested_ithaca37", 28)
    group:group("nested_mossberg_590", 170)
    group:group("nested_mossberg_590m", 34)
    group:group("nested_ksg", 78)
    group:group("nested_dp_12", 25)
    group:group("nested_mossberg_590_shockwave", 12)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "12_gauge_break", kind = "distribution" }
    group:group("nested_shotgun_s", 11)
    group:group("nested_shotgun_d", 87)
    group:group("nested_shotgun_triple", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "12_gauge_semi_display", kind = "distribution" }
    group:item("benelli_sa", 45, "m2")
    group:item("benelli_sa", 65, "sbe")
    group:item("remington_1100", 85)
    group:item("browning_a5")
    group:item("benelli_tsa", 24)
    group:item("mossberg_930", 31)
    group:item("benelli_m4", 11)
    group:item("saiga_12", 28)
    group:item("tavor_12", 53)
    group:item("gfy_1", 17)
    group:item("srm_1216", 2)
    group:item("ar12_shotgun", 254)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "12_gauge_pump_display", kind = "distribution" }
    group:item("mossberg_500")
    group:item("winchester_1897", 17)
    group:item("remington_870_express", 43)
    group:item("remington_870", 49)
    group:item("ithaca37", 28)
    group:item("mossberg_590", 170)
    group:item("mossberg_590m", 34)
    group:item("ksg", 78)
    group:item("dp_12", 25)
    group:item("mossberg_590_shockwave", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "12_gauge_break_display", kind = "distribution" }
    group:item("shotgun_s", 11)
    group:item("shotgun_d", 87)
    group:item("shotgun_triple", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "20_gauge_pump", kind = "distribution" }
    group:group("nested_mossberg_500_20")
    group:group("nested_remington_870_20")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "20_gauge_bolt", kind = "distribution" }
    group:group("nested_savage_model_220")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "20_gauge_break", kind = "distribution" }
    group:group("nested_browning_citori_20")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "20_gauge_pump_display", kind = "distribution" }
    group:item("mossberg_500_20")
    group:item("remington_870_20")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "20_gauge_bolt_display", kind = "distribution" }
    group:item("savage_model_220")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "20_gauge_break_display", kind = "distribution" }
    group:item("browning_citori_20")
    content.add(group)
end

do
    -- If the gun is designed for conceal carry, such as being small, use prob from guns_pistol_common.  If full sized, 10-20% of the original prob.  This is an asspull but I know that full sized handguns are gonna be less commonly carried
    local group = content.ItemGroup { id = "guns_pistol_common_everyday_carry_9mm", kind = "distribution" }
    group:entry { item = "glock_17", charges = { 0, -1 }, probability = 7 }
    group:entry { item = "glock_19", charges = { 0, -1 } }
    group:entry { item = "glock_26", charges = { 0, -1 }, probability = 14 }
    group:entry { item = "glock_34", charges = { 0, -1 }, probability = 1 }
    group:entry { item = "glock_43", charges = { 0, -1 }, probability = 13 }
    group:entry { item = "glock_43x", charges = { 0, -1 }, probability = 51 }
    group:entry { item = "glock_48", charges = { 0, -1 }, probability = 19 }
    group:entry { item = "p365", charges = { 0, -1 }, probability = 161 }
    group:entry { item = "m9", charges = { 0, -1 }, variant = "m9", probability = 2 }
    group:entry { item = "px4", charges = { 0, -1 }, probability = 5 }
    group:entry { item = "hi_power_9mm", charges = { 0, -1 }, probability = 2 }
    group:entry { item = "walther_ppq_9mm", charges = { 0, -1 }, probability = 4 }
    group:entry { item = "hptc9", charges = { 0, -1 }, probability = 2 }
    group:entry { item = "cz75", charges = { 0, -1 }, probability = 7 }
    group:entry { item = "walther_ccp", charges = { 0, -1 }, probability = 2 }
    group:entry { item = "m18", charges = { 0, -1 }, probability = 22 }
    group:entry { item = "m11", charges = { 0, -1 }, probability = 6 }
    group:entry { item = "m17", charges = { 0, -1 }, probability = 5 }
    group:entry { item = "p226_9mm", charges = { 0, -1 }, probability = 11 }
    group:entry { item = "sp2022", charges = { 0, -1 }, probability = 4 }
    group:entry { item = "usp_9mm", charges = { 0, -1 }, probability = 6 }
    group:entry { item = "walther_p38", charges = { 0, -1 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_everyday_carry_22", kind = "distribution" }
    group:entry { item = "sig_mosquito", charges = { 0, -1 }, probability = 6 }
    group:entry { item = "sr22", charges = { 0, -1 }, probability = 80 }
    group:entry { item = "walther_p22", charges = { 0, -1 }, probability = 45 }
    group:entry { item = "ruger_lcr_22", charges = { 0, -1 }, probability = 2 }
    group:entry { item = "ruger_mk4", charges = { 0, -1 }, probability = 16 }
    group:entry { item = "1911_22", charges = { 0, -1 }, probability = 20 }
    group:entry { item = "glock_44", charges = { 0, -1 }, probability = 13 }
    group:entry { item = "sw617", charges = { 0, -1 }, probability = 8 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_everyday_carry_45", kind = "distribution" }
    group:entry { item = "glock_21", charges = { 0, -1 }, probability = 2 }
    group:entry { item = "glock_30", charges = { 0, -1 }, probability = 10 }
    group:entry { item = "glock_36", charges = { 0, -1 }, probability = 3 }
    group:entry { item = "m1911", charges = { 0, -1 }, probability = 13 }
    group:entry { item = "walther_ppq_45", charges = { 0, -1 }, probability = 1 }
    group:entry { item = "hptjhp", charges = { 0, -1 }, probability = 1 }
    group:entry { item = "usp_45", charges = { 0, -1 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_everyday_carry_380", kind = "distribution" }
    group:entry { item = "rugerlcp", charges = { 0, -1 }, probability = 231 }
    group:entry { item = "hptcf380", charges = { 0, -1 }, probability = 15 }
    group:entry { item = "swbodyguard", charges = { 0, -1 }, probability = 1673 }
    group:entry { item = "glock_42", charges = { 0, -1 }, probability = 439 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_everyday_carry_40", kind = "distribution" }
    group:entry { item = "glock_22", charges = { 0, -1 }, probability = 10 }
    group:entry { item = "glock_23", charges = { 0, -1 }, probability = 61 }
    group:entry { item = "glock_27", charges = { 0, -1 }, probability = 75 }
    group:entry { item = "px4_40", charges = { 0, -1 }, probability = 20 }
    group:entry { item = "hi_power_40", charges = { 0, -1 }, probability = 1 }
    group:entry { item = "hptjcp", charges = { 0, -1 }, probability = 3 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_everyday_carry_357mag", kind = "distribution" }
    group:entry { item = "sw_619", charges = { 0, -1 }, probability = 10 }
    group:entry { item = "rp63", charges = { 0, -1 }, probability = 11 }
    group:entry { item = "colt_python", charges = { 0, -1 }, probability = 10 }
    group:entry { item = "chiappa_rhino", charges = { 0, -1 }, probability = 7 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_everyday_carry_38", kind = "distribution" }
    group:entry { item = "ruger_lcr_38", charges = { 0, -1 }, probability = 66 }
    group:entry { item = "sw642", charges = { 0, -1 } }
    group:entry { item = "model_10_revolver", charges = { 0, -1 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_everyday_carry_44", kind = "distribution" }
    group:entry { item = "sw629", charges = { 0, -1 }, probability = 10 }
    group:entry { item = "colt_anaconda_6", charges = { 0, -1 }, probability = 4 }
    group:entry { item = "colt_anaconda_4", charges = { 0, -1 }, probability = 12 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_everyday_carry_10mm", kind = "distribution" }
    group:entry { item = "glock_40", charges = { 0, -1 }, probability = 5 }
    group:entry { item = "m1911_10", charges = { 0, -1 }, probability = 3 }
    group:entry { item = "p220_10", charges = { 0, -1 }, probability = 4 }
    group:entry { item = "xd_10", charges = { 0, -1 }, probability = 9 }
    group:entry { item = "witness_10", charges = { 0, -1 }, probability = 1 }
    group:entry { item = "glock_20", charges = { 0, -1 }, probability = 12 }
    group:entry { item = "glock_29", charges = { 0, -1 }, probability = 62 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_everyday_carry_57", kind = "distribution" }
    group:entry { item = "ruger_57", charges = { 0, -1 }, probability = 10 }
    group:entry { item = "fn57", charges = { 0, -1 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_everyday_carry_32", kind = "distribution" }
    group:entry { item = "walther_ppk", charges = { 0, -1 }, probability = 1 }
    group:entry { item = "lws32", charges = { 0, -1 }, probability = 200 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_everyday_carry_45colt", kind = "distribution" }
    group:entry { item = "taurus_judge", charges = { 0, -1 }, probability = 10 }
    group:entry { item = "colt_saa", charges = { 0, -1 }, probability = 2 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_everyday_carry_38super", kind = "distribution" }
    group:entry { item = "m1911a1_38super", charges = { 0, -1 } }
    content.add(group)
end
