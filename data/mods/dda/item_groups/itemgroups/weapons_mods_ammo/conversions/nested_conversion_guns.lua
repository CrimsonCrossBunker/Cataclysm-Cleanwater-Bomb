local content = require("ccb").content

do
    -- An item group for a random, personally-converted weapon to spawn.
    local group = content.ItemGroup { id = "nested_converted_mdrx", kind = "collection" }
    group:entry {
        distribution = {
            { group = "nested_mdrx_retool_223rem", probability = 30 },
            { group = "nested_mdrx_retool_300blk", probability = 20 },
            { group = "nested_mdrx_retool_308win", probability = 15 },
        },
    }
    content.add(group)
end

do
    -- An item group for a random, personally-converted weapon to spawn.
    local group = content.ItemGroup { id = "nested_converted_axmc", kind = "collection" }
    group:entry {
        distribution = {
            { group = "nested_axmc_retool_300win", probability = 20 },
            { group = "nested_axmc_retool_308win", probability = 20 },
        },
    }
    content.add(group)
end

do
    -- This is a distribution for the gun, reasonable number of backup mags, and some ammo to repack.  20 inch rifle barrel.
    local group = content.ItemGroup { id = "nested_ar15_retool_223_20", kind = "collection", with_ammo = 100 }
    group:entry { group = "ar15_223long", charges = { 0, 30 } }
    group:item("stanag30")
    group:item("stanag30", 50)
    group:group("on_hand_223")
    content.add(group)
end

do
    -- This is a distribution for the gun, reasonable number of backup mags, and some ammo to repack.  16 inch rifle barrel.
    local group = content.ItemGroup { id = "nested_ar15_retool_223_16", kind = "collection", with_ammo = 100 }
    group:entry { group = "modular_ar15", charges = { 0, 30 } }
    group:item("stanag30")
    group:item("stanag30", 50)
    group:group("on_hand_223")
    content.add(group)
end

do
    -- This is a distribution for the gun, reasonable number of backup mags, and some ammo to repack.  14 inch rifle barrel, shouldn't really spawn outside of criminal/survivor locations.
    local group = content.ItemGroup { id = "nested_ar15_retool_223_14", kind = "collection", with_ammo = 100 }
    group:entry { group = "ar15_223medium", charges = { 0, 30 } }
    group:item("stanag30")
    group:item("stanag30", 50)
    group:group("on_hand_223")
    content.add(group)
end

do
    -- This is a distribution for the gun, reasonable number of backup mags, and some ammo to repack.  10 inch rifle barrel, shouldn't really spawn outside of criminal/survivor locations.
    local group = content.ItemGroup { id = "nested_ar15_retool_223_10", kind = "collection", with_ammo = 100 }
    group:entry { group = "ar15_223short", charges = { 0, 30 } }
    group:item("stanag30")
    group:item("stanag30", 50)
    group:group("on_hand_223")
    content.add(group)
end

do
    -- This is a distribution for the gun, reasonable number of backup mags, and some ammo to repack.  16 inch rifle barrel.
    local group = content.ItemGroup { id = "nested_ar15_retool_300_16", kind = "collection", with_ammo = 100 }
    group:entry { group = "ar15_300", charges = { 0, 30 } }
    group:item("stanag30")
    group:item("stanag30", 50)
    group:group("on_hand_300BLK")
    content.add(group)
end

do
    -- This is a distribution for the gun, reasonable number of backup mags, and some ammo to repack.  10 inch rifle barrel, shouldn't really spawn outside of criminal/survivor locations.
    local group = content.ItemGroup { id = "nested_ar15_retool_300_10", kind = "collection", with_ammo = 100 }
    group:entry { group = "ar15_300medium", charges = { 0, 30 } }
    group:item("stanag30")
    group:item("stanag30", 50)
    group:group("on_hand_300BLK")
    content.add(group)
end

do
    -- This is a distribution for the gun, reasonable number of backup mags, and some ammo to repack.  18 inch rifle barrel.
    local group = content.ItemGroup { id = "nested_ar15_retool_50beowulf_18", kind = "collection", with_ammo = 100 }
    group:entry { group = "ar15_50", charges = { 0, 30 } }
    group:item("50beowulf_ar15mag")
    group:item("50beowulf_ar15mag", 50)
    group:group("on_hand_50beowulf")
    content.add(group)
end

do
    -- This is a distribution for the gun, reasonable number of backup mags, and some ammo to repack.  16 inch rifle barrel.
    local group = content.ItemGroup { id = "nested_ar15_retool_50beowulf_16", kind = "collection", with_ammo = 100 }
    group:entry { group = "ar15_50medium", charges = { 0, 30 } }
    group:item("50beowulf_ar15mag")
    group:item("50beowulf_ar15mag", 50)
    group:group("on_hand_50beowulf")
    content.add(group)
end

do
    -- This is a distribution for the gun, reasonable number of backup mags, and some ammo to repack.  7 inch rifle barrel, though keep in mind it's a pistol.
    local group = content.ItemGroup { id = "nested_ar15_retool_50beowulf_7", kind = "collection", with_ammo = 100 }
    group:entry { group = "ar15_50short", charges = { 0, 30 } }
    group:item("50beowulf_ar15mag")
    group:item("50beowulf_ar15mag", 50)
    group:group("on_hand_50beowulf")
    content.add(group)
end

do
    -- This is a distribution for the gun, reasonable number of backup mags, and some ammo to repack.  18 inch rifle barrel.
    local group = content.ItemGroup { id = "nested_ar15_retool_450bushmaster_18", kind = "collection", with_ammo = 100 }
    group:entry { group = "ar15_450", charges = { 0, 30 } }
    group:item("450_ar15mag")
    group:item("450_ar15mag", 50)
    group:group("on_hand_450")
    content.add(group)
end

do
    -- This is a distribution for the gun, reasonable number of backup mags, and some ammo to repack.  10 inch rifle barrel, shouldn't really spawn outside of criminal/survivor locations.
    local group = content.ItemGroup { id = "nested_ar15_retool_450bushmaster_10", kind = "collection", with_ammo = 100 }
    group:entry { group = "ar15_450medium", charges = { 0, 30 } }
    group:item("450_ar15mag")
    group:item("450_ar15mag", 50)
    group:group("on_hand_450")
    content.add(group)
end

do
    -- This is a distribution for the gun, reasonable number of backup mags, and some ammo to repack.  7 inch rifle barrel, though keep in mind it's a pistol.
    local group = content.ItemGroup { id = "nested_ar15_retool_450bushmaster_7", kind = "collection", with_ammo = 100 }
    group:entry { group = "ar15_450short", charges = { 0, 30 } }
    group:item("450_ar15mag")
    group:item("450_ar15mag", 50)
    group:group("on_hand_450")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    -- groups together all identical weapons rechambered for the same caliber and converted with different barrel-lengths.
    local group = content.ItemGroup { id = "nested_ar15_retool_762", kind = "collection", with_ammo = 100 }
    group:entry { group = "ar15_762", charges = { 0, 30 } }
    group:item("762_ar15mag_30rd")
    group:item("762_ar15mag_30rd", 50)
    group:group("on_hand_762")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    -- groups together all identical weapons rechambered for the same caliber and converted with different barrel-lengths.
    local group = content.ItemGroup { id = "nested_ar15_retool_22", kind = "collection", with_ammo = 100 }
    group:entry { group = "ar15_22", charges = { 0, -1 } }
    group:entry {
        distribution = {
            {
                collection = {
                    { item = "22_ar15mag_10" },
                    { item = "22_ar15mag_10", probability = 50 },
                },
            },
            {
                collection = {
                    { item = "22_ar15mag_28" },
                    { item = "22_ar15mag_28", probability = 50 },
                },
            },
        },
    }
    group:group("on_hand_22")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    -- groups together all identical weapons rechambered for the same caliber and converted with different barrel-lengths.
    local group = content.ItemGroup { id = "nested_mdrx_retool_223rem", kind = "collection", with_ammo = 100 }
    group:entry {
        distribution = {
            { group = "mdrx_223", charges = { 0, 30 }, probability = 10 },
            { group = "mdrx_223short", charges = { 0, 30 }, probability = 8 },
        },
    }
    group:item("stanag30")
    group:item("stanag30", 50)
    group:group("on_hand_223")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    -- A distribution that avoids NFA items (barrels under 16 inches)
    local group = content.ItemGroup { id = "nested_mdrx_retool_223rem_civilian", kind = "collection", with_ammo = 100 }
    group:entry {
        distribution = {
            { group = "mdrx_223", charges = { 0, 30 }, probability = 4 },
            { group = "mdrx", charges = { 0, 30 }, probability = 5 },
        },
    }
    group:item("stanag30")
    group:item("stanag30", 50)
    group:group("on_hand_223")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    -- groups together all identical weapons rechambered for the same caliber and converted with different barrel-lengths.
    local group = content.ItemGroup { id = "nested_mdrx_retool_300blk", kind = "collection", with_ammo = 100 }
    group:entry { group = "mdrx_300", charges = { 0, 30 } }
    group:item("stanag30")
    group:item("stanag30", 50)
    group:group("on_hand_300BLK")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    -- groups together all identical weapons rechambered for the same caliber and converted with different barrel-lengths.
    local group = content.ItemGroup { id = "nested_mdrx_retool_308win", kind = "collection", with_ammo = 100 }
    group:entry {
        distribution = {
            { group = "mdrx_308", charges = { 0, 20 }, probability = 10 },
            { group = "mdrx_308medium", charges = { 0, 20 }, probability = 8 },
        },
    }
    group:item("ar10mag_20rd")
    group:item("ar10mag_20rd", 50)
    group:group("on_hand_308")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    -- groups together all identical weapons rechambered for the same caliber and converted with different barrel-lengths.
    local group = content.ItemGroup { id = "nested_axmc_retool_308win", kind = "collection", with_ammo = 100 }
    group:entry { group = "axmc_308", charges = { 0, 10 } }
    group:item("ai_308mag_10")
    group:item("ai_308mag_10", 50)
    group:group("on_hand_308")
    content.add(group)
end
