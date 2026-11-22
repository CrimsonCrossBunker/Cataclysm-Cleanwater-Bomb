local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_pizzaiolo_celebrate1",
    line = ccb.content.text("Mmm, delicious.  You know, you are good friend, and a good cook.  I'm glad that I'm with you at the day like this.  Say, what do you think about me going with you?  As you can see, my restaurant is thrashes, my house ruined, the only option left is to travel somewhere, and it's better if I do it with someone."),
    on_enter = {
        { actions = { "morale_chat_activity", actions.replace_mutation("interlocutor", "BGSS_pizzaiolo") } },
    },
    replies = {
        {
            text = ccb.content.text("Sure, <name_g>.  <end_talking>"),
            next_topic = "TALK_DONE",
            actions = { "follow" },
        },
        {
            text = ccb.content.text("<end_talking_later>"),
            next_topic = "TALK_DONE",
            actions = { actions.set_first_topic("TALK_pizzaiolo_1"), actions.set_actor_value("interlocutor", "dialogue_pizzaiolo_u_helped_pizzaiolo", "yes") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_pizzaiolo_Background",
    line = ccb.content.gendered_line("I'm just a regular pizzaiolo.  My father was a pizzaiolo, my grandfather was a pizzaiolo and I also became a pizzaiolo.  I was making pizza my whole life, until some American <name_b>s ruined my business!  I couldn't do anything about this, but now, with <the_cataclysm> and <zombies> around, I have a chance to get my revenge!", { "interlocutor" }),
}
