local content = require("ccb").content

do
    -- This group does not spawn anywhere, it exists only to set Exodii merchant prices
    local group = content.ItemGroup { id = "Exodii_XE_no_dreamdross_items", kind = "distribution" }
    group:group("dreamsmith_artifact", 1)
    group:group("dreamer_artifact", 1)
    group:group("xe_lab_dreamsmith_dreamdross", 1)
    group:group("xe_lab_dreamsmith_dream_gear", 1)
    group:group("inventor_creations", 1)
    group:group("xe_all_spells_low", 400)
    group:group("xe_all_spells_mid", 200)
    group:group("xe_all_spells_high")
    content.extend_item_group(group)
end

do
    -- This group does not spawn anywhere, it exists only to set Exodii merchant prices
    local group = content.ItemGroup { id = "Exodii_XE_no_fair_folk_items", kind = "distribution" }
    group:group("spell_spawned_goblin_fruit", 1)
    group:group("spell_spawned_goblin_fruit_ierde", 1)
    group:group("spell_spawned_goblin_fruit_arvore", 1)
    group:group("spell_spawned_goblin_fruit_homullus", 1)
    group:group("spell_spawned_goblin_fruit_salamander", 1)
    group:group("spell_spawned_goblin_fruit_sylph", 1)
    group:group("spell_spawned_goblin_fruit_undine", 1)
    group:group("spell_spawned_goblin_fruit_brownie", 1)
    group:group("spell_spawned_goblin_fruit_selkie", 1)
    group:group("spell_spawned_goblin_fruit_pooka", 1)
    group:group("spell_spawned_goblin_fruit_trow", 1)
    group:group("spell_spawned_goblin_fruit_noble", 1)
    group:item("book_moons_tears_ingot", 1)
    group:group("dead_fae_gear", 1)
    group:item("hammer_fey_smith", 15)
    content.extend_item_group(group)
end

do
    -- This group does not spawn anywhere, it exists only to set Exodii merchant prices
    local group = content.ItemGroup { id = "Exodii_XE_no_spell_items", kind = "distribution" }
    group:group("nether_sorcery_books", 1)
    group:group("xe_nether_cult_artifact", 1)
    content.extend_item_group(group)
end
