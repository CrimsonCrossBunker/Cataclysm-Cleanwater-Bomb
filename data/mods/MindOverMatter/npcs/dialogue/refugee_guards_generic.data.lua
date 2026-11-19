local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = { "TALK_EVAC_GUARD2_scan" },
    line = {
        choices = {
            ccb.content.text("«Not bad playing tour guide.  Better than having to fight.»"),
            {
                when = predicates.conversation_state("daylight"),
                yes = {
                    choices = {
                        ccb.content.text("«Another day after <the_cataclysm>.  One foot in front of the other.»"),
                    },
                },
                no = {
                    choices = {
                        ccb.content.text("«So tired.  That's what I get for drawing the night shift.»"),
                        ccb.content.text("«At least in here I can see them coming.  If I were out there…»"),
                    },
                },
            },
            {
                when = predicates.actor_state("speaker", "male"),
                yes = {
                    choices = { ccb.content.text("«How much did it take to get here?  What has he lost?»") },
                },
                no = {
                    choices = { ccb.content.text("«How much did it take to get here?  What has she lost?»") },
                },
            },
        },
    },
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_EVAC_GUARD2" } },
}
