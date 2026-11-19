local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "mon_swarm_structure_attack",
    name = ccb.content.text_without_extraction("Swarm Structure Action"),
    description = ccb.content.text_without_extraction("Teleports and summons monsters."),
    copy_from = "base_portal",
    extra_spells = { { spell = "portal_severely_hurt_self", self = true } },
    min_range = 15,
    max_range = 15,
    effect_data = "EOC_mon_swarm_structure_attack",
}
