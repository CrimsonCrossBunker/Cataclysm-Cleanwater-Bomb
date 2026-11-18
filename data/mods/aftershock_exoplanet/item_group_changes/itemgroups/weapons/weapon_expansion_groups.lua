local content = require("ccb").content

do
    local group = content.ItemGroup { id = "ammo_pistol_milspec", kind = "distribution" }
    group:item("afs_5x50dart", 30)
    group:item("afs_5x50heavy", 20)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "ammo_rifle_milspec", kind = "distribution" }
    group:item("afs_7.50mm_caseless", 40)
    group:item("afs_7.50mm_rp", 50)
    content.extend_item_group(group)
end

do
    -- Military specification shotgun ammo found at military sites.
    local group = content.ItemGroup { id = "ammo_shotgun_milspec", kind = "distribution" }
    group:item("afs_25mm_shot", 10)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "ammo_casings", kind = "distribution" }
    group:item("afs_5x50_hull", 60)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "ammo_casings_milspec", kind = "distribution" }
    group:entry { item = "afs_5x50_hull", count = { 1, 30 }, probability = 10 }
    content.extend_item_group(group)
end

do
    -- This file adds Aftershock weapons to vanilla groups. To be deleted once the total conversion gets going.
    local group = content.ItemGroup { id = "guns_pistol_common", kind = "distribution" }
    group:entry { item = "afs_seyfert_84K", charges = { 0, 20 }, probability = 3 }
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common_display", kind = "distribution" }
    group:entry { item = "afs_seyfert_84K", charges = { 0, 0 }, probability = 3 }
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_milspec", kind = "distribution" }
    group:entry { item = "afs_needlepistol", charges = { 0, 50 }, probability = 30 }
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "guns_smg_milspec", kind = "distribution" }
    group:entry { item = "afs_needlegun", charges = { 0, 100 }, probability = 30 }
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common", kind = "distribution" }
    group:entry { item = "afs_gibrifle", charges = { 0, 30 }, probability = 25 }
    group:entry { item = "afs_Accipitermg", charges = { 0, 30 }, probability = 20 }
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_display", kind = "distribution" }
    group:entry { item = "afs_gibrifle", charges = { 0, 0 }, probability = 1 }
    group:entry { item = "afs_Accipitermg", charges = { 0, 0 }, probability = 1 }
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_milspec", kind = "distribution" }
    group:entry { item = "afs_gibrifle", charges = { 0, 30 }, probability = 50 }
    group:entry { item = "afs_Accipitermg", charges = { 0, 30 }, probability = 45 }
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "guns_shotgun_milspec", kind = "distribution" }
    group:entry { item = "afs_gibs_shotgun", charges = { 0, 40 }, probability = 20 }
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "mags_common", kind = "distribution" }
    group:item("afs_5x50_50_mag", 9)
    group:item("afs_5x50_100_mag", 5)
    group:item("afs_84k_20mag", 18)
    group:item("afs_UICASTA30", 28)
    group:item("afs_UICASTA100drum", 14)
    group:item("afs_25mm_mag", 12)
    content.extend_item_group(group)
end
