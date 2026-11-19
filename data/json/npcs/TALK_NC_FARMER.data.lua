local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_NC_FARMER",
    line = ccb.content.gendered_line("Are you one of them?", { "speaker" }),
    replies = {
        { text = ccb.content.text("One of who?"), next_topic = "TALK_NC_FARMER_INTRO" },
        {
            text = ccb.content.text("My thoughts exactly.  We have a lot in common, we should travel together!"),
            next_topic = "TALK_SUGGEST_FOLLOW",
        },
        {
            text = ccb.content.text("A daring trader?  Yes.  Let's trade items."),
            next_topic = "TALK_NONE",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NC_FARMER_INTRO",
    line = ccb.content.gendered_line("Hey, you're alive!  Me too.  Been a long while since I've had a conversation.  Uh, with someone else.  Um.", { "interlocutor", "speaker" }),
    replies = {
        {
            text = ccb.content.text("It's not safe here anymore, you need to move on."),
            next_topic = "TALK_NC_FARMER_LEAVE",
        },
        { text = ccb.content.text("How did you make it?"), next_topic = "TALK_NC_FARMER_STORY1" },
        {
            text = ccb.content.text("What did you do before the Cataclysm?"),
            next_topic = "TALK_NC_FARMER_EXPERTISE",
        },
        {
            text = ccb.content.text("Have anything to trade?"),
            next_topic = "TALK_NONE",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NC_FARMER_LEAVE",
    line = ccb.content.gendered_line("I heard it's bad in the cities, back when the radio was still working.  Some of those things came through here.  I want to stay out in the country if I can stay safe.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("What did you do before the Cataclysm?"),
            next_topic = "TALK_NC_FARMER_EXPERTISE",
        },
        { text = ccb.content.text("Wanna get outta here?"), next_topic = "TALK_SUGGEST_FOLLOW" },
        {
            text = ccb.content.text("Let's trade items."),
            next_topic = "TALK_NONE",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NC_FARMER_STORY1",
    line = ccb.content.text("One of the nice things about the country life is the troubles of the world take a little longer to reach you, and some don't get you at all.  We didn't see any dead the first day, but we heard all kinds of crazy things on the news."),
    replies = {
        { text = ccb.content.text("What happened next?"), next_topic = "TALK_NC_FARMER_STORY2" },
        {
            text = ccb.content.text("What did you do before the Cataclysm?"),
            next_topic = "TALK_NC_FARMER_EXPERTISE",
        },
        {
            text = ccb.content.text("Let's trade items."),
            next_topic = "TALK_NONE",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NC_FARMER_STORY2",
    line = ccb.content.text("Come a little closer, I don't want to make too much noise.  You smell much nicer than what I'm used to.  Someone in trouble banged on the door that night, she said she was desperate, she had a baby, her home had burned down and her drugs were gone and there were monsters in the streets.  We figured she was on drugs, but we couldn't turn them away so we gave them food and let them stay in the barn."),
    replies = {
        {
            text = ccb.content.text("That's decent, was she all right?"),
            next_topic = "TALK_NC_FARMER_STORY3",
        },
        {
            text = ccb.content.text("What did you do before the Cataclysm?"),
            next_topic = "TALK_NC_FARMER_EXPERTISE",
        },
        {
            text = ccb.content.text("Let's trade items."),
            next_topic = "TALK_NONE",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NC_FARMER_STORY3",
    line = ccb.content.text("She was not all right.  I don't know what happened, if she was already turning or if something got in and got her, but she and the baby didn't make it.  We lost some more people trying to figure that out, it was horrible."),
    replies = {
        { text = ccb.content.text("Are you all right?"), next_topic = "TALK_NC_FARMER_STORY4" },
        {
            text = ccb.content.text("What did you do before the Cataclysm?"),
            next_topic = "TALK_NC_FARMER_EXPERTISE",
        },
        {
            text = ccb.content.text("Let's trade items."),
            next_topic = "TALK_NONE",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NC_FARMER_STORY4",
    line = ccb.content.gendered_line("I'm a lot better now, I've been hunkering down here.  Something came by in the night screaming and crying, sounded just like that woman.  Maybe a ghost, I don't know.  It's good to have company again.  You're not a ghost, right?  On second thought, don't tell me if you are, I probably don't want to know.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("What did you do before the Cataclysm?"),
            next_topic = "TALK_NC_FARMER_EXPERTISE",
        },
        {
            text = ccb.content.text("Let's trade items."),
            next_topic = "TALK_NONE",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NC_FARMER_EXPERTISE",
    line = ccb.content.gendered_line("I grew up on the farm, I don't know much about ghosts and goblins, but I've spent a lot of time growing food and I work hard.  It's better in the country, cleaner.  Not as dangerous.  I hope.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Why don't you go somewhere else?"),
            next_topic = "TALK_NC_FARMER_LEAVE",
        },
        { text = ccb.content.text("Wanna get outta here?"), next_topic = "TALK_SUGGEST_FOLLOW" },
        {
            text = ccb.content.text("Let's trade items."),
            next_topic = "TALK_NONE",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
