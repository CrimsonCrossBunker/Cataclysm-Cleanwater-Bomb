local content = require("ccb").content

do
    local group = content.ItemGroup { id = "regional_boxed_glock_17-glock17_17", kind = "collection", container = "box_pistol" }
    group:item("glock_17")
    group:group("firearm_box_extras")
    group:entry { item = "glock17_17", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_boxed_glock_19-glockmag", kind = "collection", container = "box_pistol" }
    group:item("glock_19")
    group:group("firearm_box_extras")
    group:entry { item = "glockmag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_boxed_m9-m9mag", kind = "collection", container = "box_pistol" }
    group:item("m9")
    group:group("firearm_box_extras")
    group:entry { item = "m9mag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_boxed_m1911-m1911mag", kind = "collection", container = "box_pistol" }
    group:item("m1911")
    group:group("firearm_box_extras")
    group:entry { item = "m1911mag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_boxed_rugerlcp-rugerlcpmag", kind = "collection", container = "box_pistol" }
    group:item("rugerlcp")
    group:group("firearm_box_extras")
    group:entry { item = "rugerlcpmag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_boxed_model_10_revolver", kind = "collection", container = "box_pistol" }
    group:item("model_10_revolver")
    group:group("firearm_box_extras")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_boxed_walther_p22-wp22mag", kind = "collection", container = "box_pistol" }
    group:item("walther_p22")
    group:group("firearm_box_extras")
    group:entry { item = "wp22mag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_boxed_ruger_lcr_22", kind = "collection", container = "box_pistol" }
    group:item("ruger_lcr_22")
    group:group("firearm_box_extras")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "regional_boxed_ruger_1022-ruger1022bigmag",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:item("ruger_1022")
    group:group("firearm_box_extras")
    group:entry { item = "ruger1022bigmag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "regional_boxed_henry_golden_boy",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:item("henry_golden_boy")
    group:group("firearm_box_extras")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "regional_boxed_marlin_336_3030",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:item("marlin_336_3030")
    group:group("firearm_box_extras")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "regional_boxed_remington_700",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:item("remington_700")
    group:group("firearm_box_extras")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "regional_boxed_remington_700_308",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:item("remington_700_308")
    group:group("firearm_box_extras")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "regional_boxed_steyr_scout-steyr_scout_mag",
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
        id = "regional_boxed_mossberg_500",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_shotgun",
    }
    group:item("mossberg_500")
    group:group("firearm_box_extras")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "regional_boxed_remington_870",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_shotgun",
    }
    group:item("remington_870")
    group:group("firearm_box_extras")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "regional_boxed_mossberg_500_20",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_shotgun",
    }
    group:item("mossberg_500_20")
    group:group("firearm_box_extras")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "regional_boxed_mossberg_500_410",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_shotgun",
    }
    group:item("mossberg_500_410")
    group:group("firearm_box_extras")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "regional_boxed_ithaca37",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_shotgun",
    }
    group:item("ithaca37")
    group:group("firearm_box_extras")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "regional_boxed_winchester_1897",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_shotgun",
    }
    group:item("winchester_1897")
    group:group("firearm_box_extras")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "regional_boxed_remington_1100",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_shotgun",
    }
    group:item("remington_1100")
    group:group("firearm_box_extras")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "regional_boxed_benelli_m4",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_shotgun",
    }
    group:item("benelli_m4")
    group:group("firearm_box_extras")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "regional_boxed_mossberg_590m-mossberg_590m_mag_20",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_shotgun",
    }
    group:item("mossberg_590m")
    group:group("firearm_box_extras")
    group:entry { item = "mossberg_590m_mag_20", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "regional_boxed_ruger_mini-ruger20",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:item("ruger_mini")
    group:group("firearm_box_extras")
    group:entry { item = "ruger20", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "regional_boxed_mp_15-stanag30",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:item("mp_15")
    group:group("firearm_box_extras")
    group:entry { item = "stanag30", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "regional_boxed_sks",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:item("sks")
    group:group("firearm_box_extras")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "regional_boxed_m1a-m14mag",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:item("m1a")
    group:group("firearm_box_extras")
    group:entry { item = "m14mag", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-open", kind = "distribution" }
    group:group("guns_pistol_common-open", 90)
    group:group("guns_rifle_common-open", 30)
    group:group("guns_shotgun_common-open", 8)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common_boxed-open", kind = "distribution" }
    group:group("guns_pistol_common_boxed-open", 90)
    group:group("guns_rifle_common_boxed-open", 30)
    group:group("guns_shotgun_common_boxed-open", 8)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common_display-open", kind = "distribution" }
    group:group("guns_pistol_common_display-open", 90)
    group:group("guns_rifle_common_display-open", 30)
    group:group("guns_shotgun_common_display-open", 8)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_original_guns_pistol_common", kind = "distribution", with_magazine = 100 }
    group:group("guns_pistol_common_9mm", 74)
    group:group("guns_pistol_common_22", 64)
    group:group("guns_pistol_common_45", 20)
    group:group("guns_pistol_common_380", 28)
    group:group("guns_pistol_common_40", 19)
    group:group("guns_pistol_common_357mag", 12)
    group:group("guns_pistol_common_38", 11)
    group:group("guns_pistol_common_44", 1)
    group:group("guns_pistol_common_10mm", 1)
    group:group("guns_pistol_common_223", 33)
    group:group("guns_pistol_common_300", 8)
    group:group("guns_pistol_common_57", 2)
    group:group("guns_pistol_common_460", 2)
    group:group("guns_pistol_common_32", 1)
    group:group("guns_pistol_common_45colt", 1)
    group:group("guns_pistol_common_38super", 1)
    group:group("guns_pistol_common_other", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common-open", kind = "distribution" }
    group:entry {
        item = "glock_17",
        contents = {
            { item = "glock17_17" },
        },
    }
    group:entry {
        item = "glock_19",
        contents = {
            { item = "glockmag" },
        },
        probability = 110,
    }
    group:entry {
        item = "m9",
        contents = {
            { item = "m9mag" },
        },
        probability = 55,
    }
    group:entry {
        item = "m1911",
        contents = {
            { item = "m1911mag" },
        },
        probability = 60,
    }
    group:entry {
        item = "rugerlcp",
        contents = {
            { item = "rugerlcpmag" },
        },
        probability = 70,
    }
    group:item("model_10_revolver", 55)
    group:entry {
        item = "walther_p22",
        contents = {
            { item = "wp22mag" },
        },
        probability = 60,
    }
    group:item("ruger_lcr_22", 30)
    group:group("regional_original_guns_pistol_common", 540)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_original_guns_pistol_common_display", kind = "distribution" }
    group:group("guns_pistol_common_display_9mm", 74)
    group:group("guns_pistol_common_display_22", 64)
    group:group("guns_pistol_common_display_45", 20)
    group:group("guns_pistol_common_display_380", 28)
    group:group("guns_pistol_common_display_40", 19)
    group:group("guns_pistol_common_display_357mag", 12)
    group:group("guns_pistol_common_display_38", 11)
    group:group("guns_pistol_common_display_44", 1)
    group:group("guns_pistol_common_display_45colt", 5)
    group:group("guns_pistol_common_display_10mm", 1)
    group:group("guns_pistol_common_display_223", 17)
    group:group("guns_pistol_common_display_300", 8)
    group:group("guns_pistol_common_display_57", 2)
    group:group("guns_pistol_common_display_460", 2)
    group:group("guns_pistol_common_display_32", 1)
    group:group("guns_pistol_common_display_38super", 1)
    group:group("guns_pistol_common_display_other", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_display-open", kind = "distribution" }
    group:item("glock_17")
    group:item("glock_19", 110)
    group:item("m9", 55)
    group:item("m1911", 60)
    group:item("rugerlcp", 70)
    group:item("model_10_revolver", 55)
    group:item("walther_p22", 60)
    group:item("ruger_lcr_22", 30)
    group:group("regional_original_guns_pistol_common_display", 540)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_boxed-open", kind = "distribution" }
    group:group("regional_boxed_glock_17-glock17_17")
    group:group("regional_boxed_glock_19-glockmag", 110)
    group:group("regional_boxed_m9-m9mag", 55)
    group:group("regional_boxed_m1911-m1911mag", 60)
    group:group("regional_boxed_rugerlcp-rugerlcpmag", 70)
    group:group("regional_boxed_model_10_revolver", 55)
    group:group("regional_boxed_walther_p22-wp22mag", 60)
    group:group("regional_boxed_ruger_lcr_22", 30)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "regional_original_guns_pistol_common_everyday_carry",
        kind = "distribution",
        with_magazine = 100,
    }
    group:group("guns_pistol_common_everyday_carry_9mm", 92)
    group:group("guns_pistol_common_everyday_carry_22", 73)
    group:group("guns_pistol_common_everyday_carry_45", 21)
    group:group("guns_pistol_common_everyday_carry_380", 28)
    group:group("guns_pistol_common_everyday_carry_40", 13)
    group:group("guns_pistol_common_everyday_carry_357mag", 4)
    group:group("guns_pistol_common_everyday_carry_38", 8)
    group:group("guns_pistol_common_everyday_carry_44", 1)
    group:group("guns_pistol_common_everyday_carry_10mm", 1)
    group:group("guns_pistol_common_everyday_carry_32", 2)
    group:group("guns_pistol_common_everyday_carry_57", 2)
    group:group("guns_pistol_common_everyday_carry_38super", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_everyday_carry-open", kind = "distribution" }
    group:entry {
        item = "glock_17",
        contents = {
            { item = "glock17_17" },
        },
    }
    group:entry {
        item = "glock_19",
        contents = {
            { item = "glockmag" },
        },
        probability = 110,
    }
    group:entry {
        item = "m9",
        contents = {
            { item = "m9mag" },
        },
        probability = 55,
    }
    group:entry {
        item = "m1911",
        contents = {
            { item = "m1911mag" },
        },
        probability = 60,
    }
    group:entry {
        item = "rugerlcp",
        contents = {
            { item = "rugerlcpmag" },
        },
        probability = 70,
    }
    group:item("model_10_revolver", 55)
    group:entry {
        item = "walther_p22",
        contents = {
            { item = "wp22mag" },
        },
        probability = 60,
    }
    group:item("ruger_lcr_22", 30)
    group:group("regional_original_guns_pistol_common_everyday_carry", 540)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_original_guns_pistol_hunting_display", kind = "distribution" }
    group:group("guns_pistol_common_display_22", 20)
    group:group("guns_pistol_common_display_44", 20)
    group:group("guns_pistol_common_display_357mag", 45)
    group:group("guns_pistol_common_display_10mm", 4)
    group:item("bfr", 4)
    group:item("raging_bull", 4)
    group:item("sw_500", 7)
    group:item("460_xvr", 6)
    group:group("modular_deagle_50", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_hunting_display-open", kind = "distribution" }
    group:item("glock_17")
    group:item("glock_19", 110)
    group:item("m9", 55)
    group:item("m1911", 60)
    group:item("rugerlcp", 70)
    group:item("model_10_revolver", 55)
    group:item("walther_p22", 60)
    group:item("ruger_lcr_22", 30)
    group:group("regional_original_guns_pistol_hunting_display", 540)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_original_guns_rifle_common", kind = "distribution", with_magazine = 100 }
    group:group("guns_rifle_common_22", 1760)
    group:group("guns_rifle_common_223", 1000)
    group:group("guns_rifle_common_308", 320)
    group:group("guns_rifle_common_45acp", 271)
    group:group("guns_rifle_common_762", 230)
    group:group("guns_rifle_common_9mm", 180)
    group:group("guns_rifle_common_3006", 149)
    group:group("guns_rifle_common_357", 108)
    group:group("guns_rifle_common_44", 81)
    group:group("guns_rifle_common_3030", 76)
    group:group("guns_rifle_common_762R", 70)
    group:group("guns_rifle_common_270win", 57)
    group:group("guns_rifle_common_300winmag", 32)
    group:group("guns_rifle_common_380", 24)
    group:group("guns_rifle_common_300blk", 19)
    group:group("guns_rifle_common_4570", 18)
    group:group("guns_rifle_common_30carbine", 17)
    group:group("guns_rifle_common_303", 16)
    group:group("guns_rifle_common_338", 14)
    group:group("guns_rifle_common_450", 3)
    group:group("guns_rifle_common_50beowulf", 3)
    group:group("guns_rifle_common_57", 3)
    group:group("guns_rifle_common_545", 3)
    group:group("guns_rifle_common_7mm_arisaka", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common-open", kind = "distribution" }
    group:entry {
        item = "ruger_1022",
        contents = {
            { item = "ruger1022bigmag" },
        },
        probability = 125,
    }
    group:item("henry_golden_boy", 65)
    group:item("marlin_336_3030", 65)
    group:item("remington_700", 85)
    group:item("remington_700_308", 80)
    group:entry {
        item = "steyr_scout",
        contents = {
            { item = "steyr_scout_mag" },
        },
        probability = 25,
    }
    group:entry {
        item = "ruger_mini",
        contents = {
            { item = "ruger20" },
        },
        probability = 60,
    }
    group:entry {
        item = "mp_15",
        contents = {
            { item = "stanag30" },
        },
        probability = 125,
    }
    group:item("sks", 45)
    group:entry {
        item = "m1a",
        contents = {
            { item = "m14mag" },
        },
        probability = 45,
    }
    group:group("regional_original_guns_rifle_common", 720)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_original_guns_rifle_common_display", kind = "distribution" }
    group:group("guns_rifle_common_display_22", 1760)
    group:group("guns_rifle_common_display_223", 1000)
    group:group("guns_rifle_common_display_308", 320)
    group:group("guns_rifle_common_display_45acp", 271)
    group:group("guns_rifle_common_display_762", 230)
    group:group("guns_rifle_common_display_9mm", 180)
    group:group("guns_rifle_common_display_3006", 149)
    group:group("guns_rifle_common_display_357", 108)
    group:group("guns_rifle_common_display_44", 81)
    group:group("guns_rifle_common_display_3030", 76)
    group:group("guns_rifle_common_display_762R", 70)
    group:group("guns_rifle_common_display_270win", 57)
    group:group("guns_rifle_common_display_300winmag", 32)
    group:group("guns_rifle_common_display_380", 24)
    group:group("guns_rifle_common_display_300blk", 19)
    group:group("guns_rifle_common_display_4570", 18)
    group:group("guns_rifle_common_display_30carbine", 17)
    group:group("guns_rifle_common_display_303", 16)
    group:group("guns_rifle_common_display_338", 14)
    group:group("guns_rifle_common_display_450", 3)
    group:group("guns_rifle_common_display_50beowulf", 3)
    group:group("guns_rifle_common_display_57", 3)
    group:group("guns_rifle_common_display_545", 3)
    group:group("guns_rifle_common_display_7mm_arisaka", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_display-open", kind = "distribution" }
    group:item("ruger_1022", 125)
    group:item("henry_golden_boy", 65)
    group:item("marlin_336_3030", 65)
    group:item("remington_700", 85)
    group:item("remington_700_308", 80)
    group:item("steyr_scout", 25)
    group:item("ruger_mini", 60)
    group:item("mp_15", 125)
    group:item("sks", 45)
    group:item("m1a", 45)
    group:group("regional_original_guns_rifle_common_display", 720)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_boxed-open", kind = "distribution" }
    group:group("regional_boxed_ruger_1022-ruger1022bigmag", 125)
    group:group("regional_boxed_henry_golden_boy", 65)
    group:group("regional_boxed_marlin_336_3030", 65)
    group:group("regional_boxed_remington_700", 85)
    group:group("regional_boxed_remington_700_308", 80)
    group:group("regional_boxed_steyr_scout-steyr_scout_mag", 25)
    group:group("regional_boxed_ruger_mini-ruger20", 60)
    group:group("regional_boxed_mp_15-stanag30", 125)
    group:group("regional_boxed_sks", 45)
    group:group("regional_boxed_m1a-m14mag", 45)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_worn-open", kind = "distribution" }
    group:entry {
        item = "ruger_1022",
        damage = { 1, 4 },
        contents = {
            { item = "ruger1022bigmag" },
        },
        probability = 125,
    }
    group:entry { item = "henry_golden_boy", damage = { 1, 4 }, probability = 65 }
    group:entry { item = "marlin_336_3030", damage = { 1, 4 }, probability = 65 }
    group:entry { item = "remington_700", damage = { 1, 4 }, probability = 85 }
    group:entry { item = "remington_700_308", damage = { 1, 4 }, probability = 80 }
    group:entry {
        item = "steyr_scout",
        damage = { 1, 4 },
        contents = {
            { item = "steyr_scout_mag" },
        },
        probability = 25,
    }
    group:entry {
        item = "ruger_mini",
        damage = { 1, 4 },
        contents = {
            { item = "ruger20" },
        },
        probability = 60,
    }
    group:entry {
        item = "mp_15",
        damage = { 1, 4 },
        contents = {
            { item = "stanag30" },
        },
        probability = 125,
    }
    group:entry { item = "sks", damage = { 1, 4 }, probability = 45 }
    group:entry {
        item = "m1a",
        damage = { 1, 4 },
        contents = {
            { item = "m14mag" },
        },
        probability = 45,
    }
    group:group("regional_original_guns_rifle_common_worn", 720)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_original_guns_rifle_hunting_display", kind = "distribution" }
    group:group("guns_rifle_common_display_22", 176)
    group:group("guns_rifle_common_display_223")
    group:group("guns_rifle_common_display_308", 320)
    group:group("guns_rifle_common_display_762", 115)
    group:group("guns_rifle_common_display_3006", 149)
    group:group("guns_rifle_common_display_44", 8)
    group:group("guns_rifle_common_display_3030", 76)
    group:group("guns_rifle_common_display_762R", 70)
    group:group("guns_rifle_common_display_270win", 57)
    group:group("guns_rifle_common_display_300winmag", 32)
    group:group("guns_rifle_common_display_4570", 18)
    group:group("guns_rifle_common_display_303", 16)
    group:group("guns_rifle_common_display_338", 14)
    group:group("guns_rifle_common_display_450", 3)
    group:group("guns_rifle_common_display_50beowulf", 3)
    group:group("guns_rifle_common_display_7mm_arisaka", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_hunting_display-open", kind = "distribution" }
    group:item("ruger_1022", 125)
    group:item("henry_golden_boy", 65)
    group:item("marlin_336_3030", 65)
    group:item("remington_700", 85)
    group:item("remington_700_308", 80)
    group:item("steyr_scout", 25)
    group:item("ruger_mini", 60)
    group:item("mp_15", 125)
    group:item("sks", 45)
    group:item("m1a", 45)
    group:group("regional_original_guns_rifle_hunting_display", 720)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_original_guns_shotgun_common", kind = "distribution", with_magazine = 100 }
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
    local group = content.ItemGroup { id = "guns_shotgun_common-open", kind = "distribution" }
    group:item("mossberg_500")
    group:item("remington_870")
    group:item("mossberg_500_20", 70)
    group:item("mossberg_500_410", 35)
    group:item("ithaca37", 30)
    group:item("winchester_1897", 15)
    group:item("remington_1100", 30)
    group:item("benelli_m4", 25)
    group:entry {
        item = "mossberg_590m",
        contents = {
            { item = "mossberg_590m_mag_20" },
        },
        probability = 25,
    }
    group:group("regional_original_guns_shotgun_common", 430)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_original_guns_shotgun_common_display", kind = "distribution" }
    group:group("12_gauge_semi_display", 48)
    group:group("12_gauge_pump_display", 34)
    group:group("12_gauge_break_display", 18)
    group:group("20_gauge_pump_display", 6)
    group:group("20_gauge_bolt_display", 5)
    group:group("20_gauge_break_display", 2)
    group:item("mossberg_500_410", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_shotgun_common_display-open", kind = "distribution" }
    group:item("mossberg_500")
    group:item("remington_870")
    group:item("mossberg_500_20", 70)
    group:item("mossberg_500_410", 35)
    group:item("ithaca37", 30)
    group:item("winchester_1897", 15)
    group:item("remington_1100", 30)
    group:item("benelli_m4", 25)
    group:item("mossberg_590m", 25)
    group:group("regional_original_guns_shotgun_common_display", 430)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_shotgun_common_boxed-open", kind = "distribution" }
    group:group("regional_boxed_mossberg_500")
    group:group("regional_boxed_remington_870")
    group:group("regional_boxed_mossberg_500_20", 70)
    group:group("regional_boxed_mossberg_500_410", 35)
    group:group("regional_boxed_ithaca37", 30)
    group:group("regional_boxed_winchester_1897", 15)
    group:group("regional_boxed_remington_1100", 30)
    group:group("regional_boxed_benelli_m4", 25)
    group:group("regional_boxed_mossberg_590m-mossberg_590m_mag_20", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_shotgun_common_worn-open", kind = "distribution" }
    group:entry { item = "mossberg_500", damage = { 1, 4 } }
    group:entry { item = "remington_870", damage = { 1, 4 } }
    group:entry { item = "mossberg_500_20", damage = { 1, 4 }, probability = 70 }
    group:entry { item = "mossberg_500_410", damage = { 1, 4 }, probability = 35 }
    group:entry { item = "ithaca37", damage = { 1, 4 }, probability = 30 }
    group:entry { item = "winchester_1897", damage = { 1, 4 }, probability = 15 }
    group:entry { item = "remington_1100", damage = { 1, 4 }, probability = 30 }
    group:entry { item = "benelli_m4", damage = { 1, 4 }, probability = 25 }
    group:entry {
        item = "mossberg_590m",
        damage = { 1, 4 },
        contents = {
            { item = "mossberg_590m_mag_20" },
        },
        probability = 25,
    }
    group:group("regional_original_guns_shotgun_common_worn", 430)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_boxed_glock_17-glock17_10", kind = "collection", container = "box_pistol" }
    group:item("glock_17")
    group:group("firearm_box_extras")
    group:entry { item = "glock17_10", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "regional_boxed_ruger_1022-ruger1022mag",
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
    local group = content.ItemGroup {
        id = "regional_boxed_mossberg_590m-mossberg_590m_mag_10",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_shotgun",
    }
    group:item("mossberg_590m")
    group:group("firearm_box_extras")
    group:entry { item = "mossberg_590m_mag_10", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "regional_boxed_ruger_mini-ruger10",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:item("ruger_mini")
    group:group("firearm_box_extras")
    group:entry { item = "ruger10", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "regional_boxed_mp_15-stanag10",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:item("mp_15")
    group:group("firearm_box_extras")
    group:entry { item = "stanag10", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "regional_boxed_m1a-m14smallmag",
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
    local group = content.ItemGroup { id = "guns_common-split", kind = "distribution" }
    group:group("guns_pistol_common-split", 90)
    group:group("guns_rifle_common-split", 30)
    group:group("guns_shotgun_common-split", 8)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common_boxed-split", kind = "distribution" }
    group:group("guns_pistol_common_boxed-split", 90)
    group:group("guns_rifle_common_boxed-split", 30)
    group:group("guns_shotgun_common_boxed-split", 8)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common_display-split", kind = "distribution" }
    group:group("guns_pistol_common_display-split", 90)
    group:group("guns_rifle_common_display-split", 30)
    group:group("guns_shotgun_common_display-split", 8)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common-split", kind = "distribution" }
    group:entry {
        item = "glock_17",
        contents = {
            { item = "glock17_10" },
        },
    }
    group:entry {
        item = "glock_19",
        contents = {
            { item = "glockmag" },
        },
        probability = 110,
    }
    group:entry {
        item = "m9",
        contents = {
            { item = "m9mag" },
        },
        probability = 55,
    }
    group:entry {
        item = "m1911",
        contents = {
            { item = "m1911mag" },
        },
        probability = 60,
    }
    group:entry {
        item = "rugerlcp",
        contents = {
            { item = "rugerlcpmag" },
        },
        probability = 70,
    }
    group:item("model_10_revolver", 55)
    group:entry {
        item = "walther_p22",
        contents = {
            { item = "wp22mag" },
        },
        probability = 60,
    }
    group:item("ruger_lcr_22", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_display-split", kind = "distribution" }
    group:item("glock_17")
    group:item("glock_19", 110)
    group:item("m9", 55)
    group:item("m1911", 60)
    group:item("rugerlcp", 70)
    group:item("model_10_revolver", 55)
    group:item("walther_p22", 60)
    group:item("ruger_lcr_22", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_boxed-split", kind = "distribution" }
    group:group("regional_boxed_glock_17-glock17_10")
    group:group("regional_boxed_glock_19-glockmag", 110)
    group:group("regional_boxed_m9-m9mag", 55)
    group:group("regional_boxed_m1911-m1911mag", 60)
    group:group("regional_boxed_rugerlcp-rugerlcpmag", 70)
    group:group("regional_boxed_model_10_revolver", 55)
    group:group("regional_boxed_walther_p22-wp22mag", 60)
    group:group("regional_boxed_ruger_lcr_22", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_everyday_carry-split", kind = "distribution" }
    group:entry {
        item = "glock_17",
        contents = {
            { item = "glock17_10" },
        },
    }
    group:entry {
        item = "glock_19",
        contents = {
            { item = "glockmag" },
        },
        probability = 110,
    }
    group:entry {
        item = "m9",
        contents = {
            { item = "m9mag" },
        },
        probability = 55,
    }
    group:entry {
        item = "m1911",
        contents = {
            { item = "m1911mag" },
        },
        probability = 60,
    }
    group:entry {
        item = "rugerlcp",
        contents = {
            { item = "rugerlcpmag" },
        },
        probability = 70,
    }
    group:item("model_10_revolver", 55)
    group:entry {
        item = "walther_p22",
        contents = {
            { item = "wp22mag" },
        },
        probability = 60,
    }
    group:item("ruger_lcr_22", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_hunting_display-split", kind = "distribution" }
    group:item("glock_17")
    group:item("glock_19", 110)
    group:item("m9", 55)
    group:item("m1911", 60)
    group:item("rugerlcp", 70)
    group:item("model_10_revolver", 55)
    group:item("walther_p22", 60)
    group:item("ruger_lcr_22", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common-split", kind = "distribution" }
    group:entry {
        item = "ruger_1022",
        contents = {
            { item = "ruger1022mag" },
        },
        probability = 125,
    }
    group:item("henry_golden_boy", 65)
    group:item("marlin_336_3030", 65)
    group:item("remington_700", 85)
    group:item("remington_700_308", 80)
    group:entry {
        item = "steyr_scout",
        contents = {
            { item = "steyr_scout_mag" },
        },
        probability = 25,
    }
    group:entry {
        item = "ruger_mini",
        contents = {
            { item = "ruger10" },
        },
        probability = 60,
    }
    group:entry {
        item = "mp_15",
        contents = {
            { item = "stanag10" },
        },
        probability = 125,
    }
    group:item("sks", 45)
    group:entry {
        item = "m1a",
        contents = {
            { item = "m14smallmag" },
        },
        probability = 45,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_display-split", kind = "distribution" }
    group:item("ruger_1022", 125)
    group:item("henry_golden_boy", 65)
    group:item("marlin_336_3030", 65)
    group:item("remington_700", 85)
    group:item("remington_700_308", 80)
    group:item("steyr_scout", 25)
    group:item("ruger_mini", 60)
    group:item("mp_15", 125)
    group:item("sks", 45)
    group:item("m1a", 45)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_boxed-split", kind = "distribution" }
    group:group("regional_boxed_ruger_1022-ruger1022mag", 125)
    group:group("regional_boxed_henry_golden_boy", 65)
    group:group("regional_boxed_marlin_336_3030", 65)
    group:group("regional_boxed_remington_700", 85)
    group:group("regional_boxed_remington_700_308", 80)
    group:group("regional_boxed_steyr_scout-steyr_scout_mag", 25)
    group:group("regional_boxed_ruger_mini-ruger10", 60)
    group:group("regional_boxed_mp_15-stanag10", 125)
    group:group("regional_boxed_sks", 45)
    group:group("regional_boxed_m1a-m14smallmag", 45)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_worn-split", kind = "distribution" }
    group:entry {
        item = "ruger_1022",
        damage = { 1, 4 },
        contents = {
            { item = "ruger1022mag" },
        },
        probability = 125,
    }
    group:entry { item = "henry_golden_boy", damage = { 1, 4 }, probability = 65 }
    group:entry { item = "marlin_336_3030", damage = { 1, 4 }, probability = 65 }
    group:entry { item = "remington_700", damage = { 1, 4 }, probability = 85 }
    group:entry { item = "remington_700_308", damage = { 1, 4 }, probability = 80 }
    group:entry {
        item = "steyr_scout",
        damage = { 1, 4 },
        contents = {
            { item = "steyr_scout_mag" },
        },
        probability = 25,
    }
    group:entry {
        item = "ruger_mini",
        damage = { 1, 4 },
        contents = {
            { item = "ruger10" },
        },
        probability = 60,
    }
    group:entry {
        item = "mp_15",
        damage = { 1, 4 },
        contents = {
            { item = "stanag10" },
        },
        probability = 125,
    }
    group:entry { item = "sks", damage = { 1, 4 }, probability = 45 }
    group:entry {
        item = "m1a",
        damage = { 1, 4 },
        contents = {
            { item = "m14smallmag" },
        },
        probability = 45,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_hunting_display-split", kind = "distribution" }
    group:item("ruger_1022", 125)
    group:item("henry_golden_boy", 65)
    group:item("marlin_336_3030", 65)
    group:item("remington_700", 85)
    group:item("remington_700_308", 80)
    group:item("steyr_scout", 25)
    group:item("ruger_mini", 60)
    group:item("mp_15", 125)
    group:item("sks", 45)
    group:item("m1a", 45)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_shotgun_common-split", kind = "distribution" }
    group:item("mossberg_500")
    group:item("remington_870")
    group:item("mossberg_500_20", 70)
    group:item("mossberg_500_410", 35)
    group:item("ithaca37", 30)
    group:item("winchester_1897", 15)
    group:item("remington_1100", 30)
    group:item("benelli_m4", 25)
    group:entry {
        item = "mossberg_590m",
        contents = {
            { item = "mossberg_590m_mag_10" },
        },
        probability = 25,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_shotgun_common_display-split", kind = "distribution" }
    group:item("mossberg_500")
    group:item("remington_870")
    group:item("mossberg_500_20", 70)
    group:item("mossberg_500_410", 35)
    group:item("ithaca37", 30)
    group:item("winchester_1897", 15)
    group:item("remington_1100", 30)
    group:item("benelli_m4", 25)
    group:item("mossberg_590m", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_shotgun_common_boxed-split", kind = "distribution" }
    group:group("regional_boxed_mossberg_500")
    group:group("regional_boxed_remington_870")
    group:group("regional_boxed_mossberg_500_20", 70)
    group:group("regional_boxed_mossberg_500_410", 35)
    group:group("regional_boxed_ithaca37", 30)
    group:group("regional_boxed_winchester_1897", 15)
    group:group("regional_boxed_remington_1100", 30)
    group:group("regional_boxed_benelli_m4", 25)
    group:group("regional_boxed_mossberg_590m-mossberg_590m_mag_10", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_shotgun_common_worn-split", kind = "distribution" }
    group:entry { item = "mossberg_500", damage = { 1, 4 } }
    group:entry { item = "remington_870", damage = { 1, 4 } }
    group:entry { item = "mossberg_500_20", damage = { 1, 4 }, probability = 70 }
    group:entry { item = "mossberg_500_410", damage = { 1, 4 }, probability = 35 }
    group:entry { item = "ithaca37", damage = { 1, 4 }, probability = 30 }
    group:entry { item = "winchester_1897", damage = { 1, 4 }, probability = 15 }
    group:entry { item = "remington_1100", damage = { 1, 4 }, probability = 30 }
    group:entry { item = "benelli_m4", damage = { 1, 4 }, probability = 25 }
    group:entry {
        item = "mossberg_590m",
        damage = { 1, 4 },
        contents = {
            { item = "mossberg_590m_mag_10" },
        },
        probability = 25,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_boxed_glock_19-glockmag_10", kind = "collection", container = "box_pistol" }
    group:item("glock_19")
    group:group("firearm_box_extras")
    group:entry { item = "glockmag_10", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_boxed_m9-m9mag_10rd", kind = "collection", container = "box_pistol" }
    group:item("m9")
    group:group("firearm_box_extras")
    group:entry { item = "m9mag_10rd", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-restricted10", kind = "distribution" }
    group:group("guns_pistol_common-restricted10", 90)
    group:group("guns_rifle_common-restricted10", 30)
    group:group("guns_shotgun_common-restricted10", 8)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common_boxed-restricted10", kind = "distribution" }
    group:group("guns_pistol_common_boxed-restricted10", 90)
    group:group("guns_rifle_common_boxed-restricted10", 30)
    group:group("guns_shotgun_common_boxed-restricted10", 8)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common_display-restricted10", kind = "distribution" }
    group:group("guns_pistol_common_display-restricted10", 90)
    group:group("guns_rifle_common_display-restricted10", 30)
    group:group("guns_shotgun_common_display-restricted10", 8)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common-restricted10", kind = "distribution" }
    group:entry {
        item = "glock_17",
        contents = {
            { item = "glock17_10" },
        },
    }
    group:entry {
        item = "glock_19",
        contents = {
            { item = "glockmag_10" },
        },
        probability = 110,
    }
    group:entry {
        item = "m9",
        contents = {
            { item = "m9mag_10rd" },
        },
        probability = 55,
    }
    group:entry {
        item = "m1911",
        contents = {
            { item = "m1911mag" },
        },
        probability = 60,
    }
    group:entry {
        item = "rugerlcp",
        contents = {
            { item = "rugerlcpmag" },
        },
        probability = 70,
    }
    group:item("model_10_revolver", 55)
    group:entry {
        item = "walther_p22",
        contents = {
            { item = "wp22mag" },
        },
        probability = 60,
    }
    group:item("ruger_lcr_22", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_display-restricted10", kind = "distribution" }
    group:item("glock_17")
    group:item("glock_19", 110)
    group:item("m9", 55)
    group:item("m1911", 60)
    group:item("rugerlcp", 70)
    group:item("model_10_revolver", 55)
    group:item("walther_p22", 60)
    group:item("ruger_lcr_22", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_boxed-restricted10", kind = "distribution" }
    group:group("regional_boxed_glock_17-glock17_10")
    group:group("regional_boxed_glock_19-glockmag_10", 110)
    group:group("regional_boxed_m9-m9mag_10rd", 55)
    group:group("regional_boxed_m1911-m1911mag", 60)
    group:group("regional_boxed_rugerlcp-rugerlcpmag", 70)
    group:group("regional_boxed_model_10_revolver", 55)
    group:group("regional_boxed_walther_p22-wp22mag", 60)
    group:group("regional_boxed_ruger_lcr_22", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_everyday_carry-restricted10", kind = "distribution" }
    group:entry {
        item = "glock_17",
        contents = {
            { item = "glock17_10" },
        },
    }
    group:entry {
        item = "glock_19",
        contents = {
            { item = "glockmag_10" },
        },
        probability = 110,
    }
    group:entry {
        item = "m9",
        contents = {
            { item = "m9mag_10rd" },
        },
        probability = 55,
    }
    group:entry {
        item = "m1911",
        contents = {
            { item = "m1911mag" },
        },
        probability = 60,
    }
    group:entry {
        item = "rugerlcp",
        contents = {
            { item = "rugerlcpmag" },
        },
        probability = 70,
    }
    group:item("model_10_revolver", 55)
    group:entry {
        item = "walther_p22",
        contents = {
            { item = "wp22mag" },
        },
        probability = 60,
    }
    group:item("ruger_lcr_22", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_hunting_display-restricted10", kind = "distribution" }
    group:item("glock_17")
    group:item("glock_19", 110)
    group:item("m9", 55)
    group:item("m1911", 60)
    group:item("rugerlcp", 70)
    group:item("model_10_revolver", 55)
    group:item("walther_p22", 60)
    group:item("ruger_lcr_22", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common-restricted10", kind = "distribution" }
    group:entry {
        item = "ruger_1022",
        contents = {
            { item = "ruger1022mag" },
        },
        probability = 125,
    }
    group:item("henry_golden_boy", 65)
    group:item("marlin_336_3030", 65)
    group:item("remington_700", 85)
    group:item("remington_700_308", 80)
    group:entry {
        item = "steyr_scout",
        contents = {
            { item = "steyr_scout_mag" },
        },
        probability = 25,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_display-restricted10", kind = "distribution" }
    group:item("ruger_1022", 125)
    group:item("henry_golden_boy", 65)
    group:item("marlin_336_3030", 65)
    group:item("remington_700", 85)
    group:item("remington_700_308", 80)
    group:item("steyr_scout", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_boxed-restricted10", kind = "distribution" }
    group:group("regional_boxed_ruger_1022-ruger1022mag", 125)
    group:group("regional_boxed_henry_golden_boy", 65)
    group:group("regional_boxed_marlin_336_3030", 65)
    group:group("regional_boxed_remington_700", 85)
    group:group("regional_boxed_remington_700_308", 80)
    group:group("regional_boxed_steyr_scout-steyr_scout_mag", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_worn-restricted10", kind = "distribution" }
    group:entry {
        item = "ruger_1022",
        damage = { 1, 4 },
        contents = {
            { item = "ruger1022mag" },
        },
        probability = 125,
    }
    group:entry { item = "henry_golden_boy", damage = { 1, 4 }, probability = 65 }
    group:entry { item = "marlin_336_3030", damage = { 1, 4 }, probability = 65 }
    group:entry { item = "remington_700", damage = { 1, 4 }, probability = 85 }
    group:entry { item = "remington_700_308", damage = { 1, 4 }, probability = 80 }
    group:entry {
        item = "steyr_scout",
        damage = { 1, 4 },
        contents = {
            { item = "steyr_scout_mag" },
        },
        probability = 25,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_hunting_display-restricted10", kind = "distribution" }
    group:item("ruger_1022", 125)
    group:item("henry_golden_boy", 65)
    group:item("marlin_336_3030", 65)
    group:item("remington_700", 85)
    group:item("remington_700_308", 80)
    group:item("steyr_scout", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_shotgun_common-restricted10", kind = "distribution" }
    group:item("mossberg_500")
    group:item("remington_870")
    group:item("mossberg_500_20", 70)
    group:item("mossberg_500_410", 35)
    group:item("ithaca37", 30)
    group:item("winchester_1897", 15)
    group:item("remington_1100", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_shotgun_common_display-restricted10", kind = "distribution" }
    group:item("mossberg_500")
    group:item("remington_870")
    group:item("mossberg_500_20", 70)
    group:item("mossberg_500_410", 35)
    group:item("ithaca37", 30)
    group:item("winchester_1897", 15)
    group:item("remington_1100", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_shotgun_common_boxed-restricted10", kind = "distribution" }
    group:group("regional_boxed_mossberg_500")
    group:group("regional_boxed_remington_870")
    group:group("regional_boxed_mossberg_500_20", 70)
    group:group("regional_boxed_mossberg_500_410", 35)
    group:group("regional_boxed_ithaca37", 30)
    group:group("regional_boxed_winchester_1897", 15)
    group:group("regional_boxed_remington_1100", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_shotgun_common_worn-restricted10", kind = "distribution" }
    group:entry { item = "mossberg_500", damage = { 1, 4 } }
    group:entry { item = "remington_870", damage = { 1, 4 } }
    group:entry { item = "mossberg_500_20", damage = { 1, 4 }, probability = 70 }
    group:entry { item = "mossberg_500_410", damage = { 1, 4 }, probability = 35 }
    group:entry { item = "ithaca37", damage = { 1, 4 }, probability = 30 }
    group:entry { item = "winchester_1897", damage = { 1, 4 }, probability = 15 }
    group:entry { item = "remington_1100", damage = { 1, 4 }, probability = 30 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "regional_boxed_ruger_1022-ruger1022mag_15",
        kind = "collection",
        container = "box_longarm",
        container_variant = "box_longarm_rifle",
    }
    group:item("ruger_1022")
    group:group("firearm_box_extras")
    group:entry { item = "ruger1022mag_15", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-restricted17", kind = "distribution" }
    group:group("guns_pistol_common-restricted17", 90)
    group:group("guns_rifle_common-restricted17", 30)
    group:group("guns_shotgun_common-restricted17", 8)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common_boxed-restricted17", kind = "distribution" }
    group:group("guns_pistol_common_boxed-restricted17", 90)
    group:group("guns_rifle_common_boxed-restricted17", 30)
    group:group("guns_shotgun_common_boxed-restricted17", 8)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common_display-restricted17", kind = "distribution" }
    group:group("guns_pistol_common_display-restricted17", 90)
    group:group("guns_rifle_common_display-restricted17", 30)
    group:group("guns_shotgun_common_display-restricted17", 8)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common-restricted17", kind = "distribution" }
    group:entry {
        item = "glock_17",
        contents = {
            { item = "glock17_17" },
        },
    }
    group:entry {
        item = "glock_19",
        contents = {
            { item = "glockmag" },
        },
        probability = 110,
    }
    group:entry {
        item = "m9",
        contents = {
            { item = "m9mag" },
        },
        probability = 55,
    }
    group:entry {
        item = "m1911",
        contents = {
            { item = "m1911mag" },
        },
        probability = 60,
    }
    group:entry {
        item = "rugerlcp",
        contents = {
            { item = "rugerlcpmag" },
        },
        probability = 70,
    }
    group:item("model_10_revolver", 55)
    group:entry {
        item = "walther_p22",
        contents = {
            { item = "wp22mag" },
        },
        probability = 60,
    }
    group:item("ruger_lcr_22", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_display-restricted17", kind = "distribution" }
    group:item("glock_17")
    group:item("glock_19", 110)
    group:item("m9", 55)
    group:item("m1911", 60)
    group:item("rugerlcp", 70)
    group:item("model_10_revolver", 55)
    group:item("walther_p22", 60)
    group:item("ruger_lcr_22", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_boxed-restricted17", kind = "distribution" }
    group:group("regional_boxed_glock_17-glock17_17")
    group:group("regional_boxed_glock_19-glockmag", 110)
    group:group("regional_boxed_m9-m9mag", 55)
    group:group("regional_boxed_m1911-m1911mag", 60)
    group:group("regional_boxed_rugerlcp-rugerlcpmag", 70)
    group:group("regional_boxed_model_10_revolver", 55)
    group:group("regional_boxed_walther_p22-wp22mag", 60)
    group:group("regional_boxed_ruger_lcr_22", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_everyday_carry-restricted17", kind = "distribution" }
    group:entry {
        item = "glock_17",
        contents = {
            { item = "glock17_17" },
        },
    }
    group:entry {
        item = "glock_19",
        contents = {
            { item = "glockmag" },
        },
        probability = 110,
    }
    group:entry {
        item = "m9",
        contents = {
            { item = "m9mag" },
        },
        probability = 55,
    }
    group:entry {
        item = "m1911",
        contents = {
            { item = "m1911mag" },
        },
        probability = 60,
    }
    group:entry {
        item = "rugerlcp",
        contents = {
            { item = "rugerlcpmag" },
        },
        probability = 70,
    }
    group:item("model_10_revolver", 55)
    group:entry {
        item = "walther_p22",
        contents = {
            { item = "wp22mag" },
        },
        probability = 60,
    }
    group:item("ruger_lcr_22", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_hunting_display-restricted17", kind = "distribution" }
    group:item("glock_17")
    group:item("glock_19", 110)
    group:item("m9", 55)
    group:item("m1911", 60)
    group:item("rugerlcp", 70)
    group:item("model_10_revolver", 55)
    group:item("walther_p22", 60)
    group:item("ruger_lcr_22", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common-restricted17", kind = "distribution" }
    group:entry {
        item = "ruger_1022",
        contents = {
            { item = "ruger1022mag_15" },
        },
        probability = 125,
    }
    group:item("henry_golden_boy", 65)
    group:item("marlin_336_3030", 65)
    group:item("remington_700", 85)
    group:item("remington_700_308", 80)
    group:entry {
        item = "steyr_scout",
        contents = {
            { item = "steyr_scout_mag" },
        },
        probability = 25,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_display-restricted17", kind = "distribution" }
    group:item("ruger_1022", 125)
    group:item("henry_golden_boy", 65)
    group:item("marlin_336_3030", 65)
    group:item("remington_700", 85)
    group:item("remington_700_308", 80)
    group:item("steyr_scout", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_boxed-restricted17", kind = "distribution" }
    group:group("regional_boxed_ruger_1022-ruger1022mag_15", 125)
    group:group("regional_boxed_henry_golden_boy", 65)
    group:group("regional_boxed_marlin_336_3030", 65)
    group:group("regional_boxed_remington_700", 85)
    group:group("regional_boxed_remington_700_308", 80)
    group:group("regional_boxed_steyr_scout-steyr_scout_mag", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_worn-restricted17", kind = "distribution" }
    group:entry {
        item = "ruger_1022",
        damage = { 1, 4 },
        contents = {
            { item = "ruger1022mag_15" },
        },
        probability = 125,
    }
    group:entry { item = "henry_golden_boy", damage = { 1, 4 }, probability = 65 }
    group:entry { item = "marlin_336_3030", damage = { 1, 4 }, probability = 65 }
    group:entry { item = "remington_700", damage = { 1, 4 }, probability = 85 }
    group:entry { item = "remington_700_308", damage = { 1, 4 }, probability = 80 }
    group:entry {
        item = "steyr_scout",
        damage = { 1, 4 },
        contents = {
            { item = "steyr_scout_mag" },
        },
        probability = 25,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_hunting_display-restricted17", kind = "distribution" }
    group:item("ruger_1022", 125)
    group:item("henry_golden_boy", 65)
    group:item("marlin_336_3030", 65)
    group:item("remington_700", 85)
    group:item("remington_700_308", 80)
    group:item("steyr_scout", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_shotgun_common-restricted17", kind = "distribution" }
    group:item("mossberg_500")
    group:item("remington_870")
    group:item("mossberg_500_20", 70)
    group:item("mossberg_500_410", 35)
    group:item("ithaca37", 30)
    group:item("winchester_1897", 15)
    group:item("remington_1100", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_shotgun_common_display-restricted17", kind = "distribution" }
    group:item("mossberg_500")
    group:item("remington_870")
    group:item("mossberg_500_20", 70)
    group:item("mossberg_500_410", 35)
    group:item("ithaca37", 30)
    group:item("winchester_1897", 15)
    group:item("remington_1100", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_shotgun_common_boxed-restricted17", kind = "distribution" }
    group:group("regional_boxed_mossberg_500")
    group:group("regional_boxed_remington_870")
    group:group("regional_boxed_mossberg_500_20", 70)
    group:group("regional_boxed_mossberg_500_410", 35)
    group:group("regional_boxed_ithaca37", 30)
    group:group("regional_boxed_winchester_1897", 15)
    group:group("regional_boxed_remington_1100", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_shotgun_common_worn-restricted17", kind = "distribution" }
    group:entry { item = "mossberg_500", damage = { 1, 4 } }
    group:entry { item = "remington_870", damage = { 1, 4 } }
    group:entry { item = "mossberg_500_20", damage = { 1, 4 }, probability = 70 }
    group:entry { item = "mossberg_500_410", damage = { 1, 4 }, probability = 35 }
    group:entry { item = "ithaca37", damage = { 1, 4 }, probability = 30 }
    group:entry { item = "winchester_1897", damage = { 1, 4 }, probability = 15 }
    group:entry { item = "remington_1100", damage = { 1, 4 }, probability = 30 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-restricted15", kind = "distribution" }
    group:group("guns_pistol_common-restricted15", 90)
    group:group("guns_rifle_common-restricted15", 30)
    group:group("guns_shotgun_common-restricted15", 8)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common_boxed-restricted15", kind = "distribution" }
    group:group("guns_pistol_common_boxed-restricted15", 90)
    group:group("guns_rifle_common_boxed-restricted15", 30)
    group:group("guns_shotgun_common_boxed-restricted15", 8)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common_display-restricted15", kind = "distribution" }
    group:group("guns_pistol_common_display-restricted15", 90)
    group:group("guns_rifle_common_display-restricted15", 30)
    group:group("guns_shotgun_common_display-restricted15", 8)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common-restricted15", kind = "distribution" }
    group:entry {
        item = "glock_17",
        contents = {
            { item = "glock17_10" },
        },
    }
    group:entry {
        item = "glock_19",
        contents = {
            { item = "glockmag" },
        },
        probability = 110,
    }
    group:entry {
        item = "m9",
        contents = {
            { item = "m9mag" },
        },
        probability = 55,
    }
    group:entry {
        item = "m1911",
        contents = {
            { item = "m1911mag" },
        },
        probability = 60,
    }
    group:entry {
        item = "rugerlcp",
        contents = {
            { item = "rugerlcpmag" },
        },
        probability = 70,
    }
    group:item("model_10_revolver", 55)
    group:entry {
        item = "walther_p22",
        contents = {
            { item = "wp22mag" },
        },
        probability = 60,
    }
    group:item("ruger_lcr_22", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_display-restricted15", kind = "distribution" }
    group:item("glock_17")
    group:item("glock_19", 110)
    group:item("m9", 55)
    group:item("m1911", 60)
    group:item("rugerlcp", 70)
    group:item("model_10_revolver", 55)
    group:item("walther_p22", 60)
    group:item("ruger_lcr_22", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_boxed-restricted15", kind = "distribution" }
    group:group("regional_boxed_glock_17-glock17_10")
    group:group("regional_boxed_glock_19-glockmag", 110)
    group:group("regional_boxed_m9-m9mag", 55)
    group:group("regional_boxed_m1911-m1911mag", 60)
    group:group("regional_boxed_rugerlcp-rugerlcpmag", 70)
    group:group("regional_boxed_model_10_revolver", 55)
    group:group("regional_boxed_walther_p22-wp22mag", 60)
    group:group("regional_boxed_ruger_lcr_22", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_everyday_carry-restricted15", kind = "distribution" }
    group:entry {
        item = "glock_17",
        contents = {
            { item = "glock17_10" },
        },
    }
    group:entry {
        item = "glock_19",
        contents = {
            { item = "glockmag" },
        },
        probability = 110,
    }
    group:entry {
        item = "m9",
        contents = {
            { item = "m9mag" },
        },
        probability = 55,
    }
    group:entry {
        item = "m1911",
        contents = {
            { item = "m1911mag" },
        },
        probability = 60,
    }
    group:entry {
        item = "rugerlcp",
        contents = {
            { item = "rugerlcpmag" },
        },
        probability = 70,
    }
    group:item("model_10_revolver", 55)
    group:entry {
        item = "walther_p22",
        contents = {
            { item = "wp22mag" },
        },
        probability = 60,
    }
    group:item("ruger_lcr_22", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_hunting_display-restricted15", kind = "distribution" }
    group:item("glock_17")
    group:item("glock_19", 110)
    group:item("m9", 55)
    group:item("m1911", 60)
    group:item("rugerlcp", 70)
    group:item("model_10_revolver", 55)
    group:item("walther_p22", 60)
    group:item("ruger_lcr_22", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common-restricted15", kind = "distribution" }
    group:entry {
        item = "ruger_1022",
        contents = {
            { item = "ruger1022mag_15" },
        },
        probability = 125,
    }
    group:item("henry_golden_boy", 65)
    group:item("marlin_336_3030", 65)
    group:item("remington_700", 85)
    group:item("remington_700_308", 80)
    group:entry {
        item = "steyr_scout",
        contents = {
            { item = "steyr_scout_mag" },
        },
        probability = 25,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_display-restricted15", kind = "distribution" }
    group:item("ruger_1022", 125)
    group:item("henry_golden_boy", 65)
    group:item("marlin_336_3030", 65)
    group:item("remington_700", 85)
    group:item("remington_700_308", 80)
    group:item("steyr_scout", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_boxed-restricted15", kind = "distribution" }
    group:group("regional_boxed_ruger_1022-ruger1022mag_15", 125)
    group:group("regional_boxed_henry_golden_boy", 65)
    group:group("regional_boxed_marlin_336_3030", 65)
    group:group("regional_boxed_remington_700", 85)
    group:group("regional_boxed_remington_700_308", 80)
    group:group("regional_boxed_steyr_scout-steyr_scout_mag", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_worn-restricted15", kind = "distribution" }
    group:entry {
        item = "ruger_1022",
        damage = { 1, 4 },
        contents = {
            { item = "ruger1022mag_15" },
        },
        probability = 125,
    }
    group:entry { item = "henry_golden_boy", damage = { 1, 4 }, probability = 65 }
    group:entry { item = "marlin_336_3030", damage = { 1, 4 }, probability = 65 }
    group:entry { item = "remington_700", damage = { 1, 4 }, probability = 85 }
    group:entry { item = "remington_700_308", damage = { 1, 4 }, probability = 80 }
    group:entry {
        item = "steyr_scout",
        damage = { 1, 4 },
        contents = {
            { item = "steyr_scout_mag" },
        },
        probability = 25,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_hunting_display-restricted15", kind = "distribution" }
    group:item("ruger_1022", 125)
    group:item("henry_golden_boy", 65)
    group:item("marlin_336_3030", 65)
    group:item("remington_700", 85)
    group:item("remington_700_308", 80)
    group:item("steyr_scout", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_shotgun_common-restricted15", kind = "distribution" }
    group:item("mossberg_500")
    group:item("remington_870")
    group:item("mossberg_500_20", 70)
    group:item("mossberg_500_410", 35)
    group:item("ithaca37", 30)
    group:item("winchester_1897", 15)
    group:item("remington_1100", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_shotgun_common_display-restricted15", kind = "distribution" }
    group:item("mossberg_500")
    group:item("remington_870")
    group:item("mossberg_500_20", 70)
    group:item("mossberg_500_410", 35)
    group:item("ithaca37", 30)
    group:item("winchester_1897", 15)
    group:item("remington_1100", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_shotgun_common_boxed-restricted15", kind = "distribution" }
    group:group("regional_boxed_mossberg_500")
    group:group("regional_boxed_remington_870")
    group:group("regional_boxed_mossberg_500_20", 70)
    group:group("regional_boxed_mossberg_500_410", 35)
    group:group("regional_boxed_ithaca37", 30)
    group:group("regional_boxed_winchester_1897", 15)
    group:group("regional_boxed_remington_1100", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_shotgun_common_worn-restricted15", kind = "distribution" }
    group:entry { item = "mossberg_500", damage = { 1, 4 } }
    group:entry { item = "remington_870", damage = { 1, 4 } }
    group:entry { item = "mossberg_500_20", damage = { 1, 4 }, probability = 70 }
    group:entry { item = "mossberg_500_410", damage = { 1, 4 }, probability = 35 }
    group:entry { item = "ithaca37", damage = { 1, 4 }, probability = 30 }
    group:entry { item = "winchester_1897", damage = { 1, 4 }, probability = 15 }
    group:entry { item = "remington_1100", damage = { 1, 4 }, probability = 30 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-restricted_split", kind = "distribution" }
    group:group("guns_pistol_common-restricted_split", 90)
    group:group("guns_rifle_common-restricted_split", 30)
    group:group("guns_shotgun_common-restricted_split", 8)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common_boxed-restricted_split", kind = "distribution" }
    group:group("guns_pistol_common_boxed-restricted_split", 90)
    group:group("guns_rifle_common_boxed-restricted_split", 30)
    group:group("guns_shotgun_common_boxed-restricted_split", 8)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common_display-restricted_split", kind = "distribution" }
    group:group("guns_pistol_common_display-restricted_split", 90)
    group:group("guns_rifle_common_display-restricted_split", 30)
    group:group("guns_shotgun_common_display-restricted_split", 8)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common-restricted_split", kind = "distribution" }
    group:entry {
        item = "glock_17",
        contents = {
            { item = "glock17_10" },
        },
    }
    group:entry {
        item = "glock_19",
        contents = {
            { item = "glockmag" },
        },
        probability = 110,
    }
    group:entry {
        item = "m9",
        contents = {
            { item = "m9mag" },
        },
        probability = 55,
    }
    group:entry {
        item = "m1911",
        contents = {
            { item = "m1911mag" },
        },
        probability = 60,
    }
    group:entry {
        item = "rugerlcp",
        contents = {
            { item = "rugerlcpmag" },
        },
        probability = 70,
    }
    group:item("model_10_revolver", 55)
    group:entry {
        item = "walther_p22",
        contents = {
            { item = "wp22mag" },
        },
        probability = 60,
    }
    group:item("ruger_lcr_22", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_display-restricted_split", kind = "distribution" }
    group:item("glock_17")
    group:item("glock_19", 110)
    group:item("m9", 55)
    group:item("m1911", 60)
    group:item("rugerlcp", 70)
    group:item("model_10_revolver", 55)
    group:item("walther_p22", 60)
    group:item("ruger_lcr_22", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_boxed-restricted_split", kind = "distribution" }
    group:group("regional_boxed_glock_17-glock17_10")
    group:group("regional_boxed_glock_19-glockmag", 110)
    group:group("regional_boxed_m9-m9mag", 55)
    group:group("regional_boxed_m1911-m1911mag", 60)
    group:group("regional_boxed_rugerlcp-rugerlcpmag", 70)
    group:group("regional_boxed_model_10_revolver", 55)
    group:group("regional_boxed_walther_p22-wp22mag", 60)
    group:group("regional_boxed_ruger_lcr_22", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_everyday_carry-restricted_split", kind = "distribution" }
    group:entry {
        item = "glock_17",
        contents = {
            { item = "glock17_10" },
        },
    }
    group:entry {
        item = "glock_19",
        contents = {
            { item = "glockmag" },
        },
        probability = 110,
    }
    group:entry {
        item = "m9",
        contents = {
            { item = "m9mag" },
        },
        probability = 55,
    }
    group:entry {
        item = "m1911",
        contents = {
            { item = "m1911mag" },
        },
        probability = 60,
    }
    group:entry {
        item = "rugerlcp",
        contents = {
            { item = "rugerlcpmag" },
        },
        probability = 70,
    }
    group:item("model_10_revolver", 55)
    group:entry {
        item = "walther_p22",
        contents = {
            { item = "wp22mag" },
        },
        probability = 60,
    }
    group:item("ruger_lcr_22", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_hunting_display-restricted_split", kind = "distribution" }
    group:item("glock_17")
    group:item("glock_19", 110)
    group:item("m9", 55)
    group:item("m1911", 60)
    group:item("rugerlcp", 70)
    group:item("model_10_revolver", 55)
    group:item("walther_p22", 60)
    group:item("ruger_lcr_22", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common-restricted_split", kind = "distribution" }
    group:entry {
        item = "ruger_1022",
        contents = {
            { item = "ruger1022mag" },
        },
        probability = 125,
    }
    group:item("henry_golden_boy", 65)
    group:item("marlin_336_3030", 65)
    group:item("remington_700", 85)
    group:item("remington_700_308", 80)
    group:entry {
        item = "steyr_scout",
        contents = {
            { item = "steyr_scout_mag" },
        },
        probability = 25,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_display-restricted_split", kind = "distribution" }
    group:item("ruger_1022", 125)
    group:item("henry_golden_boy", 65)
    group:item("marlin_336_3030", 65)
    group:item("remington_700", 85)
    group:item("remington_700_308", 80)
    group:item("steyr_scout", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_boxed-restricted_split", kind = "distribution" }
    group:group("regional_boxed_ruger_1022-ruger1022mag", 125)
    group:group("regional_boxed_henry_golden_boy", 65)
    group:group("regional_boxed_marlin_336_3030", 65)
    group:group("regional_boxed_remington_700", 85)
    group:group("regional_boxed_remington_700_308", 80)
    group:group("regional_boxed_steyr_scout-steyr_scout_mag", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_worn-restricted_split", kind = "distribution" }
    group:entry {
        item = "ruger_1022",
        damage = { 1, 4 },
        contents = {
            { item = "ruger1022mag" },
        },
        probability = 125,
    }
    group:entry { item = "henry_golden_boy", damage = { 1, 4 }, probability = 65 }
    group:entry { item = "marlin_336_3030", damage = { 1, 4 }, probability = 65 }
    group:entry { item = "remington_700", damage = { 1, 4 }, probability = 85 }
    group:entry { item = "remington_700_308", damage = { 1, 4 }, probability = 80 }
    group:entry {
        item = "steyr_scout",
        damage = { 1, 4 },
        contents = {
            { item = "steyr_scout_mag" },
        },
        probability = 25,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_hunting_display-restricted_split", kind = "distribution" }
    group:item("ruger_1022", 125)
    group:item("henry_golden_boy", 65)
    group:item("marlin_336_3030", 65)
    group:item("remington_700", 85)
    group:item("remington_700_308", 80)
    group:item("steyr_scout", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_shotgun_common-restricted_split", kind = "distribution" }
    group:item("mossberg_500")
    group:item("remington_870")
    group:item("mossberg_500_20", 70)
    group:item("mossberg_500_410", 35)
    group:item("ithaca37", 30)
    group:item("winchester_1897", 15)
    group:item("remington_1100", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_shotgun_common_display-restricted_split", kind = "distribution" }
    group:item("mossberg_500")
    group:item("remington_870")
    group:item("mossberg_500_20", 70)
    group:item("mossberg_500_410", 35)
    group:item("ithaca37", 30)
    group:item("winchester_1897", 15)
    group:item("remington_1100", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_shotgun_common_boxed-restricted_split", kind = "distribution" }
    group:group("regional_boxed_mossberg_500")
    group:group("regional_boxed_remington_870")
    group:group("regional_boxed_mossberg_500_20", 70)
    group:group("regional_boxed_mossberg_500_410", 35)
    group:group("regional_boxed_ithaca37", 30)
    group:group("regional_boxed_winchester_1897", 15)
    group:group("regional_boxed_remington_1100", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_shotgun_common_worn-restricted_split", kind = "distribution" }
    group:entry { item = "mossberg_500", damage = { 1, 4 } }
    group:entry { item = "remington_870", damage = { 1, 4 } }
    group:entry { item = "mossberg_500_20", damage = { 1, 4 }, probability = 70 }
    group:entry { item = "mossberg_500_410", damage = { 1, 4 }, probability = 35 }
    group:entry { item = "ithaca37", damage = { 1, 4 }, probability = 30 }
    group:entry { item = "winchester_1897", damage = { 1, 4 }, probability = 15 }
    group:entry { item = "remington_1100", damage = { 1, 4 }, probability = 30 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-hawaii", kind = "distribution" }
    group:group("guns_pistol_common-hawaii", 90)
    group:group("guns_rifle_common-hawaii", 30)
    group:group("guns_shotgun_common-hawaii", 8)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common_boxed-hawaii", kind = "distribution" }
    group:group("guns_pistol_common_boxed-hawaii", 90)
    group:group("guns_rifle_common_boxed-hawaii", 30)
    group:group("guns_shotgun_common_boxed-hawaii", 8)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common_display-hawaii", kind = "distribution" }
    group:group("guns_pistol_common_display-hawaii", 90)
    group:group("guns_rifle_common_display-hawaii", 30)
    group:group("guns_shotgun_common_display-hawaii", 8)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common-hawaii", kind = "distribution" }
    group:entry {
        item = "glock_17",
        contents = {
            { item = "glock17_10" },
        },
    }
    group:entry {
        item = "glock_19",
        contents = {
            { item = "glockmag_10" },
        },
        probability = 110,
    }
    group:entry {
        item = "m9",
        contents = {
            { item = "m9mag_10rd" },
        },
        probability = 55,
    }
    group:entry {
        item = "m1911",
        contents = {
            { item = "m1911mag" },
        },
        probability = 60,
    }
    group:entry {
        item = "rugerlcp",
        contents = {
            { item = "rugerlcpmag" },
        },
        probability = 70,
    }
    group:item("model_10_revolver", 55)
    group:entry {
        item = "walther_p22",
        contents = {
            { item = "wp22mag" },
        },
        probability = 60,
    }
    group:item("ruger_lcr_22", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_display-hawaii", kind = "distribution" }
    group:item("glock_17")
    group:item("glock_19", 110)
    group:item("m9", 55)
    group:item("m1911", 60)
    group:item("rugerlcp", 70)
    group:item("model_10_revolver", 55)
    group:item("walther_p22", 60)
    group:item("ruger_lcr_22", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_boxed-hawaii", kind = "distribution" }
    group:group("regional_boxed_glock_17-glock17_10")
    group:group("regional_boxed_glock_19-glockmag_10", 110)
    group:group("regional_boxed_m9-m9mag_10rd", 55)
    group:group("regional_boxed_m1911-m1911mag", 60)
    group:group("regional_boxed_rugerlcp-rugerlcpmag", 70)
    group:group("regional_boxed_model_10_revolver", 55)
    group:group("regional_boxed_walther_p22-wp22mag", 60)
    group:group("regional_boxed_ruger_lcr_22", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_everyday_carry-hawaii", kind = "distribution" }
    group:entry {
        item = "glock_17",
        contents = {
            { item = "glock17_10" },
        },
    }
    group:entry {
        item = "glock_19",
        contents = {
            { item = "glockmag_10" },
        },
        probability = 110,
    }
    group:entry {
        item = "m9",
        contents = {
            { item = "m9mag_10rd" },
        },
        probability = 55,
    }
    group:entry {
        item = "m1911",
        contents = {
            { item = "m1911mag" },
        },
        probability = 60,
    }
    group:entry {
        item = "rugerlcp",
        contents = {
            { item = "rugerlcpmag" },
        },
        probability = 70,
    }
    group:item("model_10_revolver", 55)
    group:entry {
        item = "walther_p22",
        contents = {
            { item = "wp22mag" },
        },
        probability = 60,
    }
    group:item("ruger_lcr_22", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_hunting_display-hawaii", kind = "distribution" }
    group:item("glock_17")
    group:item("glock_19", 110)
    group:item("m9", 55)
    group:item("m1911", 60)
    group:item("rugerlcp", 70)
    group:item("model_10_revolver", 55)
    group:item("walther_p22", 60)
    group:item("ruger_lcr_22", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common-hawaii", kind = "distribution" }
    group:entry {
        item = "ruger_1022",
        contents = {
            { item = "ruger1022bigmag" },
        },
        probability = 125,
    }
    group:item("henry_golden_boy", 65)
    group:item("marlin_336_3030", 65)
    group:item("remington_700", 85)
    group:item("remington_700_308", 80)
    group:entry {
        item = "steyr_scout",
        contents = {
            { item = "steyr_scout_mag" },
        },
        probability = 25,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_display-hawaii", kind = "distribution" }
    group:item("ruger_1022", 125)
    group:item("henry_golden_boy", 65)
    group:item("marlin_336_3030", 65)
    group:item("remington_700", 85)
    group:item("remington_700_308", 80)
    group:item("steyr_scout", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_boxed-hawaii", kind = "distribution" }
    group:group("regional_boxed_ruger_1022-ruger1022bigmag", 125)
    group:group("regional_boxed_henry_golden_boy", 65)
    group:group("regional_boxed_marlin_336_3030", 65)
    group:group("regional_boxed_remington_700", 85)
    group:group("regional_boxed_remington_700_308", 80)
    group:group("regional_boxed_steyr_scout-steyr_scout_mag", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_worn-hawaii", kind = "distribution" }
    group:entry {
        item = "ruger_1022",
        damage = { 1, 4 },
        contents = {
            { item = "ruger1022bigmag" },
        },
        probability = 125,
    }
    group:entry { item = "henry_golden_boy", damage = { 1, 4 }, probability = 65 }
    group:entry { item = "marlin_336_3030", damage = { 1, 4 }, probability = 65 }
    group:entry { item = "remington_700", damage = { 1, 4 }, probability = 85 }
    group:entry { item = "remington_700_308", damage = { 1, 4 }, probability = 80 }
    group:entry {
        item = "steyr_scout",
        damage = { 1, 4 },
        contents = {
            { item = "steyr_scout_mag" },
        },
        probability = 25,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_hunting_display-hawaii", kind = "distribution" }
    group:item("ruger_1022", 125)
    group:item("henry_golden_boy", 65)
    group:item("marlin_336_3030", 65)
    group:item("remington_700", 85)
    group:item("remington_700_308", 80)
    group:item("steyr_scout", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_shotgun_common-hawaii", kind = "distribution" }
    group:item("mossberg_500")
    group:item("remington_870")
    group:item("mossberg_500_20", 70)
    group:item("mossberg_500_410", 35)
    group:item("ithaca37", 30)
    group:item("winchester_1897", 15)
    group:item("remington_1100", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_shotgun_common_display-hawaii", kind = "distribution" }
    group:item("mossberg_500")
    group:item("remington_870")
    group:item("mossberg_500_20", 70)
    group:item("mossberg_500_410", 35)
    group:item("ithaca37", 30)
    group:item("winchester_1897", 15)
    group:item("remington_1100", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_shotgun_common_boxed-hawaii", kind = "distribution" }
    group:group("regional_boxed_mossberg_500")
    group:group("regional_boxed_remington_870")
    group:group("regional_boxed_mossberg_500_20", 70)
    group:group("regional_boxed_mossberg_500_410", 35)
    group:group("regional_boxed_ithaca37", 30)
    group:group("regional_boxed_winchester_1897", 15)
    group:group("regional_boxed_remington_1100", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_shotgun_common_worn-hawaii", kind = "distribution" }
    group:entry { item = "mossberg_500", damage = { 1, 4 } }
    group:entry { item = "remington_870", damage = { 1, 4 } }
    group:entry { item = "mossberg_500_20", damage = { 1, 4 }, probability = 70 }
    group:entry { item = "mossberg_500_410", damage = { 1, 4 }, probability = 35 }
    group:entry { item = "ithaca37", damage = { 1, 4 }, probability = 30 }
    group:entry { item = "winchester_1897", damage = { 1, 4 }, probability = 15 }
    group:entry { item = "remington_1100", damage = { 1, 4 }, probability = 30 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-canada", kind = "distribution" }
    group:group("guns_rifle_common-canada", 30)
    group:group("guns_shotgun_common-canada", 8)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common_boxed-canada", kind = "distribution" }
    group:group("guns_rifle_common_boxed-canada", 30)
    group:group("guns_shotgun_common_boxed-canada", 8)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common_display-canada", kind = "distribution" }
    group:group("guns_rifle_common_display-canada", 30)
    group:group("guns_shotgun_common_display-canada", 8)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common-canada", kind = "distribution" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_display-canada", kind = "distribution" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_boxed-canada", kind = "distribution" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_everyday_carry-canada", kind = "distribution" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_hunting_display-canada", kind = "distribution" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common-canada", kind = "distribution" }
    group:entry {
        item = "ruger_1022",
        contents = {
            { item = "ruger1022mag" },
        },
        probability = 125,
    }
    group:item("henry_golden_boy", 65)
    group:item("marlin_336_3030", 65)
    group:item("remington_700", 85)
    group:item("remington_700_308", 80)
    group:entry {
        item = "steyr_scout",
        contents = {
            { item = "steyr_scout_mag" },
        },
        probability = 25,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_display-canada", kind = "distribution" }
    group:item("ruger_1022", 125)
    group:item("henry_golden_boy", 65)
    group:item("marlin_336_3030", 65)
    group:item("remington_700", 85)
    group:item("remington_700_308", 80)
    group:item("steyr_scout", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_boxed-canada", kind = "distribution" }
    group:group("regional_boxed_ruger_1022-ruger1022mag", 125)
    group:group("regional_boxed_henry_golden_boy", 65)
    group:group("regional_boxed_marlin_336_3030", 65)
    group:group("regional_boxed_remington_700", 85)
    group:group("regional_boxed_remington_700_308", 80)
    group:group("regional_boxed_steyr_scout-steyr_scout_mag", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_worn-canada", kind = "distribution" }
    group:entry {
        item = "ruger_1022",
        damage = { 1, 4 },
        contents = {
            { item = "ruger1022mag" },
        },
        probability = 125,
    }
    group:entry { item = "henry_golden_boy", damage = { 1, 4 }, probability = 65 }
    group:entry { item = "marlin_336_3030", damage = { 1, 4 }, probability = 65 }
    group:entry { item = "remington_700", damage = { 1, 4 }, probability = 85 }
    group:entry { item = "remington_700_308", damage = { 1, 4 }, probability = 80 }
    group:entry {
        item = "steyr_scout",
        damage = { 1, 4 },
        contents = {
            { item = "steyr_scout_mag" },
        },
        probability = 25,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_hunting_display-canada", kind = "distribution" }
    group:item("ruger_1022", 125)
    group:item("henry_golden_boy", 65)
    group:item("marlin_336_3030", 65)
    group:item("remington_700", 85)
    group:item("remington_700_308", 80)
    group:item("steyr_scout", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_shotgun_common-canada", kind = "distribution" }
    group:item("mossberg_500")
    group:item("remington_870")
    group:item("mossberg_500_20", 70)
    group:item("mossberg_500_410", 35)
    group:item("ithaca37", 30)
    group:item("winchester_1897", 15)
    group:item("remington_1100", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_shotgun_common_display-canada", kind = "distribution" }
    group:item("mossberg_500")
    group:item("remington_870")
    group:item("mossberg_500_20", 70)
    group:item("mossberg_500_410", 35)
    group:item("ithaca37", 30)
    group:item("winchester_1897", 15)
    group:item("remington_1100", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_shotgun_common_boxed-canada", kind = "distribution" }
    group:group("regional_boxed_mossberg_500")
    group:group("regional_boxed_remington_870")
    group:group("regional_boxed_mossberg_500_20", 70)
    group:group("regional_boxed_mossberg_500_410", 35)
    group:group("regional_boxed_ithaca37", 30)
    group:group("regional_boxed_winchester_1897", 15)
    group:group("regional_boxed_remington_1100", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_shotgun_common_worn-canada", kind = "distribution" }
    group:entry { item = "mossberg_500", damage = { 1, 4 } }
    group:entry { item = "remington_870", damage = { 1, 4 } }
    group:entry { item = "mossberg_500_20", damage = { 1, 4 }, probability = 70 }
    group:entry { item = "mossberg_500_410", damage = { 1, 4 }, probability = 35 }
    group:entry { item = "ithaca37", damage = { 1, 4 }, probability = 30 }
    group:entry { item = "winchester_1897", damage = { 1, 4 }, probability = 15 }
    group:entry { item = "remington_1100", damage = { 1, 4 }, probability = 30 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-mexico", kind = "distribution" }
    group:group("guns_pistol_common-mexico", 90)
    group:group("guns_rifle_common-mexico", 30)
    group:group("guns_shotgun_common-mexico", 8)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common_boxed-mexico", kind = "distribution" }
    group:group("guns_pistol_common_boxed-mexico", 90)
    group:group("guns_rifle_common_boxed-mexico", 30)
    group:group("guns_shotgun_common_boxed-mexico", 8)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common_display-mexico", kind = "distribution" }
    group:group("guns_pistol_common_display-mexico", 90)
    group:group("guns_rifle_common_display-mexico", 30)
    group:group("guns_shotgun_common_display-mexico", 8)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common-mexico", kind = "distribution" }
    group:entry {
        item = "rugerlcp",
        contents = {
            { item = "rugerlcpmag" },
        },
        probability = 70,
    }
    group:item("model_10_revolver", 55)
    group:entry {
        item = "walther_p22",
        contents = {
            { item = "wp22mag" },
        },
        probability = 60,
    }
    group:item("ruger_lcr_22", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_display-mexico", kind = "distribution" }
    group:item("rugerlcp", 70)
    group:item("model_10_revolver", 55)
    group:item("walther_p22", 60)
    group:item("ruger_lcr_22", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_boxed-mexico", kind = "distribution" }
    group:group("regional_boxed_rugerlcp-rugerlcpmag", 70)
    group:group("regional_boxed_model_10_revolver", 55)
    group:group("regional_boxed_walther_p22-wp22mag", 60)
    group:group("regional_boxed_ruger_lcr_22", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_everyday_carry-mexico", kind = "distribution" }
    group:entry {
        item = "rugerlcp",
        contents = {
            { item = "rugerlcpmag" },
        },
        probability = 70,
    }
    group:item("model_10_revolver", 55)
    group:entry {
        item = "walther_p22",
        contents = {
            { item = "wp22mag" },
        },
        probability = 60,
    }
    group:item("ruger_lcr_22", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_hunting_display-mexico", kind = "distribution" }
    group:item("rugerlcp", 70)
    group:item("model_10_revolver", 55)
    group:item("walther_p22", 60)
    group:item("ruger_lcr_22", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common-mexico", kind = "distribution" }
    group:entry {
        item = "ruger_1022",
        contents = {
            { item = "ruger1022bigmag" },
        },
        probability = 125,
    }
    group:item("henry_golden_boy", 65)
    group:item("marlin_336_3030", 65)
    group:item("remington_700", 85)
    group:item("remington_700_308", 80)
    group:entry {
        item = "steyr_scout",
        contents = {
            { item = "steyr_scout_mag" },
        },
        probability = 25,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_display-mexico", kind = "distribution" }
    group:item("ruger_1022", 125)
    group:item("henry_golden_boy", 65)
    group:item("marlin_336_3030", 65)
    group:item("remington_700", 85)
    group:item("remington_700_308", 80)
    group:item("steyr_scout", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_boxed-mexico", kind = "distribution" }
    group:group("regional_boxed_ruger_1022-ruger1022bigmag", 125)
    group:group("regional_boxed_henry_golden_boy", 65)
    group:group("regional_boxed_marlin_336_3030", 65)
    group:group("regional_boxed_remington_700", 85)
    group:group("regional_boxed_remington_700_308", 80)
    group:group("regional_boxed_steyr_scout-steyr_scout_mag", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_worn-mexico", kind = "distribution" }
    group:entry {
        item = "ruger_1022",
        damage = { 1, 4 },
        contents = {
            { item = "ruger1022bigmag" },
        },
        probability = 125,
    }
    group:entry { item = "henry_golden_boy", damage = { 1, 4 }, probability = 65 }
    group:entry { item = "marlin_336_3030", damage = { 1, 4 }, probability = 65 }
    group:entry { item = "remington_700", damage = { 1, 4 }, probability = 85 }
    group:entry { item = "remington_700_308", damage = { 1, 4 }, probability = 80 }
    group:entry {
        item = "steyr_scout",
        damage = { 1, 4 },
        contents = {
            { item = "steyr_scout_mag" },
        },
        probability = 25,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_hunting_display-mexico", kind = "distribution" }
    group:item("ruger_1022", 125)
    group:item("henry_golden_boy", 65)
    group:item("marlin_336_3030", 65)
    group:item("remington_700", 85)
    group:item("remington_700_308", 80)
    group:item("steyr_scout", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_shotgun_common-mexico", kind = "distribution" }
    group:item("mossberg_500")
    group:item("remington_870")
    group:item("mossberg_500_20", 70)
    group:item("ithaca37", 30)
    group:item("remington_1100", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_shotgun_common_display-mexico", kind = "distribution" }
    group:item("mossberg_500")
    group:item("remington_870")
    group:item("mossberg_500_20", 70)
    group:item("ithaca37", 30)
    group:item("remington_1100", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_shotgun_common_boxed-mexico", kind = "distribution" }
    group:group("regional_boxed_mossberg_500")
    group:group("regional_boxed_remington_870")
    group:group("regional_boxed_mossberg_500_20", 70)
    group:group("regional_boxed_ithaca37", 30)
    group:group("regional_boxed_remington_1100", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_shotgun_common_worn-mexico", kind = "distribution" }
    group:entry { item = "mossberg_500", damage = { 1, 4 } }
    group:entry { item = "remington_870", damage = { 1, 4 } }
    group:entry { item = "mossberg_500_20", damage = { 1, 4 }, probability = 70 }
    group:entry { item = "ithaca37", damage = { 1, 4 }, probability = 30 }
    group:entry { item = "remington_1100", damage = { 1, 4 }, probability = 30 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-CA-AB", kind = "distribution" }
    group:group("guns_common-canada")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-CA-BC", kind = "distribution" }
    group:group("guns_common-canada")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-CA-MB", kind = "distribution" }
    group:group("guns_common-canada")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-CA-NB", kind = "distribution" }
    group:group("guns_common-canada")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-CA-NL", kind = "distribution" }
    group:group("guns_common-canada")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-CA-NS", kind = "distribution" }
    group:group("guns_common-canada")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-CA-NT", kind = "distribution" }
    group:group("guns_common-canada")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-CA-NU", kind = "distribution" }
    group:group("guns_common-canada")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-CA-ON", kind = "distribution" }
    group:group("guns_common-canada")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-CA-PE", kind = "distribution" }
    group:group("guns_common-canada")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-CA-QC", kind = "distribution" }
    group:group("guns_common-canada")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-CA-SK", kind = "distribution" }
    group:group("guns_common-canada")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-CA-YT", kind = "distribution" }
    group:group("guns_common-canada")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-MX-AGU", kind = "distribution" }
    group:group("guns_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-MX-BCN", kind = "distribution" }
    group:group("guns_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-MX-BCS", kind = "distribution" }
    group:group("guns_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-MX-CAM", kind = "distribution" }
    group:group("guns_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-MX-CHH", kind = "distribution" }
    group:group("guns_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-MX-CHP", kind = "distribution" }
    group:group("guns_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-MX-CMX", kind = "distribution" }
    group:group("guns_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-MX-COA", kind = "distribution" }
    group:group("guns_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-MX-COL", kind = "distribution" }
    group:group("guns_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-MX-DUR", kind = "distribution" }
    group:group("guns_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-MX-GRO", kind = "distribution" }
    group:group("guns_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-MX-GUA", kind = "distribution" }
    group:group("guns_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-MX-HID", kind = "distribution" }
    group:group("guns_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-MX-JAL", kind = "distribution" }
    group:group("guns_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-MX-MEX", kind = "distribution" }
    group:group("guns_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-MX-MIC", kind = "distribution" }
    group:group("guns_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-MX-MOR", kind = "distribution" }
    group:group("guns_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-MX-NAY", kind = "distribution" }
    group:group("guns_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-MX-NLE", kind = "distribution" }
    group:group("guns_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-MX-OAX", kind = "distribution" }
    group:group("guns_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-MX-PUE", kind = "distribution" }
    group:group("guns_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-MX-QUE", kind = "distribution" }
    group:group("guns_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-MX-ROO", kind = "distribution" }
    group:group("guns_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-MX-SIN", kind = "distribution" }
    group:group("guns_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-MX-SLP", kind = "distribution" }
    group:group("guns_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-MX-SON", kind = "distribution" }
    group:group("guns_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-MX-TAB", kind = "distribution" }
    group:group("guns_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-MX-TAM", kind = "distribution" }
    group:group("guns_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-MX-TLA", kind = "distribution" }
    group:group("guns_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-MX-VER", kind = "distribution" }
    group:group("guns_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-MX-YUC", kind = "distribution" }
    group:group("guns_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-MX-ZAC", kind = "distribution" }
    group:group("guns_common-mexico")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-AK", kind = "distribution" }
    group:group("guns_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-AL", kind = "distribution" }
    group:group("guns_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-AR", kind = "distribution" }
    group:group("guns_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-AZ", kind = "distribution" }
    group:group("guns_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-CA", kind = "distribution" }
    group:group("guns_common-restricted10")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-CO", kind = "distribution" }
    group:group("guns_common-restricted15")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-CT", kind = "distribution" }
    group:group("guns_common-restricted10")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-DC", kind = "distribution" }
    group:group("guns_common-restricted10")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-DE", kind = "distribution" }
    group:group("guns_common-restricted17")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-FL", kind = "distribution" }
    group:group("guns_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-GA", kind = "distribution" }
    group:group("guns_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-HI", kind = "distribution" }
    group:group("guns_common-hawaii")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-IA", kind = "distribution" }
    group:group("guns_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-ID", kind = "distribution" }
    group:group("guns_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-IL", kind = "distribution" }
    group:group("guns_common-restricted_split")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-IN", kind = "distribution" }
    group:group("guns_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-KS", kind = "distribution" }
    group:group("guns_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-KY", kind = "distribution" }
    group:group("guns_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-LA", kind = "distribution" }
    group:group("guns_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-MD", kind = "distribution" }
    group:group("guns_common-restricted10")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-ME", kind = "distribution" }
    group:group("guns_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-MI", kind = "distribution" }
    group:group("guns_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-MN", kind = "distribution" }
    group:group("guns_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-MO", kind = "distribution" }
    group:group("guns_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-MS", kind = "distribution" }
    group:group("guns_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-MT", kind = "distribution" }
    group:group("guns_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-NC", kind = "distribution" }
    group:group("guns_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-ND", kind = "distribution" }
    group:group("guns_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-NE", kind = "distribution" }
    group:group("guns_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-NH", kind = "distribution" }
    group:group("guns_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-NJ", kind = "distribution" }
    group:group("guns_common-restricted10")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-NM", kind = "distribution" }
    group:group("guns_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-NV", kind = "distribution" }
    group:group("guns_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-NY", kind = "distribution" }
    group:group("guns_common-restricted10")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-OH", kind = "distribution" }
    group:group("guns_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-OK", kind = "distribution" }
    group:group("guns_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-OR", kind = "distribution" }
    group:group("guns_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-PA", kind = "distribution" }
    group:group("guns_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-RI", kind = "distribution" }
    group:group("guns_common-restricted10")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-SC", kind = "distribution" }
    group:group("guns_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-SD", kind = "distribution" }
    group:group("guns_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-TN", kind = "distribution" }
    group:group("guns_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-TX", kind = "distribution" }
    group:group("guns_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-UT", kind = "distribution" }
    group:group("guns_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-VA", kind = "distribution" }
    group:group("guns_common-restricted15")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-VT", kind = "distribution" }
    group:group("guns_common-split")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-WA", kind = "distribution" }
    group:group("guns_common-restricted10")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-WI", kind = "distribution" }
    group:group("guns_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-WV", kind = "distribution" }
    group:group("guns_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "guns_common-US-WY", kind = "distribution" }
    group:group("guns_common-open")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_original_guns_rifle_common_worn", kind = "distribution" }
    group:entry { group = "guns_rifle_common_display", charges = { 1, 30 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "regional_original_guns_shotgun_common_worn", kind = "distribution" }
    group:entry { group = "guns_shotgun_common_display", charges = { 1, 8 } }
    content.add(group)
end
