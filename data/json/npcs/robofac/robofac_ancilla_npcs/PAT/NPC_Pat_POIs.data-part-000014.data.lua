local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_xedra_rural_church",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_knows_u_cyborg" } }),
        yes = ccb.content.text("&You hear a chirp in your comm and Pat's voice comes over the line: \"Pat ta' <pat_robo_nickname>.  You see that?  Ovah.\""),
        no = ccb.content.text("&You hear a chirp in your comm and Pat's voice comes over the line: \"Pat heah.  You see that?  Ovah.\""),
    },
    replies = {
        {
            text = ccb.content.text("Yeah, that purple glow in the distance?  I'm getting close to the location that photo was taken.  Over."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_xedra_rural_church_recon",
            when = predicates.has_mission("MISSION_ROBOFAC_PAT_RECON_8"),
        },
        {
            text = ccb.content.text("Yeah, that faint purple glow in the distance, I think I do.  I've got an address from some \"XEDRA\" notebook.  Know anything about it?  Over."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_xedra_rural_church_1",
            when = predicates.has_mission("MISSION_XEDRA_FIELD_STATION_1"),
        },
        {
            text = ccb.content.text("See what?  Over."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_xedra_rural_church_2",
        },
        {
            text = ccb.content.text("Not now, Pat.  We'll talk about this later.  Over and out."),
            next_topic = "TALK_DONE",
            actions = {
                actions.set_actor_value("speaker", "robofac_pat_talk_xedra_rural_church_later", "yes"),
            },
        },
        {
            text = ccb.content.text("[Chirp Pat twice and stay silent]"),
            next_topic = "TALK_DONE",
            actions = {
                actions.set_actor_value("speaker", "robofac_pat_talk_xedra_rural_church_later", "yes"),
            },
        },
    },
}
