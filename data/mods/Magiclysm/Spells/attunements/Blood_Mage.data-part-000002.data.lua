local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "demonic_possession_real",
    name = ccb.content.text_without_extraction("Demonic Possession Real"),
    description = ccb.content.text_without_extraction("Grants the aura that gives the demon traits.  You're not supposed to see this."),
    valid_targets = { "self" },
    flags = {
        "CONJURATION_SPELL",
        "SOMATIC",
        "NO_LEGS",
        "MUST_HAVE_CLASS_TO_LEARN",
        "SILENT",
        "NO_EXPLOSION_SFX",
    },
    extra_spells = { { spell = "eoc_summon_setup", self = true } },
    effect = "spawn_item",
    shape = "blast",
    effect_data = "demon_possession_aura",
    min_damage = 1,
    max_damage = 1,
    min_duration = { handler = "scaled_demonic_possession_real_min_duration", fallback = 360000.0 },
    max_duration = { handler = "scaled_demonic_possession_real_min_duration", fallback = 360000.0 },
    spell_class = "BLOOD_MAGE",
    difficulty = 5,
    max_level = 35,
    base_casting_time = 0,
}
