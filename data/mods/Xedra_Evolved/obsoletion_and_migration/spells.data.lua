local ccb = require("ccb")

ccb.content.define_spell {
    id = "arvore_forest_translocate_real",
    skill = "deduction",
    shape = "blast",
    effect = "translocate",
    spell_class = "ARVORE",
    name = "From Root to Root the Forest Is Joined Real",
    description = "The actual spell that transports you for From Root to Root the Forest Is Joined.  It's a bug if you have it.",
    teachable = false,
    flags = { "VERBAL", "SOMATIC" },
    valid_targets = { "self" },
    difficulty = 9,
    max_level = { handler = "wave14a_xedra_evolved_stat_95", fallback = 0 },
}
