local ccb = require("ccb")

ccb.content.define_spell {
    id = "paraclesian_spell_dodge_bonus_sylph",
    copy_from = "paraclesian_spell_dodge_bonus_arvore",
    spell_class = "SYLPH",
    name = "The Wind Blows, the Willow Bends",
    description = "Like the flitting wind or the flexible willow, the spell allows you to avoid attacks much more easily.  It has <color_yellow>reduced effects</color> indoors.",
    min_duration = { handler = "wave14a_xedra_evolved_stat_105", fallback = 0 },
    max_duration = { handler = "wave14a_xedra_evolved_stat_106", fallback = 0 },
}

ccb.content.define_spell {
    id = "paraclesian_spell_make_gossamer",
    skill = "deduction",
    components = "spell_components_paraclesian_spell_make_gossamer",
    shape = "blast",
    effect = "spawn_item",
    effect_data = "gossamer_patchwork",
    magic_type = "xe_fey_magick",
    name = "Weave Gossamer",
    description = "Under the light of the moon, you can weave cotton into gossamer.",
    caster_condition_fail_message = "You must be outdoors under the moonlight to turn cotton into gossamer",
    flags = {
        "SOMATIC",
        "VERBAL",
        "NO_FAIL",
        "PERMANENT",
        "PERMANENT_ALL_LEVELS",
        "NO_EXPLOSION_SFX",
    },
    valid_targets = { "self" },
    min_damage = { handler = "wave14a_xedra_evolved_stat_107", fallback = 0 },
    max_damage = { handler = "wave14a_xedra_evolved_stat_107", fallback = 0 },
    base_energy_cost = 800,
    difficulty = 7,
    max_level = 8,
    base_casting_time = 360000,
    caster_when = "wave14a_xedra_evolved_cond_1",
}
