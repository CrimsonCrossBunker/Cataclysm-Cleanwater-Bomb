local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_temple_stairs",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_knows_u_cyborg" } }),
        yes = ccb.content.text("&You hear a chirp in your comm and Pat's voice comes over the line: \"Pat ta' <pat_robo_nickname>.  The photos I'm gettin' are worse than usual.  Somethin's fahkin' with the transmission.  Just be careful, yeah?  Ovah.\""),
        no = ccb.content.text("&You hear a chirp in your comm and Pat's voice comes over the line: \"Pat heah.  The photos I'm gettin' are worse than usual.  Somethin's fahkin' with the transmission.  Just be careful, yeah?  Ovah.\""),
    },
    replies = {
        {
            text = ccb.content.text("I'm near the point from that treasure map you bought.  Think it's that?  Over."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_temple_stairs_recon",
            when = predicates.has_mission("MISSION_ROBOFAC_PAT_RECON_3"),
        },
        { text = ccb.content.text("Alright.  Over and out."), next_topic = "TALK_DONE" },
        { text = ccb.content.text("[Chirp Pat twice and stay silent]"), next_topic = "TALK_DONE" },
    },
}
