local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "bloodthorne_druid_summon_whip",
    name = ccb.content.text_without_extraction("Summon Heartvine Whip"),
    description = ccb.content.text_without_extraction("Needed to summon the heartwhip and wield it."),
    valid_targets = { "self" },
    flags = { "SILENT" },
    effect = "spawn_item",
    effect_data = "heartvine_whip",
    shape = "blast",
    max_level = 0,
    min_damage = 1,
    max_damage = 1,
    difficulty = 0,
    spell_class = "NONE",
    min_duration = 10000000,
    max_duration = 10000000,
}
