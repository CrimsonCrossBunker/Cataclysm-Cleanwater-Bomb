local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_unvitrified_orchard",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_knows_u_cyborg" } }),
        yes = ccb.content.text("&You hear a chirp in your comm and Pat's voice comes over the line: \"Pat ta' <pat_robo_nickname>.  I'm pickin' up some radio disturbances.  Ovah.\""),
        no = ccb.content.text("&You hear a chirp in your comm and Pat's voice comes over the line: \"Pat heah.  I'm pickin' up some radio disturbances.  Ovah.\""),
    },
    replies = {
        {
            text = ccb.content.text("I'm getting close to that farmstead the merc told us about.  Pick up any more recon?  Over."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_unvitrified_orchard_recon",
            when = predicates.has_mission("MISSION_ROBOFAC_PAT_RECON_1"),
        },
        {
            text = ccb.content.text("What kind of disturbances?  Over."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_unvitrified_orchard_1",
        },
        {
            text = ccb.content.text("Not now, Pat.  We'll talk about this later.  Over and out."),
            next_topic = "TALK_DONE",
            actions = {
                actions.set_actor_value("speaker", "robofac_pat_talk_unvitrified_orchard_later", "yes"),
            },
        },
        {
            text = ccb.content.text("[Quickly Chirp the radio twice and stay silent]"),
            next_topic = "TALK_DONE",
            actions = {
                actions.set_actor_value("speaker", "robofac_pat_talk_unvitrified_orchard_later", "yes"),
            },
        },
    },
}
