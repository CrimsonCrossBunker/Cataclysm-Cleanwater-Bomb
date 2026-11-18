local content = require("ccb").content

do
    -- Ammo that spawns inside of boxes, with no loose ammo with it.  Meant mainly for gunstores.
    -- Weighted very weirdly as it accounts for the average round count, as some ammo like .22 LR more commonly comes in larger boxes than something like 556
    local group = content.ItemGroup { id = "ammo_common_boxed", kind = "distribution" }
    group:group("boxed_9mm", 5730)
    group:group("boxed_22lr", 1487)
    group:group("boxed_223", 969)
    group:group("boxed_45", 2282)
    group:group("boxed_380", 1428)
    group:group("boxed_40", 1338)
    group:group("boxed_762", 390)
    group:group("boxed_357", 1719)
    group:group("boxed_12", 4065)
    group:group("boxed_308", 742)
    group:group("boxed_38", 647)
    group:group("boxed_44", 993)
    group:group("boxed_3006", 378)
    group:group("boxed_45colt", 340)
    group:group("boxed_3030", 334)
    group:group("boxed_762R", 175)
    group:group("boxed_270", 167)
    group:group("boxed_20", 1000)
    group:group("boxed_410", 678)
    group:group("boxed_10mm", 31)
    group:group("boxed_300", 72)
    group:group("boxed_303", 72)
    group:group("boxed_30carbine", 31)
    group:group("boxed_32", 113)
    group:group("boxed_338", 64)
    group:group("boxed_357sig", 105)
    group:group("boxed_38super", 35)
    group:group("boxed_450", 15)
    group:group("boxed_454", 125)
    group:group("boxed_4570", 84)
    group:group("boxed_460", 137)
    group:group("boxed_500", 137)
    group:group("boxed_545", 122)
    group:group("boxed_57", 22)
    group:group("boxed_762x25", 13)
    group:group("boxed_300blk", 197)
    group:group("boxed_9x18", 77)
    group:group("boxed_50beowulf", 14)
    group:group("boxed_77x58", 11)
    group:group("boxed_50AE", 10)
    group:group("boxed_458", 5)
    content.add(group)
end

do
    -- Ammo that spawns inside of boxes, with either some extra loose ammo with it, or lacking some ammo.  Meant mainly for civilian ammo ownership, or lightly looted places.
    local group = content.ItemGroup { id = "ammo_common_boxed_used", kind = "distribution" }
    group:group("boxed_9mm_used", 5730)
    group:group("boxed_22lr_used", 1487)
    group:group("boxed_223_used", 969)
    group:group("boxed_45_used", 2282)
    group:group("boxed_380_used", 1428)
    group:group("boxed_40_used", 1338)
    group:group("boxed_762_used", 390)
    group:group("boxed_357_used", 1719)
    group:group("boxed_12_used", 4065)
    group:group("boxed_308_used", 742)
    group:group("boxed_38_used", 647)
    group:group("boxed_44_used", 993)
    group:group("boxed_3006_used", 378)
    group:group("boxed_45colt_used", 340)
    group:group("boxed_3030_used", 334)
    group:group("boxed_762R_used", 175)
    group:group("boxed_270_used", 167)
    group:group("boxed_20_used", 1000)
    group:group("boxed_410_used", 678)
    group:group("boxed_10mm_used", 31)
    group:group("boxed_300_used", 72)
    group:group("boxed_303_used", 72)
    group:group("boxed_30carbine_used", 31)
    group:group("boxed_32_used", 113)
    group:group("boxed_338_used", 64)
    group:group("boxed_357sig_used", 105)
    group:group("boxed_38super_used", 35)
    group:group("boxed_450_used", 15)
    group:group("boxed_454_used", 125)
    group:group("boxed_4570_used", 84)
    group:group("boxed_460_used", 137)
    group:group("boxed_500_used", 137)
    group:group("boxed_545_used", 122)
    group:group("boxed_57_used", 22)
    group:group("boxed_762x25_used", 13)
    group:group("boxed_300blk_used", 197)
    group:group("boxed_9x18_used", 77)
    group:group("boxed_50beowulf_used", 14)
    group:group("boxed_77x58_used", 11)
    group:group("boxed_50AE_used", 10)
    group:group("boxed_458_used", 5)
    content.add(group)
end

do
    -- Ammo that spawns inside of boxes that are very low in number. Meant for civilian ammo ownership, and looted locations.
    local group = content.ItemGroup { id = "ammo_common_boxed_looted", kind = "distribution" }
    group:group("boxed_9mm_looted", 5730)
    group:group("boxed_22lr_looted", 1487)
    group:group("boxed_223_looted", 969)
    group:group("boxed_45_looted", 2282)
    group:group("boxed_380_looted", 1428)
    group:group("boxed_40_looted", 1338)
    group:group("boxed_762_looted", 390)
    group:group("boxed_357_looted", 1719)
    group:group("boxed_12_looted", 4065)
    group:group("boxed_308_looted", 742)
    group:group("boxed_38_looted", 647)
    group:group("boxed_44_looted", 993)
    group:group("boxed_3006_looted", 378)
    group:group("boxed_45colt_looted", 340)
    group:group("boxed_3030_looted", 334)
    group:group("boxed_762R_looted", 175)
    group:group("boxed_270_looted", 167)
    group:group("boxed_20_looted", 1000)
    group:group("boxed_410_looted", 678)
    group:group("boxed_10mm_looted", 31)
    group:group("boxed_300_looted", 72)
    group:group("boxed_303_looted", 72)
    group:group("boxed_30carbine_looted", 31)
    group:group("boxed_32_looted", 113)
    group:group("boxed_338_looted", 64)
    group:group("boxed_357sig_looted", 105)
    group:group("boxed_38super_looted", 35)
    group:group("boxed_450_looted", 15)
    group:group("boxed_454_looted", 125)
    group:group("boxed_4570_looted", 84)
    group:group("boxed_460_looted", 137)
    group:group("boxed_500_looted", 137)
    group:group("boxed_545_looted", 122)
    group:group("boxed_57_looted", 22)
    group:group("boxed_762x25_looted", 13)
    group:group("boxed_300blk_looted", 197)
    group:group("boxed_9x18_looted", 77)
    group:group("boxed_50beowulf_looted", 14)
    group:group("boxed_77x58_looted", 11)
    group:group("boxed_50AE_looted", 10)
    group:group("boxed_458_looted", 5)
    content.add(group)
end

do
    -- Military specification pistol ammo found at military sites.
    local group = content.ItemGroup { id = "ammo_pistol_milspec", kind = "distribution" }
    group:item("9mmfmj")
    content.add(group)
end

do
    -- Military specification rifle ammo found at military sites.
    local group = content.ItemGroup { id = "ammo_rifle_milspec", kind = "distribution" }
    group:item("50_incendiary", 10)
    group:item("50bmg", 30)
    group:item("50match", 30)
    group:item("50ss", 10)
    group:item("50_mk211", 1)
    group:item("556_incendiary", 15)
    group:item("556_mk262", 3)
    group:item("556_mk318", 1)
    group:item("556", 79)
    group:item("556_m855a1", 2)
    group:item("556_m995", 2)
    group:item("762_51_incendiary", 10)
    group:item("762_51", 40)
    group:item("762_51_m993", 20)
    group:item("300blk", 15)
    group:item("300blk_ss", 10)
    group:item("338lapua_fmjbt", 15)
    group:item("338lapua_api", 15)
    content.add(group)
end

do
    -- Military specification shotgun ammo found at military sites.
    local group = content.ItemGroup { id = "ammo_shotgun_milspec", kind = "distribution" }
    group:group("ammo_can_shot_full", 10)
    group:group("ammo_can_slug_full", 2)
    content.add(group)
end

do
    -- Factory specification grenade launcher ammo intended for military use
    local group = content.ItemGroup { id = "ammo_launcher_grenade", kind = "distribution" }
    group:item("40x53mm_m1001", 10)
    group:item("40x46mm_m433", 120)
    group:item("40x53mm_m430a1", 75)
    group:item("40x46mm_m576", 15)
    group:item("40x46mm_m651", 20)
    content.add(group)
end

do
    -- Ammo issued to paramilitary forces in addition to standard police issue.
    local group = content.ItemGroup { id = "ammo_swat", kind = "distribution" }
    group:group("ammo_cop")
    group:entry { item = "300_winmag", charges = { 1, 10 }, probability = 5 }
    group:entry { item = "3006fmj", charges = { 1, 20 }, probability = 2 }
    group:entry { item = "40x46mm_m433", charges = { 1, 6 }, probability = 5 }
    group:entry { item = "40x46mm_m651", charges = { 1, 6 }, probability = 20 }
    group:entry { item = "556", charges = { 1, 30 }, probability = 10 }
    group:entry { item = "shot_slug", charges = { 1, 20 }, probability = 20 }
    content.add(group)
end
