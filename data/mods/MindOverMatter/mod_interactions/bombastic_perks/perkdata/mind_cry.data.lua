local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "telepathic_blast_radius_mind_cry",
    name = ccb.content.text_without_extraction("[Ψ]Psychic Scream Mind Cry"),
    description = ccb.content.text_without_extraction("The Mind Cry version of Psychic Scream.  It's a bug if you have it."),
    message = ccb.content.text("You unleash a mind-piercing psionic shriek!"),
    teachable = false,
    valid_targets = { "hostile", "ally" },
    spell_class = "TELEPATH",
    magic_type = "mom_psionics",
    skill = "metaphysics",
    flags = {
        "PSIONIC",
        "SILENT",
        "RANDOM_DAMAGE",
        "NO_HANDS",
        "NO_EXPLOSION_SFX",
        "NO_LEGS",
        "PERCENTAGE_DAMAGE",
        "IGNORE_WALLS",
    },
    difficulty = 7,
    max_level = { handler = "scale_telepathic_blast_radius_mind_cry_max_level", fallback = 0 },
    effect = "attack",
    extra_spells = { { spell = "telepathic_blast_radius_mind_cry_guaranteed", self = false } },
    shape = "blast",
    damage_type = "psi_telepathic_damage",
    min_damage = { handler = "scale_telepathic_blast_radius_mind_cry_min_damage", fallback = 0.0 },
    max_damage = { handler = "scale_telepathic_blast_radius_mind_cry_max_damage", fallback = 0.0 },
    min_aoe = { handler = "scale_telepathic_blast_radius_mind_cry_min_aoe", fallback = 0.0 },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "telepathic_blast_radius_mind_cry_guaranteed",
    name = ccb.content.text_without_extraction("[Ψ]Psychic Scream Mind Cry Additional Damage"),
    description = ccb.content.text_without_extraction("This exists to allow Psychic Scream to do minimal damage and kill small animals whose extremely low HP would otherwise be below the percentage threshold, as well as making it more likely to stun or daze.  It's a bug if you have it directly."),
    message = "",
    teachable = false,
    valid_targets = { "hostile", "ally" },
    flags = { "PSIONIC", "SILENT", "NO_HANDS", "NO_EXPLOSION_SFX", "IGNORE_WALLS" },
    max_level = { handler = "scale_telepathic_blast_radius_mind_cry_max_level", fallback = 0 },
    effect = "attack",
    shape = "blast",
    damage_type = "psi_telepathic_damage",
    min_damage = 1,
    max_damage = 2,
    damage_increment = 0.1,
    min_aoe = { handler = "scale_telepathic_blast_radius_mind_cry_min_aoe", fallback = 0.0 },
}
