local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "clair_sense_rads_outside",
    name = ccb.content.text_without_extraction("[Ψ]Radiation Sense on your environment"),
    description = ccb.content.text_without_extraction("Sense your environmental radiation.  It's a bug if you have it directly."),
    valid_targets = { "self" },
    flags = { "PSIONIC", "SILENT", "NO_EXPLOSION_SFX", "RANDOM_DURATION" },
    shape = "blast",
    max_level = { handler = "scale_clair_sense_rads_outside_max_level", fallback = 0 },
    effect = "attack",
    effect_data = "effect_clair_sense_rads_self",
    min_duration = { handler = "scale_clair_sense_rads_outside_min_duration", fallback = 0.0 },
    max_duration = { handler = "scale_clair_sense_rads_outside_max_duration", fallback = 0.0 },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "clair_sense_rads_outside_spawn_item",
    name = ccb.content.text_without_extraction("[Ψ]Radiation Sense summon item"),
    description = ccb.content.text_without_extraction("This is the reoccurring item summon for Radiation Sense.  It's a bug if you have it."),
    valid_targets = { "self" },
    flags = { "PSIONIC", "SILENT", "NO_EXPLOSION_SFX", "RANDOM_DURATION" },
    max_level = { handler = "scale_clair_sense_rads_outside_max_level", fallback = 0 },
    effect = "spawn_item",
    effect_data = "clair_sense_rad_item",
    shape = "blast",
    min_damage = 1,
    max_damage = 1,
    min_duration = 1100,
    max_duration = 1100,
}
