local content = require("ccb").content

do
    -- Makeshift or otherwise poor quality SMGs.
    local group = content.ItemGroup { id = "guns_smg_improvised", kind = "distribution" }
    group:group("archery", 50)
    content.replace(group)
end

do
    -- Rifles commonly owned by citizens and found in many locations.
    -- This is for worn items so ammo should be handled elsewhere so that mods can be added directly.
    local group = content.ItemGroup { id = "guns_rifle_common_worn", kind = "distribution" }
    group:group("guns_rifle_improvised", 22)
    content.replace(group)
end

do
    -- Makeshift or otherwise poor quality rifles.
    local group = content.ItemGroup { id = "guns_rifle_improvised", kind = "distribution" }
    group:item("longrifle_flintlock", 30)
    group:item("rifle_flintlock", 30)
    group:item("carbine_flintlock", 30)
    group:item("carbine_flintlock_double", 30)
    content.replace(group)
end

do
    -- Shotguns commonly owned by citizens and found in many locations.
    local group = content.ItemGroup { id = "guns_shotgun_common", kind = "distribution" }
    group:group("guns_shotgun_improvised", 22)
    content.replace(group)
end

do
    -- Shotguns commonly owned by citizens and found in many locations.
    local group = content.ItemGroup { id = "guns_shotgun_common_worn", kind = "distribution" }
    group:group("guns_shotgun_improvised", 22)
    content.replace(group)
end

do
    -- Makeshift or otherwise poor quality shotguns.
    local group = content.ItemGroup { id = "guns_shotgun_improvised", kind = "distribution" }
    group:item("blunderbuss", 70)
    content.replace(group)
end

do
    -- Factory manufactured incendiary liquid projectors (excludes improvised weapons)
    local group = content.ItemGroup { id = "guns_launcher_flame", kind = "distribution" }
    group:group("archery", 50)
    content.replace(group)
end

do
    -- Factory manufactured rocket launchers (excludes improvised weapons)
    local group = content.ItemGroup { id = "guns_launcher_rocket", kind = "distribution" }
    group:group("archery", 50)
    content.replace(group)
end

do
    -- Factory manufactured grenade and rocket launchers (excludes improvised weapons)
    local group = content.ItemGroup { id = "guns_launcher_milspec", kind = "distribution" }
    group:group("archery", 50)
    content.replace(group)
end

do
    -- Guns of all types commonly owned by citizens and found in many locations.
    local group = content.ItemGroup { id = "guns_common", kind = "distribution" }
    group:group("guns_improvised")
    content.replace(group)
end

do
    -- Military specification guns of all types.
    local group = content.ItemGroup { id = "guns_milspec", kind = "distribution" }
    group:group("guns_improvised")
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "guns_display_pieces", kind = "distribution" }
    group:group("guns_improvised")
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "guns_collectible", kind = "distribution" }
    group:group("guns_improvised")
    content.replace(group)
end

do
    -- Makeshift or otherwise poor quality guns of all types.
    local group = content.ItemGroup { id = "guns_improvised", kind = "distribution" }
    group:group("guns_pistol_improvised", 80)
    group:group("guns_rifle_improvised")
    group:group("guns_shotgun_improvised")
    group:group("archery", 50)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "longguns_cop", kind = "distribution" }
    group:entry {
        group = "guns_rifle_improvised",
        charges = { 0, 1 },
        contents = {
            { item = "shoulder_strap" },
        },
    }
    content.replace(group)
end

do
    -- loaded in the back of a trunk or something
    local group = content.ItemGroup { id = "longguns_cop_loaded", kind = "distribution" }
    group:group("guns_rifle_improvised", 20)
    content.replace(group)
end

do
    -- gun plus potential expended magazines
    local group = content.ItemGroup { id = "longguns_cop_in_field", kind = "distribution" }
    group:entry {
        collection = {
            { group = "guns_shotgun_improvised" },
        },
        probability = 10,
    }
    content.replace(group)
end

do
    -- guns lost but still have mags
    local group = content.ItemGroup { id = "longguns_cop_in_field_no_gun", kind = "distribution" }
    group:group("archery", 50)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "sidearms_cop", kind = "distribution" }
    group:item("null", 50)
    content.replace(group)
end

do
    -- gun plus potential expended magazines
    local group = content.ItemGroup { id = "sidearms_cop_in_field", kind = "distribution" }
    group:item("null", 50)
    content.replace(group)
end

do
    -- guns lost but still have mags
    local group = content.ItemGroup { id = "sidearms_cop_in_field_no_gun", kind = "distribution" }
    group:group("archery", 50)
    content.replace(group)
end

do
    -- Guns issued to paramilitary forces in addition to standard police issue.
    local group = content.ItemGroup { id = "guns_swat", kind = "distribution" }
    group:group("guns_improvised")
    content.replace(group)
end

do
    -- Police issue weapons of all types
    local group = content.ItemGroup { id = "guns_cop", kind = "distribution" }
    group:group("guns_improvised", 20)
    content.replace(group)
end

do
    -- Guns typically carried by survivors, either improvised or thematically appropriate.
    local group = content.ItemGroup { id = "guns_survival", kind = "distribution" }
    group:group("guns_improvised", 50)
    content.replace(group)
end

do
    -- Pistols that are reasonably prolific amongst civilians, commonly owned and reliably obtainable by citizens and that are found in many locations.
    local group = content.ItemGroup { id = "guns_pistol_common", kind = "distribution" }
    group:group("guns_pistol_improvised", 35)
    content.replace(group)
end

do
    -- US military specification pistols only ever found at military sites. These weapons must be pistols that are still in current inventory, and are still being issued in some capacity to American personnel.
    -- Making the assumption any loaded gun will have additional ammo and mags with it.
    local group = content.ItemGroup { id = "guns_pistol_milspec", kind = "distribution" }
    group:group("guns_pistol_improvised", 35)
    content.replace(group)
end

do
    -- Rifles commonly owned by citizens and found in many locations.
    -- Making the assumption any loaded gun will have additional ammo and mags with it.
    local group = content.ItemGroup { id = "guns_rifle_common", kind = "distribution" }
    group:group("guns_rifle_improvised", 22)
    content.replace(group)
end

do
    -- Military specification rifles only ever found at military sites.
    -- Making the assumption any loaded gun will have additional ammo and mags with it.
    local group = content.ItemGroup { id = "guns_rifle_milspec", kind = "distribution" }
    group:group("guns_rifle_improvised", 22)
    content.replace(group)
end

do
    -- Military shotguns currently in service.
    local group = content.ItemGroup { id = "guns_shotgun_milspec", kind = "distribution" }
    group:group("guns_shotgun_improvised", 20)
    content.replace(group)
end

do
    -- Factory manufactured grenade launchers (excludes improvised weapons)
    local group = content.ItemGroup { id = "guns_launcher_grenade", kind = "distribution" }
    group:group("archery", 50)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "archery", kind = "distribution" }
    group:item("crossbow", 70)
    group:item("bullet_crossbow", 10)
    group:item("hand_crossbow", 10)
    group:item("longbow", 40)
    group:item("shortbow", 20)
    content.upsert_item_group(group)
end
