local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "summon_trapspider",
    name = ccb.content.text_without_extraction("Summon Trapdoor Spider"),
    description = ccb.content.text_without_extraction("This spell summons hostile trapdoor spiders from the earth."),
    effect = "summon",
    effect_data = "GROUP_SPIDER_TRAPDOOR",
    shape = "blast",
    valid_targets = { "ground" },
    flags = { "PERMANENT", "HOSTILE_SUMMON", "NO_EXPLOSION_SFX", "SPAWN_GROUP" },
    max_level = 15,
    min_aoe = 2,
    max_aoe = 2,
    min_damage = 1,
    max_damage = 1,
    min_range = 1,
    max_range = 1,
    min_duration = 30000,
    max_duration = 120000,
    duration_increment = 6000,
    spell_class = "NONE",
    base_casting_time = 400,
    base_energy_cost = 600,
    energy_source = "MANA",
    difficulty = 6,
}
