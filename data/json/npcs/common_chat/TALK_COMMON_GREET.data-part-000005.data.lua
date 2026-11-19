local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_WEAPON_DROPPED",
    line = {
        when = predicates.actor_state("interlocutor", "male"),
        yes = ccb.content.text("*drops his weapon."),
        no = ccb.content.text("*drops her weapon."),
    },
    replies = {
        {
            text = ccb.content.text("Now get out of here."),
            next_topic = "TALK_DONE",
            native_actions = { "flee" },
            opinion = { trust = -1, fear = -2, anger = -2 },
        },
    },
}
