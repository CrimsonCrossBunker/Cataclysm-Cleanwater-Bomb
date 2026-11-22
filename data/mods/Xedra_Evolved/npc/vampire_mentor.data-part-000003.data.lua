local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_KILLING" },
    line = ccb.content.text("There are many vampires in this place.  Feel free to kill the others, I am not affiliated with them."),
    replies = {
        {
            text = ccb.content.text("I'm here to kill all vampires, no exceptions.  Prepare to die."),
            next_topic = "TALK_DONE",
            actions = { "hostile", actions.handler("dlg_a_xedra_evolved_53c17c81e090") },
        },
        {
            text = ccb.content.text("You seem more reasonable than the rest.  Would you like to be cured of your curse?"),
            next_topic = "TALK_VAMPIRE_MENTOR_CURE",
        },
        {
            text = ccb.content.text("It can wait.  Can we talk?"),
            next_topic = "TALK_VAMPIRE_MENTOR_TALK",
        },
        {
            text = ccb.content.text("It can wait.  Can we discuss what you meant by \"mentor\"?"),
            next_topic = "TALK_VAMPIRE_MENTOR_MENTORING",
        },
        {
            text = ccb.content.text("I just wanted to look around.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}
