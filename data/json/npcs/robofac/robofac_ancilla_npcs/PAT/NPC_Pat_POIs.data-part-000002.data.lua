local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_LIXA_surface_1a",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_knows_u_cyborg" } }),
        yes = ccb.content.text("&You hear a chirp in your comm and Pat's voice comes over the line: \"Pat ta' <pat_robo_nickname>.  Hang on.  Need to confirm ya' location.  Ovah.\""),
        no = ccb.content.text("&You hear a chirp in your comm and Pat's voice comes over the line: \"Pat heah.  Hang on.  Need to confirm ya' location.  Ovah.\""),
    },
    replies = {
        {
            text = ccb.content.text("I'm getting close to that Department of Energy facility we talked about.  What's up?  Over."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_LIXA_surface_1a_recon",
            when = predicates.has_mission("MISSION_ROBOFAC_PAT_RECON_2"),
        },
        {
            text = ccb.content.text("What's going on?  Over."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_LIXA_surface_1a_1",
        },
        {
            text = ccb.content.text("Not now, Pat.  We'll talk about this later.  Over and out."),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("speaker", "robofac_pat_talk_LIXA_surface_1a_later", "yes") },
        },
        {
            text = ccb.content.text("[Chirp Pat twice and stay silent]"),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("speaker", "robofac_pat_talk_LIXA_surface_1a_later", "yes") },
        },
    },
}
