local ccb = require("ccb")

ccb.content.define_spell {
    id = "mag_call_stag_beetle_real",
    name = ccb.content.text("Call Stag Beetle"),
    description = ccb.content.text("A stag beetle responds to the call, arriving in the location you are in.  It can be used to carry you and your belongings so long as you have a wildwood rune and the skill to ride it."),
    valid_targets = { "ground" },
    min_damage = 1,
    max_damage = 1,
    min_range = 1,
    max_range = 5,
    base_casting_time = 0,
    magic_type = "magiclysm_generic_magic",
    max_level = 5,
    difficulty = 1,
    min_duration = 700000,
    max_duration = 2200000,
    duration_increment = 750000,
    flags = { "SOMATIC", "VERBAL", "NO_LEGS", "NO_CORPSE_QUIET" },
    shape = "blast",
    effect = "summon",
    effect_data = "mon_mag_stag_beetle",
}

ccb.content.define_spell {
    id = "forge_teleport",
    shape = "blast",
    name = ccb.content.text_without_extraction("Forge Teleport"),
    description = ccb.content.text_without_extraction("Travel to the forge marking your return point in the process."),
    valid_targets = { "self" },
    base_casting_time = 30000,
    impact_handler = "w16b_sp_imp_magiclysm_c6964f19fa6f",
}

ccb.content.define_spell {
    id = "forge_return_teleport",
    shape = "blast",
    name = ccb.content.text_without_extraction("Forge Return Teleport"),
    description = ccb.content.text_without_extraction("Travel back to your saved forge return point."),
    valid_targets = { "self" },
    base_casting_time = 30000,
    impact_handler = "w16b_sp_imp_magiclysm_5b9cd920bb87",
}
