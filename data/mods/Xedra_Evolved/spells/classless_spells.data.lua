local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "boann_banish_monsters",
    name = ccb.content.text_without_extraction("Boann's retaliation against monsters"),
    description = ccb.content.text_without_extraction("Boann's retaliation against monsters, deleting them as they are \"teleported\" away.  You shouldn't see this"),
    teachable = false,
    valid_targets = { "self" },
    effect = "banishment",
    shape = "blast",
    spell_class = "NONE",
    damage_type = "pure",
    skill = "deduction",
    min_damage = 9999,
    max_damage = 9999,
    base_casting_time = 0,
    flags = { "SILENT", "NO_FAIL" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "xedra_self_banish",
    name = ccb.content.text_without_extraction("Banish Self"),
    description = ccb.content.text_without_extraction("Banish the caster, killing them and destroying their body.  Having this spell is a bug, and casting it would be suicidal."),
    teachable = false,
    valid_targets = { "self" },
    effect = "banishment",
    shape = "blast",
    spell_class = "NONE",
    damage_type = "pure",
    min_damage = 9999,
    max_damage = 9999,
    base_casting_time = 0,
    flags = { "SILENT", "NO_FAIL", "PERCENT_DAMAGE" },
}

ccb.content.define_spell {
    id = "night_sight",
    skill = "deduction",
    shape = "blast",
    effect = "attack",
    effect_data = "night_sight",
    magic_type = "xedra_magic_generic",
    name = "Night Sight",
    description = "Gives you the power to see in the dark.",
    message = "Your eyes glow lavender for a moment.  Now your sight can pierce the darkest shadows.",
    valid_targets = { "self" },
    min_duration = 18000,
    duration_increment = 18000,
    max_duration = 1080000,
    base_energy_cost = 1200,
    difficulty = 6,
    max_level = 20,
    base_casting_time = 2000,
}
