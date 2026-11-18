local content = require("ccb").content

do
    -- Collections of magazines for guns that ignore magazine limits.  Shouldn't be found in places such as gunstores, and should only be found in private areas like homes.  Weighted by caliber.
    local group = content.ItemGroup { id = "regional_original_mags_common", kind = "distribution" }
    group:group("common_magazines_9mm", 209)
    group:group("common_magazines_10mm", 9)
    group:group("common_magazines_22lr", 204)
    group:group("common_magazines_30_carbine", 1)
    group:group("common_magazines_32", 44)
    group:group("common_magazines_38", 34)
    group:group("common_magazines_40sw", 40)
    group:group("common_magazines_44", 15)
    group:group("common_magazines_45", 49)
    group:group("common_magazines_57", 4)
    group:group("common_magazines_223", 125)
    group:group("common_magazines_303", 19)
    group:group("common_magazines_308", 25)
    group:group("common_magazines_380", 48)
    group:group("common_magazines_762", 34)
    group:group("common_magazines_762R", 4)
    group:group("common_magazines_3006", 8)
    group:group("common_magazines_450", 1)
    group:group("common_magazines_12", 8)
    group:group("uncommon_magazines", 3)
    group:group("magazines_ak74", 1)
    group:item("500_speedloader5", 1)
    group:item("ruger_pr_mag", 1)
    group:item("454_speedloader5", 25)
    group:item("50beowulf_ar15mag", 2)
    group:item("m1911mag_10rd_38super", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-open", kind = "distribution" }
    group:item("glock17_10", 50)
    group:item("glock17_17")
    group:item("glockmag", 110)
    group:item("glockmag_10", 55)
    group:item("m14mag", 45)
    group:item("m14smallmag", 22)
    group:item("m1911mag", 60)
    group:item("m9mag", 55)
    group:item("m9mag_10rd", 27)
    group:item("mossberg_590m_mag_10", 6)
    group:item("mossberg_590m_mag_15", 12)
    group:item("mossberg_590m_mag_20", 25)
    group:item("mossberg_590m_mag_5", 3)
    group:item("ruger10", 30)
    group:item("ruger1022bigmag", 125)
    group:item("ruger1022mag", 31)
    group:item("ruger1022mag_15", 62)
    group:item("ruger20", 60)
    group:item("ruger5", 15)
    group:item("rugerlcpmag", 70)
    group:item("stanag10", 31)
    group:item("stanag20", 62)
    group:item("stanag30", 125)
    group:item("stanag5", 15)
    group:item("steyr_scout_mag", 25)
    group:item("wp22mag", 60)
    group:group("regional_original_mags_common", 1281)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common_restricted-open", kind = "distribution" }
    group:item("glock17_10", 50)
    group:item("glock17_17")
    group:item("glockmag", 110)
    group:item("glockmag_10", 55)
    group:item("m14mag", 45)
    group:item("m14smallmag", 22)
    group:item("m1911mag", 60)
    group:item("m9mag", 55)
    group:item("m9mag_10rd", 27)
    group:item("mossberg_590m_mag_10", 6)
    group:item("mossberg_590m_mag_15", 12)
    group:item("mossberg_590m_mag_20", 25)
    group:item("mossberg_590m_mag_5", 3)
    group:item("ruger10", 30)
    group:item("ruger1022bigmag", 125)
    group:item("ruger1022mag", 31)
    group:item("ruger1022mag_15", 62)
    group:item("ruger20", 60)
    group:item("ruger5", 15)
    group:item("rugerlcpmag", 70)
    group:item("stanag10", 31)
    group:item("stanag20", 62)
    group:item("stanag30", 125)
    group:item("stanag5", 15)
    group:item("steyr_scout_mag", 25)
    group:item("wp22mag", 60)
    group:group("regional_original_mags_common", 1281)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common_restricted_packaged-open", kind = "distribution" }
    group:entry {
        item = "blister_pack",
        contents = {
            { group = "mags_common_restricted-open" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_hunting-open", kind = "distribution" }
    group:item("glock17_10", 50)
    group:item("glock17_17")
    group:item("glockmag", 110)
    group:item("glockmag_10", 55)
    group:item("m14mag", 45)
    group:item("m14smallmag", 22)
    group:item("m1911mag", 60)
    group:item("m9mag", 55)
    group:item("m9mag_10rd", 27)
    group:item("mossberg_590m_mag_10", 6)
    group:item("mossberg_590m_mag_15", 12)
    group:item("mossberg_590m_mag_20", 25)
    group:item("mossberg_590m_mag_5", 3)
    group:item("ruger10", 30)
    group:item("ruger1022bigmag", 125)
    group:item("ruger1022mag", 31)
    group:item("ruger1022mag_15", 62)
    group:item("ruger20", 60)
    group:item("ruger5", 15)
    group:item("rugerlcpmag", 70)
    group:item("stanag10", 31)
    group:item("stanag20", 62)
    group:item("stanag30", 125)
    group:item("stanag5", 15)
    group:item("steyr_scout_mag", 25)
    group:item("wp22mag", 60)
    group:group("regional_original_mags_common", 1281)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_pistol_hunting-open", kind = "distribution" }
    group:item("glock17_10", 50)
    group:item("glock17_17")
    group:item("glockmag", 110)
    group:item("glockmag_10", 55)
    group:item("m1911mag", 60)
    group:item("m9mag", 55)
    group:item("m9mag_10rd", 27)
    group:item("rugerlcpmag", 70)
    group:item("wp22mag", 60)
    group:group("regional_original_mags_common", 587)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_rifle_hunting-open", kind = "distribution" }
    group:item("m14mag", 45)
    group:item("m14smallmag", 22)
    group:item("ruger10", 30)
    group:item("ruger1022bigmag", 125)
    group:item("ruger1022mag", 31)
    group:item("ruger1022mag_15", 62)
    group:item("ruger20", 60)
    group:item("ruger5", 15)
    group:item("stanag10", 31)
    group:item("stanag20", 62)
    group:item("stanag30", 125)
    group:item("stanag5", 15)
    group:item("steyr_scout_mag", 25)
    group:group("regional_original_mags_common", 648)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-split", kind = "distribution" }
    group:item("glock17_10")
    group:item("glockmag", 110)
    group:item("glockmag_10", 55)
    group:item("m14smallmag", 45)
    group:item("m1911mag", 60)
    group:item("m9mag", 55)
    group:item("m9mag_10rd", 27)
    group:item("mossberg_590m_mag_10", 25)
    group:item("mossberg_590m_mag_5", 12)
    group:item("ruger10", 60)
    group:item("ruger1022mag", 125)
    group:item("ruger5", 30)
    group:item("rugerlcpmag", 70)
    group:item("stanag10", 125)
    group:item("stanag5", 62)
    group:item("steyr_scout_mag", 25)
    group:item("wp22mag", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common_restricted-split", kind = "distribution" }
    group:item("glock17_10")
    group:item("glockmag", 110)
    group:item("glockmag_10", 55)
    group:item("m14smallmag", 45)
    group:item("m1911mag", 60)
    group:item("m9mag", 55)
    group:item("m9mag_10rd", 27)
    group:item("mossberg_590m_mag_10", 25)
    group:item("mossberg_590m_mag_5", 12)
    group:item("ruger10", 60)
    group:item("ruger1022mag", 125)
    group:item("ruger5", 30)
    group:item("rugerlcpmag", 70)
    group:item("stanag10", 125)
    group:item("stanag5", 62)
    group:item("steyr_scout_mag", 25)
    group:item("wp22mag", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common_restricted_packaged-split", kind = "distribution" }
    group:entry {
        item = "blister_pack",
        contents = {
            { group = "mags_common_restricted-split" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_hunting-split", kind = "distribution" }
    group:item("glock17_10")
    group:item("glockmag", 110)
    group:item("glockmag_10", 55)
    group:item("m14smallmag", 45)
    group:item("m1911mag", 60)
    group:item("m9mag", 55)
    group:item("m9mag_10rd", 27)
    group:item("mossberg_590m_mag_10", 25)
    group:item("mossberg_590m_mag_5", 12)
    group:item("ruger10", 60)
    group:item("ruger1022mag", 125)
    group:item("ruger5", 30)
    group:item("rugerlcpmag", 70)
    group:item("stanag10", 125)
    group:item("stanag5", 62)
    group:item("steyr_scout_mag", 25)
    group:item("wp22mag", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_pistol_hunting-split", kind = "distribution" }
    group:item("glock17_10")
    group:item("glockmag", 110)
    group:item("glockmag_10", 55)
    group:item("m1911mag", 60)
    group:item("m9mag", 55)
    group:item("m9mag_10rd", 27)
    group:item("rugerlcpmag", 70)
    group:item("wp22mag", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_rifle_hunting-split", kind = "distribution" }
    group:item("m14smallmag", 45)
    group:item("ruger10", 60)
    group:item("ruger1022mag", 125)
    group:item("ruger5", 30)
    group:item("stanag10", 125)
    group:item("stanag5", 62)
    group:item("steyr_scout_mag", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-restricted10", kind = "distribution" }
    group:item("glock17_10")
    group:item("glockmag_10", 110)
    group:item("m1911mag", 60)
    group:item("m9mag_10rd", 55)
    group:item("ruger1022mag", 125)
    group:item("rugerlcpmag", 70)
    group:item("steyr_scout_mag", 25)
    group:item("wp22mag", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common_restricted-restricted10", kind = "distribution" }
    group:item("glock17_10")
    group:item("glockmag_10", 110)
    group:item("m1911mag", 60)
    group:item("m9mag_10rd", 55)
    group:item("ruger1022mag", 125)
    group:item("rugerlcpmag", 70)
    group:item("steyr_scout_mag", 25)
    group:item("wp22mag", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common_restricted_packaged-restricted10", kind = "distribution" }
    group:entry {
        item = "blister_pack",
        contents = {
            { group = "mags_common_restricted-restricted10" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_hunting-restricted10", kind = "distribution" }
    group:item("glock17_10")
    group:item("glockmag_10", 110)
    group:item("m1911mag", 60)
    group:item("m9mag_10rd", 55)
    group:item("ruger1022mag", 125)
    group:item("rugerlcpmag", 70)
    group:item("steyr_scout_mag", 25)
    group:item("wp22mag", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_pistol_hunting-restricted10", kind = "distribution" }
    group:item("glock17_10")
    group:item("glockmag_10", 110)
    group:item("m1911mag", 60)
    group:item("m9mag_10rd", 55)
    group:item("rugerlcpmag", 70)
    group:item("wp22mag", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_rifle_hunting-restricted10", kind = "distribution" }
    group:item("ruger1022mag", 125)
    group:item("steyr_scout_mag", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-restricted17", kind = "distribution" }
    group:item("glock17_10", 50)
    group:item("glock17_17")
    group:item("glockmag", 110)
    group:item("glockmag_10", 55)
    group:item("m1911mag", 60)
    group:item("m9mag", 55)
    group:item("m9mag_10rd", 27)
    group:item("ruger1022mag", 62)
    group:item("ruger1022mag_15", 125)
    group:item("rugerlcpmag", 70)
    group:item("steyr_scout_mag", 25)
    group:item("wp22mag", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common_restricted-restricted17", kind = "distribution" }
    group:item("glock17_10", 50)
    group:item("glock17_17")
    group:item("glockmag", 110)
    group:item("glockmag_10", 55)
    group:item("m1911mag", 60)
    group:item("m9mag", 55)
    group:item("m9mag_10rd", 27)
    group:item("ruger1022mag", 62)
    group:item("ruger1022mag_15", 125)
    group:item("rugerlcpmag", 70)
    group:item("steyr_scout_mag", 25)
    group:item("wp22mag", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common_restricted_packaged-restricted17", kind = "distribution" }
    group:entry {
        item = "blister_pack",
        contents = {
            { group = "mags_common_restricted-restricted17" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_hunting-restricted17", kind = "distribution" }
    group:item("glock17_10", 50)
    group:item("glock17_17")
    group:item("glockmag", 110)
    group:item("glockmag_10", 55)
    group:item("m1911mag", 60)
    group:item("m9mag", 55)
    group:item("m9mag_10rd", 27)
    group:item("ruger1022mag", 62)
    group:item("ruger1022mag_15", 125)
    group:item("rugerlcpmag", 70)
    group:item("steyr_scout_mag", 25)
    group:item("wp22mag", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_pistol_hunting-restricted17", kind = "distribution" }
    group:item("glock17_10", 50)
    group:item("glock17_17")
    group:item("glockmag", 110)
    group:item("glockmag_10", 55)
    group:item("m1911mag", 60)
    group:item("m9mag", 55)
    group:item("m9mag_10rd", 27)
    group:item("rugerlcpmag", 70)
    group:item("wp22mag", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_rifle_hunting-restricted17", kind = "distribution" }
    group:item("ruger1022mag", 62)
    group:item("ruger1022mag_15", 125)
    group:item("steyr_scout_mag", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-restricted15", kind = "distribution" }
    group:item("glock17_10")
    group:item("glockmag", 110)
    group:item("glockmag_10", 55)
    group:item("m1911mag", 60)
    group:item("m9mag", 55)
    group:item("m9mag_10rd", 27)
    group:item("ruger1022mag", 62)
    group:item("ruger1022mag_15", 125)
    group:item("rugerlcpmag", 70)
    group:item("steyr_scout_mag", 25)
    group:item("wp22mag", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common_restricted-restricted15", kind = "distribution" }
    group:item("glock17_10")
    group:item("glockmag", 110)
    group:item("glockmag_10", 55)
    group:item("m1911mag", 60)
    group:item("m9mag", 55)
    group:item("m9mag_10rd", 27)
    group:item("ruger1022mag", 62)
    group:item("ruger1022mag_15", 125)
    group:item("rugerlcpmag", 70)
    group:item("steyr_scout_mag", 25)
    group:item("wp22mag", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common_restricted_packaged-restricted15", kind = "distribution" }
    group:entry {
        item = "blister_pack",
        contents = {
            { group = "mags_common_restricted-restricted15" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_hunting-restricted15", kind = "distribution" }
    group:item("glock17_10")
    group:item("glockmag", 110)
    group:item("glockmag_10", 55)
    group:item("m1911mag", 60)
    group:item("m9mag", 55)
    group:item("m9mag_10rd", 27)
    group:item("ruger1022mag", 62)
    group:item("ruger1022mag_15", 125)
    group:item("rugerlcpmag", 70)
    group:item("steyr_scout_mag", 25)
    group:item("wp22mag", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_pistol_hunting-restricted15", kind = "distribution" }
    group:item("glock17_10")
    group:item("glockmag", 110)
    group:item("glockmag_10", 55)
    group:item("m1911mag", 60)
    group:item("m9mag", 55)
    group:item("m9mag_10rd", 27)
    group:item("rugerlcpmag", 70)
    group:item("wp22mag", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_rifle_hunting-restricted15", kind = "distribution" }
    group:item("ruger1022mag", 62)
    group:item("ruger1022mag_15", 125)
    group:item("steyr_scout_mag", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-restricted_split", kind = "distribution" }
    group:item("glock17_10")
    group:item("glockmag", 110)
    group:item("glockmag_10", 55)
    group:item("m1911mag", 60)
    group:item("m9mag", 55)
    group:item("m9mag_10rd", 27)
    group:item("ruger1022mag", 125)
    group:item("rugerlcpmag", 70)
    group:item("steyr_scout_mag", 25)
    group:item("wp22mag", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common_restricted-restricted_split", kind = "distribution" }
    group:item("glock17_10")
    group:item("glockmag", 110)
    group:item("glockmag_10", 55)
    group:item("m1911mag", 60)
    group:item("m9mag", 55)
    group:item("m9mag_10rd", 27)
    group:item("ruger1022mag", 125)
    group:item("rugerlcpmag", 70)
    group:item("steyr_scout_mag", 25)
    group:item("wp22mag", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common_restricted_packaged-restricted_split", kind = "distribution" }
    group:entry {
        item = "blister_pack",
        contents = {
            { group = "mags_common_restricted-restricted_split" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_hunting-restricted_split", kind = "distribution" }
    group:item("glock17_10")
    group:item("glockmag", 110)
    group:item("glockmag_10", 55)
    group:item("m1911mag", 60)
    group:item("m9mag", 55)
    group:item("m9mag_10rd", 27)
    group:item("ruger1022mag", 125)
    group:item("rugerlcpmag", 70)
    group:item("steyr_scout_mag", 25)
    group:item("wp22mag", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_pistol_hunting-restricted_split", kind = "distribution" }
    group:item("glock17_10")
    group:item("glockmag", 110)
    group:item("glockmag_10", 55)
    group:item("m1911mag", 60)
    group:item("m9mag", 55)
    group:item("m9mag_10rd", 27)
    group:item("rugerlcpmag", 70)
    group:item("wp22mag", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_rifle_hunting-restricted_split", kind = "distribution" }
    group:item("ruger1022mag", 125)
    group:item("steyr_scout_mag", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-hawaii", kind = "distribution" }
    group:item("glock17_10")
    group:item("glockmag_10", 110)
    group:item("m1911mag", 60)
    group:item("m9mag_10rd", 55)
    group:item("ruger1022bigmag", 125)
    group:item("ruger1022mag", 31)
    group:item("ruger1022mag_15", 62)
    group:item("rugerlcpmag", 70)
    group:item("steyr_scout_mag", 25)
    group:item("wp22mag", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common_restricted-hawaii", kind = "distribution" }
    group:item("glock17_10")
    group:item("glockmag_10", 110)
    group:item("m1911mag", 60)
    group:item("m9mag_10rd", 55)
    group:item("ruger1022bigmag", 125)
    group:item("ruger1022mag", 31)
    group:item("ruger1022mag_15", 62)
    group:item("rugerlcpmag", 70)
    group:item("steyr_scout_mag", 25)
    group:item("wp22mag", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common_restricted_packaged-hawaii", kind = "distribution" }
    group:entry {
        item = "blister_pack",
        contents = {
            { group = "mags_common_restricted-hawaii" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_hunting-hawaii", kind = "distribution" }
    group:item("glock17_10")
    group:item("glockmag_10", 110)
    group:item("m1911mag", 60)
    group:item("m9mag_10rd", 55)
    group:item("ruger1022bigmag", 125)
    group:item("ruger1022mag", 31)
    group:item("ruger1022mag_15", 62)
    group:item("rugerlcpmag", 70)
    group:item("steyr_scout_mag", 25)
    group:item("wp22mag", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_pistol_hunting-hawaii", kind = "distribution" }
    group:item("glock17_10")
    group:item("glockmag_10", 110)
    group:item("m1911mag", 60)
    group:item("m9mag_10rd", 55)
    group:item("rugerlcpmag", 70)
    group:item("wp22mag", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_rifle_hunting-hawaii", kind = "distribution" }
    group:item("ruger1022bigmag", 125)
    group:item("ruger1022mag", 31)
    group:item("ruger1022mag_15", 62)
    group:item("steyr_scout_mag", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-canada", kind = "distribution" }
    group:item("ruger1022mag", 125)
    group:item("steyr_scout_mag", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common_restricted-canada", kind = "distribution" }
    group:item("ruger1022mag", 125)
    group:item("steyr_scout_mag", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common_restricted_packaged-canada", kind = "distribution" }
    group:entry {
        item = "blister_pack",
        contents = {
            { group = "mags_common_restricted-canada" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_hunting-canada", kind = "distribution" }
    group:item("ruger1022mag", 125)
    group:item("steyr_scout_mag", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_pistol_hunting-canada", kind = "distribution" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_rifle_hunting-canada", kind = "distribution" }
    group:item("ruger1022mag", 125)
    group:item("steyr_scout_mag", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-mexico", kind = "distribution" }
    group:item("ruger1022bigmag", 125)
    group:item("ruger1022mag", 31)
    group:item("ruger1022mag_15", 62)
    group:item("rugerlcpmag", 70)
    group:item("steyr_scout_mag", 25)
    group:item("wp22mag", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common_restricted-mexico", kind = "distribution" }
    group:item("ruger1022bigmag", 125)
    group:item("ruger1022mag", 31)
    group:item("ruger1022mag_15", 62)
    group:item("rugerlcpmag", 70)
    group:item("steyr_scout_mag", 25)
    group:item("wp22mag", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common_restricted_packaged-mexico", kind = "distribution" }
    group:entry {
        item = "blister_pack",
        contents = {
            { group = "mags_common_restricted-mexico" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_hunting-mexico", kind = "distribution" }
    group:item("ruger1022bigmag", 125)
    group:item("ruger1022mag", 31)
    group:item("ruger1022mag_15", 62)
    group:item("rugerlcpmag", 70)
    group:item("steyr_scout_mag", 25)
    group:item("wp22mag", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_pistol_hunting-mexico", kind = "distribution" }
    group:item("rugerlcpmag", 70)
    group:item("wp22mag", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_rifle_hunting-mexico", kind = "distribution" }
    group:item("ruger1022bigmag", 125)
    group:item("ruger1022mag", 31)
    group:item("ruger1022mag_15", 62)
    group:item("steyr_scout_mag", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-CA-AB", kind = "distribution" }
    group:group("mags_common-canada")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-CA-BC", kind = "distribution" }
    group:group("mags_common-canada")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-CA-MB", kind = "distribution" }
    group:group("mags_common-canada")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-CA-NB", kind = "distribution" }
    group:group("mags_common-canada")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-CA-NL", kind = "distribution" }
    group:group("mags_common-canada")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-CA-NS", kind = "distribution" }
    group:group("mags_common-canada")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-CA-NT", kind = "distribution" }
    group:group("mags_common-canada")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-CA-NU", kind = "distribution" }
    group:group("mags_common-canada")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-CA-ON", kind = "distribution" }
    group:group("mags_common-canada")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-CA-PE", kind = "distribution" }
    group:group("mags_common-canada")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-CA-QC", kind = "distribution" }
    group:group("mags_common-canada")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-CA-SK", kind = "distribution" }
    group:group("mags_common-canada")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-CA-YT", kind = "distribution" }
    group:group("mags_common-canada")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-MX-AGU", kind = "distribution" }
    group:group("mags_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-MX-BCN", kind = "distribution" }
    group:group("mags_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-MX-BCS", kind = "distribution" }
    group:group("mags_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-MX-CAM", kind = "distribution" }
    group:group("mags_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-MX-CHH", kind = "distribution" }
    group:group("mags_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-MX-CHP", kind = "distribution" }
    group:group("mags_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-MX-CMX", kind = "distribution" }
    group:group("mags_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-MX-COA", kind = "distribution" }
    group:group("mags_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-MX-COL", kind = "distribution" }
    group:group("mags_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-MX-DUR", kind = "distribution" }
    group:group("mags_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-MX-GRO", kind = "distribution" }
    group:group("mags_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-MX-GUA", kind = "distribution" }
    group:group("mags_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-MX-HID", kind = "distribution" }
    group:group("mags_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-MX-JAL", kind = "distribution" }
    group:group("mags_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-MX-MEX", kind = "distribution" }
    group:group("mags_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-MX-MIC", kind = "distribution" }
    group:group("mags_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-MX-MOR", kind = "distribution" }
    group:group("mags_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-MX-NAY", kind = "distribution" }
    group:group("mags_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-MX-NLE", kind = "distribution" }
    group:group("mags_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-MX-OAX", kind = "distribution" }
    group:group("mags_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-MX-PUE", kind = "distribution" }
    group:group("mags_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-MX-QUE", kind = "distribution" }
    group:group("mags_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-MX-ROO", kind = "distribution" }
    group:group("mags_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-MX-SIN", kind = "distribution" }
    group:group("mags_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-MX-SLP", kind = "distribution" }
    group:group("mags_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-MX-SON", kind = "distribution" }
    group:group("mags_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-MX-TAB", kind = "distribution" }
    group:group("mags_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-MX-TAM", kind = "distribution" }
    group:group("mags_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-MX-TLA", kind = "distribution" }
    group:group("mags_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-MX-VER", kind = "distribution" }
    group:group("mags_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-MX-YUC", kind = "distribution" }
    group:group("mags_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-MX-ZAC", kind = "distribution" }
    group:group("mags_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-AK", kind = "distribution" }
    group:group("mags_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-AL", kind = "distribution" }
    group:group("mags_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-AR", kind = "distribution" }
    group:group("mags_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-AZ", kind = "distribution" }
    group:group("mags_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-CA", kind = "distribution" }
    group:group("mags_common-restricted10")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-CO", kind = "distribution" }
    group:group("mags_common-restricted15")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-CT", kind = "distribution" }
    group:group("mags_common-restricted10")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-DC", kind = "distribution" }
    group:group("mags_common-restricted10")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-DE", kind = "distribution" }
    group:group("mags_common-restricted17")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-FL", kind = "distribution" }
    group:group("mags_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-GA", kind = "distribution" }
    group:group("mags_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-HI", kind = "distribution" }
    group:group("mags_common-hawaii")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-IA", kind = "distribution" }
    group:group("mags_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-ID", kind = "distribution" }
    group:group("mags_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-IL", kind = "distribution" }
    group:group("mags_common-restricted_split")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-IN", kind = "distribution" }
    group:group("mags_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-KS", kind = "distribution" }
    group:group("mags_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-KY", kind = "distribution" }
    group:group("mags_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-LA", kind = "distribution" }
    group:group("mags_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-MD", kind = "distribution" }
    group:group("mags_common-restricted10")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-ME", kind = "distribution" }
    group:group("mags_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-MI", kind = "distribution" }
    group:group("mags_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-MN", kind = "distribution" }
    group:group("mags_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-MO", kind = "distribution" }
    group:group("mags_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-MS", kind = "distribution" }
    group:group("mags_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-MT", kind = "distribution" }
    group:group("mags_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-NC", kind = "distribution" }
    group:group("mags_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-ND", kind = "distribution" }
    group:group("mags_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-NE", kind = "distribution" }
    group:group("mags_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-NH", kind = "distribution" }
    group:group("mags_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-NJ", kind = "distribution" }
    group:group("mags_common-restricted10")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-NM", kind = "distribution" }
    group:group("mags_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-NV", kind = "distribution" }
    group:group("mags_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-NY", kind = "distribution" }
    group:group("mags_common-restricted10")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-OH", kind = "distribution" }
    group:group("mags_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-OK", kind = "distribution" }
    group:group("mags_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-OR", kind = "distribution" }
    group:group("mags_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-PA", kind = "distribution" }
    group:group("mags_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-RI", kind = "distribution" }
    group:group("mags_common-restricted10")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-SC", kind = "distribution" }
    group:group("mags_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-SD", kind = "distribution" }
    group:group("mags_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-TN", kind = "distribution" }
    group:group("mags_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-TX", kind = "distribution" }
    group:group("mags_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-UT", kind = "distribution" }
    group:group("mags_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-VA", kind = "distribution" }
    group:group("mags_common-restricted15")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-VT", kind = "distribution" }
    group:group("mags_common-split")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-WA", kind = "distribution" }
    group:group("mags_common-restricted10")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-WI", kind = "distribution" }
    group:group("mags_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-WV", kind = "distribution" }
    group:group("mags_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mags_common-US-WY", kind = "distribution" }
    group:group("mags_common-open")
    content.add(group)
end
