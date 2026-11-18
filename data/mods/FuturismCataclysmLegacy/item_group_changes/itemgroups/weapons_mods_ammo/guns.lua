local content = require("ccb").content

do
    local group = content.ItemGroup { id = "guns_pistol_milspec", kind = "distribution" }
    group:group("fcl_nested_needlepistol", 30)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "guns_smg_milspec", kind = "distribution" }
    group:group("fcl_nested_needlegun", 30)
    content.extend_item_group(group)
end

do
    -- Military specification rifles only ever found at military sites.
    -- Making the assumption any loaded gun will have additional ammo and mags with it.
    local group = content.ItemGroup { id = "guns_rifle_milspec", kind = "distribution" }
    group:group("fcl_nested_rm298", 10)
    group:group("fcl_nested_rm614_lmg", 10)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "guns_energy", kind = "distribution" }
    group:entry { item = "fcl_plasma_gun", charges = { 0, 25 }, probability = 10 }
    group:entry { item = "fcl_plasma_rifle", charges = { 0, 25 }, probability = 5 }
    group:entry {
        item = "fcl_ftk93",
        charges = { 0, 25 },
        contents = {
            { group = "fcl_fusion_pack" },
        },
        probability = 2,
    }
    group:entry {
        item = "fcl_ftk29",
        contents = {
            { group = "fcl_fusion_ftk29_mag" },
        },
        probability = 4,
    }
    group:entry {
        item = "fcl_ftk07",
        contents = {
            { group = "fcl_fusion_ftk07_mag" },
        },
        probability = 3,
    }
    content.extend_item_group(group)
end

do
    -- Factory manufactured grenade launchers (excludes improvised weapons)
    local group = content.ItemGroup { id = "guns_launcher_grenade", kind = "distribution" }
    group:entry { item = "fcl_rm802", charges = { 0, 4 }, probability = 15 }
    content.extend_item_group(group)
end
