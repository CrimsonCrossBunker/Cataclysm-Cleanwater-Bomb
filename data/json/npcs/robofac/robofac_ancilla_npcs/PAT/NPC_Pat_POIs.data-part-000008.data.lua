local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_mine_amigara_finale_central",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_knows_u_cyborg" } }),
        yes = ccb.content.text("&You hear a chirp in your comm and Pat's voice comes over the line, broken up by static: \"Pat ta' <pat_robo_nickname>. You heah tha-- sound?  Ovah.\""),
        no = ccb.content.text("&You hear a chirp in your comm and Pat's voice comes over the line, broken up by static: \"Pat heah.  You heah tha-- sound?  Ovah.\""),
    },
    replies = {
        {
            text = ccb.content.text("Hear what?  Over."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_mine_amigara_finale_central_1",
            actions = {
                actions.set_actor_value("speaker", "robofac_pat_talk_mine_amigara_finale_central_later", "yes"),
            },
        },
        {
            text = ccb.content.text("Not now, Pat.  We'll talk about this later.  Over and out."),
            next_topic = "TALK_DONE",
            actions = {
                actions.set_actor_value("speaker", "robofac_pat_talk_mine_amigara_finale_central_later", "yes"),
            },
        },
        {
            text = ccb.content.text("[Chirp Pat twice and stay silent]"),
            next_topic = "TALK_DONE",
            actions = {
                actions.set_actor_value("speaker", "robofac_pat_talk_mine_amigara_finale_central_later", "yes"),
            },
        },
    },
}
