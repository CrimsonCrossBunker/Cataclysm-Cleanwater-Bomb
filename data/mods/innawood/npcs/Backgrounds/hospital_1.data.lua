local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_HOSPITAL_1_STORY1",
    line = ccb.content.text("I saw it all pretty early, before it all really started.  I worked as a healer.  It started with a jump in the number of code whites - that's an aggressive patient.  Wasn't my training so I didn't hear about it until later… but rumors started flying about hyperaggressive delirious patients that coded and seemed to die, then started attacking people, and wouldn't respond to anything we hit them with.  Then a friend of mine was killed by one of them, and I realized it wasn't just a few weird reports.  I called in sick the next day."),
    replies = {
        {
            text = ccb.content.text("What happened on your sick day?"),
            next_topic = "BGSS_HOSPITAL_1_STORY2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_HOSPITAL_1_STORY2",
    line = ccb.content.text("Well, <the_cataclysm>.  I lived out in the woods, and I already knew something was seriously wrong, but I hadn't admitted to myself what I was really seeing quite yet.  When I saw the men with spears marching, I put the pieces together.  At first I thought it was just the people where I was working.  Still, I packed up my things and got ready to run."),
    replies = {
        { text = ccb.content.text("Did you get out?"), next_topic = "BGSS_HOSPITAL_1_STORY3" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_HOSPITAL_1_STORY3",
    line = ccb.content.text("No.  I'd already seen the clouds on the horizon.  Fluffy pink mushroom clouds, and also those insane fiery green hell-clouds.  I've heard that horrible things came out of them.  I decided it was safer in the woods."),
    replies = {
        {
            text = ccb.content.text("Something must have happened to drive you out?"),
            next_topic = "BGSS_HOSPITAL_1_STORY4",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_HOSPITAL_1_STORY4",
    line = ccb.content.text("The men with spears came.  They showed up and commandeered my land for some kind of special operation, demanding I evacuate to a camp.  I didn't even try to argue… I had my dad's old pistol, but they had numbers and seemed a little crazed.  I heard one of them joking about the camp being a death camp, though.  I went with them but as soon as I could I gave them the slip and decided to make for my sister's place up north.  In theory I guess I'm still going that way, although honestly I'm just busy not dying."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
