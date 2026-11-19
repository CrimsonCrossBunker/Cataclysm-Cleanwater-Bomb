local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_KINDRED_COOPER",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cooper" } }),
        yes = {
            when = predicates.has_trait("speaker", "seer_mark"),
            yes = {
                when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cooper_cooper_friendly" } }),
                yes = ccb.content.text("Kindred.  What can I do for you?"),
                no = ccb.content.text("What do you want, Kindred?"),
            },
            no = {
                when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cooper_cooper_friendly" } }),
                yes = ccb.content.text("Hello again, traveler."),
                no = ccb.content.text("Yes?"),
            },
        },
        no = {
            when = predicates.has_trait("speaker", "seer_mark"),
            yes = ccb.content.gendered_line("How do you do.  Name's Cooper.  What's your- wait… that's the Mark of the Seer on your hand.  You're Kindred.  So I guess you know who I am, then.", { "speaker" }),
            no = ccb.content.text("How do you do.  Name's Cooper.  And you are?"),
        },
    },
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "dialogue_first_meeting_talked_to_cooper", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("I do.  Brigitte told me about you, and that you're dangerous."),
            next_topic = "TALK_KNOWS_COOPER1",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cooper_confronted_cooper" } })), predicates.has_trait("speaker", "seer_mark"), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_cooper_knows_cooper" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_cooper_knows_cooper_kill" } })) }),
        },
        {
            text = ccb.content.text("Brigitte told me everything.  What could drive a man to carve the bones of living people?"),
            next_topic = "TALK_KNOWS_COOPER_CARVE",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cooper_confronted_cooper" } })), predicates.has_trait("speaker", "seer_mark"), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_cooper_knows_cooper" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_cooper_knows_cooper_kill" } }) }),
        },
        {
            text = ccb.content.text("Brigitte told me about you.  I think what you do might be what's necessary, even if Brigitte doesn't agree."),
            next_topic = "TALK_COOPER_AGREE",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cooper_confronted_cooper" } })), predicates.has_trait("speaker", "seer_mark"), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_cooper_knows_cooper" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_cooper_knows_cooper_kill" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_admires_cooper" } }) }),
        },
        {
            text = ccb.content.text("I can't say that I do.  Should I?"),
            next_topic = "TALK_COOPER_NOTFMLR",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cooper" } })), predicates.has_trait("speaker", "seer_mark"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_cooper_knows_cooper" } })) }),
        },
        {
            text = ccb.content.text("Just a traveler, trying to survive.  What about you?  Scavenging?"),
            next_topic = "TALK_COOPER_INTRODUCTION",
            when = predicates.all({ predicates.negate(predicates.has_trait("speaker", "seer_mark")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_cooper_knows_cooper" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cooper" } })) }),
        },
        {
            text = ccb.content.text("Wait, Cooper?  Brigitte LaCroix mentioned someone by that name.  You're the man who carved the bones of living people."),
            next_topic = "TALK_KNOWS_COOPER_CARVE",
            when = predicates.all({ predicates.negate(predicates.has_trait("speaker", "seer_mark")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cooper" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_cooper_knows_cooper" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_cooper_knows_cooper_kill" } }) }),
        },
        {
            text = ccb.content.text("Cooper?  I met a woman who mentioned you, Brigitte.  She said you're dangerous."),
            next_topic = "TALK_COOPER_INTRODUCTION_QUERY",
            when = predicates.all({ predicates.negate(predicates.has_trait("speaker", "seer_mark")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cooper" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_cooper_knows_cooper" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_cooper_knows_cooper_kill" } })) }),
        },
        {
            text = ccb.content.text("Wait, Cooper?  I heard about you.  A woman, Brigitte LaCroix, said that you're dangerous, but seems to me like you're just doing what it takes."),
            next_topic = "TALK_COOPER_AGREE",
            when = predicates.all({ predicates.negate(predicates.has_trait("speaker", "seer_mark")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cooper" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_cooper_knows_cooper" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_admires_cooper" } }) }),
        },
        {
            text = ccb.content.text("Why did Brigitte say you're dangerous?"),
            next_topic = "TALK_COOPERS_SIDE",
            when = predicates.all({ predicates.negate(predicates.has_trait("speaker", "seer_mark")), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cooper" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_cooper_knows_cooper" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_cooper_goal_k" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_cooper_knows_cooper_kill" } })) }),
        },
        {
            text = ccb.content.text("Why do you kill people?"),
            next_topic = "TALK_COOPER_GOAL",
            when = predicates.all({ predicates.negate(predicates.has_trait("speaker", "seer_mark")), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cooper" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_cooper_knows_cooper" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_cooper_goal_k" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_cooper_knows_cooper_kill" } }) }),
        },
        {
            text = ccb.content.text("Could you tell me about yourself?"),
            next_topic = "TALK_COOPER_ABOUT",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cooper" } }) }),
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cooper" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cooper_cooper_friendly" } })) }),
        },
        {
            text = ccb.content.text("Remind me what happened between you and Brigitte."),
            next_topic = "TALK_COOPERS_SIDE",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cooper" } }), predicates.has_trait("speaker", "seer_mark") }),
        },
        {
            text = ccb.content.text("I've been thinking about what you do.  I can't let you keep hurting people.  You have to be stopped."),
            next_topic = "TALK_COOPER_FIGHT",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cooper" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_cooper_knows_cooper_kill" } }) }),
        },
        {
            text = ccb.content.text("Could you remind me of your goal again?"),
            next_topic = "TALK_COOPER_GOAL",
            when = predicates.all({ predicates.negate(predicates.has_trait("speaker", "seer_mark")), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cooper" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_cooper_goal_k" } }) }),
        },
        {
            text = ccb.content.text("You mentioned that you have a goal.  What is that exactly?"),
            next_topic = "TALK_COOPER_GOAL",
            when = predicates.all({ predicates.negate(predicates.has_trait("speaker", "seer_mark")), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cooper" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_cooper_goal_dk" } }) }),
        },
        {
            text = ccb.content.text("The woman you mentioned - Brigitte - why isn't she with you?"),
            next_topic = "TALK_COOPERS_SIDE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_cooper_goal_k" } }),
        },
        {
            text = ccb.content.text("I was just checking in.  Take care."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cooper" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cooper_cooper_friendly" } }) }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_KNOWS_COOPER1",
    line = ccb.content.text("I suppose she probably said I'm some sort of a maniac and that you should kill me on the spot, correct?"),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "dialogue_cooper_confronted_cooper", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("I want to hear your side of the story.  You make it sound like it's not so cut and dry."),
            next_topic = "TALK_COOPERS_SIDE",
        },
        {
            text = ccb.content.text("You kill innocent people and butcher them like animals.  I don't care what you say.  You have to be stopped."),
            next_topic = "TALK_COOPER_FIGHT",
        },
    },
}
