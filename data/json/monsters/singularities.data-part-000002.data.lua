local ccb = require("ccb")

-- This is a hack because npc_die is not working(?!) for EOC_KILL_SHADOW
-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "BEGONE_SHADOW",
    name = ccb.content.text_without_extraction("BEGONE_SHADOW"),
    description = ccb.content.text_without_extraction("BEGONE_SHADOW."),
    valid_targets = { "ground", "self" },
    base_casting_time = 0,
    min_damage = 9999,
    max_damage = 9999,
    shape = "blast",
    effect = "banishment",
}
