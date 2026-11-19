local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_cabin_3_reverberation_hint",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_knows_u_cyborg" } }),
        yes = ccb.content.text("&You hear a chirp in your comm and Pat's voice comes over the line: \"Pat ta' <pat_robo_nickname>.  Some'a your recent images are wicked twisted with errors and noise.  Not sure what's nearby, but it's messin' with the signal.  Ovah.\""),
        no = ccb.content.text("&You hear a chirp in your comm and Pat's voice comes over the line: \"Pat heah.  Some'a your recent images are wicked twisted with errors and noise.  Not sure what's nearby, but it's messin' with the signal.  Ovah.\""),
    },
    replies = {
        {
            text = ccb.content.text("I'm close to the cabin we talked about.  Think that's it?  Over."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_cabin_3_reverberation_hint_1",
            when = predicates.has_mission("MISSION_ROBOFAC_PAT_RECON_10"),
        },
        {
            text = ccb.content.text("I'll be careful.  Thanks, Pat.  Over and out."),
            next_topic = "TALK_DONE",
        },
        { text = ccb.content.text("[Chirp Pat twice and stay silent]"), next_topic = "TALK_DONE" },
    },
}
