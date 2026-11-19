local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Zachary_Intro_2",
    line = {
        when = predicates.has_mission("MISSION_GODCO_ZACHARY_KILL_NIGHTMARE"),
        yes = ccb.content.text("I ain't leaving, <name_g>.  Not until you or someone else has checked out that nightmare for me."),
        no = {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_meeting_zachary_willing_to_follow" } }),
            yes = ccb.content.text("Thanks, <name_g>.  I sure owe you one."),
            no = ccb.content.text("I ain't leaving, <name_g>.  Not until that eldritch screeching nightmare is dead 'n buried."),
        },
    },
    replies = {
        {
            text = ccb.content.text("What nightmare?"),
            when = predicates.all({ predicates.negate(predicates.has_mission("MISSION_GODCO_ZACHARY_KILL_NIGHTMARE")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_meeting_zachary_willing_to_follow" } })) }),
            next_topic = "TALK_GODCO_Zachary_Nightmare",
        },
        { text = ccb.content.text("I'll see you around then."), next_topic = "TALK_DONE" },
    },
}
