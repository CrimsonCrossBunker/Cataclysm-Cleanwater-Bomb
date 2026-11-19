local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_EXODII_EXISTENCE",
    line = ccb.content.text("Not without significantly advanced surveillance tech most of which were either decommissioned or destroyed post cataclysm."),
    replies = {
        {
            text = ccb.content.text("Actually a bunch of high tech dudes HAVE scouted out this place and wanted me to check it out."),
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "knowledge_exodii_transdimensional_u_knows_exodiilore" } })),
            next_topic = "TALK_ROBOFAC_ABOUT_EXODII_1",
        },
        {
            text = ccb.content.text("I am in tight with a bunch of inter-dimensional travellers who observed this base and sent me out to investigate this place."),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "knowledge_exodii_transdimensional_u_knows_exodiilore" } }),
            next_topic = "TALK_ROBOFAC_ABOUT_EXODII_2",
        },
    },
}
