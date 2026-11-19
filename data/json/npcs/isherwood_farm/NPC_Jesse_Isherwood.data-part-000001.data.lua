local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_JESSE_TALK1",
    line = ccb.content.text("It would be a lot harder without family.  Keeping the animals safe is essential to our future."),
    replies = {
        {
            text = ccb.content.text("Sounds like you are betting on civilization not coming back."),
            next_topic = "TALK_ISHERWOOD_JESSE_OPINION",
        },
        {
            text = ccb.content.text("Do you have any animal care tips?"),
            next_topic = "TALK_ISHERWOOD_JESSE_TIPS",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_JESSE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_JESSE_OPINION",
    line = ccb.content.text("We can't wait for someone else to fix things, we need to take care of ourselves."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_JESSE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_JESSE_TIPS",
    line = ccb.content.text("Horses make good all around companions.  They can get places that cars can't and also help when all the engines fail.  They become very trusting if you feed them some nice fodder."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_JESSE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MET_JACK_CLAIRE",
    line = ccb.content.text("Oh good, I'm sure Jack wanted to put you to work.  If you're interested, I could use a hand clearing out the woods.  My son, Chris has his hands full trying to keep the predators under control."),
    replies = {
        {
            text = ccb.content.text("I'd like to speak with Carlos too about some work."),
            next_topic = "TALK_JESSE_CARLOS1",
        },
        {
            text = ccb.content.text("Is Chris around?  I'd like to know what he's run into out in the woods."),
            next_topic = "TALK_JESSE_CHRIS",
        },
        { text = ccb.content.text("What needs killing?"), next_topic = "TALK_MISSION_LIST" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_JESSE_TOPICS",
        },
        {
            text = ccb.content.text("I'm not interested right now.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_JESSE_CARLOS1",
    line = ccb.content.text("He's out back in the workshop."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_JESSE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_JESSE_CHRIS",
    line = ccb.content.text("He's out doing some surveying, we are planning on adding a fence line and some defenses."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_JESSE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_JESSE_CARLOS2",
    line = ccb.content.text("Carlos will be in his workshop if he isn't out hunting.  He is trying to get a forge set up."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_JESSE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_LEAVE_NOW_MARSHAL",
    line = ccb.content.text("You should get off my farm, I won't deal with a government stooge."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_JESSE_TOPICS",
    line = ccb.content.text("Go on…"),
    replies = {
        {
            text = ccb.content.text("Looks like you are doing well here."),
            next_topic = "TALK_ISHERWOOD_JESSE_TALK1",
        },
        {
            text = ccb.content.text("Do you have any animal care tips?"),
            next_topic = "TALK_ISHERWOOD_JESSE_TIPS",
        },
        {
            text = ccb.content.text("Jack and Claire suggested I come talk to you."),
            next_topic = "TALK_MET_JACK_CLAIRE",
        },
        {
            text = ccb.content.text("I'd like to speak with Carlos too about some work."),
            next_topic = "TALK_JESSE_CARLOS2",
        },
        { text = ccb.content.text("Is Chris around?"), next_topic = "TALK_JESSE_CHRIS" },
        { text = ccb.content.text("Can I do anything for you?"), next_topic = "TALK_MISSION_LIST" },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
