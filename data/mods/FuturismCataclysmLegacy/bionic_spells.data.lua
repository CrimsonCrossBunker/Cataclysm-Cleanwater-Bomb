local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "fcl_generic_free_turn",
    name = ccb.content.text_without_extraction("Futurism Extra Turn"),
    description = ccb.content.text_without_extraction("Grants you an extra turn."),
    message = "",
    valid_targets = { "self" },
    effect = "mod_moves",
    shape = "blast",
    min_damage = 100,
    max_damage = 100,
    base_casting_time = 1,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "fcl_generic_speed_bonus",
    name = ccb.content.text_without_extraction("Futurism Stacking Speed Bonus"),
    description = ccb.content.text_without_extraction("Grants you a stackable speed bonus."),
    message = "",
    valid_targets = { "self" },
    effect = "attack",
    effect_data = "fcl_generic_speed_bonus",
    shape = "blast",
    flags = { "NO_PROJECTILE" },
    base_casting_time = 1,
    min_duration = 100,
    max_duration = 100,
}
