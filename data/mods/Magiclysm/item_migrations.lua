local content = require("ccb").content

-- migration_and_obsoletion/items.json
-- Remove after 0.J
content.add(content.ItemMigration {
    from = {
        "spell_scroll_baleful_polymorph",
        "spell_scroll_spirit_armor",
        "spell_scroll_holy_blade",
        "spell_scroll_cats_grace",
        "spell_scroll_eagles_sight",
        "spell_scroll_ogres_strength",
        "spell_scroll_foxs_cunning",
    },
    to = "manual_swimming",
})

-- migration_and_obsoletion/migration.json
content.add(content.ItemMigration { from = "spell_scroll_summon_zombie", to = "spell_scroll_summon_undead" })
content.add(content.ItemMigration { from = "spell_scroll_summon_skeleton", to = "spell_scroll_summon_undead" })
content.add(content.ItemMigration {
    from = "spell_scroll_summon_decayed_pouncer",
    to = "spell_scroll_summon_undead_swarm",
})
content.add(content.ItemMigration { from = "tainted_blood", to = "blood_tainted" })
content.add(content.ItemMigration { from = "sledge_plus_one", to = "hammer_sledge" })
content.add(content.ItemMigration { from = "sledge_plus_two", to = "hammer_sledge" })
content.add(content.ItemMigration { from = "sledge_heavy_plus_one", to = "hammer_sledge_heavy" })
content.add(content.ItemMigration { from = "sledge_heavy_plus_two", to = "hammer_sledge_heavy" })
content.add(content.ItemMigration { from = "bat_plus_one", to = "bat" })
content.add(content.ItemMigration { from = "bat_plus_two", to = "bat" })
content.add(content.ItemMigration { from = "bat_metal_plus_one", to = "bat_metal" })
content.add(content.ItemMigration { from = "bat_metal_plus_two", to = "bat_metal" })
content.add(content.ItemMigration { from = "fire_ax_plus_one", to = "fire_ax" })
content.add(content.ItemMigration { from = "fire_ax_plus_two", to = "fire_ax" })
content.add(content.ItemMigration { from = "pickaxe_plus_one", to = "pickaxe" })
content.add(content.ItemMigration { from = "pickaxe_plus_two", to = "pickaxe" })
content.add(content.ItemMigration { from = "crowbar_plus_one", to = "crowbar" })
content.add(content.ItemMigration { from = "crowbar_plus_two", to = "crowbar" })
content.add(content.ItemMigration { from = "knife_hunting_plus_one", to = "knife_hunting" })
content.add(content.ItemMigration { from = "knife_hunting_plus_two", to = "knife_hunting" })
content.add(content.ItemMigration { from = "jack_plus_one", to = "jack" })
content.add(content.ItemMigration { from = "jack_plus_two", to = "jack" })
content.add(content.ItemMigration { from = "scalpel_plus_one", to = "scalpel" })
content.add(content.ItemMigration { from = "scalpel_plus_two", to = "scalpel" })
content.add(content.ItemMigration { from = "knife_butcher_plus_one", to = "knife_huge" })
content.add(content.ItemMigration { from = "knife_butcher_plus_two", to = "knife_huge" })
content.add(content.ItemMigration { from = "knife_meat_cleaver_plus_one", to = "knife_huge" })
content.add(content.ItemMigration { from = "knife_meat_cleaver_plus_two", to = "knife_huge" })
content.add(content.ItemMigration { from = "knife_carving_plus_one", to = "knife_huge" })
content.add(content.ItemMigration { from = "knife_carving_plus_two", to = "knife_huge" })
content.add(content.ItemMigration { from = "butchering_kit_plus_one", to = "butchering_kit" })
content.add(content.ItemMigration { from = "butchering_kit_plus_two", to = "butchering_kit" })
