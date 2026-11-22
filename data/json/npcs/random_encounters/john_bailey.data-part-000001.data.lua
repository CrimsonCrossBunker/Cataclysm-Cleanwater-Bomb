local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_RC_John_Bailey_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_met_John_Bailey" } }),
        yes = ccb.content.text("*looks up at you, taking a moment to place your face, then grins broadly.  He looks about the same as when you last saw him, perhaps a little more fit.  \"So, you're still playing on the 'living' team, huh?  Glad to see you're still kicking around.  Always good to run into a familiar face nowadays.\""),
        no = ccb.content.text("*glances your way, then makes eye contact as you move closer to speak.  He is a strong-looking man in his mid forties, his hair graying and his face flecked with stubble and travel dust.  The clothes he's wearing are clearly scavenged, though they fit well, and he has the build of someone who until recently had the luxury of carrying a few extra pounds.  \"Hi there.\"  He presents his hand to shake.  \"You don't look like you belong here.  Name's Bailey, John Bailey.\""),
    },
    on_enter = {
        { actions = { actions.set_actor_value("speaker", "u_met_John_Bailey", "yes"), actions.set_first_topic("TALK_RC_John_Bailey_1a"), actions.handler("dlg_a_dda_fbd5e2022429") } },
    },
    replies = {
        {
            text = ccb.content.text("Hi John.  What are you doing here?"),
            next_topic = "TALK_RC_John_Bailey_2",
        },
        {
            text = ccb.content.text("Hi John.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

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
