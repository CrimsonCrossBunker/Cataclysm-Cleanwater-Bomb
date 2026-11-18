local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "nether_sorcery_grimoire_xe_nether_sorcery_cold_damage_over_time",
        name = ccb.content.plural_text("Grimoire: Bound in Ebon Bands", "Grimoires: Bound in Ebon Bands"),
        description = ccb.content.text("A hefty-looking tome, with an unadorned cover of dark leather.  The interior is filled with complicated instructions and some sort of formulae."),
        mass_milligrams = 1200000,
        volume_ml = 2500,
        price_cents = 3000,
        looks_like = "cookbook",
        symbol = "?",
        color = "blue",
    }
    item:material("paper", 1)
    item:clear_use_actions()
    item:teach_spells { "xe_nether_sorcery_cold_damage_over_time" }
    content.add(item)
end

do
    local item = content.Item {
        id = "nether_sorcery_grimoire_xe_nether_sorcery_summon_kreck_pack",
        name = ccb.content.plural_text("Grimoire: The Baying of Hounds", "Grimoires: The Baying of Hounds"),
        description = ccb.content.text("A hefty-looking tome, with an unadorned cover of dark leather.  The interior is filled with complicated instructions and some sort of formulae."),
        mass_milligrams = 1200000,
        volume_ml = 2500,
        price_cents = 3000,
        looks_like = "cookbook",
        symbol = "?",
        color = "blue",
    }
    item:material("paper", 1)
    item:clear_use_actions()
    item:teach_spells { "xe_nether_sorcery_summon_kreck_pack" }
    content.add(item)
end

do
    local item = content.Item {
        id = "nether_sorcery_grimoire_xe_nether_sorcery_cause_withering_damage",
        name = ccb.content.plural_text("Grimoire: The Withering", "Grimoires: The Withering"),
        description = ccb.content.text("A hefty-looking tome, with an unadorned cover of dark leather.  The interior is filled with complicated instructions and some sort of formulae."),
        mass_milligrams = 1200000,
        volume_ml = 2500,
        price_cents = 3000,
        looks_like = "cookbook",
        symbol = "?",
        color = "blue",
    }
    item:material("paper", 1)
    item:clear_use_actions()
    item:teach_spells { "xe_nether_sorcery_cause_withering_damage" }
    content.add(item)
end

do
    local item = content.Item {
        id = "nether_sorcery_grimoire_xe_nether_sorcery_wind_dodge_shell",
        name = ccb.content.plural_text("Grimoire: Shell of the Four Winds", "Grimoires: Shell of the Four Winds"),
        description = ccb.content.text("A hefty-looking tome, with an unadorned cover of dark leather.  The interior is filled with complicated instructions and some sort of formulae."),
        mass_milligrams = 1200000,
        volume_ml = 2500,
        price_cents = 3000,
        looks_like = "cookbook",
        symbol = "?",
        color = "blue",
    }
    item:material("paper", 1)
    item:clear_use_actions()
    item:teach_spells { "xe_nether_sorcery_wind_dodge_shell" }
    content.add(item)
end
