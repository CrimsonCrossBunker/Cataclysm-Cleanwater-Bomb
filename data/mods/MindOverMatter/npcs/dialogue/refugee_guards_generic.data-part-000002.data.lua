local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = { "TALK_EVAC_GUARD1" },
    replies = {
        {
            text = ccb.content.text("[Premonition] *Determine if <npc_name> is a threat*"),
            next_topic = "TALK_EVAC_GUARD1_danger_sense",
            when = predicates.handler("dlg_p_mindovermatter_222d75bf80b0"),
        },
        {
            text = ccb.content.text("[Telepathy] *Read <npc_name>'s mind*"),
            next_topic = "TALK_EVAC_GUARD1_scan",
            when = predicates.handler("dlg_p_mindovermatter_8333d7767a16"),
        },
    },
}
