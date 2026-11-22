local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Greenwood_2",
    line = {
        when = predicates.actor_state("speaker", "male"),
        yes = ccb.content.text("How may I help you, brother?"),
        no = ccb.content.text("How may I help you, sister?"),
    },
    replies = {
        {
            text = ccb.content.text("Where am I again?"),
            next_topic = "TALK_GODCO_Greenwood_Where",
        },
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_GODCO_Greenwood_Past",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("Could you tell me a bit about this church?"),
            next_topic = "TALK_GODCO_Greenwood_NECC",
        },
        {
            text = ccb.content.text("I'm looking for work.  Can I do anything for your congregation?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
