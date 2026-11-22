local ccb = require("ccb")

ccb.content.define_spell {
    id = "druid_water_walking_real",
    shape = "blast",
    effect = "spawn_item",
    effect_data = "aura_druid_waterwalk",
    name = "Water Strider's Walk Real",
    description = "The actual spell that lets you walk on water.  It's a bug if you have it.",
    flags = { "CONCENTRATE", "VERBAL", "SOMATIC" },
    valid_targets = { "self" },
    min_damage = 1,
    max_damage = 1,
    min_duration = { handler = "wave14a_magiclysm_stat_24", fallback = 0 },
    max_duration = { handler = "wave14a_magiclysm_stat_25", fallback = 0 },
    difficulty = 4,
}
