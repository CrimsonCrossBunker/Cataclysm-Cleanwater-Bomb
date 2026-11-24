local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

-- A generic commanding officer for UICA ground installations.
ccb.content.define_npc {
    id = "uica_ground_engineer",
    suffix = ccb.content.text("UICA Engineer"),
    class = "NC_UICA_GROUND_ENGINEER",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_UICA_GROUND_ENGINEER",
    faction = "UICA",
}

ccb.content.define_dialogue_topic {
    id = "TALK_UICA_GROUND_ENGINEER",
    line = {
        choices = {
            ccb.content.text("Keep it civil, salvor."),
            ccb.content.text("No time to talk now."),
            {
                when = predicates.actor_state("speaker", "male"),
                yes = { choices = { ccb.content.text("Sir.") } },
                no = { choices = { ccb.content.text("Ma'am") } },
            },
        },
    },
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}
