local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_microlab_portal_security1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_knows_u_cyborg" } }),
        yes = ccb.content.text("&You hear a chirp in your comm and Pat's voice comes over the line, broken up by static: \"Pat ta' <pat_robo_nickname>.  I'm not gettin' a good--cshhh--signal.  Yo--cshhh--eep underground.  Somethin' bad--cshhh--\"…  the line is then filled with dead static."),
        no = ccb.content.text("&You hear a chirp in your comm and Pat's voice comes over the line, broken up by static: \"Pat heah.  I'm not gettin' a good--cshhh--signal.  Yo--cshhh--eep underground.  Somethin' bad--cshhh--\"…  the line is then filled with dead static."),
    },
    replies = {
        {
            text = ccb.content.text("…"),
            next_topic = "TALK_DONE",
            actions = {
                actions.set_actor_value("speaker", "robofac_pat_talk_microlab_portal_security1_later", "yes"),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_corpse_surface",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_knows_u_cyborg" } }),
        yes = ccb.content.text("&You hear a chirp in your comm and Pat's voice comes over the line: \"Pat ta' <pat_robo_nickname>.  Ovah.\""),
        no = ccb.content.text("&You hear a chirp in your comm and Pat's voice comes over the line: \"Pat heah.  Ovah.\""),
    },
    replies = {
        {
            text = ccb.content.text("I'm close to that place the hunk of meat came from.  See anything?  Over."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_corpse_surface_2",
            when = predicates.has_mission("MISSION_ROBOFAC_PAT_RECON_7"),
        },
        {
            text = ccb.content.text("Hey, Pat.  I'm getting close to that… thing I'm supposed to go into for the Hub.  Over."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_corpse_surface_1",
            when = predicates.has_mission("MISSION_ROBOFAC_INTERCOM_MWS_MONSTER_CORPSE"),
        },
        {
            text = ccb.content.text("Go ahead, Pat.  Over."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_corpse_surface_2",
        },
        {
            text = ccb.content.text("Not now, Pat.  We'll talk about this later.  Over and out."),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("speaker", "robofac_pat_talk_corpse_surface_later", "yes") },
        },
        {
            text = ccb.content.text("[Chirp Pat twice and stay silent]"),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("speaker", "robofac_pat_talk_corpse_surface_later", "yes") },
        },
    },
}
