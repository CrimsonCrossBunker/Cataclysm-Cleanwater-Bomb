local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

-- A generic guard for port augustmoon.
ccb.content.define_npc {
    id = "augustmoon_security",
    suffix = ccb.content.text("Augustmoon Security"),
    class = "NC_UICA_NAVAL_POLICE",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_AUGUSTMOON_SECURITY",
    faction = "UICA",
}

ccb.content.define_dialogue_topic {
    id = "TALK_AUGUSTMOON_SECURITY",
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
