local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AO_BOOK_SNAP_PUSH",
    name = ccb.content.text_without_extraction("Grimorie Snap Push"),
    description = ccb.content.text_without_extraction("The push portion of the rock blast spell."),
    valid_targets = { "hostile", "ground", "ally", "item" },
    flags = { "RANDOM_DAMAGE", "SILENT" },
    effect = "area_push",
    shape = "blast",
    min_aoe = 4,
    max_aoe = 4,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AO_READ_GOOD",
    name = ccb.content.text_without_extraction("Artifact fast reader"),
    description = ccb.content.text_without_extraction("Makes you a fast reader."),
    message = ccb.content.text("You don't understand the book yet, but you feel like you are making progress."),
    effect = "mutate",
    shape = "blast",
    effect_data = "FASTREADER",
    min_damage = 10000,
    max_damage = 10000,
    flags = { "SILENT", "MUTATE_TRAIT" },
    valid_targets = { "self", "ally" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AO_READ_BAD",
    name = ccb.content.text_without_extraction("Artifact Nearsighted"),
    description = ccb.content.text_without_extraction("Makes you nearsighted."),
    message = ccb.content.text("Your eyes hurt after focusing on the strange tome."),
    effect = "mutate",
    shape = "blast",
    effect_data = "MYOPIC",
    min_damage = 10000,
    max_damage = 10000,
    flags = { "SILENT", "MUTATE_TRAIT" },
    valid_targets = { "self", "ally" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AO_READ_VERY_BAD",
    name = ccb.content.text_without_extraction("Artifact Illiterate"),
    description = ccb.content.text_without_extraction("Makes you illiterate."),
    message = ccb.content.text("You realize that staring at the scratches within is pointless, you don't know how to read."),
    effect = "mutate",
    shape = "blast",
    effect_data = "ILLITERATE",
    min_damage = 10000,
    max_damage = 10000,
    flags = { "SILENT", "MUTATE_TRAIT" },
    valid_targets = { "self", "ally" },
}

ccb.content.define_spell {
    id = "AO_BOOK_SNAP",
    sound_type = "combat",
    sound_id = "thunder_near",
    sound_variant = "environment",
    shape = "blast",
    effect = "attack",
    field = "fd_plasma",
    damage_type = "bash",
    name = ccb.content.text_without_extraction("Grimoire Snap"),
    description = ccb.content.text_without_extraction("Creates a shockwave that damages nearby enemies."),
    message = "The tome snaps shut with tremendous force.",
    flags = { "RANDOM_DAMAGE", "NO_EXPLOSION_SFX", "SILENT" },
    valid_targets = { "hostile", "ally", "ground" },
    field_chance = 4,
    min_field_intensity = 1,
    max_field_intensity = 2,
    min_damage = { handler = "wave14a_dda_stat_1", fallback = 0 },
    max_damage = { handler = "wave14a_dda_stat_2", fallback = 0 },
    min_aoe = 5,
    max_aoe = 5,
    extra_spells = {
        { spell = "AO_BOOK_SNAP_PUSH", self = true },
        { spell = "AO_BOOK_SNAP_PUSH", self = true },
    },
}
