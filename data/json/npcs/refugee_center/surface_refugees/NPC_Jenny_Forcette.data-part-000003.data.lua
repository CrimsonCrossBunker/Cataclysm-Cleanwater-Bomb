local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_JENNY_Background2",
    line = ccb.content.text("*grins and tugs at her shirt, an uncharacteristically crisp white T-shirt sporting a brightly colored penguin holding a slide rule, and a rainbow slogan reading 'sudo build it the way I told you to'.  \"Ha!  You must not know many engineers, hey?  I guess there's more to me than engineering, but most of my hobbies come back to it one way or the other.  It's not that I live for my work, doing engineering for a heating company wasn't some great dream, but when I got home I'd putter with the projects I wanted to do instead of the ones they made me do.  You know?  And of course, I had my friends and things, we'd go out or hang out and play board games and stuff.  Maybe some day I'll get a board game group started up here, although there's nothing wrong with the card games we've got now.  Plus I don't think Zombicide would hold the same interest for me as it used to.\""),
    replies = {
        {
            text = ccb.content.text("What kind of board games do you play?"),
            next_topic = "TALK_REFUGEE_JENNY_Games1",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_JENNY_Survival",
    line = ccb.content.text("*shrugs, looking distant.  \"I don't really like to talk about that time much.  None of us do.  Short story is that I made it to one of the evacuation shelters and got loaded onto a bus.  It was supposed to go to some sort of FEMA support camp, but there was a roadblock on the way there.  A few people just jumped out and ran for the military for protection.  They… it… it was bad.  The driver managed to get us turned around and booked it, and I guess they didn't chase us.  She took us back to one of the shelters and we found the address for this place.  Only a few of us decided to risk it, the rest stayed at the shelter to try their luck a different way.  I still wonder how they did.\""),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_JENNY_World",
    line = ccb.content.text("Ha!  I wonder how long that's going to be one of our go-to small talk questions.  It's perfect, isn't it?  Doesn't make you talk about the worst stuff but stays on theme for what's on everyone's mind.  Okay, I'll bite.  Have you heard any of the really wild stories?  Giant monsters the size of skyscrapers kicking over tanks and stuff, during the worst days?  I think somehow our planet got moved into another dimension, probably some kind of experimental process gone wrong.  During transit, some of those things came across, but they left when we arrived wherever we are now.  The rules are different here, and maybe we're superimposed with whatever version of Earth was here to start with, and that's why we hear about aliens and other unbelievable stuff out there along with the zombies.\"  She grins.  \"And before you say that's implausible, bear in mind that *the dead walk now*, so plausibility is off the table."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
