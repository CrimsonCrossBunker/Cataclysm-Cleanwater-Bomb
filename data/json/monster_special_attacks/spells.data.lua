local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "flying_polyp_out_of_phase_spell",
    name = ccb.content.text_without_extraction("Polyp Out of Phase"),
    description = ccb.content.text_without_extraction("Flying Polyps cast this on spawn."),
    flags = { "NO_PROJECTILE", "SILENT", "NO_EXPLOSION_SFX" },
    effect = "attack",
    effect_data = "effect_polyp_out_of_phase",
    valid_targets = { "self" },
    base_casting_time = 200,
    min_duration = 84600,
    max_duration = 84600,
    shape = "blast",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "pallid_horror_spawn",
    name = ccb.content.text_without_extraction("Summon Pallid Horror"),
    description = ccb.content.text_without_extraction("Summons a pallid horror."),
    flags = { "HOSTILE_SUMMON", "PERMANENT", "NO_EXPLOSION_SFX", "SILENT" },
    valid_targets = { "ground", "self" },
    min_damage = 1,
    max_damage = 1,
    min_aoe = 1,
    max_aoe = 1,
    extra_spells = { { spell = "spawning_zombie_die", self = true } },
    shape = "blast",
    effect = "summon",
    effect_data = "mon_inner_cabins_interstice_horror",
}
