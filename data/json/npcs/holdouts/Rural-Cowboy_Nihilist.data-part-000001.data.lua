local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_COWBOYN_PARTNER",
    line = ccb.content.gendered_line("I didn't leave the town alone.  I arrived here alone.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("I'm sorry for your loss.  But you still can't give up.  You have a lot to live for!"),
            next_topic = "TALK_COWBOYN_MOTIVATEF",
        },
        {
            text = ccb.content.text("We all lost someone.  No reason to sit down and die."),
            next_topic = "TALK_COWBOYN_MOTIVATEF",
        },
        {
            text = ccb.content.text("You can't let yourself be consumed by grief.  It will get better."),
            next_topic = "TALK_COWBOYN_MOTIVATEF",
        },
        {
            text = ccb.content.text("No one gets out alive.  Always been that way.  So we keep going."),
            next_topic = "TALK_COWBOYN_MOTIVATES",
        },
        {
            text = ccb.content.text("I'm sure your loved one would want you to live on for them."),
            next_topic = "TALK_COWBOYN_MOTIVATEF",
        },
    },
}
