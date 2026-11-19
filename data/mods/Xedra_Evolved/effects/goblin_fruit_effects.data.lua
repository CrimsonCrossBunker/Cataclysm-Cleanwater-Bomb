local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "goblin_fruit_regeneration_spell",
    name = ccb.content.text_without_extraction("Sweet Goblin Fruit Healing Effect"),
    description = ccb.content.text_without_extraction("Heals the target."),
    valid_targets = { "self" },
    min_damage = -1,
    max_damage = -1,
    effect = "attack",
    shape = "blast",
    flags = { "SILENT" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "goblin_fruit_aura_thorns",
    name = ccb.content.text_without_extraction("Goblin fruit aura thorns"),
    description = ccb.content.text_without_extraction("Stab a monster that attacked you."),
    valid_targets = { "hostile" },
    flags = { "RANDOM_DAMAGE" },
    shape = "blast",
    effect = "attack",
    damage_type = "stab",
    min_damage = 1,
    max_damage = 4,
    min_range = 1,
    max_range = 1,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "goblin_fruit_teleport_spell",
    name = ccb.content.text_without_extraction("fractal fruit teleport"),
    description = ccb.content.text_without_extraction("Makes the fractal goblin fruit."),
    effect = "short_range_teleport",
    shape = "blast",
    valid_targets = { "none" },
    flags = { "NO_FAIL", "SILENT", "NO_LEGS" },
    min_aoe = 2,
    max_aoe = 3,
    min_range = 2,
    max_range = 15,
    difficulty = 0,
    spell_class = "NONE",
}
