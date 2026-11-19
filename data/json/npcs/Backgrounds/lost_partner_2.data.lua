local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "BGSS_LOST_PARTNER_2_HOME2",
    line = {
        choices = {
            {
                when = predicates.actor_state("interlocutor", "female"),
                yes = ccb.content.text("I did.  Took a few hours to get an opening.  And you wanna know the fucked up part?  Like, out of all this?  My husband was still alive.  He'd been in the basement the whole time, pinned under a collapsed piece of floor.  And he'd lost a ton of blood, he was delirious by the time I found him.  I couldn't get him out, so I gave him food and water and just stayed with him and held his hand until he passed.  And then… well, then I did what you have to do to the dead now.  And then I packed up the last few fragments of my life, and I try to never look back."),
                no = ccb.content.text("I did.  Took a few hours to get an opening.  And you wanna know the fucked up part?  Like, out of all this?  My wife was still alive.  She'd been in the basement the whole time, pinned under a collapsed piece of floor.  And she'd lost a ton of blood, she was delirious by the time I found her.  I couldn't get her out, so I gave her food and water and just stayed with her and held her hand until she passed.  And then… well, then I did what you have to do to the dead now.  And then I packed up the last few fragments of my life, and I try to never look back."),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Thanks for telling me that.  <done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
