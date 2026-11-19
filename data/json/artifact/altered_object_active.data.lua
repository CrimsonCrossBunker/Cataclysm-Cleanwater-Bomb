local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AO_TRUESIGHT_EFFECT",
    name = ccb.content.text_without_extraction("Artifact Truesight"),
    description = ccb.content.text_without_extraction("Grants you the TRUE_SEEING flag."),
    message = ccb.content.text("You see movement in the corners of your vision."),
    valid_targets = { "self" },
    flags = { "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    effect = "attack",
    effect_data = "effect_true_seeing",
    shape = "blast",
    min_duration = 6800,
    max_duration = 6800,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AO_DARKNESS_EFFECT",
    name = ccb.content.text_without_extraction("Artifact Darkness"),
    description = ccb.content.text_without_extraction("Grants you the Darkness effect."),
    message = ccb.content.text("Persistent shadows invade your field of view."),
    valid_targets = { "self" },
    flags = { "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    effect = "attack",
    effect_data = "darkness",
    shape = "blast",
    min_duration = 2400,
    max_duration = 2400,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AO_LIFE_DRAIN",
    name = ccb.content.text_without_extraction("Artifact Hurtall"),
    description = ccb.content.text_without_extraction("Hurts you for random damage."),
    message = ccb.content.text("You feel hollow inside."),
    min_damage = 0,
    max_damage = 10,
    valid_targets = { "self" },
    flags = { "RANDOM_DAMAGE", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    shape = "blast",
    effect = "attack",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AO_CLOSE_TEAR",
    name = ccb.content.text_without_extraction("Artifact Close Tear"),
    description = ccb.content.text_without_extraction("Closes a tear in reality and transfers strange energy to the artifact user."),
    message = "",
    min_aoe = 40,
    max_aoe = 40,
    valid_targets = { "field" },
    flags = { "IGNORE_WALLS", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    shape = "blast",
    effect = "remove_field",
    effect_data = "fd_fatigue",
}
