local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chef_get_food_bribe",
    line = ccb.content.text("No, I wouldn't.  Like I said, we don't have any to spare."),
    replies = {
        {
            text = ccb.content.text("Is there any way I could join the community?"),
            next_topic = "TALK_GODCO_chef_join",
        },
        { text = ccb.content.text("It was worth a shot, I guess."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chef_katherine",
    line = ccb.content.text("She's my wife, worked for the Church before <the_cataclysm>.  She used to organize charities for the needy, now we're the ones in need of charity.  She has a bit of a high horse these days, but a nice lady once you get to know her.  We've been married for 28 years, and I couldn't ask for a better wife."),
    replies = {
        { text = ccb.content.text("Who's Jeremiah?"), next_topic = "TALK_GODCO_chef_jeremiah" },
        {
            text = ccb.content.text("That's good to hear.  <done_conversation_section>"),
            next_topic = "TALK_GODCO_chef_idle_chat",
        },
        {
            text = ccb.content.text("That's good to hear, but I gotta go."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chef_jeremiah",
    line = ccb.content.text("Jeremiah is my son, he's a sweet boy and all grown up now.  We taught him everything he knows, and we all had high hopes for how he could make it in the world, before <the_cataclysm> took it away.  He doesn't like his mother, Katherine, very much, and I've tried to help the two, but they can't seem to properly get along."),
    replies = {
        { text = ccb.content.text("Who's Katherine?"), next_topic = "TALK_GODCO_chef_katherine" },
        {
            text = ccb.content.text("Why would they have an issue with each other?"),
            next_topic = "TALK_GODCO_chef_k&j_conflict",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_chef_idle_chat",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chef_k&j_conflict",
    line = ccb.content.text("Katherine is a bit overprotective of him, and ever since <the_cataclysm>, she's become extremely worried for his safety.  He wants more independence, seein' as how he's grown now, but she won't leave him be.  She tells me that someone needs to keep an eye on him, so she took it upon herself to do so.  I think she has the best intentions at heart, I know she loves him dearly, but the boy needs to figure out some things on his own."),
    replies = {
        {
            text = ccb.content.text("Could you tell me more about Katherine?"),
            next_topic = "TALK_GODCO_chef_katherine",
        },
        {
            text = ccb.content.text("Could you tell me more about Jeremiah?"),
            next_topic = "TALK_GODCO_chef_jeremiah",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_chef_idle_chat",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chef_get_food_family",
    line = ccb.content.text("Look, I have a family too.  I know how hard it is for you, but I've already told you, rules are rules."),
    replies = { { text = ccb.content.text("I guess I'll starve."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chef_mood",
    line = ccb.content.text("Could be better, could be worse, but I'm not complaining.  I have everything I need here; my family, a nice job, and roof over my head.  I only wish God was as forgiving to others as to me."),
    replies = { { text = ccb.content.text("Good to hear that."), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chef_join",
    line = ccb.content.text("You'd have to talk to Gemma or Julian about that.  I'm sure there's a way, though."),
    replies = { { text = ccb.content.text("Thanks for the info."), next_topic = "TALK_DONE" } },
}
