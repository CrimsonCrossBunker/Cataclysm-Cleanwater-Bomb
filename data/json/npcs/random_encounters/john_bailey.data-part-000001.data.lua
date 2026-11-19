local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_RC_John_Bailey_2",
    line = {
        joined = {
            {
                when = predicates.any_equal({ "seen", { scope = "speaker", key = "RC_John_Bailey_2_John_Bailey_Convo" } }),
                yes = ccb.content.text("Like I said,\" John shrugs.  \"I'm just checking "),
                no = ccb.content.text("Same as you, I imagine,\" John shrugs.  \"Checking "),
            },
            ccb.content.text("the place out, doing a little shopping.  Then I'll be on my way again.  Might see if they have any work that needs done first, if the price is right."),
        },
    },
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "RC_John_Bailey_2_John_Bailey_Convo", "seen") },
        },
    },
    replies = {
        {
            text = ccb.content.text("What are you shopping for?"),
            next_topic = "TALK_RC_John_Bailey_Shopping",
        },
        {
            text = ccb.content.text("What do you know about this place?"),
            next_topic = "TALK_RC_John_Bailey_RefCenter",
        },
        {
            text = ccb.content.text("On your way\" where?"),
            next_topic = "TALK_RC_John_Bailey_OnMyWay",
        },
        {
            text = ccb.content.text("What kind of work are you looking for?"),
            next_topic = "TALK_RC_John_Bailey_Work",
        },
        {
            text = ccb.content.text("Got time to teach me anything?"),
            next_topic = "TALK_RC_John_Bailey_Teach",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "John_Bailey_teach" } }),
        },
        {
            text = ccb.content.text("Sounds about the same as me, yep.  I'd better get back to it."),
            next_topic = "TALK_DONE",
        },
    },
}
