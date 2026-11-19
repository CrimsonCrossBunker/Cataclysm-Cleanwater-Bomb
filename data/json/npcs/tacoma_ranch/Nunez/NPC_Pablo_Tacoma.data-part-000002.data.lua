local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_TACOMA_Pablo_2",
    line = ccb.content.text("Can't complain,\" he stretches his neck and pops his shoulder.  \"No, really, I can't.  The work is hard, but people here really want to *do* something, not just hide inside and hope someone saves us.  I've been helping doing general labor a bit, but also working out an inventory system for our supplies.  It's already helped us get a few important bits in earlier than we'd have noticed otherwise.  Post-apocalyptic accounting, ha!  Who'd have thought?"),
    replies = {
        {
            text = ccb.content.text("Keeping inventory is similar to accounting?  Really?"),
            next_topic = "TALK_TACOMA_Pablo_Accounting1",
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
    id = "TALK_TACOMA_Pablo_Accounting1",
    line = ccb.content.text("If you want the honest truth, only a bit.  It's not much like filing income tax.  Still, I know my way around a spreadsheet and I don't mind staring at numbers all day.  I think people were dubious at first, but now that it's starting to show real value they're coming around."),
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
    id = "TALK_TACOMA_Pablo_Trailer1",
    line = ccb.content.text("Oh, Dana tells that story better than me.  Basically we found it at an old trailer park and she liked the bakery, so we figured out a way to get it back here.  We definitely earned some cred for coming with our own shelter."),
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
    id = "TALK_TACOMA_Pablo_Bakery1",
    line = ccb.content.text("Yeah, she would say that.\"  He makes intense eye contact.  \"Not just a bakery, my friend.  A real, post apocalyptic, honest-to-god culinary experience!  We're planning to grow food and crops here.  Central's plan is to import our crops directly, and pay us for our work.  I don't think they've even thought much about transport, outside just shipping them back home.  If we do local site processing we can prevent storage losses, and make higher value material to sell out!  And Central still benefits from having a dedicated bread basket!"),
    replies = {
        {
            text = ccb.content.text("Do you know anything about building a 'culinary experience'?"),
            next_topic = "TALK_TACOMA_Pablo_Bakery2",
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
    id = "TALK_TACOMA_Pablo_Bakery2",
    line = ccb.content.text("I'm being a bit tongue-in-cheek there.  Really I want some big wood fired ovens, tools for milling grain, tinning and canning equipment, stuff like that.  We'll make flour, jam, pickles, bread, maybe some sauerkraut and things.  All the old school ways of preserving food, from before fridges were commonplace."),
    replies = {
        {
            text = ccb.content.text("Okay, but do you know anything about that?"),
            next_topic = "TALK_TACOMA_Pablo_Bakery3",
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
    id = "TALK_TACOMA_Pablo_Bakery3",
    line = ccb.content.text("Well…\" he tugs jokingly at his collar as though letting off steam.  \"I know a bit.  I used to make pickles and jams as a hobby.  With my mom.  When I was a teenager.  But I know the principles!  And Dana knows more than you'd think about grain and flour because she's a huge nerd for her craft.  We do have some knowledge gaps between design and implementation though."),
    replies = {
        { text = ccb.content.text("What kind of gaps?"), next_topic = "TALK_TACOMA_Pablo_Bakery4" },
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
