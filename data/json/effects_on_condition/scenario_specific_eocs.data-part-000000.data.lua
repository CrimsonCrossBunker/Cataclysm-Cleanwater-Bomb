local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "SPELL_ALLY_WITH_MUTANTS",
    name = ccb.content.text_without_extraction("SPELL_ALLY_WITH_MUTANTS"),
    description = ccb.content.text_without_extraction("SPELL_ALLY_WITH_MUTANTS"),
    valid_targets = { "hostile" },
    shape = "blast",
    effect = "charm_monster",
    min_damage = 99999,
    max_damage = 99999,
    min_duration = 2000000000,
    max_duration = 2000000000,
    targeted_monsters = {
        "mon_mutant_experimental",
        "mon_mutant_evolved",
        "mon_mutant_antler",
        "mon_mutant_arthropod",
        "mon_mutant_camouflaged",
        "mon_mutant_alpha",
        "mon_mutant_mollusk",
        "mon_mutant_alpha_boss",
    },
    min_aoe = 50,
    flags = { "SILENT", "NO_EXPLOSION_SFX", "NO_PROJECTILE", "NO_FAIL", "IGNORE_WALLS" },
}
