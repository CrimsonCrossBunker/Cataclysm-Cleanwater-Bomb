local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GLOOSCAP_MYTH_SUCCESS",
    line = ccb.content.gendered_line("I do have a twin.  Malsumis is probably around here somewhere, very tricky.  You know I turned Malsumis to stone once?  I'm supposed to be the nice one, but you know how much it hurts turning yourself back from stone?  It takes days.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("[INT 14] I'll look out then, thanks.  Of course if you were Malsumis you probably wouldn't admit it because no one likes Malsumis.  Who would your twin say you are?"),
            next_topic = "TALK_GLOOSCAP_MYTH_RIDDLE",
            actions = { actions.set_actor_value("speaker", "general_meeting_u_asked_malsumis", "yes") },
        },
        {
            text = ccb.content.text("You know you're not really Glooscap right?  You're joking right?"),
            next_topic = "TALK_GLOOSCAP_JOKING",
            actions = { actions.set_actor_value("speaker", "general_meeting_u_asked_malsumis", "yes") },
        },
        {
            text = ccb.content.text("Of course, that all makes as much sense as anything I guess.  So you have crazy supernatural powers then?  Can you stop whatever is happening and make it like before?"),
            next_topic = "TALK_GLOOSCAP_POWERS",
            actions = { actions.set_actor_value("speaker", "general_meeting_u_asked_malsumis", "yes") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GLOOSCAP_MYTH_RIDDLE",
    line = ccb.content.text("I don't know what Malsumis would say, Malsumis is very tricky.  I always tell the truth, it's very boring."),
    replies = {
        {
            text = ccb.content.text("[INT 14] I think you're Malsumis.  Where is Glooscap?"),
            next_topic = "TALK_GLOOSCAP_MYTH_ACCUSE",
            actions = { actions.set_actor_value("speaker", "general_meeting_u_accused_malsumis", "yes") },
        },
        {
            text = ccb.content.text("[INT 14] Yes, that all makes sense to me.  Forget I asked."),
            next_topic = "TALK_GLOOSCAP",
        },
        {
            text = ccb.content.text("I don't have time for this.  I have serious survival business to do.  I am a serious survival business person."),
            next_topic = "TALK_DONE",
        },
    },
}
