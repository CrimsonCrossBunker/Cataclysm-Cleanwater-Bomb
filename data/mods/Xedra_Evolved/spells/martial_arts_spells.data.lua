local ccb = require("ccb")

ccb.content.define_spell {
    id = "tech_xe_ma_arvore_venom_attack_spell",
    skill = "gramarye",
    shape = "blast",
    effect = "attack",
    spell_class = "ARVORE",
    damage_type = "biological",
    magic_type = "xedra_arvore_magick",
    name = ccb.content.text_without_extraction("Nightshade's Touch Effect"),
    description = ccb.content.text_without_extraction("Spell cast by the target of nightshade's touch"),
    message = "",
    teachable = false,
    flags = { "SILENT", "NO_PROJECTILE", "NO_FAIL", "NON_MAGICAL", "RANDOM_DURATION" },
    valid_targets = { "self" },
    min_dot = { handler = "wave14a_xedra_evolved_stat_422", fallback = 0 },
    max_dot = { handler = "wave14a_xedra_evolved_stat_422", fallback = 0 },
    min_duration = { handler = "wave14a_xedra_evolved_stat_423", fallback = 0 },
    max_duration = { handler = "wave14a_xedra_evolved_stat_424", fallback = 0 },
}
