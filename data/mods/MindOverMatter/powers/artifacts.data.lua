local ccb = require("ccb")

ccb.content.define_spell {
    id = "MoM_AEA_ASTRAL_PROJECTION",
    skill = "metaphysics",
    shape = "blast",
    name = ccb.content.text_without_extraction("MoM Artifact Astral Projection"),
    description = ccb.content.text_without_extraction("Causes the artifact cast you forth from your body as a spirit."),
    message = "",
    flags = { "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    valid_targets = { "self" },
    base_casting_time = 100,
    impact_handler = "w16b_sp_imp_mindovermatter_d3bffc4f3b07",
    extra_spells = {
        { spell = "mom_aea_artifact_calorie_hit", self = true },
    },
}

ccb.content.define_spell {
    id = "MoM_AEA_INTENSIFY_NEARBY_FLAMES",
    skill = "metaphysics",
    shape = "blast",
    name = ccb.content.text_without_extraction("MoM AEA Intensify Nearby Flames"),
    description = ccb.content.text_without_extraction("Causes all nearby flames to increase in intensity."),
    message = "The crystal pulses heat for moment.",
    flags = { "NO_LEGS", "SILENT", "NO_EXPLOSION_SFX", "RANDOM_AOE" },
    valid_targets = { "self" },
    impact_handler = "w16b_sp_imp_mindovermatter_a1ae4915ddff",
    extra_spells = {
        { spell = "mom_aea_artifact_calorie_hit", self = true },
    },
}

ccb.content.define_spell {
    id = "MoM_AEA_BURST_OF_FORCE",
    shape = "blast",
    name = ccb.content.text_without_extraction("MoM AEA Wave of Force"),
    description = ccb.content.text_without_extraction("Unleash a wave of force and knock targets back."),
    message = "A wave of force burst out from you!",
    teachable = false,
    flags = { "PSIONIC", "NO_HANDS", "RANDOM_AOE", "NO_LEGS" },
    valid_targets = { "hostile" },
    min_aoe = 1,
    max_aoe = 3,
    impact_handler = "w16b_sp_imp_mindovermatter_b1c6c278005d",
    extra_spells = {
        { spell = "mom_aea_artifact_calorie_hit", self = true },
    },
}

ccb.content.define_spell {
    id = "MoM_AEA_FEAR_AURA",
    skill = "metaphysics",
    shape = "blast",
    name = ccb.content.text_without_extraction("MoM AEA Artifact Fear Aura"),
    description = ccb.content.text_without_extraction("Reduces Morale on all targets in the area"),
    message = "A chill runs down your spine.",
    teachable = false,
    flags = {
        "PSIONIC",
        "SILENT",
        "NO_HANDS",
        "NO_EXPLOSION_SFX",
        "NO_LEGS",
        "RANDOM_AOE",
        "IGNORE_WALLS",
    },
    valid_targets = { "hostile", "ally" },
    ignored_species = { "PSI_NULL" },
    min_damage = 4,
    max_damage = 11,
    min_aoe = 6,
    max_aoe = 10,
    impact_handler = "w16b_sp_imp_mindovermatter_dcd05489e8ae",
    extra_spells = {
        { spell = "mom_aea_artifact_calorie_hit", self = true },
    },
}

ccb.content.define_spell {
    id = "MoM_AEA_DISTANT_TELEPORT",
    shape = "blast",
    name = ccb.content.text_without_extraction("MoM AEA Artifact Distant Teleport"),
    description = ccb.content.text_without_extraction("Causes you to teleport far away"),
    flags = { "CONCENTRATE", "SILENT", "NO_HANDS", "NO_LEGS" },
    valid_targets = { "self" },
    base_casting_time = 50,
    impact_handler = "w16b_sp_imp_mindovermatter_79b3c972c0e6",
    extra_spells = {
        { spell = "mom_aea_artifact_calorie_hit", self = true },
    },
}

ccb.content.define_spell {
    id = "MoM_AEA_BLOOD_PURGE",
    shape = "blast",
    name = ccb.content.text_without_extraction("MoM AEA Blood Purge"),
    description = ccb.content.text_without_extraction("Removes substances in blood, including beneficial ones."),
    message = "You hear the roar of blood through your veins.",
    flags = { "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    valid_targets = { "self" },
    base_casting_time = 100,
    impact_handler = "w16b_sp_imp_mindovermatter_ced2a22222d6",
    extra_spells = {
        { spell = "mom_aea_artifact_calorie_hit", self = true },
    },
}
