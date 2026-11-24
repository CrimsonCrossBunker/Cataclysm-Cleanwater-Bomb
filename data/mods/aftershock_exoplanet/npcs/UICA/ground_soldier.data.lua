local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

-- A generic guard for uica ground installations.
ccb.content.define_npc {
    id = "uica_ground_soldier",
    suffix = ccb.content.text("UICA Installation Security"),
    class = "NC_UICA_GROUND_SOLDIER",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_UICA_GROUND_SOLDIER",
    faction = "UICA",
}

ccb.content.define_dialogue_topic {
    id = "TALK_UICA_GROUND_SOLDIER",
    line = {
        choices = {
            ccb.content.text("Keep it civil, salvor."),
            ccb.content.text("Just on watch, move along."),
            {
                when = predicates.actor_state("speaker", "male"),
                yes = { choices = { ccb.content.text("Sir.") } },
                no = { choices = { ccb.content.text("Ma'am") } },
            },
        },
    },
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}
