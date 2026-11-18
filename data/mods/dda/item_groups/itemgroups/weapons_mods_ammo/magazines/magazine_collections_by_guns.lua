local content = require("ccb").content

do
    -- These are collections of all guns with 2 or more magazines.  This was created to make magazine spawn ratios more exact.
    -- Collections of magazines for the gun.  Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_9mm_glock", kind = "distribution" }
    group:item("glockmag", 300)
    group:item("glockmag_10", 200)
    group:item("glock17_10", 300)
    group:item("glock17_17", 500)
    group:item("glock17_22", 50)
    group:item("glockbigmag", 20)
    group:item("glock_drum_50rd", 5)
    group:item("glock_drum_100rd", 1)
    content.add(group)
end

do
    -- Collections of magazines for the gun.  Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_9mm_m9", kind = "distribution" }
    group:item("m9mag_10rd", 300)
    group:item("m9mag", 500)
    group:item("m9mag_17rd", 500)
    group:item("m9mag_18rd", 70)
    group:item("m9mag_20rd", 60)
    group:item("m9bigmag", 50)
    group:item("m9mag_32rd", 5)
    group:item("m9mag_35rd", 3)
    content.add(group)
end

do
    -- Collections of magazines for the gun.  Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_9mm_px4", kind = "distribution" }
    group:item("px4mag_10rd", 200)
    group:item("px4mag_15rd", 400)
    group:item("px4mag", 500)
    group:item("px4mag_20rd", 60)
    content.add(group)
end

do
    -- Collections of magazines for the gun.  Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_9mm_usp", kind = "distribution" }
    group:item("usp9mag_10rd", 300)
    group:item("usp9mag", 500)
    group:item("usp9mag_18rd", 50)
    group:item("usp9mag_32rd", 4)
    content.add(group)
end

do
    -- Collections of magazines for the gun.  Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_9mm_p226", kind = "distribution" }
    group:item("p226mag_10rd_9x19mm", 500)
    group:item("p226mag_15rd_9x19mm", 500)
    content.add(group)
end

do
    -- Collections of magazines for the gun.  Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_9mm_p320", kind = "distribution" }
    group:item("p320mag_10rd_9x19mm", 250)
    group:item("p320mag_17rd_9x19mm", 500)
    group:item("p320mag_21rd_9x19mm")
    content.add(group)
end

do
    -- Collections of magazine for the gun.  Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_9mm_browning_hi", kind = "distribution" }
    group:item("bhp9mag_13rd", 500)
    group:item("bhp9mag_15rd", 500)
    content.add(group)
end

do
    -- Collections of magazines for the gun.  Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_9mm_ppq", kind = "distribution" }
    group:item("ppq9mag_10rd", 400)
    group:item("ppq9mag_15rd", 500)
    group:item("ppq9mag_17rd", 400)
    content.add(group)
end

do
    -- Collections of magazines for the gun.  Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_9mm_hipoint_c9", kind = "distribution" }
    group:item("hptc9mag_8rd", 500)
    group:item("hptc9mag_10rd")
    group:item("hptc9mag_15rd", 30)
    content.add(group)
end

do
    -- Collections of magazines for the gun.  Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_restricted_9mm_hipoint_c9", kind = "distribution" }
    group:item("hptc9mag_8rd", 500)
    group:item("hptc9mag_10rd")
    content.add(group)
end

do
    -- Collections of magazines for the gun.  Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_9mm_cz", kind = "distribution" }
    group:item("cz75mag_10rd", 300)
    group:item("cz75mag_16rd", 500)
    group:item("cz75mag_20rd")
    group:item("cz75mag_26rd", 25)
    content.add(group)
end

do
    -- Collections of magazine for the gun.  Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_9mm_sp2022", kind = "distribution" }
    group:item("sp2022mag_10rd_9mm", 500)
    group:item("sp2022mag_15rd_9mm", 400)
    content.add(group)
end

do
    -- Collections of magazines for the gun.  Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_9mm_ccp", kind = "distribution" }
    group:item("ccpmag", 500)
    group:item("ccpmag_9rd", 400)
    content.add(group)
end

do
    -- Collections of magazines for the gun.  Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_9mm_apc9", kind = "distribution" }
    group:item("btmp9mag_9x19mm_10rd", 250)
    group:item("btmp9mag_9x19mm_15", 400)
    group:item("btmp9mag_9x19mm_20", 500)
    group:item("btmp9mag_9x19mm_25", 400)
    group:item("btmp9mag_9x19mm_30", 70)
    group:item("btmp9mag_9x19mm_50rd", 10)
    content.add(group)
end

do
    -- Collections of magazines for the gun.  Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_9mm_mp5", kind = "distribution" }
    group:item("mp5mag_10rd", 250)
    group:item("mp5mag_15rd", 350)
    group:item("mp5mag_20rd", 350)
    group:item("mp5mag", 500)
    group:item("mp5mag_38rd", 60)
    group:item("mp5mag_40rd", 50)
    group:item("mp5bigmag", 5)
    group:item("mp5mag_100rd", 1)
    content.add(group)
end

do
    -- Collections of magazines for the gun.  Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_9mm_luger", kind = "distribution" }
    group:item("p08mag_8rd", 500)
    group:item("p08mag_32rd", 3)
    content.add(group)
end

do
    -- Collections of magazines for the gun.  Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_9mm_mp40", kind = "distribution" }
    group:item("mp40mag_32rd", 500)
    content.add(group)
end

do
    -- Collections of magazines for the gun.  Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_9mm_sten", kind = "distribution" }
    group:item("stenmag", 500)
    content.add(group)
end

do
    -- Collections of magazines for the gun.  Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_9mm_uzi", kind = "distribution" }
    group:item("uzimag_20rd", 400)
    group:item("uzimag_25rd", 450)
    group:item("uzimag", 500)
    group:item("uzimag_40rd")
    group:item("uzimag_50rd", 50)
    group:item("uzimag_100rd", 1)
    content.add(group)
end

do
    -- Collections of magazines for the gun.  Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_40_glock", kind = "distribution" }
    group:item("glock40mag_10", 300)
    group:item("glock40mag", 500)
    group:item("glock40bigmag", 350)
    content.add(group)
end

do
    -- Collections of magazines for the gun.  Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_10mm_glock", kind = "distribution" }
    group:item("glock_29mag", 250)
    group:item("glock_20mag", 500)
    group:item("glock_20mag_10", 400)
    group:item("tdi_10mm_mag", 70)
    content.add(group)
end

do
    -- Collections of magazines for the gun.  Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_22_ar", kind = "distribution" }
    group:item("22_ar15mag_10", 500)
    group:item("22_ar15mag_28", 200)
    content.add(group)
end

do
    -- Collections of magazines for the gun.  Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.  In this case, it seems the 110 drum is quite commom for the high capacties.
    local group = content.ItemGroup { id = "magazines_22_1022", kind = "distribution" }
    group:item("ruger1022mag", 500)
    group:item("ruger1022mag_15", 200)
    group:item("ruger1022bigmag", 300)
    group:item("ruger1022mag_30", 1)
    group:item("ruger1022mag_32", 5)
    group:item("ruger1022mag_55", 12)
    group:item("ruger1022mag_70", 16)
    group:item("ruger1022mag_110", 20)
    content.add(group)
end

do
    -- Collections of magazines for the gun.  Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_45_glock", kind = "distribution" }
    group:item("glock_21mag_10", 300)
    group:item("glock_21mag", 500)
    group:item("glock_21mag26")
    group:item("tdi_mag", 50)
    content.add(group)
end

do
    -- Collections of magazines for the gun.  Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_45_thompson", kind = "distribution" }
    group:item("thompson_mag", 500)
    group:item("thompson_bigmag", 60)
    group:item("thompson_drum", 5)
    content.add(group)
end

do
    -- Collections of magazines for the gun.  Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_45_usc", kind = "distribution" }
    group:item("usc10mag", 400)
    group:item("usc15mag", 500)
    group:item("usc20mag", 200)
    content.add(group)
end

do
    -- Collections of magazines for the gun.  Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_45_1911", kind = "distribution" }
    group:item("m1911mag", 500)
    group:item("m1911bigmag", 50)
    content.add(group)
end

do
    -- Collections of magazines for the gun.  Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_57_ruger", kind = "distribution" }
    group:item("ruger_57_10_round_mag", 300)
    group:item("ruger_57mag", 500)
    content.add(group)
end

do
    -- Collections of magazines for STANAG guns. Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_stanag", kind = "distribution" }
    group:item("stanag5", 300)
    group:item("stanag5ranger")
    group:item("stanag10", 350)
    group:item("stanag10ranger", 115)
    group:item("stanag20", 400)
    group:item("stanag20ranger", 130)
    group:item("stanag30", 700)
    group:item("stanag30ranger", 230)
    group:item("stanag40", 80)
    group:item("stanag40ranger", 20)
    group:item("stanag50", 40)
    group:item("stanag60", 10)
    group:item("stanag60drum", 10)
    group:item("stanag90", 8)
    group:item("stanag100", 5)
    group:item("stanag100drum", 5)
    group:item("stanag150", 1)
    content.add(group)
end

do
    -- Collections of magazines for STANAG guns. Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_restricted_stanag", kind = "distribution" }
    group:item("stanag5", 300)
    group:item("stanag5ranger")
    group:item("stanag10", 350)
    group:item("stanag10ranger", 115)
    content.add(group)
end

do
    -- Collections of magazines for the gun. Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_mini14", kind = "distribution" }
    group:item("ruger5", 300)
    group:item("ruger10", 400)
    group:item("ruger20", 400)
    group:item("ruger30", 400)
    group:item("ruger90", 60)
    group:item("ruger100", 10)
    content.add(group)
end

do
    -- Collections of magazines for the gun. Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_restricted_mini14", kind = "distribution" }
    group:item("ruger5", 300)
    group:item("ruger10", 400)
    content.add(group)
end

do
    -- Collections of magazines for the gun. Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_aug", kind = "distribution" }
    group:item("augmag_10rd", 250)
    group:item("augmag_30rd", 500)
    group:item("augmag_42rd", 40)
    content.add(group)
end

do
    -- Collections of magazines for the gun. Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_fal", kind = "distribution" }
    group:item("falmag", 500)
    group:item("falbigmag", 40)
    content.add(group)
end

do
    -- Collections of magazines for the gun. Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_g3", kind = "distribution" }
    group:item("g3mag", 500)
    group:item("g3bigmag", 1)
    content.add(group)
end

do
    -- Collections of magazines for the gun. Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_m14", kind = "distribution" }
    group:item("m14smallmag", 300)
    group:item("m14mag", 500)
    content.add(group)
end

do
    -- Collections of magazines for the gun. Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_m77", kind = "distribution" }
    group:item("papm77mag_10rd", 400)
    group:item("papm77mag", 500)
    content.add(group)
end

do
    -- Collections of magazines for the gun. Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_scarh", kind = "distribution" }
    group:item("scarhmag_10", 400)
    group:item("scarhmag", 500)
    group:item("scarhbigmag", 20)
    content.add(group)
end

do
    -- Collections of magazines for the gun. Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_ar10", kind = "distribution" }
    group:item("ar10mag_10rd", 300)
    group:item("ar10mag_20rd", 500)
    group:item("ar10mag_25rd", 50)
    group:item("ar10mag_50rd", 5)
    content.add(group)
end

do
    -- Collections of magazines for the gun. Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_hipoint380", kind = "distribution" }
    group:item("hptcf380mag_8rd", 500)
    group:item("hptcf380mag_10rd", 300)
    content.add(group)
end

do
    -- Collections of magazines for the gun. Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_ak74", kind = "distribution" }
    group:item("ak74mag", 500)
    group:item("rpk74mag", 20)
    content.add(group)
end

do
    -- Collections of magazines for the gun. Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_ar762", kind = "distribution" }
    group:item("762_ar15mag_5rd", 200)
    group:item("762_ar15mag_10rd", 400)
    group:item("762_ar15mag_20rd", 500)
    group:item("762_ar15mag_30rd", 300)
    content.add(group)
end

do
    -- Collections of magazines for the gun. Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_restricted_ar762", kind = "distribution" }
    group:item("762_ar15mag_5rd", 200)
    group:item("762_ar15mag_10rd", 400)
    content.add(group)
end

do
    -- Collections of magazines for the gun. Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_psl", kind = "distribution" }
    group:item("pslmag5", 200)
    group:item("pslmag10", 500)
    content.add(group)
end

do
    -- Collections of magazines for the gun. Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_saiga12", kind = "distribution" }
    group:item("saiga10mag", 500)
    group:item("saiga30mag", 20)
    content.add(group)
end

do
    -- Collections of speedloaders for shotguns.  Based on gunbroker capacity stats.
    local group = content.ItemGroup { id = "magazines_shot_speedloaders", kind = "distribution" }
    group:item("shot_speedloader6", 3)
    group:item("shot_speedloader8", 1)
    content.add(group)
end

do
    -- Collections of magazines for the gun. Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_590m", kind = "distribution" }
    group:item("mossberg_590m_mag_5", 500)
    group:item("mossberg_590m_mag_10")
    group:item("mossberg_590m_mag_15", 20)
    group:item("mossberg_590m_mag_20", 5)
    content.add(group)
end

do
    -- Collections of magazines for the gun. Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_mka", kind = "distribution" }
    group:item("mka_1919_5", 500)
    group:item("mka_1919_10")
    group:item("mka_1919_20", 20)
    content.add(group)
end
