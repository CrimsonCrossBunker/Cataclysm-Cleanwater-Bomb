local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = { "TALK_GUARD" },
    replies = {
        {
            text = ccb.content.text("[Premonition] *Check for anything amiss*"),
            next_topic = "TALK_GUARD_GENERIC_REFUGEE_danger_sense",
            when = predicates.handler("dlg_p_mindovermatter_222d75bf80b0"),
        },
        {
            text = ccb.content.text("[Sense Hostility] *Determine if <npc_name> is a threat*"),
            next_topic = "TALK_GUARD_GENERIC_REFUGEE_sense_hostility",
            when = predicates.handler("dlg_p_mindovermatter_5b3ce0810487"),
        },
        {
            text = ccb.content.text("[Telepathy] *Read <npc_name>'s mind*"),
            next_topic = "TALK_GUARD_GENERIC_REFUGEE_scan",
            when = predicates.handler("dlg_p_mindovermatter_8333d7767a16"),
        },
    },
}
