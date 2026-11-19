local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Helena_Story",
    line = ccb.content.text("I am a prophet, like my uncle before me.  He saw <the_cataclysm>, the righteous judgment of God and set about preparing an ark to save us.  He passed before his visions could be fulfilled, and now I carry his righteous banner."),
    replies = {
        {
            text = ccb.content.text("Tell me about his visions."),
            next_topic = "TALK_GODCO_Helena_Uncle",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Helena_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Helena_Uncle",
    line = ccb.content.text("He had many visions, and he had many secrets.  I don't know all of them, but there was one he was highly vocal about, regarding <the_cataclysm>, that according to him \"The spawn of Satan shall descend upon the Earth, and all will be consumed in death and destruction\".  He never said much else about it, and always had a mortified face whenever someone brought it up."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Helena_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Helena_Mood",
    line = ccb.content.text("Thanks to my uncle's forethought, we've been blessed by God.  We have plenty of food for ourselves, safety from the hordes of Hell, and the continued protection of the Lord our God."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Helena_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Helena_Community",
    line = ccb.content.text("They denied us, they labeled us as a doomsday cult, threw sticks and stones at us, and yet, we were standing resiliently.  Why?  Because we knew God was on our side."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Helena_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Helena_Join",
    line = ccb.content.text("We are all under God's protection here.  Our community, like all moral civilizations, has a set of rules.  Obey the Decalogue, have respect for your neighbors and we'll get along just fine.  Go see Gemma or Julian for a bed, if one's available.  We do have limited space on our Ark, though."),
    replies = {
        {
            text = ccb.content.text("Okay, I'll see about that later."),
            next_topic = "TALK_GODCO_Helena_2",
        },
        {
            text = ccb.content.text("What is the Decalogue?"),
            next_topic = "TALK_GODCO_Helena_Decalouge",
        },
        {
            text = ccb.content.text("Okay, I'll see about that.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Helena_Decalouge",
    line = ccb.content.text("Its also called the Ten Commandments, if you've heard it by that.  A long time ago, Moses lead the Israelites out of slavery in Egypt, towards the Promised Land.  They broke their Covenant with God, and were cursed to wander the desert for forty years, as opposed to the nineteen days it would normally take.  On the way there, Moses went atop Mount Sinai to speak with God.  He saw a burning bush, and heard the voice of the Lord; who engraved the Decalogue on two tablets of stone."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_GODCO_Helena_Decalouge2" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Helena_Decalouge2",
    line = ccb.content.text("&Helena flips through her Bible before stopping.  \"They read: 'I am the Lord your God, who brought you out of Egypt, out of the land of slavery.  You shall have no other gods before me.  You shall not make for yourself a carved image, or any likeness of anything that is in heaven above, or that is in the earth beneath, or that is in the water under the earth.  You shall not take the name of the Lord your God in vain.  Remember the Sabbath day, and keep it holy.  Honor your father and your mother.  You shall not murder.  You shall not commit adultery.  You shall not steal.  You shall not bear false witness against your neighbor.  You shall not covet your neighbors house.\"  They're written in Exodus 20:1-17, for future reference."),
    replies = { { text = ccb.content.text("Thanks."), next_topic = "TALK_GODCO_Helena_2" } },
}
