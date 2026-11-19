local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_PRISONER_GREET",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_first_meeting" } }),
        yes = ccb.content.text("Do I need to repeat myself?  Get outta here, <name_b>."),
        no = ccb.content.gendered_line("Hey, who the fuck are you?  I haven't seen you 'round.  Ah, fuck it, it doesn't matter.\nHere's the rules.  The first and most important one: ALWAYS CLOSE THE FUCKING ENTRY DOOR BEHIND YOUR ASS!  If you're okay with that, the following rules are: don't fuck with us, don't steal from us, don't start a fight without a reason with someone from us.  Got it, punk?  Now get lost.", { "speaker" }),
    },
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "dialogue_first_meeting_first_meeting", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("Yeah, I got it.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_first_meeting" } })),
        },
        {
            text = ccb.content.text("I just wanted to ask if you have a job for me."),
            next_topic = "TALK_PRISONER_ANNOYED",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_first_meeting" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_annoyed_greeter_talked_to_greeter" } })) }),
        },
        {
            text = ccb.content.text("I'm just hungry, and I thought you might give me some food for some job."),
            next_topic = "TALK_PRISONER_ANGRY",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_first_meeting" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_annoyed_greeter_talked_to_greeter" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_angry_greeter_talked_to_greeter" } })) }),
        },
        {
            text = ccb.content.text("Can we just talk it over?"),
            next_topic = "TALK_PRISONER_READY_TO_MUG",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_first_meeting" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_angry_greeter_talked_to_greeter" } }) }),
        },
        {
            text = ccb.content.text("Hey, fuck you, <name_b>!"),
            next_topic = "TALK_DONE",
            actions = { "hostile" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PRISONER_ANNOYED",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_annoyed_greeter_talked_to_greeter" } }),
        yes = ccb.content.text("Get out, loser."),
        no = ccb.content.text("Do I have a <freaking> exclamation sign over my <freaking> head, like I'm a <freaking> quest-giver from some <freaking> video game?"),
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "dialogue_annoyed_greeter_talked_to_greeter", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("No, of course not!  Sorry, I'm leaving."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_annoyed_greeter_talked_to_greeter" } })),
        },
        {
            text = ccb.content.text("Hey, fuck you, <name_b>!"),
            next_topic = "TALK_DONE",
            actions = { "hostile" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PRISONER_ANGRY",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_annoyed_greeter_talked_to_greeter" } }),
        yes = ccb.content.gendered_line("Are you deaf or stupid?  I said I don't give a fuck for you and your <freaking> problems.  Bother me one more time, and you'll regret that.  Get outta my sight.", { "speaker" }),
        no = ccb.content.text("Disappear, <name_b>."),
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "dialogue_angry_greeter_talked_to_greeter", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Ok, sorry, I promise I won't bother you anymore."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_angry_greeter_talked_to_greeter" } })),
        },
        {
            text = ccb.content.text("Hey, fuck you, <name_b>!"),
            next_topic = "TALK_DONE",
            actions = { "hostile" },
        },
    },
}
