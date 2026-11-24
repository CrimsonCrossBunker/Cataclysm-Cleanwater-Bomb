local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "BGSS_RURAL_1_STORY1",
    line = {
        choices = {
            {
                when = predicates.actor_state("interlocutor", "female"),
                yes = ccb.content.text("I lived alone, on the old family property way out in the middle of nowhere.  My husband passed away a bit over a month before this started… cancer.  If anything good has come out of all this, it's that I finally see a positive to losing him so young.  I'd been shut in for a while anyway.  When I heard about foreign weapons and sleeper agents, and rioting and such, I curled up with my woods soup and tried not to worry."),
                no = ccb.content.text("I lived alone, on the old family property way out in the middle of nowhere.  My wife passed away a bit over a month before this started… cancer.  If anything good has come out of all this, it's that I finally see a positive to losing her so young.  I'd been shut in for a while anyway.  When I heard about foreign weapons and sleeper agents, and rioting and such, I curled up with my woods soup and tried not to worry."),
            },
        },
    },
    replies = {
        { text = ccb.content.text("What happened next?"), next_topic = "BGSS_RURAL_1_STORY2" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_RURAL_1_STORY2",
    line = ccb.content.text("Well, it built up a bit.  There was that acid rain, it burnt up my crops.  Not that I'd been working the fields since… well, it'd been a terrible year and I hadn't done much worth doing.  There were explosions and things, and some strange sounds.  I was scared, kept to my shelter, practicing on my flute.  Then, one day, it was quiet."),
    replies = {
        { text = ccb.content.text("What happened next?"), next_topic = "BGSS_RURAL_1_STORY3" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_RURAL_1_STORY3",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_BGSS_rural_1_started_quest" } }),
        yes = ccb.content.text("That was the first thing to really shake me out of it.  I didn't really have any very close friends, but there were people I cared about a bit.  I started to worry about them.  I headed out, but everything seemed different to me.  Didn't get far before I bumped into a giant fly buzzing, and that's when I started to put it all together.  Never did see my friends again.  My place was trashed anyway, so I wandered on.  And now I'm here with you."),
        no = ccb.content.text("That was the first thing to really shake me out of it.  I didn't really have any very close friends, but there were people I cared about a bit.  I started to worry about them.  I headed out, but everything seemed different to me.  Didn't get far before I bumped into a giant fly buzzing, and that's when I started to put it all together.  Never did see my friends again.  My place was trashed anyway, so I've just been wandering since."),
    },
    replies = {
        {
            text = ccb.content.text("Thanks for telling me that.  <done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
