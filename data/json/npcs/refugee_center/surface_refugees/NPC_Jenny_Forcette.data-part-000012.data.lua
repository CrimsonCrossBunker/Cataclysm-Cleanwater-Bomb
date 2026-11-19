local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_JENNY_FreeMerchants",
    line = ccb.content.text("They run this place, and they don't run a charity.  We get paid for working around the place, maintaining it, what have you, and we trade cash for food.  The thing is, supply and demand and all… there's a lot more cash than food around.  It's easier to buy a laptop than a piece of beef jerky, and there's no sign of that getting better.  The balance is way off right now, a hard day of work barely gets you enough to fill your belly.  I shouldn't bitch too much though.  I don't know much better way to run it, although rumor is that the folks living downstairs have it a lot easier than we do.  I try not to think too much on that."),
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
    id = "TALK_REFUGEE_JENNY_Refugees2_Fatima",
    line = ccb.content.text("Fatima's a sweety, but she's a total dork.  I know, I know, it's backwards for the engineer to call the heavy-duty mechanic a nerd, but hey.  I call it like it is.  She and I have been doing some odd jobs around the upstairs here, fixing up old machinery and things."),
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
    id = "TALK_REFUGEE_JENNY_Refugees2_Friends",
    line = ccb.content.text("Well, Dana lost her baby right after <the_cataclysm>, in a bus rollover.  She was lucky to make it out alive.  She and Pedro had one of the rougher trips here, I guess.  We just kinda click as friends, I'm grateful there's someone else here I can really get along with.  Her husband, Pedro, is still pretty shell-shocked.  He doesn't talk much.  I like him though, when he opens up he's just hilarious.  Draco is just a cantankerous old fart who hasn't actually got old yet, give him twenty years and he'll be there.  I like grumpy people.  We also have pretty similar taste in music.  Aleesha's a sweet kid, and we've all kind of adopted her, but she seems to hang out with me and Dana the most.  She's a great artist, and she's full of crazy ideas.  I guess I like her because of all of us, she seems to have the most hope that there's a future to be had."),
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
