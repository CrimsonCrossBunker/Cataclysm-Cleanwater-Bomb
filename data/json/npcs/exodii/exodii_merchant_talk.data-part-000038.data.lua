local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

-- Making do, making do, same as you I'd imagine.  Our last home got too dead and putrid around the edges, basically.  It happens to the best of them.  We caught some news that brought us along to your place here, fired up the engines, and boom!  Now, quick as can be, here we are.  We got a good timing this time, seems to me you'd only been dead a few days when we got here.  Freshest corpse I've seen in a while.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Purpose",
    line = ccb.content.text("Makin' do, makin' do, same as you, an I'm ken.  Last home got a bit too dead 'n putrid roun' the edges, like.  Happens to the best of 'em.  Caught a jibber that made us ken 'bout your place here, fired up the ol' wibble-wammles and boom!  Now it's all tick-tock on a zimmer, here we be.  Got a good timing this time, I razz you only been dead a few days when we wobbled in.  Freshest corpse this'n's seen in a kitchen sink."),
    replies = {
        { text = ccb.content.text("…what?"), next_topic = "TALK_EXODII_MERCHANT_Purpose_Dialect" },
        {
            text = ccb.content.text("[INT or PER 9] Where did you come from then?  Are you aliens or something?"),
            when = predicates.any({ predicates.minimum_attribute("speaker", "intelligence", 9), predicates.minimum_attribute("speaker", "perception", 9) }),
            next_topic = "TALK_EXODII_MERCHANT_Aliens",
        },
        {
            text = ccb.content.text("Is there anything else you want from this place?"),
            next_topic = "TALK_EXODII_MERCHANT_Purpose2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

-- We're just here to survive, you understand?  Our last world got too overrun with undead.  So, we came to a new world.  This one.  If I'm not mistaken, it's not so long dead around here just yet.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Purpose_Dialect",
    line = ccb.content.text("Us're here to live and breathe, kennit?  After our last otherland got a li'l too dead an' all.  So, us'n came to a new place.  This'n.  An I'm ken, it's not so long dead round here jus' yet."),
    replies = {
        {
            text = ccb.content.text("[INT or PER 7] Otherland?  Are you aliens or something?"),
            when = predicates.any({ predicates.minimum_attribute("speaker", "intelligence", 7), predicates.minimum_attribute("speaker", "perception", 7) }),
            next_topic = "TALK_EXODII_MERCHANT_Aliens",
        },
        {
            text = ccb.content.text("Is there anything else you want from this place?"),
            next_topic = "TALK_EXODII_MERCHANT_Purpose2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
