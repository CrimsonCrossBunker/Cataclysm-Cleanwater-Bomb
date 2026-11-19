local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_2_JOBSDONE",
    line = {
        joined = {
            ccb.content.text("Well… I had it all pretty together, "),
            {
                when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_recruit_beggars_recruited" } }),
                yes = ccb.content.text("but the others have left, and "),
                no = ccb.content.text("and I feel bad with all the help you've given me already, but "),
            },
            ccb.content.text("now the masters won't let me build my sanctuary.  I know I can't build it in here, they wouldn't allow it.  They won't listen to me when I ask for a safe place.  They just want me to disappear, like the others.  Can you help me figure them out?"),
        },
    },
    replies = {
        {
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_recruit_beggars_recruited" } })),
            text = ccb.content.text("Why don't you leave this place?  Come with me, I could use some help out there."),
            next_topic = "TALK_REFUGEE_BEGGAR_2_JOIN",
        },
        {
            text = ccb.content.text("Sure, Dave.  One last favor, I think I can talk to Smokes about finding you a place to go."),
            actions = { actions.assign_mission("MISSION_BEGGAR_2_PERMISSION") },
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("I'll have to think on that, Dave, I've done a lot already."),
            next_topic = "TALK_DONE",
        },
    },
}
