local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_Luo1",
    line = ccb.content.text("You kind of already know, don't you?  I used to be a post-doc researcher in mycology, then I wound up stuck in the lobby at that stupid refugee center, then you came and yeeted us all out of there.  What more is there?"),
    replies = {
        {
            text = ccb.content.text("I don't remember, did you tell me how you wound up in that place?"),
            next_topic = "BGSS_Luo2",
        },
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "BGSS_Luo_Expertise",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_Luo2",
    line = ccb.content.text("Pretty sure I did, but I do love hearing the sound of my own voice.  I got evacuated on to the local concentration center, then picked up on a repurposed school bus and dragged out to that shithole.  We heard the place was getting more people than they could fit, and the few who'd got there first had set up some sort of self-appointed processing lineup.  The chick processing me to get in saw my Chinese name and conveniently 'lost' my paperwork.  I was sent out to the lobby to wait for 'further processing', while I watched busloads of people get processed and taken in.  By the time they 'found' my paperwork, wouldn't you know it, the place was too full for me.  They oh-so-kindly let me camp out in the front since I'd been on one of the first buses."),
    replies = {
        {
            text = ccb.content.text("You think you were treated like that because of your race?"),
            next_topic = "BGSS_Luo2_Racism",
        },
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "BGSS_Luo_Expertise",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_Luo2_Racism",
    line = ccb.content.text("I can read the newspapers as well as anyone, I know how people who look like me get smeared.  My grandparents were from China.  That means I'm obviously personally responsible for all this.  I don't know any other reason they let hundreds of other educated people in and left me sitting out there to rot."),
    replies = {
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "BGSS_Luo_Expertise",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_Luo_Expertise",
    line = ccb.content.text("Well, before <the_cataclysm> I was working at a university bookstore, remember?  But that was just an in-between after finishing my PhD, while I looked for a post-doc placement I was interested in.  Which, I suppose, I've got now?  You didn't recruit my for my fragile body, intractable obesity, or sunny disposition."),
    replies = {
        {
            text = ccb.content.text("How do you know I didn't recruit you for your sass, though?"),
            next_topic = "BGSS_Luo_Expertise_Sass",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_Luo_Expertise_Sass",
    line = ccb.content.text("*gives a single rough laugh.  \"Fair call, sass like mine is what will get us through these trying times.\""),
    replies = { { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" } },
}
