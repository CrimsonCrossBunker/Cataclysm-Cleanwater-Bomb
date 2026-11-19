local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Gemma_Firstmeet",
    line = ccb.content.gendered_line("It's nice to meet you too, survivor.  It's a tragedy what's become of the New England Church Community, perhaps it'll flourish again someday.", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("<end_talking_leave>  Nice meeting you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Gemma_Leave",
    line = ccb.content.text("I heard what it's like out there.  You must be weary from exploring this unforgiving wasteland.  I'm sorry that you're leaving us this soon."),
    replies = {
        {
            text = ccb.content.text("<end_talking_leave>  Nice meeting you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Gemma_Join",
    line = ccb.content.text("We are all under God's protection here.  Our community, like all moral civilizations, has a set of rules.  Obey the Decalogue, have respect for your neighbors and we'll get along just fine, okay?"),
    replies = {
        { text = ccb.content.text("Got it."), next_topic = "TALK_GODCO_Gemma_Joinee" },
        {
            text = ccb.content.text("What is the Decalogue?"),
            next_topic = "TALK_GODCO_Gemma_Decalouge",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Gemma_Decalouge",
    line = ccb.content.text("Its also called the Ten Commandments, if you've heard it by that.  A long time ago, Moses lead the Israelites out of slavery in Egypt, towards the Promised Land.  They broke their Covenant with God, and were cursed to wander the desert for forty years, as opposed to the nineteen days it would normally take.  On the way there, Moses went atop Mount Sinai to speak with God.  He saw a burning bush, and heard the voice of the Lord; who engraved the Decalogue on two tablets of stone."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_GODCO_Gemma_Decalouge2" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Gemma_Decalouge2",
    line = ccb.content.text("&Gemma is in deep, silent thought for a moment, before clearing her throat.  \"They read: 'I am the Lord your God, who brought you out of Egypt, out of the land of slavery.  You shall have no other gods before me.  You shall not make for yourself a carved image, or any likeness of anything that is in heaven above, or that is in the earth beneath, or that is in the water under the earth.  You shall not take the name of the Lord your God in vain.  Remember the Sabbath day, and keep it holy.  Honor your father and your mother.  You shall not murder.  You shall not commit adultery.  You shall not steal.  You shall not bear false witness against your neighbor.  You shall not covet your neighbors house.\"  They're written in Exodus 20:1-17, for future reference."),
    replies = { { text = ccb.content.text("Got it."), next_topic = "TALK_GODCO_Gemma_Joinee" } },
}
