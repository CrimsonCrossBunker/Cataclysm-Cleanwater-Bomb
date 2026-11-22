local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = { "TALK_PORTAL_STORM_WHAT_DO_YOU_GET" },
    replies = {
        {
            text = ccb.content.text("[Clarity 3+] *Is the voice lying?*"),
            next_topic = "TALK_PORTAL_STORM_CLARITY",
            when = predicates.handler("dlg_p_mindovermatter_4d44b6e93be9"),
        },
    },
}
