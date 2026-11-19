local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_HOMELESS_SURVIVOR_STORY",
    line = {
        choices = {
            ccb.content.gendered_line("I was homeless before everything went down, just camping out here for a while.  Stuck up <name_b>s shunned me for my condition, but they're all dead now.  I guess I'm better off than they are.", { "interlocutor" }),
            ccb.content.gendered_line("I guess you probably wouldn't have noticed this place before shit hit the fan, but I've been down here for quite a while.", { "speaker" }),
            ccb.content.text("Nothing to it.  Before <the_cataclysm>, it didn't take much to find yourself here.  And I guess it just made sense to stay.  We seem to be doing better than most, anyway."),
            ccb.content.text("Surviving, as I always have.  Is that what you mean?"),
            ccb.content.gendered_line("It's hard to say exactly what I'm doing out here, but I guess one thing just leads to another and… well, you're just being nice when you ask, aren't you?  It doesn't matter now anyway.  I'm here and I'm still alive.", { "interlocutor" }),
        },
    },
    replies = { { text = ccb.content.text("Hm."), next_topic = "TALK_NONE" } },
}
