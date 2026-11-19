local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_LUMBERMILL_MERCHANT_STORY",
    line = {
        when = predicates.has_trait("interlocutor", "BGSS_No_Past_2"),
        yes = ccb.content.text("I mean, I don't remember a whole lot about this job I had, I just know that I managed this lumbermill and sold wood to… somebody.  I think it was some sort of company.  I'm just glad I remember my coworkers here, my <name_g>s.  They're helping me to try and remember who I was before all this.  You see, that's the weird thing; I remember what my job was and how to do it the right way, but I don't know where I learned that, or who taught me.  I just know that we're in this together, and we're gonna make it through Hell if we have too."),
        no = {
            when = predicates.has_trait("interlocutor", "BGSS_No_Past_3"),
            yes = ccb.content.text("I mean, I don't remember a whole lot about this job I had, I just know that I managed this lumbermill and sold wood to… somebody.  I think it was some sort of company.  I'm just glad I remember my coworkers here, my <name_g>s.  They're helping me to try and remember who I was before all this.  You see, that's the weird thing; I remember what my job was and how to do it the right way, but I don't know where I learned that, or who taught me.  I just know that we're in this together, and we're gonna make it through Hell if we have too."),
            no = ccb.content.text("I'm the manager here at the mill.  It's a tight-knit crew, unionized operation.  When <the_cataclysm> broke out, we were all running scared when some <zombies> broke onto the yard, had to fight them off.  Now, we've just held up here.  I imagine any folks left out there might be needing our machinery and skills to keep civilization alive.  Might make new customers yet."),
        },
    },
    replies = { { text = ccb.content.text("Hm."), next_topic = "TALK_NONE" } },
}
