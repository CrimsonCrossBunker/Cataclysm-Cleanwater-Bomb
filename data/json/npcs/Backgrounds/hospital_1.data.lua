local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_HOSPITAL_1_STORY1",
    line = ccb.content.gendered_line("I saw it all pretty early, before it all really started.  I worked at the hospital.  It started with a jump in the number of code whites - that's an aggressive patient.  Wasn't my training so I didn't hear about it until later… but rumors started flying about hyperaggressive delirious patients that coded and seemed to die, then started attacking staff, and wouldn't respond to anything we hit them with.  Then a friend of mine was killed by one of them, and I realized it wasn't just a few weird reports.  I called in sick the next day.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("What happened on your sick day?"),
            next_topic = "BGSS_HOSPITAL_1_STORY2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_HOSPITAL_1_STORY2",
    line = ccb.content.gendered_line("Well, <the_cataclysm>.  I lived a fair distance out of town, and I already knew something was seriously wrong, but I hadn't admitted to myself what I was really seeing quite yet.  When I saw the military convoys pouring into the city, I put the pieces together.  At first I thought it was just my hospital.  Still, I packed up my bags, locked the doors and windows, and waited for the evacuation call.", { "interlocutor" }),
    replies = {
        { text = ccb.content.text("Did you get evacuated?"), next_topic = "BGSS_HOSPITAL_1_STORY3" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_HOSPITAL_1_STORY3",
    line = ccb.content.gendered_line("No.  The call came too late.  I'd already seen the clouds on the horizon.  Mushroom clouds, and also those insane hell-clouds.  I've heard that horrible things came out of them.  I decided it was safer in my locked up house.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Something must have happened to drive you out?"),
            next_topic = "BGSS_HOSPITAL_1_STORY4",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_HOSPITAL_1_STORY4",
    line = ccb.content.gendered_line("The military happened.  They showed up and commandeered my land for some kind of forward base, demanding I evacuate to a FEMA camp.  I didn't even try to argue… I had my dad's old hunting rifle, they had high tech weapons.  I heard one of them joking about the FEMA camp being Auschwitz, though.  I gave their evac driver the slip and decided to make for my sister's place up north.  In theory I guess I'm still going that way, although honestly I'm just busy not dying.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
