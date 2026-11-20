local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_BorisCleanup1",
    line = ccb.content.text("That's enough to get someone off guard duty, yeah.  Hand it here and I'll set it up.\"  The money exchanges hands.  \"Right.  I haven't updated this list in a while, so some people are still assigned to watch the back bay, which is technically a free shift now.  I'll let one of them know about what's up and they can spend the time helping to clean up back there.  Hope it helps."),
    replies = { { text = ccb.content.text("Thank you!"), next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Talk" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_BorisCleanup2",
    line = ccb.content.text("Woah, you're really intent, hey?  That's a lot for most people here.\"  The money exchanges hands.  \"That's enough to get two people off guard duty for an afternoon, even with all the ugliness back there.  And you know what?  I'll help out, too, so make that three.  I can appreciate someone who's willing to put their money where their mouth is."),
    replies = {
        {
            text = ccb.content.text("Thank you very much!"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Talk",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_DavePermission",
    line = ccb.content.text("*looks at you cautiously.  \"He hasn't been bothering you, has he?  Dave's usually pretty harmless.\""),
    replies = {
        {
            text = ccb.content.text("He wants permission to build himself a little shelter outside of your lobby, somewhere out of the way.  He'd need access to your washrooms and things, but you could clear him out of this space."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_DavePermission2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_nevermind>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_DavePermission2",
    line = ccb.content.text("Sure, sounds great on paper, but *where*?  We aren't swimming in real estate here, the place is seriously overcrowded.  And I won't have him living out of a soggy cardboard box on the doorstep, it's an even worse look than the lobby."),
    replies = {
        {
            text = ccb.content.text("What about the rooftop?  There's a stair access there, I can see it from outside, and he'd probably be able to do a bit of a lookout job."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_DavePermission3",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_nevermind>"),
            next_topic = "TALK_DONE",
        },
    },
}
