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

ccb.content.define_mapgen {
    kind = "update",
    id = "SCENARIO_BLOOD",
    layout = {
        field_placements = {
            {
                id = "fd_blood",
                x = { 5, 20 },
                y = { 5, 20 },
                intensity = { 1, 3 },
                repetitions = 10,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "SCENARIO_FIRE",
    layout = {
        field_placements = { { id = "fd_fire", x = { 3, 20 }, y = { 3, 20 }, intensity = { 1, 3 }, repetitions = 15 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "SCENARIO_SMOKE",
    layout = {
        field_placements = {
            {
                id = "fd_smoke",
                x = { 3, 20 },
                y = { 3, 20 },
                intensity = { 1, 3 },
                repetitions = 60,
            },
        },
    },
}

ccb.content.define_spell {
    id = "SPELL_BANISH_MONSTERS_AROUND_MANSION_CENTER",
    shape = "blast",
    name = ccb.content.text_without_extraction("SPELL_BANISH_MONSTERS_AROUND_MANSION_CENTER"),
    description = ccb.content.text_without_extraction("SPELL_BANISH_MONSTERS_AROUND_MANSION_CENTER"),
    flags = { "SILENT", "NO_EXPLOSION_SFX", "NO_PROJECTILE", "NO_FAIL", "IGNORE_WALLS" },
    valid_targets = { "hostile" },
    min_aoe = 36,
    impact_handler = "w16b_sp_imp_dda_8394d1c0f288",
}

ccb.content.define_spell {
    id = "SPELL_BANISH_MANSION_CIVILIANS",
    shape = "blast",
    name = ccb.content.text_without_extraction("SPELL_BANISH_MANSION_CIVILIANS"),
    description = ccb.content.text_without_extraction("SPELL_BANISH_MANSION_CIVILIANS"),
    flags = { "SILENT", "NO_EXPLOSION_SFX", "NO_PROJECTILE", "NO_FAIL", "IGNORE_WALLS" },
    valid_targets = { "hostile" },
    targeted_monsters = {
        "mon_civilian_panic",
        "mon_civilian_parent",
        "mon_civilian_police",
        "mon_civilian_stationary",
        "mon_civilian_zombiefighter",
    },
    min_aoe = 50,
    impact_handler = "w16b_sp_imp_dda_df14c525adb8",
}
