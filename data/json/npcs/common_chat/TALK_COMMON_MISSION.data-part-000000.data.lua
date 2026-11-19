local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

-- ["The responses here are currently merged with the built in responses as not all", "responses for the topics here have been moved to json.", "Some of the topics here can be moved to NPC type specific files later."]
-- Generic responses for NPCs that can have missions
ccb.content.define_dialogue_topic {
    id = {
        "TALK_SHELTER", "TALK_EVAC_MERCHANT", "TALK_FREE_MERCHANTS_MERCHANT", "TALK_ARSONIST",
        "TALK_OLD_GUARD_REP", "TALK_EVAC_GUARD2", "TALK_RANCH_FOREMAN", "TALK_RANCH_CROP_OVERSEER",
        "TALK_CITY_COP",
    },
    replies = {
        {
            text = ccb.content.text("About that job…"),
            next_topic = "TALK_MISSION_INQUIRE",
            when = predicates.assigned_missions(1, 1),
        },
        {
            text = ccb.content.text("About one of those jobs…"),
            next_topic = "TALK_MISSION_LIST_ASSIGNED",
            when = predicates.assigned_missions(2),
        },
    },
}
