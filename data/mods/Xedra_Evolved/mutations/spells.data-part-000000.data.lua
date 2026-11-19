local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "spider_emergence_weak",
    name = ccb.content.text_without_extraction("Spider Emergence"),
    description = ccb.content.text_without_extraction("The incubating goblin spider larvae flee their host."),
    flags = { "HOSTILE_SUMMON", "PERMANENT", "RANDOM_DAMAGE" },
    valid_targets = { "ground", "self" },
    base_casting_time = 20,
    min_range = 1,
    max_range = 5,
    min_damage = 1,
    max_damage = 3,
    damage_type = "stab",
    min_aoe = 2,
    max_aoe = 3,
    shape = "blast",
    effect = "summon",
    effect_data = "mon_goblin_spider",
    extra_spells = { { spell = "eggsac_survivable", self = true } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "spider_emergence_strong",
    name = ccb.content.text_without_extraction("Spider Emergence"),
    description = ccb.content.text_without_extraction("The incubating goblin spider larvae flee their host."),
    flags = { "HOSTILE_SUMMON", "PERMANENT", "RANDOM_DAMAGE" },
    valid_targets = { "ground", "self" },
    base_casting_time = 20,
    min_range = 1,
    max_range = 5,
    min_damage = 5,
    max_damage = 8,
    damage_type = "stab",
    min_aoe = 2,
    max_aoe = 4,
    shape = "blast",
    effect = "summon",
    effect_data = "mon_goblin_spider",
    extra_spells = { { spell = "eggsac_fatal", self = true } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "eggsac_survivable",
    name = ccb.content.text_without_extraction("Eggsac Eruption"),
    description = ccb.content.text_without_extraction("Hurts yourself."),
    flags = { "LOUD", "RANDOM_DAMAGE", "NO_PROJECTILE" },
    min_damage = 10,
    max_damage = 20,
    damage_type = "cut",
    valid_targets = { "hostile", "ally", "self", "ground" },
    shape = "blast",
    effect = "attack",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "eggsac_fatal",
    name = ccb.content.text_without_extraction("Eggsac Eruption"),
    description = ccb.content.text_without_extraction("Hurts yourself."),
    flags = { "LOUD", "RANDOM_DAMAGE", "NO_PROJECTILE" },
    min_damage = 100,
    max_damage = 200,
    damage_type = "cut",
    valid_targets = { "hostile", "ally", "self", "ground" },
    shape = "blast",
    effect = "attack",
}
