local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_COOPER_INTRODUCTION",
    line = ccb.content.text("I scavenge only so I can survive, but I have a much greater goal than just to live."),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "dialogue_first_meeting_cooper_goal_dk", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("A… goal?  What do you mean?  What is there to do other than survive?"),
            next_topic = "TALK_COOPER_GOAL",
        },
        {
            text = ccb.content.text("Uh, okay then.  I have to go now; have a nice day."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COOPER_GOAL",
    line = ccb.content.text("Something changed during the Collapse - the apocalypse, if you prefer that.  The way the dead rise again and again, it's tied to their bones - notice that only when you pulp and crush them properly do they actually die.  A woman I met - Brigitte was her name - taught me how to use the power.  We call it the Song, since if you know how, you can hear it, a quiet hum in the bones.  If I collect enough Song, the concentrated power can reverse the Cataclysm.  Undo all of this."),
    on_enter = {
        {
            actions = {
                actions.clear_actor_value("speaker", "dialogue_first_meeting_cooper_goal_dk"),
                actions.set_actor_value("speaker", "dialogue_first_meeting_cooper_goal_k", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Do you have any proof that this will work?"),
            next_topic = "TALK_COOPER_WORK",
        },
        {
            text = ccb.content.text("You mentioned a woman, Brigitte.  Why isn't she with you?  What happened?"),
            next_topic = "TALK_COOPERS_SIDE",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_song_asked_about_song" } })),
        },
        {
            text = ccb.content.text("Wait, Brigitte LaCroix?  I've met her."),
            next_topic = "TALK_COOPER_KNOWBRIG",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_song_asked_about_song" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cooper_cooper_friendly" } })) }),
        },
        { text = ccb.content.text("That's insane.  I'm going."), next_topic = "TALK_DONE" },
    },
}
