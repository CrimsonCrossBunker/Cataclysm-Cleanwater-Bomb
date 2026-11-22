local ccb = require("ccb")

ccb.content.define_spell {
    id = "mon_singularity_reclaimer_summon",
    shape = "blast",
    name = ccb.content.text_without_extraction("Summon Reclaimer Spawn"),
    description = ccb.content.text_without_extraction("Summons a reclaimer spawn and makes the reclaimer keep track of how many it has spawned this time."),
    flags = { "NO_EXPLOSION_SFX" },
    valid_targets = { "self" },
    impact_handler = "w16b_sp_imp_dda_4b201e0f6068",
}
