local ccb = require("ccb")

ccb.content.define_spell {
    id = "death_sap",
    name = ccb.content.text("Death Sap"),
    description = ccb.content.text("Sap Explosion"),
    valid_targets = { "ground", "hostile", "ally", "self" },
    min_aoe = 1,
    max_aoe = 2,
    aoe_increment = 1,
    max_level = 1,
    min_duration = 2400,
    max_duration = 2400,
    shape = "blast",
    effect = "attack",
    effect_data = "sap",
    field_chance = 1,
    field = "fd_bile",
    max_field_intensity = 2,
    min_field_intensity = 2,
    affected_bodyparts = { "TORSO", "ARM_R", "ARM_L", "LEG_R", "LEG_L" },
    extra_spells = { { spell = "death_explosion", self = true } },
}

ccb.content.define_spell {
    id = "death_pollen",
    name = ccb.content.text("Triffid Pollen Explosion"),
    description = ccb.content.text("Causes a small explosion of alien pollen."),
    valid_targets = { "self" },
    shape = "blast",
    effect = "emit",
    effect_data = "emit_pollen",
    extra_spells = { { spell = "death_explosion", self = true } },
}
