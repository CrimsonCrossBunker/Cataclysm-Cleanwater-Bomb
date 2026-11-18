local content = require("ccb").content

do
    -- This group does not spawn anywhere, it exists only to set Exodii merchant prices
    local group = content.ItemGroup { id = "Exodii_Magiclysm_no_spell_scrolls", kind = "distribution" }
    group:group("spellbook_loot_0", 1)
    group:group("spellbook_restricted_loot_0", 1)
    group:group("spellbook_loot_1", 1)
    group:group("spellbook_restricted_loot_1", 1)
    group:group("spellbook_loot_2", 1)
    group:group("spellbook_restricted_loot_2", 1)
    group:group("spellbook_mana_upgrades", 1)
    content.extend_item_group(group)
end
