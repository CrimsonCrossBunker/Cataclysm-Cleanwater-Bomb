local content = require("ccb").content

do
    local group = content.ItemGroup { id = "feral_humans_death_drops_axe", kind = "collection" }
    group:item("denarius", 5)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "feral_humans_death_drops_pipe", kind = "collection" }
    group:item("denarius", 7)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "feral_humans_death_drops_crowbar", kind = "collection" }
    group:item("denarius", 7)
    content.extend_item_group(group)
end

do
    -- items people could have carried in their pockets prior to zombification
    local group = content.ItemGroup { id = "default_zombie_items_pockets", kind = "collection" }
    group:item("denarius", 7)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "feral_goblin_death_drops", kind = "collection" }
    group:entry {
        group = "default_zombie_clothes",
        damage = { 1, 4 },
        flags = {
            "UNDERSIZE",
        },
    }
    group:entry { group = "default_zombie_items", count = { 1, 3 }, probability = 50 }
    group:group("wallets", 70)
    group:item("denarius", 5)
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "goblin_armor_drops", kind = "collection" }
    group:entry { item = "helmet_scrap_xs", damage = { 1, 4 }, probability = 40 }
    group:entry { item = "xs_legguard_scrap", damage = { 1, 4 }, probability = 40 }
    group:entry { item = "xs_boots_scrap", damage = { 1, 4 }, probability = 40 }
    group:entry { item = "xs_armguard_scrap", damage = { 1, 4 }, probability = 40 }
    group:entry { item = "xs_cuirass_scrap", damage = { 1, 4 }, probability = 40 }
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "goblin_chieftan_weapon_drops", kind = "distribution" }
    group:entry { group = "survivor_stabbing", damage = { 1, 4 }, probability = 96 }
    group:entry { item = "spear_steel_plus_one", damage = { 1, 4 }, probability = 3 }
    group:entry { item = "rune_biomancer_weapon", damage = { 1, 4 }, probability = 1 }
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "bugbear_stalker_weapon_drops", kind = "distribution" }
    group:group("survivor_stabbing", 97)
    group:item("spear_steel_plus_one", 3)
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "bugbear_armor_drops", kind = "collection" }
    group:item("xl_helmet_larmor", 20)
    group:item("xl_gauntlets_larmor", 20)
    group:item("xl_boots_larmor", 20)
    group:item("xl_armguard_larmor", 20)
    group:item("xl_legguard_larmor", 20)
    group:item("xl_armor_larmor_chest", 10)
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "orc_armor_drops", kind = "collection" }
    group:item("helmet_scrap", 20)
    group:item("armguard_scrap", 20)
    group:item("boots_scrap", 20)
    group:item("legguard_scrap", 20)
    group:item("cuirass_scrap", 10)
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "orc_archer_melee_weapon_drops", kind = "distribution" }
    group:entry {
        item = "sheath",
        contents = {
            { item = "knife_combat" },
        },
    }
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "orc_archer_ranged_weapon_drops", kind = "collection" }
    group:item("longbow", 85)
    group:entry {
        item = "quiver_large",
        contents = {
            { group = "quiver_orc_archer" },
        },
        probability = 50,
    }
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "orc_blood_warrior_weapon_drops", kind = "distribution" }
    group:item("mace_pipe_large", 96)
    group:item("mace_plus_one", 2)
    group:item("warhammer_plus_one", 2)
    content.upsert_item_group(group)
end
