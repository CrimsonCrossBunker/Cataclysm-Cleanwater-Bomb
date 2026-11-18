local content = require("ccb").content

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_glock_17", kind = "collection", with_ammo = 100 }
    group:entry { item = "glock_17", charges = { 0, 15 } }
    group:item("glock17_17")
    group:item("glock17_17", 50)
    group:group("on_hand_9mm")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_glock_19", kind = "collection", with_ammo = 100 }
    group:entry { item = "glock_19", charges = { 0, 15 } }
    group:item("glockmag")
    group:item("glockmag", 50)
    group:group("on_hand_9mm")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_glock_26", kind = "collection", with_ammo = 100 }
    group:entry { item = "glockmag", charges = { 0, 15 } }
    group:item("glockmag")
    group:item("glockmag", 50)
    group:group("on_hand_9mm")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_glock_34", kind = "collection", with_ammo = 100 }
    group:entry { item = "glock_34", charges = { 0, 15 } }
    group:item("glock17_17")
    group:item("glock17_17", 50)
    group:group("on_hand_9mm")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_glock_42", kind = "collection", with_ammo = 100 }
    group:entry { item = "glock_42", charges = { 0, 6 } }
    group:item("glock42_mag")
    group:item("glock42_mag", 50)
    group:group("on_hand_380")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_glock_43", kind = "collection", with_ammo = 100 }
    group:entry { item = "glock_43", charges = { 0, 6 } }
    group:item("glock43_mag")
    group:item("glock43_mag", 50)
    group:group("on_hand_9mm")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_glock_43x", kind = "collection", with_ammo = 100 }
    group:entry { item = "glock_43x", charges = { 0, 10 } }
    group:item("glock43x/48_mag")
    group:item("glock43x/48_mag", 50)
    group:group("on_hand_9mm")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_glock_48", kind = "collection", with_ammo = 100 }
    group:entry { item = "glock_48", charges = { 0, 10 } }
    group:item("glock43x/48_mag")
    group:item("glock43x/48_mag", 50)
    group:group("on_hand_9mm")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_glock_44", kind = "collection", with_ammo = 100 }
    group:entry { item = "glock_44", charges = { 0, 10 } }
    group:item("glock44_mag")
    group:item("glock44_mag", 50)
    group:group("on_hand_22")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_p365", kind = "collection", with_ammo = 100 }
    group:entry { item = "p365", charges = { 0, 10 } }
    group:item("p365_mag")
    group:item("p365_mag", 50)
    group:group("on_hand_9mm")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_glock_20", kind = "collection", with_ammo = 100 }
    group:entry { item = "glock_20", charges = { 0, 15 }, variant = "glock_20" }
    group:item("glock_20mag")
    group:item("glock_20mag", 50)
    group:group("on_hand_10mm")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_glock_21", kind = "collection", with_ammo = 100 }
    group:entry { item = "glock_21", charges = { 0, 15 } }
    group:item("glock_21mag")
    group:item("glock_21mag", 50)
    group:group("on_hand_45")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_glock_30", kind = "collection", with_ammo = 100 }
    group:entry { item = "glock_30", charges = { 0, 15 } }
    group:item("glock_21mag")
    group:item("glock_21mag", 50)
    group:group("on_hand_45")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_glock_36", kind = "collection", with_ammo = 100 }
    group:entry { item = "glock_36", charges = { 0, 15 } }
    group:item("glock36_mag")
    group:item("glock36_mag", 50)
    group:group("on_hand_45")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_hk_usc45", kind = "collection", with_ammo = 100 }
    group:entry { item = "hk_usc45", charges = { 0, 20 } }
    group:item("usc20mag")
    group:item("usc20mag", 50)
    group:group("on_hand_45")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_glock_29", kind = "collection", with_ammo = 100 }
    group:entry { item = "glock_29", charges = { 0, 10 } }
    group:item("glock_29mag")
    group:item("glock_29mag", 50)
    group:group("on_hand_10mm")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_glock_40", kind = "collection", with_ammo = 100 }
    group:entry { item = "glock_40", charges = { 0, 15 }, variant = "glock_40" }
    group:item("glock_20mag")
    group:item("glock_20mag", 50)
    group:group("on_hand_10mm")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_m1911", kind = "collection", with_ammo = 100 }
    group:entry { item = "m1911", charges = { 0, 7 } }
    group:item("m1911mag")
    group:item("m1911mag", 50)
    group:group("on_hand_45")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_m1911_MEU", kind = "collection", with_ammo = 100 }
    group:entry { item = "m1911", charges = { 0, 7 }, variant = "m1911_MEU" }
    group:item("m1911mag")
    group:item("m1911mag", 50)
    group:group("on_hand_45")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_m1911_10", kind = "collection", with_ammo = 100 }
    group:entry { item = "m1911_10", charges = { 0, 7 } }
    group:item("m1911_10mag")
    group:item("m1911_10mag", 50)
    group:group("on_hand_10mm")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_m9", kind = "collection", with_ammo = 100 }
    group:entry { item = "m9", charges = { 0, 15 }, variant = "m9" }
    group:item("m9mag")
    group:item("m9mag", 50)
    group:group("on_hand_9mm")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_px4", kind = "collection", with_ammo = 100 }
    group:entry { item = "px4", charges = { 0, 15 } }
    group:item("px4mag")
    group:item("px4mag", 50)
    group:group("on_hand_9mm")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_px4_40", kind = "collection", with_ammo = 100 }
    group:entry { item = "px4_40", charges = { 0, 15 } }
    group:item("px4_40mag")
    group:item("px4_40mag", 50)
    group:group("on_hand_40")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_ruger_lcr_38", kind = "collection", with_ammo = 100 }
    group:entry { item = "ruger_lcr_38", charges = { 0, 6 } }
    group:group("on_hand_38")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_sw642", kind = "collection", with_ammo = 100 }
    group:entry { item = "sw642", charges = { 0, 5 } }
    group:group("on_hand_38")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_sig_mosquito", kind = "collection", with_ammo = 100 }
    group:entry { item = "sig_mosquito", charges = { 0, 10 } }
    group:item("mosquitomag")
    group:item("mosquitomag", 50)
    group:group("on_hand_22")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_ruger_mk4", kind = "collection", with_ammo = 100 }
    group:entry { item = "ruger_mk4", charges = { 0, 10 } }
    group:item("ruger_mk4_mag")
    group:item("ruger_mk4_mag", 50)
    group:group("on_hand_22")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_sr22", kind = "collection", with_ammo = 100 }
    group:entry { item = "sr22", charges = { 0, 10 } }
    group:item("sr22_mag")
    group:item("sr22_mag", 50)
    group:group("on_hand_22")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_1911_22", kind = "collection", with_ammo = 100 }
    group:entry { item = "1911_22", charges = { 0, 10 } }
    group:item("1911_22_mag")
    group:item("1911_22_mag", 50)
    group:group("on_hand_22")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_marlin60", kind = "collection", with_ammo = 100 }
    group:entry { item = "marlin60", charges = { 0, 14 } }
    group:group("on_hand_22")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_sw_619", kind = "collection", with_ammo = 100 }
    group:entry { item = "sw_619", charges = { 0, 7 } }
    group:group("on_hand_38")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_colt_python", kind = "collection", with_ammo = 100 }
    group:entry { item = "colt_python", charges = { 0, 6 } }
    group:group("on_hand_357")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_model_10_revolver", kind = "collection", with_ammo = 100 }
    group:entry { item = "model_10_revolver", charges = { 0, 6 } }
    group:group("on_hand_38")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_chiappa_rhino", kind = "collection", with_ammo = 100 }
    group:entry { item = "chiappa_rhino", charges = { 0, 6 } }
    group:group("on_hand_357_38mixed")
    group:item("38_speedloader6")
    group:item("38_speedloader6", 50)
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_p220_10", kind = "collection", with_ammo = 100 }
    group:entry { item = "p220_10", charges = { 0, 8 } }
    group:item("p220_10_mag")
    group:item("p220_10_mag", 50)
    group:group("on_hand_10mm")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_p226_357sig", kind = "collection", with_ammo = 100 }
    group:entry { item = "p226_357sig", charges = { 0, 12 } }
    group:item("p226mag_12rd_357sig")
    group:item("p226mag_12rd_357sig", 50)
    group:group("on_hand_357sig")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_sp2022", kind = "collection", with_ammo = 100 }
    group:entry { item = "sp2022", charges = { 0, 15 } }
    group:item("sp2022mag_15rd_9mm")
    group:item("sp2022mag_15rd_9mm", 50)
    group:group("on_hand_9mm")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_p320_357sig", kind = "collection", with_ammo = 100 }
    group:entry { item = "p320_357sig", charges = { 0, 13 } }
    group:item("p320mag_13rd_357sig")
    group:item("p320mag_13rd_357sig", 50)
    group:group("on_hand_357sig")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_lws32", kind = "collection", with_ammo = 100 }
    group:entry { item = "lws32", charges = { 0, 6 } }
    group:item("lws32mag")
    group:item("lws32mag", 50)
    group:group("on_hand_32")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_rugerlcp", kind = "collection", with_ammo = 100 }
    group:entry { item = "rugerlcp", charges = { 0, 6 } }
    group:item("rugerlcpmag")
    group:item("rugerlcpmag", 50)
    group:group("on_hand_380")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_swbodyguard", kind = "collection", with_ammo = 100 }
    group:entry { item = "swbodyguard", charges = { 0, 6 } }
    group:item("swbodyguard_mag")
    group:item("swbodyguard_mag", 50)
    group:group("on_hand_380")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_hi_power_9mm", kind = "collection", with_ammo = 100 }
    group:entry { item = "hi_power_9mm", charges = { 0, 15 } }
    group:item("bhp9mag_13rd")
    group:item("bhp9mag_13rd", 50)
    group:group("on_hand_9mm")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_hi_power_40", kind = "collection", with_ammo = 100 }
    group:entry { item = "hi_power_40", charges = { 0, 10 } }
    group:item("bhp40mag")
    group:item("bhp40mag", 50)
    group:group("on_hand_40")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_walther_p38", kind = "collection", with_ammo = 100 }
    group:entry { item = "walther_p38", charges = { 0, 8 } }
    group:item("p38mag")
    group:item("p38mag", 50)
    group:group("on_hand_9mm")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_walther_ppq_9mm", kind = "collection", with_ammo = 100 }
    group:entry { item = "walther_ppq_9mm", charges = { 0, 17 } }
    group:item("ppq9mag_10rd")
    group:item("ppq9mag_10rd", 50)
    group:group("on_hand_9mm")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_walther_ppq_45", kind = "collection", with_ammo = 100 }
    group:entry { item = "walther_ppq_45", charges = { 0, 12 } }
    group:item("ppq45mag")
    group:item("ppq45mag", 50)
    group:group("on_hand_45")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_hptc9", kind = "collection", with_ammo = 100 }
    group:entry { item = "hptc9", charges = { 0, 15 } }
    group:item("hptc9mag_8rd")
    group:item("hptc9mag_8rd", 50)
    group:group("on_hand_9mm")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_hptcf380", kind = "collection", with_ammo = 100 }
    group:entry { item = "hptcf380", charges = { 0, 10 } }
    group:item("hptcf380mag_8rd")
    group:item("hptcf380mag_8rd", 50)
    group:group("on_hand_380")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_hpt3895", kind = "collection", with_ammo = 100 }
    group:entry { item = "hpt3895", charges = { 0, 10 } }
    group:item("hpt3895mag_10rd")
    group:item("hpt3895mag_10rd", 50)
    group:group("on_hand_380")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_hptjcp", kind = "collection", with_ammo = 100 }
    group:entry { item = "hptjcp", charges = { 0, 10 } }
    group:item("hptjcpmag")
    group:item("hptjcpmag", 50)
    group:group("on_hand_40")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_hptjhp", kind = "collection", with_ammo = 100 }
    group:entry { item = "hptjhp", charges = { 0, 9 } }
    group:item("hptjhpmag")
    group:item("hptjhpmag", 50)
    group:group("on_hand_45")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_xd_10", kind = "collection", with_ammo = 100 }
    group:entry { item = "xd_10", charges = { 0, 15 } }
    group:item("xd_10_mag")
    group:item("xd_10_mag", 50)
    group:group("on_hand_10mm")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_cz75", kind = "collection", with_ammo = 100 }
    group:entry { item = "cz75", charges = { 0, 26 } }
    group:item("cz75mag_16rd")
    group:item("cz75mag_16rd", 50)
    group:group("on_hand_9mm")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_witness_10", kind = "collection", with_ammo = 100 }
    group:entry { item = "witness_10", charges = { 0, 14 } }
    group:item("witness_mag_10")
    group:item("witness_mag_10", 50)
    group:group("on_hand_10mm")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_walther_ccp", kind = "collection", with_ammo = 100 }
    group:entry { item = "walther_ccp", charges = { 0, 8 } }
    group:item("ccpmag_9rd")
    group:item("ccpmag_9rd", 50)
    group:group("on_hand_9mm")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_walther_p22", kind = "collection", with_ammo = 100 }
    group:entry { item = "walther_p22", charges = { 0, 10 } }
    group:item("wp22mag")
    group:item("wp22mag", 50)
    group:group("on_hand_22")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_90two", kind = "collection", with_ammo = 100 }
    group:entry { item = "m9", charges = { 0, 15 }, variant = "90two" }
    group:item("m9mag_17rd")
    group:item("m9mag_17rd", 50)
    group:group("on_hand_9mm")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_bond_410", kind = "collection", with_ammo = 100 }
    group:entry { item = "bond_410", charges = { 0, 2 } }
    group:group("on_hand_45colt")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_m1911a1_38super", kind = "collection", with_ammo = 100 }
    group:entry { item = "m1911a1_38super", charges = { 0, 9 } }
    group:item("m1911mag_10rd_38super")
    group:item("m1911mag_10rd_38super", 50)
    group:group("on_hand_38super")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_fn57", kind = "collection", with_ammo = 100 }
    group:entry { item = "fn57", charges = { 0, 20 } }
    group:item("fn57mag")
    group:item("fn57mag", 50)
    group:group("on_hand_57")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_ruger_lcr_22", kind = "collection", with_ammo = 100 }
    group:entry { item = "ruger_lcr_22", charges = { 0, 8 } }
    group:group("on_hand_22")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_rough_rider_pistol", kind = "collection", with_ammo = 100 }
    group:entry { item = "rough_rider_pistol", charges = { 0, 6 } }
    group:group("on_hand_22")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_rough_rider_pistol_9", kind = "collection", with_ammo = 100 }
    group:entry { item = "rough_rider_pistol_9", charges = { 0, 6 } }
    group:group("on_hand_22")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_sw617", kind = "collection", with_ammo = 100 }
    group:entry { item = "sw617", charges = { 0, 10 } }
    group:group("on_hand_22")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_sig_40", kind = "collection", with_ammo = 100 }
    group:entry { item = "sig_40", charges = { 0, 12 } }
    group:item("sig40mag")
    group:item("sig40mag", 50)
    group:group("on_hand_40")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_sw_500", kind = "collection", with_ammo = 100 }
    group:entry { item = "sw_500", charges = { 0, 5 } }
    group:group("on_hand_500")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_sw629", kind = "collection", with_ammo = 100 }
    group:entry { item = "sw629", charges = { 0, 6 } }
    group:group("on_hand_44")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_colt_anaconda", kind = "collection", with_ammo = 100 }
    group:entry {
        distribution = {
            { item = "colt_anaconda_8", charges = { 0, 6 }, probability = 97 },
            { item = "colt_anaconda_6", charges = { 0, 6 }, probability = 143 },
            { item = "colt_anaconda_4", charges = { 0, 6 }, probability = 51 },
        },
    }
    group:group("on_hand_44")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_usp_45", kind = "collection", with_ammo = 100 }
    group:entry { item = "usp_45", charges = { 0, 12 } }
    group:item("usp45mag")
    group:item("usp45mag", 50)
    group:group("on_hand_45")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_usp_9mm", kind = "collection", with_ammo = 100 }
    group:entry { item = "usp_9mm", charges = { 0, 15 } }
    group:item("usp9mag")
    group:item("usp9mag", 50)
    group:group("on_hand_9mm")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_m17", kind = "collection", with_ammo = 100 }
    group:entry { item = "m17", charges = { 0, 17 } }
    group:item("p320mag_17rd_9x19mm")
    group:item("p320mag_17rd_9x19mm", 50)
    group:group("on_hand_9mm")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_m18", kind = "collection" }
    group:entry { item = "m18", charges = { 0, 17 } }
    group:item("p320mag_17rd_9x19mm")
    group:item("p320mag_17rd_9x19mm", 50)
    group:group("on_hand_9mm")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_m11", kind = "collection" }
    group:entry { item = "m11", charges = { 0, 13 } }
    group:item("p228mag_13rd_9x19mm")
    group:item("p228mag_13rd_9x19mm", 50)
    group:group("on_hand_9mm")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_glock_18c", kind = "collection", with_ammo = 100 }
    group:entry { item = "glock_18c", charges = { 0, 17 } }
    group:item("glock17_17")
    group:item("glock17_17", 50)
    group:group("on_hand_9mm")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_usp_45_mk23", kind = "collection", with_ammo = 100 }
    group:entry {
        item = "usp_45",
        charges = { 0, 12 },
        variant = "mk23",
        contents = {
            { group = "mk23_mods" },
        },
    }
    group:item("usp45mag")
    group:item("usp45mag", 50)
    group:group("on_hand_45")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_bfr", kind = "collection", with_ammo = 100 }
    group:item("bfr")
    group:group("on_hand_4570")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_mauser_c96", kind = "collection", with_ammo = 100 }
    group:item("mauser_c96")
    group:group("on_hand_9mm")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_p08", kind = "collection", with_ammo = 100 }
    group:item("p08")
    group:item("p08mag_8rd")
    group:item("p08mag_32rd", 50)
    group:group("on_hand_9mm")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_raging_bull", kind = "collection", with_ammo = 100 }
    group:item("raging_bull")
    group:group("on_hand_454")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_460_xvr", kind = "collection", with_ammo = 100 }
    group:item("460_xvr")
    group:group("on_hand_460sw")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_tokarev", kind = "collection", with_ammo = 100 }
    group:item("tokarev")
    group:item("tokarevmag")
    group:item("tokarevmag", 50)
    group:group("on_hand_762x25")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_walther_ppk", kind = "collection", with_ammo = 100 }
    group:item("walther_ppk")
    group:item("ppkmag")
    group:item("ppkmag", 50)
    group:group("on_hand_32")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_rm103a_pistol", kind = "collection", with_ammo = 100 }
    group:item("rm103a_pistol")
    group:item("8x40_10_mag")
    group:item("8x40_10_mag", 50)
    group:group("on_hand_8x40")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_makarov", kind = "collection", with_ammo = 100 }
    group:entry { item = "makarov", charges = { 0, 8 } }
    group:item("makarovmag")
    group:item("makarovmag", 50)
    group:group("on_hand_9x18")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_pistol_flintlock", kind = "collection", with_ammo = 100 }
    group:item("pistol_flintlock")
    group:group("on_hand_flintlock")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_colt_saa", kind = "collection", with_ammo = 100 }
    group:entry { item = "colt_saa", charges = { 0, 6 } }
    group:group("on_hand_45colt")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_mp40semi", kind = "collection", with_ammo = 100 }
    group:entry { item = "mp40semi", charges = { 0, 32 } }
    group:item("mp40mag_32rd")
    group:item("mp40mag_32rd", 50)
    group:group("on_hand_9mm")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_hk_mp5_semi_pistol", kind = "collection", with_ammo = 100 }
    group:entry { item = "hk_mp5_semi_pistol", charges = { 0, 30 } }
    group:item("mp5mag_10rd")
    group:item("mp5mag_10rd", 50)
    group:group("on_hand_9mm")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_fn_p90", kind = "collection", with_ammo = 100 }
    group:entry { item = "fn_p90", charges = { 0, 50 } }
    group:item("fnp90mag")
    group:item("fnp90mag", 50)
    group:group("on_hand_57")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_mp40", kind = "collection", with_ammo = 100 }
    group:entry { item = "mp40", charges = { 0, 32 } }
    group:item("mp40mag_32rd")
    group:item("mp40mag_32rd", 50)
    group:group("on_hand_9mm")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_tommygun", kind = "collection", with_ammo = 100 }
    group:entry { item = "tommygun", charges = { 0, 20 } }
    group:item("thompson_mag")
    group:item("thompson_mag", 50)
    group:group("on_hand_45")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_sten", kind = "collection", with_ammo = 100 }
    group:entry { item = "sten", charges = { 0, 32 } }
    group:item("stenmag")
    group:item("stenmag", 50)
    group:group("on_hand_9mm")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_uzi", kind = "collection", with_ammo = 100 }
    group:entry { item = "uzi", charges = { 0, 32 } }
    group:item("uzimag")
    group:item("uzimag", 50)
    group:group("on_hand_9mm")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_hk_mp5", kind = "collection", with_ammo = 100 }
    group:entry { item = "hk_mp5", charges = { 0, 30 } }
    group:item("mp5mag")
    group:item("mp5mag", 50)
    group:group("on_hand_9mm")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_hk_mp5sd", kind = "collection", with_ammo = 100 }
    group:entry { item = "hk_mp5", charges = { 0, 30 } }
    group:item("mp5mag")
    group:item("mp5mag", 50)
    group:group("on_hand_9mm")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_mac_10", kind = "collection", with_ammo = 100 }
    group:entry { item = "mac_10", charges = { 0, 30 } }
    group:item("mac10mag")
    group:item("mac10mag", 50)
    group:group("on_hand_45")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_mac_11", kind = "collection", with_ammo = 100 }
    group:entry { item = "mac_11", charges = { 0, 32 } }
    group:item("mac11mag")
    group:item("mac11mag", 50)
    group:group("on_hand_380")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_TDI", kind = "collection", with_ammo = 100 }
    group:entry { item = "TDI", charges = { 0, 30 } }
    group:item("tdi_mag")
    group:item("tdi_mag", 50)
    group:group("on_hand_45")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_briefcase_smg", kind = "collection", with_ammo = 100 }
    group:entry { item = "briefcase_smg", charges = { 0, 30 } }
    group:item("mp5mag_10rd")
    group:item("mp5mag_10rd", 50)
    group:group("on_hand_9mm")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_rm2000_smg", kind = "collection", with_ammo = 100 }
    group:entry { item = "rm2000_smg", charges = { 0, 10 } }
    group:item("8x40_10_mag")
    group:item("8x40_10_mag", 50)
    group:group("on_hand_8x40")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_hk_mp5k", kind = "collection", with_ammo = 100 }
    group:entry { item = "hk_mp5k", charges = { 0, 30 } }
    group:item("mp5mag")
    group:item("mp5mag", 50)
    group:group("on_hand_9mm")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_browning_blr", kind = "collection", with_ammo = 100 }
    group:entry { item = "browning_blr", charges = { 0, 4 } }
    group:item("blrmag")
    group:item("blrmag", 50)
    group:group("on_hand_3006")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_garand", kind = "collection", with_ammo = 100 }
    group:entry { item = "garand", charges = { 0, 8 } }
    group:item("garandclip")
    group:item("garandclip", 50)
    group:group("on_hand_3006")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_ar10", kind = "collection", with_ammo = 100 }
    group:entry { item = "ar10", charges = { 0, 20 } }
    group:item("ar10mag_20rd")
    group:item("ar10mag_20rd", 50)
    group:group("on_hand_308")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_ksub2000", kind = "collection", with_ammo = 100 }
    group:entry { item = "ksub2000", charges = { 0, 15 } }
    group:item("glockmag")
    group:item("glockmag", 50)
    group:group("on_hand_9mm")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_rugerpcc", kind = "collection", with_ammo = 100 }
    group:entry { item = "rugerpcc", charges = { 0, 15 } }
    group:item("glockmag")
    group:item("glockmag", 50)
    group:group("on_hand_9mm")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_m1a", kind = "collection", with_ammo = 100 }
    group:entry { item = "m1a", charges = { 0, 5 } }
    group:item("m14smallmag")
    group:item("m14smallmag", 50)
    group:group("on_hand_308")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_marlin_9a", kind = "collection", with_ammo = 100 }
    group:entry { item = "marlin_9a", charges = { 0, 19 } }
    group:group("on_hand_22")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_rio_bravo", kind = "collection", with_ammo = 100 }
    group:entry { item = "rio_bravo", charges = { 0, 15 } }
    group:group("on_hand_22")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_henry_golden_boy", kind = "collection", with_ammo = 100 }
    group:entry { item = "henry_golden_boy", charges = { 0, 16 } }
    group:group("on_hand_22")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_rascal", kind = "collection", with_ammo = 100 }
    group:entry { item = "savage_rascal", charges = { 0, 11 } }
    group:group("on_hand_22")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_rossi_gallery", kind = "collection", with_ammo = 100 }
    group:entry { item = "rossi_gallery", charges = { 0, 15 } }
    group:group("on_hand_22")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_mosin44", kind = "collection", with_ammo = 100 }
    group:entry { item = "mosin44", charges = { 0, 5 }, variant = "mosin44" }
    group:group("on_hand_762R")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_mosin91_30", kind = "collection", with_ammo = 100 }
    group:entry { item = "mosin91_30", charges = { 0, 5 }, variant = "mosin91_30" }
    group:group("on_hand_762R")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_psl", kind = "collection", with_ammo = 100 }
    group:entry { item = "psl", charges = { 0, 10 } }
    group:item("pslmag10")
    group:item("pslmag10", 50)
    group:item("pslmag5", 50)
    group:group("on_hand_762R")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_remington700_270", kind = "collection", with_ammo = 100 }
    group:entry { item = "remington700_270", charges = { 0, 4 } }
    group:group("on_hand_270win")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_remington_700", kind = "collection", with_ammo = 100 }
    group:entry { item = "remington_700", charges = { 0, 4 } }
    group:group("on_hand_3006")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_remington_700_308", kind = "collection", with_ammo = 100 }
    group:entry { item = "remington_700_308", charges = { 0, 4 } }
    group:group("on_hand_308")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_ruger_1022", kind = "collection", with_ammo = 100 }
    group:entry { item = "ruger_1022", charges = { 0, 10 } }
    group:item("ruger1022mag")
    group:item("ruger1022mag", 50)
    group:group("on_hand_22")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_mp_15_22", kind = "collection", with_ammo = 100 }
    group:entry { item = "mp_15_22", charges = { 0, 10 } }
    group:item("mp1522_mag")
    group:item("mp1522_mag", 50)
    group:group("on_hand_22")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_ruger_mini", kind = "collection", with_ammo = 100 }
    group:entry { item = "ruger_mini", charges = { 0, 5 } }
    group:item("ruger10")
    group:item("ruger10", 50)
    group:group("on_hand_223")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_mp_15", kind = "collection", with_ammo = 100 }
    group:entry { item = "mp_15", charges = { 0, 5 } }
    group:item("stanag10")
    group:item("stanag10", 50)
    group:group("on_hand_223")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_sks", kind = "collection", with_ammo = 100 }
    group:entry { item = "sks", charges = { 0, 10 } }
    group:group("on_hand_762")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_win70", kind = "collection", with_ammo = 100 }
    group:entry { item = "win70", charges = { 0, 3 } }
    group:group("on_hand_300")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_1895sbl", kind = "collection", with_ammo = 100 }
    group:entry { item = "1895sbl", charges = { 0, 6 } }
    group:group("on_hand_4570")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_aksemi", kind = "collection", with_ammo = 100 }
    group:entry { item = "aksemi", charges = { 0, 30 } }
    group:item("akmag10")
    group:item("akmag10", 50)
    group:group("on_hand_762")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_m16_auto_rifle", kind = "collection", with_ammo = 100 }
    group:entry { item = "modular_m16_auto_rifle", charges = { 0, 30 }, variant = "modular_m16a3" }
    group:item("stanag10")
    group:item("stanag10", 50)
    group:group("on_hand_223")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_fn_fal", kind = "collection", with_ammo = 100 }
    group:entry { item = "fn_fal_semi", charges = { 0, 20 } }
    group:item("falmag")
    group:item("falmag", 50)
    group:group("on_hand_308")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_m249_semi", kind = "collection", with_ammo = 100 }
    group:entry { item = "m249_semi", charges = { 0, 100 } }
    group:group("on_hand_223")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_hk_g3", kind = "collection", with_ammo = 100 }
    group:entry { item = "hk_g3", charges = { 0, 20 } }
    group:item("g3mag")
    group:item("g3mag", 50)
    group:group("on_hand_308")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_henry_big_boy", kind = "collection", with_ammo = 100 }
    group:entry { item = "henry_big_boy", charges = { 0, 10 } }
    group:group("on_hand_44")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_rossi_r92_44_16", kind = "collection", with_ammo = 100 }
    group:entry { item = "rossi_r92_44_16", charges = { 0, 8 } }
    group:group("on_hand_44")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_rossi_r92_44_20", kind = "collection", with_ammo = 100 }
    group:entry { item = "rossi_r92_44_20", charges = { 0, 10 } }
    group:group("on_hand_44")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_uberti_1873", kind = "collection", with_ammo = 100 }
    group:entry { item = "uberti_1873", charges = { 0, 10 } }
    group:group("on_hand_357")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_rossi_r92_357_16", kind = "collection", with_ammo = 100 }
    group:entry { item = "rossi_r92_357_16", charges = { 0, 8 } }
    group:group("on_hand_357")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_rossi_r92_357_20", kind = "collection", with_ammo = 100 }
    group:entry { item = "rossi_r92_357_20", charges = { 0, 10 } }
    group:group("on_hand_357")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_m14ebr", kind = "collection", with_ammo = 100 }
    group:entry { item = "m14ebr", charges = { 0, 20 } }
    group:item("m14mag")
    group:item("m14mag", 50)
    group:group("on_hand_308")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_M24", kind = "collection", with_ammo = 100 }
    group:entry { item = "M24", charges = { 0, 5 } }
    group:group("on_hand_308")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_m1903", kind = "collection", with_ammo = 100 }
    group:entry { item = "m1903", charges = { 0, 5 } }
    group:group("on_hand_3006")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_m1918", kind = "collection", with_ammo = 100 }
    group:entry { item = "m1918", charges = { 0, 20 } }
    group:item("m1918mag")
    group:item("m1918mag", 50)
    group:group("on_hand_3006")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_mosin44_ebr", kind = "collection", with_ammo = 100 }
    group:entry {
        item = "mosin44",
        charges = { 0, 5 },
        variant = "mosin44_ebr",
        contents = {
            { group = "mosin_mods" },
        },
        probability = 1,
    }
    group:group("on_hand_762R")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_mosin91_30_ebr", kind = "collection", with_ammo = 100 }
    group:entry {
        item = "mosin91_30",
        charges = { 0, 5 },
        variant = "mosin91_30_ebr",
        contents = {
            { group = "mosin_mods" },
        },
        probability = 1,
    }
    group:group("on_hand_762R")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_sharps", kind = "collection", with_ammo = 100 }
    group:entry { item = "sharps", charges = { 0, 1 } }
    group:group("on_hand_4570")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_weatherby_5", kind = "collection", with_ammo = 100 }
    group:entry { item = "weatherby_5", charges = { 0, 3 } }
    group:group("on_hand_300")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_hk417_13", kind = "collection", with_ammo = 100 }
    group:entry { item = "hk417_13", charges = { 0, 20 } }
    group:item("hk417mag_20rd")
    group:item("hk417mag_20rd", 50)
    group:group("on_hand_308")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_iwi_tavor_x95", kind = "collection", with_ammo = 100 }
    group:entry { item = "iwi_tavor_x95_300blk", charges = { 0, 30 } }
    group:group("stanag_30_random")
    group:group("stanag_30_random", 50)
    group:group("on_hand_223")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_scar_l", kind = "collection", with_ammo = 100 }
    group:entry { item = "scar_l", charges = { 0, 30 } }
    group:group("stanag_30_random")
    group:group("stanag_30_random", 50)
    group:group("on_hand_223")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_scar_16s", kind = "collection", with_ammo = 100 }
    group:entry { item = "scar_16s", charges = { 0, 30 } }
    group:group("stanag_30_random")
    group:group("stanag_30_random", 50)
    group:group("on_hand_223")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_m107a1", kind = "collection", with_ammo = 100 }
    group:entry { item = "m107a1", charges = { 0, 10 } }
    group:item("m107a1mag")
    group:item("m107a1mag", 50)
    group:group("on_hand_50")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_m134", kind = "collection", with_ammo = 100 }
    group:entry { item = "m134", charges = { 0, 100 } }
    group:group("on_hand_308")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_tac50", kind = "collection", with_ammo = 100 }
    group:entry { item = "tac50", charges = { 0, 5 } }
    group:item("tac50mag")
    group:item("tac50mag", 50)
    group:group("on_hand_50")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_m2010", kind = "collection", with_ammo = 100 }
    group:entry { item = "m2010", charges = { 0, 5 } }
    group:item("m2010mag")
    group:item("m2010mag", 50)
    group:group("on_hand_300")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_m240", kind = "collection", with_ammo = 100 }
    group:entry { item = "m240", charges = { 0, 100 } }
    group:group("on_hand_308")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_m249", kind = "collection", with_ammo = 100 }
    group:entry { item = "m249", charges = { 0, 100 } }
    group:group("on_hand_223")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_m60", kind = "collection", with_ammo = 100 }
    group:entry { item = "m60", charges = { 0, 100 } }
    group:group("on_hand_308")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_rm11b_sniper_rifle", kind = "collection", with_ammo = 100 }
    group:entry { item = "rm11b_sniper_rifle", charges = { 0, 10 } }
    group:item("8x40_10_mag")
    group:item("8x40_10_mag", 50)
    group:group("on_hand_8x40")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_rm51_assault_rifle", kind = "collection", with_ammo = 100 }
    group:entry { item = "rm51_assault_rifle", charges = { 0, 50 } }
    group:item("8x40_50_mag")
    group:item("8x40_50_mag", 50)
    group:group("on_hand_8x40")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_sig_assault_rifle", kind = "collection", with_ammo = 100 }
    group:entry { item = "sig_assault_rifle", charges = { 0, 30 } }
    group:item("stanag30")
    group:item("stanag30", 50)
    group:group("on_hand_223")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_sl8", kind = "collection", with_ammo = 100 }
    group:entry { item = "sl8", charges = { 0, 10 } }
    group:item("sl8mag")
    group:item("sl8mag", 50)
    group:group("on_hand_223")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_scar_h", kind = "collection", with_ammo = 100 }
    group:entry { item = "scar_h", charges = { 0, 20 } }
    group:item("scarhmag")
    group:item("scarhmag", 50)
    group:group("on_hand_308")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_scar_17s", kind = "collection", with_ammo = 100 }
    group:entry { item = "scar_17s", charges = { 0, 20 } }
    group:item("scarhmag")
    group:item("scarhmag", 50)
    group:group("on_hand_308")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_m110a1", kind = "collection", with_ammo = 100 }
    group:entry { item = "m110a1", charges = { 0, 20 } }
    group:item("hk417mag_20rd")
    group:item("hk417mag_20rd", 50)
    group:group("on_hand_308")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_ak47", kind = "collection", with_ammo = 100 }
    group:entry { item = "ak47", charges = { 0, 30 } }
    group:item("akmag10")
    group:item("akmag10", 50)
    group:group("on_hand_762")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_ak74", kind = "collection", with_ammo = 100 }
    group:entry { item = "ak74_semi", charges = { 0, 30 }, variant = "ak74_fixed" }
    group:item("ak74mag")
    group:item("ak74mag", 50)
    group:group("on_hand_545x39")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_aks74", kind = "collection" }
    group:entry {
        item = "ak74_semi",
        charges = { 0, 30 },
        variant = "ak74_folding",
        contents = {
            { group = "ak74_folding_mods" },
        },
        probability = 1,
    }
    group:item("ak74mag")
    group:item("ak74mag", 50)
    group:group("on_hand_545x39")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_carbine_flintlock", kind = "collection", with_ammo = 100 }
    group:entry { item = "carbine_flintlock", charges = { 0, 1 } }
    group:group("on_hand_flintlock")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_m60_semi", kind = "collection", with_ammo = 100 }
    group:entry { item = "m60_semi", charges = { 0, 100 } }
    group:group("on_hand_308")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_rifle_flintlock", kind = "collection", with_ammo = 100 }
    group:item("rifle_flintlock")
    group:group("on_hand_flintlock")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_steyr_aug", kind = "collection", with_ammo = 100 }
    group:entry { item = "steyr_aug", charges = { 0, 30 } }
    group:item("augmag_10rd")
    group:item("augmag_10rd", 50)
    group:group("on_hand_223")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_win70_458", kind = "collection", with_ammo = 100 }
    group:entry { item = "win70_458", charges = { 0, 3 } }
    group:group("on_hand_458wm")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_mossberg_500", kind = "collection", with_ammo = 100 }
    group:entry { item = "mossberg_500", charges = { 0, 6 } }
    group:group("on_hand_shot")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_remington_870", kind = "collection", with_ammo = 100 }
    group:entry { item = "remington_870", charges = { 0, 5 } }
    group:group("on_hand_shot")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_winchester_1897", kind = "collection", with_ammo = 100 }
    group:entry { item = "winchester_1897", charges = { 0, 6 } }
    group:group("on_hand_shot")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_remington_870_express", kind = "collection", with_ammo = 100 }
    group:entry { item = "remington_870_express", charges = { 0, 6 } }
    group:group("on_hand_shot")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_browning_a5", kind = "collection", with_ammo = 100 }
    group:entry { item = "browning_a5", charges = { 0, 4 } }
    group:group("on_hand_shot")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_remington_1100", kind = "collection", with_ammo = 100 }
    group:entry { item = "remington_1100", charges = { 0, 5 } }
    group:group("on_hand_shot")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_mossberg_930", kind = "collection", with_ammo = 100 }
    group:entry { item = "mossberg_930", charges = { 0, 6 } }
    group:group("on_hand_shot")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_mossberg_590_shockwave", kind = "collection", with_ammo = 100 }
    group:entry { item = "mossberg_590_shockwave", charges = { 0, 5 } }
    group:group("on_hand_shot")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_mossberg_500_410", kind = "collection", with_ammo = 100 }
    group:entry { item = "mossberg_500_410", charges = { 0, 5 } }
    group:group("on_hand_410shot")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_shotgun_d", kind = "collection", with_ammo = 100 }
    group:entry { item = "shotgun_d", charges = { 0, 2 } }
    group:group("on_hand_shot")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_shotgun_triple", kind = "collection", with_ammo = 100 }
    group:entry { item = "shotgun_triple", charges = { 0, 3 } }
    group:group("on_hand_shot")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_shotgun_s", kind = "collection", with_ammo = 100 }
    group:entry { item = "shotgun_s", charges = { 0, 1 } }
    group:group("on_hand_shot")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_dp_12", kind = "collection", with_ammo = 100 }
    group:entry { item = "dp_12", charges = { 0, 14 } }
    group:group("on_hand_shot")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_srm_1216", kind = "collection", with_ammo = 100 }
    group:entry { item = "srm_1216", charges = { 0, 16 } }
    group:item("srm_1216_mag_16")
    group:item("srm_1216_mag_16", 50)
    group:group("on_hand_shot")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_ksg", kind = "collection", with_ammo = 100 }
    group:entry { item = "ksg", charges = { 0, 7 } }
    group:group("on_hand_shot")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_tavor_12", kind = "collection", with_ammo = 100 }
    group:entry { item = "tavor_12", charges = { 0, 5 } }
    group:group("on_hand_shot")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_benelli_m4", kind = "collection", with_ammo = 100 }
    group:entry { item = "benelli_m4", charges = { 0, 5 } }
    group:group("on_hand_shot")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_m1014", kind = "collection", with_ammo = 100 }
    group:entry { item = "m1014", charges = { 0, 7 } }
    group:group("on_hand_shot")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_benelli_m2", kind = "collection", with_ammo = 100 }
    group:entry { item = "benelli_sa", charges = { 0, 4 }, variant = "m2" }
    group:group("on_hand_shot")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_black_eagle", kind = "collection", with_ammo = 100 }
    group:entry { item = "benelli_sa", charges = { 0, 4 }, variant = "sbe" }
    group:group("on_hand_shot")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_benelli_m2_tac", kind = "collection", with_ammo = 100 }
    group:entry { item = "benelli_tsa", charges = { 0, 6 } }
    group:group("on_hand_shot")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_mossberg_590", kind = "collection", with_ammo = 100 }
    group:entry { item = "mossberg_590", charges = { 0, 9 } }
    group:group("on_hand_shot")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_mossberg_590m", kind = "collection", with_ammo = 100 }
    group:entry { item = "mossberg_590", charges = { 0, 5 } }
    group:item("mossberg_590m_mag_10")
    group:item("mossberg_590m_mag_10", 50)
    group:entry {
        distribution = {
            {
                collection = {
                    { item = "mossberg_590m_mag_5" },
                    { item = "mossberg_590m_mag_5", probability = 50 },
                },
                probability = 3,
            },
            {
                collection = {
                    { item = "mossberg_590m_mag_10" },
                    { item = "mossberg_590m_mag_10", probability = 50 },
                },
                probability = 2,
            },
            {
                collection = {
                    { item = "mossberg_590m_mag_15" },
                    { item = "mossberg_590m_mag_15", probability = 50 },
                },
                probability = 1,
            },
            {
                collection = {
                    { item = "mossberg_590m_mag_20" },
                    { item = "mossberg_590m_mag_20", probability = 50 },
                },
                probability = 1,
            },
        },
    }
    group:group("on_hand_shot")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_saiga_12", kind = "collection", with_ammo = 100 }
    group:entry { item = "saiga_12", charges = { 0, 10 } }
    group:item("saiga10mag")
    group:item("saiga10mag", 50)
    group:group("on_hand_shot")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_mossberg_500_20", kind = "collection", with_ammo = 100 }
    group:entry { item = "mossberg_500_20", charges = { 0, 5 } }
    group:group("on_hand_20shot")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_remington_870_20", kind = "collection", with_ammo = 100 }
    group:entry { item = "remington_870_20", charges = { 0, 4 } }
    group:group("on_hand_20shot")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_savage_model_220", kind = "collection", with_ammo = 100 }
    group:entry { item = "savage_model_220", charges = { 0, 2 } }
    group:item("savage_220_magazine")
    group:item("savage_220_magazine", 50)
    group:item("savage_220_magazine", 50)
    group:group("on_hand_20shot")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_browning_citori_20", kind = "collection", with_ammo = 100 }
    group:entry { item = "browning_citori_20", charges = { 0, 2 } }
    group:group("on_hand_20shot")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_fn_ps90", kind = "collection", with_ammo = 100 }
    group:entry { item = "fn_ps90", charges = { 0, 10 } }
    group:item("fnp90mag_10rd")
    group:item("fnp90mag_10rd", 50)
    group:group("on_hand_57")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_ruger_57", kind = "collection", with_ammo = 100 }
    group:entry { item = "ruger_57", charges = { 0, 20 } }
    group:item("ruger_57mag")
    group:item("ruger_57mag", 50)
    group:group("on_hand_57")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_m1carbine", kind = "collection", with_ammo = 100 }
    group:entry { item = "m1carbine", charges = { 0, 15 } }
    group:item("m1carbinemag")
    group:item("m1carbinemag", 50)
    group:group("on_hand_30carbine")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_m2carbine", kind = "collection", with_ammo = 100 }
    group:entry { item = "m2carbine", charges = { 0, 15 } }
    group:item("m1carbinemag")
    group:item("m1carbinebigmag", 50)
    group:group("on_hand_30carbine")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_ak556", kind = "collection", with_ammo = 100 }
    group:entry { item = "ak556", charges = { 0, 10 } }
    group:item("zpap85mag_10rd")
    group:item("zpap85mag_10rd", 50)
    group:group("on_hand_223")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_ak308", kind = "collection", with_ammo = 100 }
    group:entry { item = "ak308", charges = { 0, 20 } }
    group:item("papm77mag_10rd")
    group:item("papm77mag_10rd", 50)
    group:group("on_hand_308")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_papm77", kind = "collection", with_ammo = 100 }
    group:entry { item = "ak308", charges = { 0, 20 }, variant = "papm77" }
    group:item("papm77mag_10rd")
    group:item("papm77mag_10rd", 50)
    group:group("on_hand_308")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_ruger_m77", kind = "collection", with_ammo = 100 }
    group:entry { item = "ruger_m77", charges = { 0, 4 } }
    group:group("on_hand_3006")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_ruger_pr", kind = "collection", with_ammo = 100 }
    group:entry { item = "ruger_pr", charges = { 0, 5 } }
    group:item("ruger_pr_mag")
    group:item("ruger_pr_mag", 50)
    group:group("on_hand_300")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_bren2_556", kind = "collection" }
    group:entry { item = "bren2_556", charges = { 0, 30 }, variant = "bren2_556" }
    group:item("stanag30")
    group:item("stanag30", 50)
    group:group("on_hand_223")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_tac338", kind = "collection", with_ammo = 100 }
    group:entry { item = "tac338", charges = { 0, 5 } }
    group:item("ai_338mag")
    group:item("ai_338mag", 50)
    group:group("on_hand_military_338lapua")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_savage112", kind = "collection", with_ammo = 100 }
    group:entry {
        item = "savage112",
        charges = { 0, 1 },
        contents = {
            { item = "rifle_scope" },
        },
    }
    group:group("on_hand_338lapua")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_mrad_smr", kind = "collection", with_ammo = 100 }
    group:entry { item = "mrad_smr", charges = { 0, 10 } }
    group:item("mrad_338lapua_mag")
    group:item("mrad_338lapua_mag", 50)
    group:group("on_hand_338lapua")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_ithaca37", kind = "collection", with_ammo = 100 }
    group:entry { item = "ithaca37", charges = { 0, 5 } }
    group:group("on_hand_shot")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_ruger_arr", kind = "collection" }
    group:entry { item = "ruger_arr", charges = { 0, 3 } }
    group:item("ruger_arr_mag")
    group:item("ruger_arr_mag", 50)
    group:group("on_hand_450")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack. Extra magazine for the stock hold
    local group = content.ItemGroup { id = "nested_steyr_scout", kind = "collection" }
    group:entry { item = "steyr_scout", charges = { 0, 3 } }
    group:item("steyr_scout_mag")
    group:item("steyr_scout_mag", 50)
    group:item("steyr_scout_mag", 50)
    group:group("on_hand_308")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_mk3", kind = "collection", with_ammo = 100 }
    group:entry {
        distribution = {
            { item = "smle_mk3", charges = { 0, 10 }, probability = 70 },
            {
                item = "smle_mk3",
                charges = { 0, 10 },
                contents = {
                    { item = "sword_bayonet" },
                },
                probability = 30,
            },
        },
    }
    group:item("clip303_5rd")
    group:item("clip303_5rd", 50)
    group:item("enfield_303mag", 5)
    group:group("on_hand_303")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_number4", kind = "collection", with_ammo = 100 }
    group:entry {
        distribution = {
            { item = "number4_mki", charges = { 0, 10 }, probability = 70 },
            {
                item = "number4_mki",
                charges = { 0, 10 },
                contents = {
                    { item = "enfield_bayonet" },
                },
                probability = 30,
            },
        },
    }
    group:item("clip303_5rd")
    group:item("clip303_5rd", 50)
    group:item("enfield_303mag", 5)
    group:group("on_hand_303")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_rdb_223", kind = "collection", with_ammo = 100 }
    group:entry {
        item = "rdb_223",
        charges = { 0, 30 },
        contents = {
            { group = "sights_rifle" },
        },
    }
    group:group("stanag_30_random")
    group:group("stanag_30_random", 50)
    group:group("on_hand_223")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_rfb_308", kind = "collection", with_ammo = 100 }
    group:entry {
        item = "rfb_308",
        charges = { 0, 20 },
        contents = {
            { group = "sights_rifle" },
        },
    }
    group:item("falmag")
    group:item("falmag", 50)
    group:group("on_hand_308")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_greasegun", kind = "collection", with_ammo = 100 }
    group:entry { item = "greasegun", charges = { 0, 30 } }
    group:item("greasegun30mag")
    group:item("greasegun30mag", 50)
    group:group("on_hand_45")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_type99", kind = "collection", with_ammo = 100 }
    group:entry {
        distribution = {
            { item = "type99", charges = { 0, 5 }, variant = "type99", probability = 30 },
            {
                item = "type99",
                charges = { 0, 5 },
                variant = "type99",
                contents = {
                    { group = "type99_mods" },
                },
                probability = 20,
            },
            { item = "type99", charges = { 0, 5 }, variant = "type99ld", probability = 30 },
            {
                item = "type99",
                charges = { 0, 5 },
                variant = "type99ld",
                contents = {
                    { group = "type99_mods" },
                },
                probability = 20,
            },
        },
    }
    group:item("clip_77mm_arisaka")
    group:item("clip_77mm_arisaka", 50)
    group:group("on_hand_77mm_arisaka")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_type99_sniper", kind = "collection" }
    group:entry {
        distribution = {
            { item = "type99_sniper", charges = { 0, 5 }, probability = 70 },
            {
                item = "type99_sniper",
                charges = { 0, 5 },
                contents = {
                    { item = "arisaka_monopod" },
                },
                probability = 30,
            },
        },
    }
    group:item("clip_77mm_arisaka")
    group:item("clip_77mm_arisaka", 50)
    group:group("on_hand_77mm_arisaka")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_rp63", kind = "collection", with_ammo = 100 }
    group:entry { item = "rp63", charges = { 0, 6 } }
    group:item("38_speedloader6")
    group:item("38_speedloader6", 50)
    group:group("on_hand_357_38mixed")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_taurus_judge", kind = "collection", with_ammo = 100 }
    group:entry { item = "taurus_judge", charges = { 0, 5 } }
    group:group("on_hand_410shot")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_winchester_94_3030", kind = "collection", with_ammo = 100 }
    group:entry { item = "winchester_94_3030", charges = { 0, 8 } }
    group:group("on_hand_3030")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_marlin_336_3030", kind = "collection", with_ammo = 100 }
    group:entry { item = "marlin_336_3030", charges = { 0, 6 } }
    group:group("on_hand_3030")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_glock_22", kind = "collection", with_ammo = 100 }
    group:entry { item = "glock_22", charges = { 0, 15 }, ammo = { item = "40sw" } }
    group:entry { item = "glock40mag", ammo = { item = "40sw" } }
    group:entry { item = "glock40mag", ammo = { item = "40sw" }, probability = 50 }
    group:group("on_hand_40")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_glock_23", kind = "collection", with_ammo = 100 }
    group:entry { item = "glock_23", charges = { 0, 15 }, ammo = { item = "40sw" } }
    group:entry { item = "glock40mag", ammo = { item = "40sw" } }
    group:entry { item = "glock40mag", ammo = { item = "40sw" }, probability = 50 }
    group:group("on_hand_40")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_glock_27", kind = "collection", with_ammo = 100 }
    group:entry { item = "glock_27", charges = { 0, 15 }, ammo = { item = "40sw" } }
    group:entry { item = "glock40mag_9", ammo = { item = "40sw" } }
    group:entry { item = "glock40mag_9", ammo = { item = "40sw" }, probability = 50 }
    group:group("on_hand_40")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_modular_deagle_357", kind = "collection", with_ammo = 100 }
    group:entry { group = "modular_deagle_357", charges = { 0, 9 } }
    group:item("deaglemag_357")
    group:item("deaglemag_357", 50)
    group:group("on_hand_357")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_modular_deagle_44", kind = "collection", with_ammo = 100 }
    group:entry { group = "modular_deagle_44", charges = { 0, 8 } }
    group:item("deaglemag")
    group:item("deaglemag", 50)
    group:group("on_hand_44")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_modular_deagle_50", kind = "collection", with_ammo = 100 }
    group:entry { group = "modular_deagle_50", charges = { 0, 7 } }
    group:item("deaglemag_50")
    group:item("deaglemag_50", 50)
    group:group("on_hand_50ae")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_modular_deagle_gold", kind = "collection", with_ammo = 100 }
    group:entry { group = "modular_deagle_50", charges = { 0, 7 }, variant = "modular_deagle_gold" }
    group:item("deaglemag_50")
    group:item("deaglemag_50", 50)
    group:group("on_hand_50ae")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_modular_ump_9", kind = "collection", with_ammo = 100 }
    group:entry { group = "modular_ump_9", charges = { 0, 30 } }
    group:item("ump9mag")
    group:item("ump9mag", 50)
    group:group("on_hand_9mm")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_modular_ump_40", kind = "collection", with_ammo = 100 }
    group:entry { group = "modular_ump_40", charges = { 0, 30 } }
    group:item("ump40mag")
    group:item("ump40mag", 50)
    group:group("on_hand_40")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_modular_ump_45", kind = "collection", with_ammo = 100 }
    group:entry { group = "modular_ump_45", charges = { 0, 25 } }
    group:item("ump45mag")
    group:item("ump45mag", 50)
    group:group("on_hand_45")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_ar15", kind = "collection", with_ammo = 100 }
    group:entry { group = "modular_ar15", charges = { 0, 30 } }
    group:item("stanag10")
    group:item("stanag10", 50)
    group:group("on_hand_223")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_ar_pistol", kind = "collection", with_ammo = 100 }
    group:entry { group = "ar_pistol", charges = { 0, 30 } }
    group:item("stanag10")
    group:item("stanag10", 50)
    group:group("on_hand_223")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_ar_pistol_long", kind = "collection", with_ammo = 100 }
    group:entry { group = "ar_pistol_long", charges = { 0, 30 } }
    group:item("stanag10")
    group:item("stanag10", 50)
    group:group("on_hand_223")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_ar_pistol_300", kind = "collection", with_ammo = 100 }
    group:entry { group = "ar_pistol_300", charges = { 0, 30 } }
    group:item("stanag10")
    group:item("stanag10", 50)
    group:group("on_hand_300BLK")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_ar_pistol_300_long", kind = "collection", with_ammo = 100 }
    group:entry { group = "ar_pistol_300_long", charges = { 0, 30 } }
    group:item("stanag10")
    group:item("stanag10", 50)
    group:group("on_hand_300BLK")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_m4_carbine", kind = "collection", with_ammo = 100 }
    group:entry { group = "modular_m4a1", charges = { 0, 30 } }
    group:item("stanag30")
    group:item("stanag30", 50)
    group:group("on_hand_223")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_h&k416a5", kind = "collection", with_ammo = 100 }
    group:entry { group = "h&k416a5_any", charges = { 0, 30 } }
    group:item("stanag30")
    group:item("stanag30", 50)
    group:group("on_hand_223")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_m27iar", kind = "collection", with_ammo = 100 }
    group:entry { group = "m27iar", charges = { 0, 30 } }
    group:item("stanag30")
    group:item("stanag30", 50)
    group:group("on_hand_223")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_ar12_shotgun", kind = "collection", with_ammo = 100 }
    group:entry { item = "ar12_shotgun", charges = { 0, -1 } }
    group:entry {
        distribution = {
            {
                collection = {
                    { item = "mka_1919_5" },
                    { item = "mka_1919_5", probability = 70 },
                    { item = "mka_1919_5", probability = 30 },
                },
                probability = 3,
            },
            {
                collection = {
                    { item = "mka_1919_10" },
                    { item = "mka_1919_10", probability = 70 },
                    { item = "mka_1919_10", probability = 30 },
                },
                probability = 2,
            },
            {
                collection = {
                    { item = "mka_1919_20" },
                    { item = "mka_1919_20", probability = 70 },
                    { item = "mka_1919_20", probability = 30 },
                },
                probability = 1,
            },
        },
    }
    group:group("on_hand_shot")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_gfy_1", kind = "collection", with_ammo = 100 }
    group:entry { item = "gfy_1", charges = { 0, -1 } }
    group:entry {
        distribution = {
            {
                collection = {
                    { item = "mka_1919_5" },
                    { item = "mka_1919_5", probability = 70 },
                    { item = "mka_1919_5", probability = 30 },
                },
                probability = 3,
            },
            {
                collection = {
                    { item = "mka_1919_10" },
                    { item = "mka_1919_10", probability = 70 },
                    { item = "mka_1919_10", probability = 30 },
                },
                probability = 2,
            },
            {
                collection = {
                    { item = "mka_1919_20" },
                    { item = "mka_1919_20", probability = 70 },
                    { item = "mka_1919_20", probability = 30 },
                },
                probability = 1,
            },
        },
    }
    group:group("on_hand_shot")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_mdrx", kind = "collection", with_ammo = 100 }
    group:entry { group = "mdrx", charges = { 0, 30 } }
    group:item("stanag30")
    group:item("stanag30", 50)
    group:group("on_hand_223")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_axmc", kind = "collection", with_ammo = 100 }
    group:entry { group = "axmc", charges = { 0, 10 } }
    group:item("ai_338mag_10")
    group:item("ai_338mag_10", 50)
    group:group("on_hand_338lapua")
    content.add(group)
end
