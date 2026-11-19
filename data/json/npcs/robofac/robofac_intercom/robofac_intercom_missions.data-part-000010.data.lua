local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = { "MISSION_ROBOFAC_INTERCOM_2_COMPLETE", "MISSION_ROBOFAC_INTERCOM_2_COMPLETE_Hardcase" },
    line = ccb.content.text("&The intercom's tray slides shut.\n\n\"This is the case; thank you.  Transferring the stipulated amount now.\"  The tray slides back open with your payment.  \"As an additional form of payment, you have been given clearance to receive a map of the area around this site, to assist in your work.  The standing price is 1 HGC; please inform us if you'd like to follow up on that offer going forward.\""),
    replies = {
        {
            text = ccb.content.text("[PER 8] The original markings on that case had been scratched out.  Who did it really belong to?"),
            when = predicates.minimum_attribute("speaker", "perception", 8),
            next_topic = "MISSION_ROBOFAC_INTERCOM_2_COMPLETE_Hardcase",
        },
        {
            text = ccb.content.text("I'm interested in that map."),
            next_topic = "TALK_ROBOFAC_INTERCOM_BUY_LOCAL_MAP",
        },
        { text = ccb.content.text("Thank you."), next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES" },
    },
}
