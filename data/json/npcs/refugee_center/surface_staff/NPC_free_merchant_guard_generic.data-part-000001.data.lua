local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_GUARD",
    line = {
        choices = {
            ccb.content.text("I'm not in charge here, you're looking for someone else…"),
            ccb.content.text("Keep civil or I'll bring the pain."),
            ccb.content.text("Just on watch, move along."),
            ccb.content.text("Don't distract me.  I'm on watch."),
            {
                when = predicates.conversation_state("daylight"),
                yes = { choices = { ccb.content.text("Hello.  Welcome to our safe zone.") } },
                no = { choices = { ccb.content.text("Good evening.  Welcome to our safe zone.") } },
            },
            {
                when = predicates.actor_state("speaker", "male"),
                yes = {
                    choices = { ccb.content.text("Sir."), ccb.content.text("Rough out there, isn't it?") },
                },
                no = {
                    choices = {
                        ccb.content.text("Ma'am"),
                        ccb.content.text("Ma'am, you really shouldn't be traveling out there."),
                    },
                },
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("I'm trying to put a cleanup crew together to tidy up the back room.  Can you offer any help?"),
            when = predicates.all({ predicates.has_mission("MISSION_REFUGEE_Boris_CLEANUP"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_Boris_mission_1_cleanup_asked" } })) }),
            next_topic = "TALK_GUARD_Boris_Mission_1",
        },
        {
            text = ccb.content.text("How did you get saddled with guard duty?"),
            next_topic = "TALK_GUARD_FM_BACKGROUND",
        },
        {
            text = ccb.content.text("Heard anything about an helicopter crash?"),
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "sunken_helicopter_tip_offer" } }), predicates.negate(predicates.has_mission("MISSION_FIND_SUNKEN_HELICOPTER")) }),
            next_topic = "TALK_GUARD_FM_SUNKEN_HELICOPTER_ANECDOTE",
        },
        { text = ccb.content.text("Don't mind me…"), next_topic = "TALK_DONE" },
    },
}
