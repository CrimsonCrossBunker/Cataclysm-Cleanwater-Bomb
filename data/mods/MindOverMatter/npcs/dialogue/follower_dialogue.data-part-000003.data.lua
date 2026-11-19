local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_PERSUADE_VITAKINETIC_HEALING",
    line = ccb.content.text("You're going to what?  How are you going to do that?"),
    replies = {
        {
            text = ccb.content.text("You've seen what I can do, right?  Let me try.  (Note: By doing this you will absorb <npc_name>'s disease into yourself.)"),
            trial = {
                kind = "persuade",
                difficulty = 0,
                modifiers = {
                    { score = "TRUST", scale = 6 },
                    { score = "VALUE", scale = 2 },
                    { score = "ANGER", scale = -6 },
                },
            },
            success = { next_topic = "TALK_ACCEPT_VITAKINETIC_HEALING" },
            failure = {
                next_topic = "TALK_DENY_VITAKINETIC_HEALING_NON_PERSUADE",
                actions = {
                    actions.add_effect("interlocutor", "asked_to_vitakinetic_heal", { turns = 86400 }),
                },
            },
        },
        { text = ccb.content.text("Never mind then."), next_topic = "TALK_FRIEND" },
        { text = ccb.content.text("Forget it, let's get going."), next_topic = "TALK_DONE" },
    },
}
