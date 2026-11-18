local content = require("ccb").content

do
    -- _DEPRECATED_ Older military magazines still in service.
    local group = content.ItemGroup { id = "mags_military", kind = "distribution" }
    group:item("m1911mag", 5)
    group:item("m9mag", 15)
    group:item("usp45mag", 5)
    content.add(group)
end

do
    -- Obsolete military magazines no longer in common use.
    local group = content.ItemGroup { id = "mags_surplus", kind = "distribution" }
    group:item("3006_clip", 5)
    group:item("pressurized_tank", 5)
    group:item("falmag", 20)
    group:item("g3mag", 15)
    group:item("m1911mag", 15)
    group:item("m1918mag", 5)
    group:item("m9mag", 25)
    group:item("stenmag", 40)
    group:item("thompson_mag", 5)
    group:item("m1carbinemag", 10)
    group:item("m1carbinebigmag", 5)
    content.add(group)
end

do
    -- Standard issue police magazines.
    local group = content.ItemGroup { id = "mags_cop", kind = "distribution" }
    group:entry { item = "fn57mag", charges = { 0, 20 }, probability = 15 }
    group:entry { item = "glockmag", charges = { 0, 15 }, probability = 40 }
    group:entry { item = "glock40mag", charges = { 0, 15 }, probability = 30 }
    group:entry { item = "m9mag", charges = { 0, 15 }, probability = 5 }
    group:entry { item = "mp5mag", charges = { 0, 30 }, probability = 10 }
    group:entry { item = "sig40mag", charges = { 0, 12 }, probability = 20 }
    group:entry { item = "stanag30", charges = { 0, 30 }, probability = 5 }
    group:entry { item = "ppq9mag_10rd", charges = { 0, 10 }, probability = 1 }
    group:entry { item = "ppq9mag_15rd", charges = { 0, 15 }, probability = 1 }
    group:entry { item = "ppq9mag_17rd", charges = { 0, 17 }, probability = 1 }
    group:entry { item = "ppq45mag", charges = { 0, 12 }, probability = 1 }
    content.add(group)
end

do
    -- Magazines issued to paramilitary forces in addition to standard police issue.
    local group = content.ItemGroup { id = "mags_swat", kind = "distribution" }
    group:group("mags_cop", 50)
    group:entry { item = "fnp90mag", charges = { 0, 50 }, probability = 20 }
    group:entry { item = "glockbigmag", charges = { 0, 30 }, probability = 10 }
    group:entry { item = "glock40bigmag", charges = { 0, 22 }, probability = 10 }
    group:entry { item = "m9bigmag", charges = { 0, 30 }, probability = 10 }
    group:entry { item = "mp5bigmag", charges = { 0, 50 }, probability = 20 }
    group:entry { item = "stanag30ranger", charges = { 0, 30 }, probability = 5 }
    group:entry { item = "stanag30", charges = { 0, 30 }, probability = 20 }
    group:entry { item = "ump45mag", charges = { 0, 25 }, probability = 20 }
    group:entry { item = "usp45mag", charges = { 0, 12 }, probability = 10 }
    group:entry { item = "usp9mag", charges = { 0, 15 }, probability = 10 }
    group:entry { item = "as50mag", charges = { 0, 10 }, probability = 2 }
    group:entry { item = "ai_338mag", charges = { 0, 5 }, probability = 5 }
    group:entry { item = "ai_338mag_10", charges = { 0, 10 }, probability = 10 }
    group:entry { item = "hk417mag_20rd", charges = { 0, 20 }, probability = 20 }
    content.add(group)
end

do
    -- one of the possible 30 round stanags
    local group = content.ItemGroup { id = "stanag_30_random", kind = "distribution" }
    group:item("stanag30", 80)
    group:item("stanag30ranger", 20)
    content.add(group)
end

do
    -- one of the possible 10 round stanags
    local group = content.ItemGroup { id = "stanag_10_random", kind = "distribution" }
    group:item("stanag10", 80)
    group:item("stanag10ranger", 20)
    content.add(group)
end

do
    -- Yes this is a clunky solution that I don't like.  This is to allow magazines in common_magazines a <1 probabilty to spawn.
    local group = content.ItemGroup { id = "uncommon_magazines", kind = "distribution" }
    group:item("deaglemag_50")
    group:item("makarovmag", 65)
    group:item("tokarevmag", 45)
    content.add(group)
end

do
    -- Collections of magazines for guns that are common place and follow the magazine limit law, specifically 10 round magazines or under, unless a lower capacity mag is not yet implemented, then just lowest capacity.
    local group = content.ItemGroup { id = "mags_common_restricted", kind = "distribution" }
    group:group("common_magazines_restricted_9mm", 209)
    group:group("common_magazines_restricted_10mm", 9)
    group:group("common_magazines_restricted_22lr", 204)
    group:item("m1carbinemag", 1)
    group:group("common_magazines_32", 44)
    group:group("common_magazines_38", 34)
    group:group("common_magazines_restricted_40sw", 40)
    group:group("common_magazines_44", 15)
    group:group("common_magazines_restricted_45", 49)
    group:group("common_magazines_restricted_57", 4)
    group:group("common_magazines_restricted_223", 125)
    group:item("enfield_303mag", 19)
    group:group("common_magazines_restricted_308", 25)
    group:group("common_magazines_380", 48)
    group:group("common_magazines_restricted_762", 34)
    group:group("common_magazines_762R", 4)
    group:group("common_magazines_3006", 8)
    group:group("common_magazines_450", 1)
    group:group("common_magazines_restricted_12", 8)
    group:group("uncommon_magazines", 3)
    group:item("ak74mag", 1)
    group:item("500_speedloader5", 1)
    group:item("ruger_pr_mag", 1)
    group:item("454_speedloader5", 25)
    group:item("50beowulf_ar15mag", 2)
    group:item("m1911mag_10rd_38super", 2)
    content.add(group)
end

do
    -- Gun magazines in blister packages
    local group = content.ItemGroup { id = "mags_common_restricted_packaged", kind = "distribution" }
    group:entry {
        item = "blister_pack",
        contents = {
            { group = "mags_common_restricted" },
        },
    }
    content.add(group)
end

do
    -- Collections of magazines for guns that are quite rare, and should only be found in private collections.
    local group = content.ItemGroup { id = "mags_collector", kind = "distribution" }
    group:group("rare_magazines_9mm", 209)
    group:group("rare_magazines_45", 49)
    group:item("ump40mag", 3)
    group:item("mac11mag", 35)
    content.add(group)
end

do
    -- Empty magazines for high-caliber pistols found within hunting supply stores and related locations.  Speed loaders have a lower chance as they're not required for the gun to operate, and I don't imagine quicker reloads being horribly important in hunting game.
    local group = content.ItemGroup { id = "mags_pistol_hunting", kind = "distribution" }
    group:group("magazines_10mm_glock", 170)
    group:item("deaglemag", 71)
    group:item("deaglemag_50", 35)
    group:item("deaglemag_357")
    group:item("500_speedloader5", 4)
    group:item("38_speedloader6", 60)
    group:item("38_speedloader", 20)
    group:item("44_speedloader6", 35)
    group:item("454_speedloader5", 5)
    content.add(group)
end

do
    -- Empty hunting rifle magazines found within hunting supply stores and related locations.
    local group = content.ItemGroup { id = "mags_rifle_hunting", kind = "distribution" }
    group:group("common_magazines_223", 25)
    group:group("common_magazines_308", 60)
    group:group("common_magazines_762", 12)
    group:group("common_magazines_762R", 8)
    group:group("common_magazines_3006", 15)
    group:group("common_magazines_450", 10)
    group:group("magazines_22_1022")
    group:group("magazines_22_ar", 6)
    content.add(group)
end

do
    -- Makeshift or otherwise poor quality shotgun magazines.
    local group = content.ItemGroup { id = "mags_shotgun_makeshift", kind = "distribution" }
    group:item("shotbelt_20", 1)
    content.add(group)
end

do
    -- Factory specification magazines commonly owned by citizens that have no better category.
    local group = content.ItemGroup { id = "mags_other_common", kind = "distribution" }
    content.add(group)
end

do
    -- Makeshift or otherwise poor quality magazines that have no better category.
    local group = content.ItemGroup { id = "mags_other_makeshift", kind = "distribution" }
    group:item("nailmag", 20)
    content.add(group)
end

do
    -- Makeshift or otherwise poor quality magazines that have no better category.
    local group = content.ItemGroup { id = "mags_flamethrower", kind = "distribution" }
    group:item("pressurized_tank_chem", 5)
    content.add(group)
end

do
    -- Makeshift or otherwise poor quality magazines that have no better category.
    local group = content.ItemGroup { id = "mags_flamethrower_xedra", kind = "distribution" }
    group:item("pressurized_tank_chem", 5)
    group:item("pressurized_tank_modern", 10)
    content.add(group)
end

do
    -- Empty store magazines for hunting guns.
    local group = content.ItemGroup { id = "mags_hunting", kind = "distribution" }
    group:group("mags_pistol_hunting", 10)
    group:group("mags_rifle_hunting")
    content.add(group)
end
