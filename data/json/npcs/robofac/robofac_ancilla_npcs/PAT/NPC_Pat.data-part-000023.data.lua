local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_RECON_DIRECTIONS_INTRO",
    line = ccb.content.text("Yeah, absolutely.  I'll chat with mercs and traders as they come by.  Check in every 3 days or so?"),
    replies = {
        {
            text = ccb.content.text("Yeah, alright.  Thanks, Pat."),
            next_topic = "TALK_ROBOFAC_MERC_PAT",
            actions = { actions.set_actor_value("speaker", "robofac_pat_talked_about_recon", "yes"), actions.handler("dlg_a_dda_09d8d955a248") },
        },
    },
}
