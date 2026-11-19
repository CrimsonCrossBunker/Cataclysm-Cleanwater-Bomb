local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_exodii_base_x0y0z0",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_knows_u_cyborg" } }),
        yes = ccb.content.text("&You hear a chirp in your comm and Pat's voice comes over the line: \"Pat ta' <pat_robo_nickname>.  Is that a fahkin' CASTLE?  Holy shit.  What the fahk kinda' world are we livin' in?  Anyway, get in there and bring me back a sword!  Ovah.\""),
        no = ccb.content.text("&You hear a chirp in your comm and Pat's voice comes over the line: \"Pat heah.  Is that a fahkin' CASTLE?  Holy shit.  What the fahk kinda' world are we livin' in?  Anyway, get in there and bring me back a sword!  Ovah.\""),
    },
    replies = {
        {
            text = ccb.content.text("It's gotta be that castle that crazy guy said \"blipped\" into existence, right?  Over."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_exodii_base_x0y0z0_recon",
            when = predicates.has_mission("MISSION_ROBOFAC_PAT_RECON_5"),
        },
        {
            text = ccb.content.text("It's that place the teamster told me about.  Over."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_exodii_base_x0y0z0_1",
            when = predicates.has_mission("directions_exodii"),
        },
        {
            text = ccb.content.text("It's that place from that sign I found.  Over."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_exodii_base_x0y0z0_1",
            when = predicates.has_mission("directions_exodii_signpost"),
        },
        {
            text = ccb.content.text("From here it looks like a pile of scrap metal, but I can't really tell.  That mean anything to you?  Over."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_exodii_base_x0y0z0_1",
        },
        {
            text = ccb.content.text("I'll see what I can do.  Over and out."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("Not now, Pat.  We'll talk about this later.  Over and out."),
            next_topic = "TALK_DONE",
            actions = {
                actions.set_actor_value("speaker", "robofac_pat_talk_exodii_base_x0y0z0_later", "yes"),
            },
        },
        {
            text = ccb.content.text("[Chirp Pat twice and stay silent]"),
            next_topic = "TALK_DONE",
            actions = {
                actions.set_actor_value("speaker", "robofac_pat_talk_exodii_base_x0y0z0_later", "yes"),
            },
        },
    },
}
