local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "xe_werewolf_summon_shadow_pack_limiter_spell",
    name = ccb.content.text_without_extraction("Summon the Shadow Pack Limiter"),
    description = ccb.content.text_without_extraction("Limit the usage of Summon the Shadow Pack."),
    message = "",
    teachable = false,
    valid_targets = { "self" },
    spell_class = "WEREWOLF_SPELLS",
    magic_type = "xe_werewolf_powers",
    skill = "deduction",
    effect = "attack",
    effect_data = "effect_xe_werewolf_summon_shadow_pack_limiter",
    shape = "blast",
    flags = { "SILENT" },
    min_duration = 4320000,
    max_duration = 4320000,
}
