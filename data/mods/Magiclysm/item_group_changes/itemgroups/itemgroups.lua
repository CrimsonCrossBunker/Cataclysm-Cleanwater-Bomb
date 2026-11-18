local content = require("ccb").content

do
    local group = content.ItemGroup { id = "fireman_gear", kind = "distribution" }
    group:item("mring_fire_protection", 1)
    content.extend_item_group(group)
end

do
    -- Goldbrew - rarity as single malt whiskey, dragonfire - rarity as vodka.
    local group = content.ItemGroup { id = "liquor_and_spirits", kind = "distribution" }
    group:item("dragonfire", 20)
    group:item("goldbrew", 2)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "homeguns", kind = "distribution" }
    group:group("enchanted_wands_disposable_combat", 5)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "lmoe_guns", kind = "distribution" }
    group:group("enchanted_wands_disposable_combat", 20)
    content.extend_item_group(group)
end

do
    -- All mana-leech shackles are inert until activated, so they won't ever be found in their active state unless worn by someone alive
    local group = content.ItemGroup { id = "prison_weapons", kind = "distribution" }
    group:group("mana_leech_shackle_and_unlock_scroll", 20)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "cop_evidence", kind = "distribution" }
    group:group("spellbook_restricted_loot_0", 4)
    group:group("spellbook_restricted_loot_1", 1)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "elecsto_pcs", kind = "distribution" }
    group:item("bio_power_storage", 1)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "elecsto_persele", kind = "distribution" }
    group:item("bio_power_storage", 5)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "elecsto_displ", kind = "distribution" }
    group:item("bio_power_storage", 10)
    content.extend_item_group(group)
end

do
    -- This way goldbrew spawns more often in places where you'd expect fancy alcohols
    local group = content.ItemGroup { id = "table_wine", kind = "distribution" }
    group:item("goldbrew", 20)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "SUS_book_nonf_soft", kind = "distribution" }
    group:item("book_nonf_magic_origin_of_species", 1)
    group:item("book_nonf_empty_social_history_no_magic", 3)
    group:item("book_nonf_history_antimagic_restraints", 1)
    group:item("messed_up_spells_lorebook", 2)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "SUS_hunting_archery", kind = "collection" }
    group:item("mbracer_archery", 1)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "milspec_arsenal_group_only_guns", kind = "distribution" }
    group:group("enchanted_wands_disposable_combat", 10)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "guns_pistol_common", kind = "distribution" }
    group:entry { item = "wand_magic_missile_minor", charges = { 12, 34 }, probability = 6 }
    group:entry { item = "wand_fireball_minor", charges = { 3, 24 }, probability = 4 }
    group:entry { item = "m47a1", charges = { 0, 6 }, probability = 4 }
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common", kind = "distribution" }
    group:entry { item = "boreal_mosin", charges = { 0, 5 }, probability = 3 }
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "guns_rifle_common_display", kind = "distribution" }
    group:entry { item = "boreal_mosin", charges = { 0, 0 }, probability = 3 }
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "mags_common", kind = "distribution" }
    group:item("borealmosin_clip", 4)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "religious_books", kind = "distribution" }
    group:item("priest_advanced", 1)
    group:item("druid_spellbook", 1)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "novels", kind = "distribution" }
    group:item("wizard_beginner", 3)
    group:item("wizard_advanced", 1)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "homebooks", kind = "distribution" }
    group:group("spellbook_tier_0", 80)
    group:item("magazine_augmentative_review", 10)
    group:group("spellbook_loot_0", 4)
    group:item("alchemy_mana_processing", 2)
    group:item("history_botanical_enchantment", 2)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "lab_bookshelves", kind = "distribution" }
    group:group("spellbook_loot_1", 3)
    group:group("spellbook_restricted_loot_1", 2)
    group:group("magic_recipe_basic", 3)
    group:group("magic_recipe_advanced", 1)
    group:group("dragon_books", 3)
    group:item("spellcraft_theory", 2)
    group:item("caster_boosts_info", 2)
    group:item("alchemy_mana_processing", 2)
    group:item("alchemy_illegal", 1)
    group:item("alchemy_master", 1)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "mansion_books", kind = "distribution" }
    group:group("spellbook_loot_0", 6)
    group:group("magic_recipe_basic", 6)
    group:group("magic_recipe_advanced", 2)
    group:group("dragon_books", 5)
    group:item("alchemy_mana_processing", 5)
    group:group("spellcraft_books", 4)
    group:group("spellbook_restricted_loot_0", 1)
    group:item("alchemy_illegal", 1)
    group:item("alchemy_master", 1)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "exotic_books", kind = "distribution" }
    group:group("spellbook_loot_1", 5)
    group:group("dragon_books", 3)
    group:group("spellcraft_books", 2)
    group:item("alchemy_illegal", 1)
    group:group("spellbook_restricted_loot_1", 1)
    group:item("alchemy_master", 1)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "esoteric_books", kind = "distribution" }
    group:group("spellbook_tier_0", 8)
    group:group("spellbook_tier_1", 2)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "book_mag_interests", kind = "distribution" }
    group:item("magazine_augmentative_review", 10)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "displays", kind = "distribution" }
    group:item("mana_potion_lesser", 50)
    group:item("magi_staff_minor", 5)
    group:item("bleed_staff_minor", 1)
    group:item("wizard_hat", 5)
    group:item("cauldron_demon_chitin", 3)
    group:item("manatouched_serum", 3)
    group:item("wolfsbane", 2)
    group:item("wolfshead_cufflinks", 3)
    group:item("magic_knife_bag", 3)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "bar_alcohol", kind = "distribution" }
    group:item("mana_potion_lesser", 20)
    group:item("manatouched_serum", 1)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "bar_fridge", kind = "distribution" }
    group:item("mana_potion_lesser", 5)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "pizza_beer", kind = "distribution" }
    group:item("mana_potion_lesser", 5)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "pizza_soda", kind = "distribution" }
    group:item("mana_potion_lesser", 3)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "coffee_display_2", kind = "distribution" }
    group:item("mana_potion_lesser", 10)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "groce_softdrink", kind = "distribution" }
    group:item("mana_potion_lesser", 15)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "army_personal_locker", kind = "distribution" }
    group:group("enchanted_worn_items", 20)
    content.extend_item_group(group)
end

do
    -- A distribution of magical items for classless themed spaces.
    local group = content.ItemGroup { id = "tools_hunting", kind = "collection" }
    group:group("enchanted_tokens_tool", 3)
    group:group("enchanted_tokens_weapon", 2)
    group:group("enchanted_arrows", 5)
    group:group("potions_common", 12)
    group:group("potions_uncommon", 6)
    group:group("potions_rare", 3)
    group:group("potions_illegal", 1)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "tools_medical", kind = "collection" }
    group:item("periapt_wound_closure", 2)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "feral_sapien_death_drops_spear", kind = "collection" }
    group:group("enchanted_combat_items", 15)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "mon_feral_prepper_death_drops", kind = "collection" }
    group:group("enchanted_combat_items", 15)
    content.extend_item_group(group)
end

do
    -- All prisoner zombies receive a shackle, as giving one to every prisoner was safer than hoping that no prisoner is able to teleport
    -- The default is that the player and NPCs prisoners managed to remove theirs before the game starts.  The player can decide to start with one if they want to add more challenge
    -- Lorewise the shackles become inert without a living wearer, so zombies won't have non-inert shackles
    local group = content.ItemGroup { id = "mon_zombie_prisoner_death_drops", kind = "collection" }
    group:item("mana_leech_shackle_unlocked")
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "mon_zombie_soldier_death_drops", kind = "collection" }
    group:group("enchanted_combat_items", 2)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "mon_zombie_heavy_soldier_death_drops", kind = "collection" }
    group:group("enchanted_combat_items", 3)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "mon_zombie_survivor_death_drops", kind = "collection" }
    group:group("enchanted_combat_items", 15)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "mon_zombie_survivor_elite_death_drops", kind = "collection" }
    group:group("enchanted_combat_items", 50)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "potions_rare", kind = "distribution" }
    group:item("flask_healing", 10)
    group:item("flask_excitement", 10)
    group:item("flask_regeneration", 10)
    group:item("flask_mana_regen", 10)
    content.add(group)
end

do
    -- a large pile of trash, made for goblin encampments.
    local group = content.ItemGroup { id = "midden_heap", kind = "collection" }
    group:group("SUS_trash_floor")
    group:group("SUS_trash_forest_manmade", 95)
    group:group("SUS_trash_floor", 80)
    group:group("SUS_trash_forest_manmade", 70)
    group:group("SUS_trash_floor", 50)
    group:group("SUS_trash_forest_manmade", 25)
    group:item("denarius", 15)
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "pawn", kind = "distribution" }
    group:group("enchanted_wands_lesser", 3)
    group:group("enchanted_rings_common", 1)
    group:item("wolfshead_cufflinks", 10)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "SUS_trash_floor_light", kind = "collection" }
    group:group("magiclysm_joke_scrolls", 1)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "SUS_trash_floor_heavy", kind = "collection" }
    group:group("magiclysm_joke_scrolls", 1)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "manuals", kind = "distribution" }
    group:group("spellbook_tier_0", 60)
    group:group("spellbook_loot_0", 3)
    group:group("dragon_books", 4)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "science", kind = "distribution" }
    group:group("magical_reagents", 18)
    content.extend_item_group(group)
end
