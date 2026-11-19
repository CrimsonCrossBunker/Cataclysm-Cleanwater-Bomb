local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_3_DOCTORATE",
    line = ccb.content.text("Yeah, yeah, it's all very glamorous.  Sure, I trained in the great ivory tower, got my PhD in mycology.  Did my dissertation on signaling pathways in hyphae formation, and a postdoc in plant-fungus communication in rhizomes.  Then I got the job at the bookstore because there wasn't a ton of work for a doctor of mycology, although I'd had a few nibbles before things really got crazy.  Now, people are just breaking down my door to get my sweet sweet knowledge of mold to help them fight the incoming zombie threat."),
    replies = {
        {
            text = ccb.content.text("Do you know about the fungal zombies though?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_MYCUS1",
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
    id = "TALK_REFUGEE_BEGGAR_3_DOCTORATE1",
    line = ccb.content.text("Heh.  Yeah, that was a great use of my time.  As you can see it really helped my employment prospects.  Yeah, I have a PhD in mycology.  Did my dissertation on signaling pathways in hyphae formation, and a postdoc in plant-fungus communication in rhizomes.  Then I got the job at the bookstore because there wasn't a ton of work for a doctor of mycology, although I'd had a few nibbles before things really got crazy.  Now, people are just breaking down my door to get my sweet sweet knowledge of mold to help them fight the incoming zombie threat."),
    replies = {
        {
            text = ccb.content.text("Do you know about the fungal zombies though?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_MYCUS1",
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
    id = "TALK_REFUGEE_BEGGAR_3_MYCUS1",
    line = ccb.content.text("No, no I don't, and I'd appreciate you not leaving me hanging on that.  There are fungal zombies?"),
    replies = {
        {
            text = ccb.content.text("Encroaching alien mushrooms, fungal towers, tough mycelium invading ground and trees, zombies taken over by aggressive mold… Yeah.  It's ugly stuff."),
            next_topic = "TALK_REFUGEE_BEGGAR_3_MYCUS2",
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
    id = "TALK_REFUGEE_BEGGAR_3_MYCUS2",
    line = ccb.content.text("Okay, you've got my attention.  Listen, do you think you could bring me some kind of sample of these things?"),
    replies = {
        {
            text = ccb.content.text("It'd be dangerous.  What kind of benefit is there from taking a risk like that?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_MYCUS3",
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
