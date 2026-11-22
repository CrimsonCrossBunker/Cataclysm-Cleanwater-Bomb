local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_VAMPIRE_HUNTER_LEADER_WHY_NO_VAMPIRES",
    line = {
        choices = {
            ccb.content.text("It has happened so many times.  A new recruit thinks they can beat fire with fire and goes past the point of no return.  When it happens, they either become another vampire or a killer of hunters.\n\nFor everyone's sake, I won't let you go down that path no matter what I must do."),
        },
    },
    replies = {
        {
            text = ccb.content.text("Okay, I'll get cured.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("It won't happen to me, though."),
            next_topic = "TALK_VAMPIRE_HUNTER_LEADER_ULTIMATUM",
            opinion = { trust = -1, value = -1, anger = 1 },
        },
        {
            text = ccb.content.text("I won't take the cure.  There's nothing you can do about it."),
            next_topic = "TALK_DONE",
            actions = { "hostile", actions.handler("w16b_a_xedra_evolved_c68b966624c1") },
            opinion = { trust = -30, value = -30, anger = 30 },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_VAMPIRE_HUNTER_LEADER_ULTIMATUM",
    line = {
        choices = {
            ccb.content.text("They all said that, but it happened to each of them.  I won't ask again.  If you refuse the cure, we will have no choice but to kill you."),
        },
    },
    replies = {
        {
            text = ccb.content.text("Okay, I'll get cured.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("I won't take the cure.  There's nothing you can do about it."),
            next_topic = "TALK_DONE",
            actions = { "hostile", actions.handler("w16b_a_xedra_evolved_c68b966624c1") },
            opinion = { trust = -30, value = -30, anger = 30 },
        },
    },
}
