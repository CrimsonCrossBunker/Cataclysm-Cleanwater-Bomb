local ccb = require("ccb")

-- this is a half-truth. while the Hub does have an interest in understanding or reversing the Cataclysm, their primary intent here is specifically to understand the Exodii better.
ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_HWP_EXODII_STARTED_1",
    line = ccb.content.text("The Cataclysm has illuminated hitherto unknown facts about our universe.  The opportunity to research - and perhaps understand - technology from not only another world, but another dimension entirely, is an exceptionally promising field of study.  Now more than ever is our continued delving into this field of study paramount; while our focus has shifted rather abruptly, we believe that if there is ever any chance of understanding or even reversing <the_cataclysm>, it would come from studies like this."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
        { text = ccb.content.text("I'll check in later."), next_topic = "TALK_DONE" },
    },
}
