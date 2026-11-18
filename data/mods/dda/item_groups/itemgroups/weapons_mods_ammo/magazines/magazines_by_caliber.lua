local content = require("ccb").content

do
    -- Note, common and rare don't mean exactly that.  It's meant moreso as a dividing line between being able to feasibly pick this up at a gunstore, and only being found in collectors items.  For example, yes, an SL8 magazine is rare, but not on the level of a collectors item like a luger drum mag
    -- Magazines are weighted by gun ratios on gunbroker, the gun with prob of 100 is the basis of these ratios, and further additions should be compared to that
    -- Collections of magazines for 9mm guns that are sold in gunstores, such as Glocks, M9s.
    local group = content.ItemGroup { id = "common_magazines_9mm", kind = "distribution" }
    group:group("magazines_9mm_glock")
    group:item("p365_mag", 161)
    group:group("magazines_9mm_m9", 20)
    group:group("magazines_9mm_px4", 20)
    group:group("magazines_9mm_usp", 20)
    group:group("magazines_9mm_p226", 40)
    group:group("magazines_9mm_p320", 60)
    group:group("magazines_9mm_browning_hi", 18)
    group:group("magazines_9mm_ppq", 15)
    group:group("magazines_9mm_hipoint_c9", 30)
    group:group("magazines_9mm_cz", 40)
    group:group("magazines_9mm_ccp", 5)
    group:group("magazines_9mm_sp2022", 10)
    group:group("magazines_9mm_mp5", 19)
    group:item("p38mag", 14)
    group:group("magazines_9mm_apc9", 5)
    content.add(group)
end

do
    -- Collections of magazines for 9mm guns that are sold in gunstores, such as Glocks, M9s, that are limited to 10 rounds or less so that they can be sold in gunstores.  If 10 round or less magazines aren't present, use the lowest current capacity magazine.
    local group = content.ItemGroup { id = "common_magazines_restricted_9mm", kind = "distribution" }
    group:item("p365_mag", 161)
    group:item("glock17_10", 48)
    group:item("glockmag_10", 52)
    group:item("glock43_mag", 16)
    group:item("glock43x/48_mag", 13)
    group:item("m9mag_10rd", 20)
    group:item("px4mag_10rd", 20)
    group:item("usp9mag_10rd", 20)
    group:item("p226mag_10rd_9x19mm", 40)
    group:item("p320mag_10rd_9x19mm", 60)
    group:item("bhp9mag_13rd", 18)
    group:item("ppq9mag_10rd", 15)
    group:group("magazines_restricted_9mm_hipoint_c9", 30)
    group:item("cz75mag_10rd", 40)
    group:group("magazines_9mm_ccp", 5)
    group:item("sp2022mag_10rd_9mm", 10)
    group:item("mp5mag_10rd", 19)
    group:item("p38mag", 14)
    group:item("btmp9mag_9x19mm_10rd", 5)
    content.add(group)
end

do
    -- Collections of magazines for 10mm guns that are sold in gunstores, such as Glocks.
    local group = content.ItemGroup { id = "common_magazines_10mm", kind = "distribution" }
    group:group("magazines_10mm_glock")
    group:item("m1911_10mag", 3)
    group:item("p220_10_mag", 21)
    group:item("witness_mag_10", 13)
    group:item("xd_10_mag", 19)
    content.add(group)
end

do
    -- Collections of magazines for 10mm guns that are sold in gunstores, such as Glocks, that are limited to 10 rounds or less.
    local group = content.ItemGroup { id = "common_magazines_restricted_10mm", kind = "distribution" }
    group:item("glock_29mag", 39)
    group:item("glock_20mag_10", 61)
    group:item("m1911_10mag", 3)
    group:item("p220_10_mag", 21)
    group:item("witness_mag_10", 13)
    group:item("xd_10_mag", 19)
    content.add(group)
end

do
    -- Collections of magazines for .22 LR guns that are sold in gunstores, such as 10/22s, Ruger Standards.
    local group = content.ItemGroup { id = "common_magazines_22lr", kind = "distribution" }
    group:group("magazines_22_ar", 8)
    group:group("magazines_22_1022")
    group:item("22_speedloader8", 1)
    group:item("mosquitomag", 20)
    group:item("wp22mag", 23)
    group:item("sr22_mag", 98)
    group:item("ruger_mk4_mag", 39)
    group:item("1911_22_mag", 26)
    group:item("mp1522_mag", 45)
    content.add(group)
end

do
    -- Collections of magazines for .22 LR guns that are sold in gunstores, such as 10/22s, Ruger Standards, that are limited to 10 rounds or less.
    local group = content.ItemGroup { id = "common_magazines_restricted_22lr", kind = "distribution" }
    group:item("22_ar15mag_10", 8)
    group:item("ruger1022mag")
    group:item("glock44_mag", 2)
    group:item("22_speedloader8", 1)
    group:item("mosquitomag", 20)
    group:item("wp22mag", 23)
    group:item("sr22_mag", 98)
    group:item("ruger_mk4_mag", 39)
    group:item("1911_22_mag", 26)
    group:item("mp1522_mag", 45)
    content.add(group)
end

do
    -- Collections of magazines for 30 carbine guns that are sold in gunstores, such as M1 Carbines and... nothing else.
    local group = content.ItemGroup { id = "common_magazines_30_carbine", kind = "distribution" }
    group:item("m1carbinemag")
    group:item("m1carbinebigmag", 10)
    content.add(group)
end

do
    -- Collections of magazines for 32 ACP guns that are sold in gunstores, such as a PPK.
    local group = content.ItemGroup { id = "common_magazines_32", kind = "distribution" }
    group:item("ppkmag")
    group:item("lws32mag", 2000)
    content.add(group)
end

do
    -- Collections of speedloaders for 38/357 revolvers that are sold in gunstores, such as a 686 or Model 10.
    local group = content.ItemGroup { id = "common_magazines_38", kind = "distribution" }
    group:item("38_speedloader", 10)
    group:item("38_speedloader5", 31)
    group:item("38_speedloader6")
    group:item("deaglemag_357", 7)
    content.add(group)
end

do
    -- Collections of magazines for 40 S&W guns that are sold in gunstores, such as the Glock 22.
    local group = content.ItemGroup { id = "common_magazines_40sw", kind = "distribution" }
    group:group("magazines_40_glock")
    group:item("px4_40mag", 16)
    group:item("px4_40mag_10", 5)
    group:item("bhp40mag", 3)
    group:item("hptjcpmag", 30)
    content.add(group)
end

do
    -- Collections of magazines for 40 S&W guns that are sold in gunstores, such as the Glock 22, that are limited to 10 rounds or less.
    local group = content.ItemGroup { id = "common_magazines_restricted_40sw", kind = "distribution" }
    group:item("glock40mag_10")
    group:item("px4_40mag_10", 21)
    group:item("bhp40mag", 3)
    group:item("hptjcpmag", 30)
    content.add(group)
end

do
    -- Collections of magazines/speedloaders for 44 magnum guns that are sold in gunstores, such as the Colt Anaconda.
    local group = content.ItemGroup { id = "common_magazines_44", kind = "distribution" }
    group:item("44_speedloader6")
    group:item("deaglemag", 17)
    content.add(group)
end

do
    -- Collections of magazines for 45 ACP guns that are sold in gunstores, such as Glocks, 1911s
    local group = content.ItemGroup { id = "common_magazines_45", kind = "distribution" }
    group:group("magazines_45_glock")
    group:group("magazines_45_thompson", 21)
    group:group("magazines_45_usc", 18)
    group:group("magazines_45_1911", 1107)
    group:item("usp45mag", 30)
    group:item("ppq45mag", 5)
    group:item("hptjhpmag", 103)
    content.add(group)
end

do
    -- Collections of magazines for 45 ACP guns that are sold in gunstores, such as Glocks, 1911s, that are limited to 10 rounds or less.
    local group = content.ItemGroup { id = "common_magazines_restricted_45", kind = "distribution" }
    group:item("glock_21mag_10")
    group:item("thompson_mag", 21)
    group:item("glock36_mag", 40)
    group:item("usc10mag", 18)
    group:group("magazines_45_1911", 1107)
    group:item("usp45mag", 30)
    group:item("ppq45mag", 5)
    group:item("hptjhpmag", 103)
    content.add(group)
end

do
    -- Collections of magazines for 5.7mm guns that can be found in gunstores.
    local group = content.ItemGroup { id = "common_magazines_57", kind = "distribution" }
    group:group("magazines_57_ruger")
    group:item("fn57mag", 13)
    group:item("fnp90mag", 115)
    content.add(group)
end

do
    -- Collections of magazines for 5.7mm guns that can be found in gunstores, that are limited to 10 rounds or less.
    local group = content.ItemGroup { id = "common_magazines_restricted_57", kind = "distribution" }
    group:item("ruger_57_10_round_mag")
    group:item("fn57mag_10rd", 13)
    group:item("fnp90mag_10rd", 115)
    content.add(group)
end

do
    -- Collections of magazines for 223/556 guns that can be found in gunstores.
    local group = content.ItemGroup { id = "common_magazines_223", kind = "distribution" }
    group:group("magazines_stanag", 1007)
    group:group("magazines_mini14")
    group:group("magazines_aug", 28)
    group:item("sl8mag", 4)
    content.add(group)
end

do
    -- Collections of magazines for 223/556 guns that can be found in gunstores, that are limited to 10 rounds or less.
    local group = content.ItemGroup { id = "common_magazines_restricted_223", kind = "distribution" }
    group:group("magazines_restricted_stanag", 1007)
    group:group("magazines_restricted_mini14")
    group:item("augmag_10rd", 28)
    group:item("sl8mag", 4)
    content.add(group)
end

do
    -- Collections of magazines/strippers for 303 guns that can be found in gunstores.
    local group = content.ItemGroup { id = "common_magazines_303", kind = "distribution" }
    group:item("enfield_303mag", 10)
    group:item("clip303_5rd")
    content.add(group)
end

do
    -- Collections of magazines for 308 guns that can be found in gunstores.
    local group = content.ItemGroup { id = "common_magazines_308", kind = "distribution" }
    group:group("magazines_fal", 25)
    group:group("magazines_g3", 19)
    group:group("magazines_m14", 300)
    group:group("magazines_m77", 39)
    group:group("magazines_scarh", 49)
    group:group("magazines_ar10")
    group:item("steyr_scout_mag", 16)
    content.add(group)
end

do
    -- Collections of magazines for 308 guns that can be found in gunstores, that are limited to 10 rounds or less.
    local group = content.ItemGroup { id = "common_magazines_restricted_308", kind = "distribution" }
    group:item("falmag", 25)
    group:item("g3mag", 19)
    group:item("m14smallmag", 300)
    group:item("papm77mag_10rd", 39)
    group:item("scarhmag_10", 49)
    group:item("ar10mag_10rd")
    group:item("steyr_scout_mag", 16)
    content.add(group)
end

do
    -- Collections of magazines for 380 guns that can be found in gunstores.
    local group = content.ItemGroup { id = "common_magazines_380", kind = "distribution" }
    group:group("magazines_hipoint380", 44)
    group:item("rugerlcpmag")
    group:item("glock42_mag", 24)
    group:item("swbodyguard_mag", 724)
    group:item("hpt3895mag_10rd", 4)
    content.add(group)
end

do
    -- Collections of magazines for 7.62x39 guns that can be found in gunstores.
    local group = content.ItemGroup { id = "common_magazines_762", kind = "distribution" }
    group:group("magazines_akm")
    group:group("magazines_ar762", 19)
    group:item("762x39_clip", 35)
    content.add(group)
end

do
    -- Collections of magazines for 7.62x39 guns that can be found in gunstores, that are limited to 10 rounds or less.
    local group = content.ItemGroup { id = "common_magazines_restricted_762", kind = "distribution" }
    group:item("akmag10")
    group:group("magazines_restricted_ar762", 19)
    group:item("762x39_clip", 35)
    content.add(group)
end

do
    -- Collections of magazines for 7.62x54mmR guns that can be found in gunstores.
    local group = content.ItemGroup { id = "common_magazines_762R", kind = "distribution" }
    group:group("magazines_psl", 12)
    group:item("762R_clip")
    content.add(group)
end

do
    -- Collections of magazines for 308 guns that can be found in gunstores.
    local group = content.ItemGroup { id = "common_magazines_3006", kind = "distribution" }
    group:item("3006_clip", 33)
    group:item("blrmag", 3)
    group:item("garandclip")
    content.add(group)
end

do
    -- Collections of magazines for 450 Bushmaster guns that can be found in gunstores.
    local group = content.ItemGroup { id = "common_magazines_450", kind = "distribution" }
    group:item("450_ar15mag")
    group:item("ruger_arr_mag", 54)
    content.add(group)
end

do
    -- Collections of magazines for 12 gauge guns that can be found in gunstores.
    local group = content.ItemGroup { id = "common_magazines_12", kind = "distribution" }
    group:group("magazines_saiga12", 6)
    group:group("magazines_shot_speedloaders", 20)
    group:group("magazines_590m", 8)
    group:group("magazines_mka")
    group:item("srm_1216_mag_16", 2)
    content.add(group)
end

do
    -- Collections of magazines for 12 gauge guns that can be found in gunstores, that are limited to 5 rounds or less as detachable shotgun magazines have a limit of 5.
    local group = content.ItemGroup { id = "common_magazines_restricted_12", kind = "distribution" }
    group:item("saiga10mag", 6)
    group:group("magazines_shot_speedloaders", 20)
    group:item("mossberg_590m_mag_5", 8)
    group:item("mka_1919_5")
    group:item("srm_1216_mag_16", 2)
    content.add(group)
end

do
    -- Collections of magazines for 9mm guns that are rare and should only be found in collections or gunshows, such as Lugers.
    local group = content.ItemGroup { id = "rare_magazines_9mm", kind = "distribution" }
    group:group("magazines_9mm_luger", 60)
    group:group("magazines_9mm_mp40", 60)
    group:group("magazines_9mm_sten", 40)
    group:group("magazines_9mm_uzi", 18)
    content.add(group)
end

do
    -- Collections of magazines for 45 ACP guns that are rare and should only be found in collections or gunshows, such as MACs.
    local group = content.ItemGroup { id = "rare_magazines_45", kind = "distribution" }
    group:item("mac10mag")
    group:item("ump45mag", 5)
    group:item("greasegun30mag", 25)
    content.add(group)
end
