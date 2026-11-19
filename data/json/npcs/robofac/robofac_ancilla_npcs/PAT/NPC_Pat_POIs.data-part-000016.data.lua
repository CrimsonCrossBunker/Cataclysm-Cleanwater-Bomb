local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_morgantown_2b_far",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_knows_u_cyborg" } }),
        yes = ccb.content.text("&You hear a chirp in your comm and Pat's voice comes over the line: \"Pat ta' <pat_robo_nickname>.  Gettin' a bit too close to Morgantown for my likin'.  Ovah.\""),
        no = ccb.content.text("&You hear a chirp in your comm and Pat's voice comes over the line: \"Pat heah.  Gettin' a bit too close to Morgantown for my likin'.  Ovah.\""),
    },
    replies = {
        {
            text = ccb.content.text("Morgantown?  Look, I'm close to the place that merc said they saw a creature in the woods.  Must be there, yeah?  What do you know about Morgantown?  Over."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_morgantown_2b_far_1",
            when = predicates.has_mission("MISSION_ROBOFAC_PAT_RECON_9"),
        },
        {
            text = ccb.content.text("Morgantown?  I've got an address from some \"XEDRA\" notebook leading me that direction.  Over."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_morgantown_2b_far_1",
            when = predicates.has_mission("MISSION_XEDRA_FIELD_STATION_2"),
        },
        {
            text = ccb.content.text("Morgantown?  Never heard of it.  Over."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_morgantown_2b_far_1",
        },
        {
            text = ccb.content.text("Not now, Pat.  We'll talk about this later.  Over and out."),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("speaker", "robofac_pat_talk_morgantown_2b_later", "yes") },
        },
        {
            text = ccb.content.text("[Chirp Pat twice and stay silent]"),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("speaker", "robofac_pat_talk_morgantown_2b_later", "yes") },
        },
    },
}
