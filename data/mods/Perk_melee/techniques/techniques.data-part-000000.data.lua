local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_perk_feint",
    name = ccb.content.text("Feint"),
    messages = {
        ccb.content.text("You fake a strike at %s"),
        ccb.content.text("<npcname> fakes a strike at %s"),
    },
    required_char_flags_all = { "MELEE_PERK_FEINT" },
    melee_allowed = true,
    defensive = true,
    miss_recovery = true,
    mult_bonuses = { { stat = "movecost", scale = 0.8 } },
}
