local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_Sadie_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_sadie" } }),
        yes = {
            choices = {
                ccb.content.text("Are we meeting again or did we already do that part?"),
                ccb.content.text("You remind me of my friend Billy."),
                ccb.content.text("What an amazing world to be alive in, more or less."),
                ccb.content.text("My head always beats when I see you.  Or is that my heart?  I should check that."),
                ccb.content.text("It's always so nice to be seen."),
            },
        },
        no = ccb.content.text("Hello Billy.  Back again to try and kill me?  It won't work, you should just give up."),
    },
    replies = {
        {
            text = ccb.content.text("What, who is Billy?"),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_sadie", "yes") },
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_sadie" } })),
            next_topic = "TALK_sadie_firstmeet",
        },
        {
            text = ccb.content.text("Die foul creature!"),
            actions = {
                actions.set_actor_value("speaker", "general_meeting_u_met_sadie", "yes"),
                "insult_combat",
            },
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_sadie" } })),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("What did you just inject me with?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_injection_sadie_injection" } }),
            next_topic = "TALK_sadie_injection",
        },
        {
            text = ccb.content.text("Would you like to come with me Sadie?"),
            next_topic = "TALK_sadie_follow",
            when = predicates.all({ predicates.negate(predicates.actor_state("interlocutor", "following")), predicates.any_equal({ "yes", { scope = "speaker", key = "general_heart_sadie_heart" } }) }),
        },
        {
            text = ccb.content.text("Can you inject me with whatever that was again?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_heart_sadie_heart" } }),
            next_topic = "TALK_sadie_injection2",
        },
        {
            text = ccb.content.text("How did you get here?"),
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_sadie" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_heart_sadie_heart" } })) }),
            next_topic = "TALK_sadie_ask_past",
        },
        {
            text = ccb.content.text("How are things here?"),
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_sadie" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_heart_sadie_heart" } })) }),
            next_topic = "TALK_sadie_ask_mood",
        },
        {
            text = ccb.content.text("Can I do anything for you?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_sadie" } }),
            next_topic = "TALK_MISSION_LIST",
        },
        { text = ccb.content.text("Goodbye."), next_topic = "TALK_DONE" },
    },
}
