local content = require("ccb").content

do
    -- This group is for matched power armor sets and combat armor for end game reward locations.
    local group = content.ItemGroup { id = "power_armor_sets", kind = "collection" }
    group:entry {
        distribution = {
            {
                collection = {
                    { item = "combat_exoskeleton_heavy" },
                    { item = "combat_exoskeleton_armor_head_heavy" },
                    { item = "combat_exoskeleton_armor_torso_heavy" },
                    { item = "combat_exoskeleton_armor_arm_heavy" },
                    { item = "combat_exoskeleton_armor_leg_heavy" },
                },
                probability = 30,
            },
            {
                collection = {
                    { item = "combat_exoskeleton_medium" },
                    { item = "combat_exoskeleton_armor_head_medium" },
                    { item = "combat_exoskeleton_armor_torso_medium" },
                    { item = "combat_exoskeleton_armor_arm_medium" },
                    { item = "combat_exoskeleton_armor_leg_medium" },
                },
                probability = 10,
            },
            {
                collection = {
                    { item = "combat_exoskeleton_light" },
                    { item = "combat_exoskeleton_armor_head_light" },
                    { item = "combat_exoskeleton_armor_torso_light" },
                    { item = "combat_exoskeleton_armor_arm_light" },
                    { item = "combat_exoskeleton_armor_leg_light" },
                },
                probability = 55,
            },
            {
                collection = {
                    { item = "rm13_armor" },
                    { item = "rm13_battery", charges = { 5000, 5000 } },
                },
                probability = 5,
            },
        },
    }
    content.add(group)
end

do
    -- This group is for UPS spawns.
    local group = content.ItemGroup { id = "UPS_power", kind = "distribution" }
    group:item("UPS_OFF", 70)
    group:item("heavy_battery_cell", 70)
    group:item("heavy_plus_battery_cell", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "SUS_hk_g80", kind = "collection" }
    group:item("hk_g80")
    group:entry { item = "hk_g80mag", count = { 1, 3 } }
    content.add(group)
end

do
    -- This group is for rare spawns of rivetech matched sets.
    local group = content.ItemGroup { id = "SUS_rivtech_8x40", kind = "collection" }
    group:entry {
        distribution = {
            { item = "8mm_caseless", count = { 1, 3 }, probability = 40 },
            { item = "8mm_jhp", count = { 1, 3 }, probability = 30 },
        },
    }
    group:group("SUS_rivtech_8x40_mag")
    group:group("SUS_rivtech_8x40_rm")
    content.add(group)
end

do
    -- This group is for rare spawns of rivetech matched sets.
    local group = content.ItemGroup { id = "SUS_rivtech_40mm", kind = "collection" }
    group:group("SUS_rivtech_40mm_rm")
    group:entry {
        distribution = {
            { item = "40x46mm_m1006", count = { 1, 3 }, probability = 50 },
            { item = "40x46mm_m433", count = { 1, 3 }, probability = 50 },
            { item = "40x46mm_m576", count = { 1, 3 }, probability = 50 },
            { item = "40x46mm_m651", count = { 1, 3 }, probability = 50 },
        },
    }
    content.add(group)
end

do
    -- This group is for rare spawns of rivetech matched sets.
    local group = content.ItemGroup { id = "SUS_rivtech_misc", kind = "distribution" }
    group:item("recipe_caseless", 50)
    group:entry {
        collection = {
            { item = "rx12_injector" },
            { item = "ampoule", count = { 1, 3 }, probability = 60 },
        },
        probability = 60,
    }
    group:entry {
        collection = {
            { item = "rx11_stimpack" },
            { item = "stimpack_ammo", count = { 1, 3 }, probability = 60 },
        },
        probability = 60,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "combat_exoskeleton_light_damaged", kind = "collection" }
    group:entry { item = "combat_exoskeleton_light", damage = { 0, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "combat_exoskeleton_medium_damaged", kind = "collection" }
    group:entry { item = "combat_exoskeleton_medium", damage = { 0, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "combat_exoskeleton_heavy_damaged", kind = "collection" }
    group:entry { item = "combat_exoskeleton_heavy", damage = { 0, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "combat_exoskeleton_armor_set_damaged", kind = "distribution" }
    group:entry { group = "combat_exoskeleton_armor_set_light", damage = { 0, 3 } }
    group:entry { group = "combat_exoskeleton_armor_set_medium", damage = { 0, 3 } }
    group:entry { group = "combat_exoskeleton_armor_set_heavy", damage = { 0, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "combat_exoskeleton_armor_set_light", kind = "collection" }
    group:item("combat_exoskeleton_armor_head_light")
    group:item("combat_exoskeleton_armor_torso_light")
    group:item("combat_exoskeleton_armor_arm_light")
    group:item("combat_exoskeleton_armor_leg_light")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "combat_exoskeleton_armor_set_medium", kind = "collection" }
    group:item("combat_exoskeleton_armor_head_medium")
    group:item("combat_exoskeleton_armor_torso_medium")
    group:item("combat_exoskeleton_armor_arm_medium")
    group:item("combat_exoskeleton_armor_leg_medium")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "combat_exoskeleton_armor_set_heavy", kind = "collection" }
    group:item("combat_exoskeleton_armor_head_heavy")
    group:item("combat_exoskeleton_armor_torso_heavy")
    group:item("combat_exoskeleton_armor_arm_heavy")
    group:item("combat_exoskeleton_armor_leg_heavy")
    content.add(group)
end
