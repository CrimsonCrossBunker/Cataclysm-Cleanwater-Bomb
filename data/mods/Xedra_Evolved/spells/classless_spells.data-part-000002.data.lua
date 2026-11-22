local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "boann_retaliation_mark",
    name = ccb.content.text_without_extraction("Boann's retaliation targeting"),
    valid_targets = { "self", "hostile", "ground", "ally" },
    description = ccb.content.text_without_extraction("Intended to be hidden.  This is how Boann teleport away monsters that hit her."),
    flags = { "SILENT", "NO_EXPLOSION_SFX", "NO_FAIL" },
    message = "",
    effect = "attack",
    effect_data = "boann_retaliation_mark",
    min_range = 60,
    max_range = 60,
    min_duration = 500,
    max_duration = 500,
    shape = "blast",
}

ccb.content.define_spell {
    id = "call_daffodil_real",
    shape = "blast",
    effect = "summon",
    effect_data = "mon_fetch_daffodil_warrior",
    spell_class = "NONE",
    name = ccb.content.text_without_extraction("Call Daffodil"),
    description = ccb.content.text_without_extraction("Hidden spell that spawns the daffodil"),
    flags = { "NO_LEGS", "SILENT", "NO_EXPLOSION_SFX", "NO_FAIL", "NO_HANDS", "NON_MAGICAL" },
    valid_targets = { "ground" },
    min_damage = 5,
    max_damage = 5,
    min_range = 3,
    max_range = 3,
    min_aoe = 3,
    max_aoe = 3,
    min_duration = 8640000,
    max_duration = 8640000,
    difficulty = 0,
    max_level = 1,
}

ccb.content.define_spell {
    id = "call_daffodil",
    shape = "blast",
    spell_class = "NONE",
    name = "Call Daffodil",
    description = "A few daffodil warriors appear near you.  They will fight for you, but they will fade away after a day.",
    flags = { "NO_LEGS", "SILENT", "NO_EXPLOSION_SFX", "NO_FAIL", "NO_HANDS", "NON_MAGICAL" },
    valid_targets = { "self" },
    impact_handler = "w16b_sp_imp_xedra_evolved_517d1a97e0eb",
}
