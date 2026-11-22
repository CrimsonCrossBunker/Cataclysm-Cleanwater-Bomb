local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_RECON_DIRECTIONS_YES",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } }),
        yes = ccb.content.text("&Your HUD flicks on and low-resolution version of Pat's computer desktop becomes visible.  \"Heah's what we got for the moment, yeah?\""),
        no = ccb.content.text("&Pat boots up their laptop and pulls out a stack of maps, photos, and documents.  \"Let's see what we have heah, yeah?\""),
    },
    replies = {
        {
            text = ccb.content.text("[Photo of a farmstead] What's this?"),
            next_topic = "MISSION_ROBOFAC_PAT_RECON_1",
            when = predicates.handler("dlg_p_dda_a3d6e4384be8"),
            actions = { actions.assign_mission("MISSION_ROBOFAC_PAT_RECON_1") },
        },
        {
            text = ccb.content.text("[Photo of large gate] What's this?"),
            next_topic = "MISSION_ROBOFAC_PAT_RECON_2",
            when = predicates.handler("dlg_p_dda_1c05067be15a"),
            actions = { actions.assign_mission("MISSION_ROBOFAC_PAT_RECON_2") },
        },
        {
            text = ccb.content.text("[Map with red marks on it] What's this?"),
            next_topic = "MISSION_ROBOFAC_PAT_RECON_3",
            when = predicates.handler("dlg_p_dda_62a9119d72be"),
            actions = { actions.assign_mission("MISSION_ROBOFAC_PAT_RECON_3") },
        },
        {
            text = ccb.content.text("[Series of photos] This looks new.  What is it?"),
            next_topic = "MISSION_ROBOFAC_PAT_RECON_4",
            when = predicates.handler("dlg_p_dda_06a68a2bea7f"),
            actions = { actions.assign_mission("MISSION_ROBOFAC_PAT_RECON_4") },
        },
        {
            text = ccb.content.text("[Image of a strange castle] What is that?"),
            next_topic = "MISSION_ROBOFAC_PAT_RECON_5",
            when = predicates.handler("dlg_p_dda_0cf126c72708"),
            actions = { actions.assign_mission("MISSION_ROBOFAC_PAT_RECON_5") },
        },
        {
            text = ccb.content.text("[Documents marked CLASSIFIED] Ooh?"),
            next_topic = "MISSION_ROBOFAC_PAT_RECON_6",
            when = predicates.handler("dlg_p_dda_b3e08a2ee841"),
        },
        {
            text = ccb.content.text("[Image of a test tube with a hunk of meat in it] What's this?"),
            next_topic = "MISSION_ROBOFAC_PAT_RECON_7",
            when = predicates.handler("dlg_p_dda_4d3ff720fdff"),
            actions = { actions.assign_mission("MISSION_ROBOFAC_PAT_RECON_7") },
        },
        {
            text = ccb.content.text("[Image of a glowing smear] What's that?"),
            next_topic = "MISSION_ROBOFAC_PAT_RECON_8",
            when = predicates.handler("dlg_p_dda_ebb60da2c217"),
            actions = { actions.assign_mission("MISSION_ROBOFAC_PAT_RECON_8") },
        },
        {
            text = ccb.content.text("[A pin on Pat's digital map] What's that?"),
            next_topic = "MISSION_ROBOFAC_PAT_RECON_9",
            when = predicates.handler("dlg_p_dda_d0462abad931"),
            actions = { actions.assign_mission("MISSION_ROBOFAC_PAT_RECON_9") },
        },
        {
            text = ccb.content.text("[A pin on Pat's digital map] What's that?"),
            next_topic = "MISSION_ROBOFAC_PAT_RECON_10",
            when = predicates.handler("dlg_p_dda_fb7ee155fe94"),
            actions = { actions.assign_mission("MISSION_ROBOFAC_PAT_RECON_10") },
        },
        {
            text = ccb.content.text("[An old cassette player and an audio file] Haven't seen one of those in a while."),
            next_topic = "MISSION_ROBOFAC_PAT_RECON_11",
            when = predicates.handler("dlg_p_dda_5cbf7f6a57a4"),
            actions = { actions.assign_mission("MISSION_ROBOFAC_PAT_RECON_11") },
        },
        {
            text = ccb.content.text("[A scanned sheet of paper with several spirals drawn on it] What's that?"),
            next_topic = "MISSION_ROBOFAC_PAT_RECON_12",
            when = predicates.handler("dlg_p_dda_9c0b06ae2d63"),
            actions = { actions.assign_mission("MISSION_ROBOFAC_PAT_RECON_12") },
        },
        {
            text = ccb.content.text("[A blurry polaroid of a scarlet storm cloud] That cloud looks nasty.  Who gave you that?"),
            next_topic = "MISSION_ROBOFAC_PAT_RECON_13",
            when = predicates.handler("dlg_p_dda_65d1ba71c183"),
            actions = { actions.assign_mission("MISSION_ROBOFAC_PAT_RECON_13") },
        },
        {
            text = ccb.content.text("Nothing looks interesting to me.  I'll check in again later."),
            next_topic = "TALK_ROBOFAC_MERC_PAT",
        },
    },
}
