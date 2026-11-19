local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_CIRCUIT_SAFARI_TELL_PAT_ABOUT_IMPLANT",
    line = ccb.content.text("&Pat chortles.  \"Well, I dunno about all that, but it explains a lot about you, pal, not gonna lie.  In that case, just don't go lettin'em scan that ugly mug'a yours.  World's already sufferin' enough with extra copies of that goin' around, hah!\""),
    replies = {
        {
            text = ccb.content.text("Hah, will do, Pat.  So, about those coordinates…"),
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_gave_circuit_safari_intel" } })),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_CIRCUIT_SAFARI_INTEL",
        },
        {
            text = ccb.content.text("Hah, thanks, Pat.  Will do.  See you around."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
        },
    },
}
