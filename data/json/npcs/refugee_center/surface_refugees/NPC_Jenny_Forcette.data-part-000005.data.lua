local ccb = require("ccb")

-- TK: Bring her a CBM to check out. Nothing useful results, it just makes her happy.
ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_JENNY_Exodii_Proof",
    line = ccb.content.text("*breathes a long, sighing curse as she examines your CBM interface.  \"Holeeeeeeshiiiiiiit.  This is amazing!  Like seriously, it's not even high tech.  At least not this part.  Can I see the schematics?  Can we dissect you?  I'm kidding.  Unless?  No, really kidding though.  Holy shit.\"  She pauses and studies you with a furrowed brow.  \"Wait, you let a strange interdimensional cyborg do brain surgery on you?  Never mind, I'd totally do that too.  Can you get me one of these?  No, I'd wind up taking it out and dismantling it.\"  She looks you up and down.  \"Thanks.  That's incredible.  It sucks that the world ended but I'm glad to know at least it ended with *cyborgs*.\""),
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
    id = "TALK_REFUGEE_JENNY_Games1",
    line = ccb.content.text("*scrunches her face in thought for a moment.  \"There was a whole world out there of weird board games for ultra nerdy people.  Lots of that stuff never really reached mainstream.  One of the hardest parts of evacuating for me was leaving my garage full of esoteric crowdfunded games I've never played.\""),
    replies = {
        {
            text = ccb.content.text("Have you ever thought about going back for them?"),
            next_topic = "TALK_REFUGEE_JENNY_Games2",
        },
        {
            text = ccb.content.text("Do you mean stuff like D&D?"),
            next_topic = "TALK_REFUGEE_JENNY_Games3",
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
    id = "TALK_REFUGEE_JENNY_Games2",
    line = ccb.content.text("No, mainly because my whole neighborhood burnt to the ground.  Some scouts went by a while ago.  Nothing there for me but melted plastic miniatures and thousands of hours of gameplay I'll never have."),
    replies = {
        {
            text = ccb.content.text("Do you mean stuff like D&D?"),
            next_topic = "TALK_REFUGEE_JENNY_Games3",
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
    id = "TALK_REFUGEE_JENNY_Games3",
    line = ccb.content.text("Well, of course I played the mandatory amount of dice based RPGs necessary to graduate my engineering program,\" she grins.  \"They're fun, something like that would be nice around here, but I'm not that kind of storyteller and I don't think anyone else here is nerdy enough for it.\"  Jenny tips her head a bit.  \"It's nice that you're asking but don't worry about me, I've got recreation."),
    replies = {
        {
            text = ccb.content.text("Have you ever thought about going back for your board games?"),
            next_topic = "TALK_REFUGEE_JENNY_Games2",
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
