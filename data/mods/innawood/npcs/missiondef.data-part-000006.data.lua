local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

-- MISSION_PYROMANIAC mission set this topic as starting topic for mission giver.
ccb.content.define_dialogue_topic {
    id = "MISSION_PYROMANIAC",
    line = ccb.content.text("Are we there yet, <name_g>?  I can't wait to burn that tree!"),
    replies = {
        {
            text = ccb.content.text("We're here.  Let's do it!"),
            next_topic = "TALK_MISSION_INQUIRE",
            when = predicates.all({ predicates.actor_state("interlocutor", "mission_complete"), predicates.has_inventory("speaker", "tinder", 1) }),
        },
    },
}
