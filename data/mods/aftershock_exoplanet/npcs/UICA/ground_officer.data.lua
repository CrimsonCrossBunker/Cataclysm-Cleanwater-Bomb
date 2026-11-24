local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

-- A generic commanding officer for UICA ground installations.
ccb.content.define_npc {
    id = "uica_ground_officer",
    suffix = ccb.content.text("UICA Officer"),
    class = "NC_UICA_GROUND_SOLDIER",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_UICA_GROUND_OFFICER",
    faction = "UICA",
}

ccb.content.define_dialogue_topic {
    id = "TALK_UICA_GROUND_OFFICER",
    line = {
        choices = {
            ccb.content.text("Can I help you salvor?"),
            ccb.content.text("Not right now, I'm busy."),
            {
                when = predicates.actor_state("speaker", "male"),
                yes = { choices = { ccb.content.text("Sir.") } },
                no = { choices = { ccb.content.text("Ma'am") } },
            },
        },
    },
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}
