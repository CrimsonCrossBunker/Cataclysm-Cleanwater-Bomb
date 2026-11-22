local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_ROBOFAC_MERC_PAT" },
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } }),
        yes = {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_knows_u_cyborg" } }),
            yes = {
                choices = {
                    ccb.content.text("&You boot up your radio unit and chirp Pat on the normal frequency.  After a short moment, Pat chirps back.  \"Pat heah, ovah.\""),
                    ccb.content.text("&You boot up your radio unit and chirp Pat on the normal frequency.  After a short moment, Pat chirps back.  \"Pat ta' Tin Man, ovah.\""),
                    ccb.content.text("&You boot up your radio unit and chirp Pat on the normal frequency.  After a short moment, Pat chirps back.  \"Pat ta' Wi-Fi, ovah.\""),
                    ccb.content.text("&You boot up your radio unit and chirp Pat on the normal frequency.  After a short moment, Pat chirps back.  \"Pat heah.  How's it hummin'?  Ovah.\""),
                    ccb.content.text("&You boot up your radio unit and chirp Pat on the normal frequency.  After a short moment, Pat chirps back.  \"Pat ta' Bluetooth, ovah.\""),
                    ccb.content.text("&You boot up your radio unit and chirp Pat on the normal frequency.  After a short moment, Pat chirps back.  \"Pat ta' Robocawp, ovah.\""),
                    ccb.content.text("&You boot up your radio unit and chirp Pat on the normal frequency.  After a short moment, Pat chirps back.  \"Beep boop beep boop, it's me, ya' human pal, ovah.\""),
                    ccb.content.text("&You boot up your radio unit and chirp Pat on the normal frequency.  After a short moment, Pat chirps back.  \"Pat ta' Toastah, ovah.\""),
                    ccb.content.text("&You boot up your radio unit and chirp Pat on the normal frequency.  After a short moment, Pat chirps back.  \"Pat heah.  Gettin' some interference.  Ya' clean your circuits lately?  Ovah.\""),
                    ccb.content.text("&You boot up your radio unit and chirp Pat on the normal frequency.  After a short moment, Pat chirps back.  \"Pat heah.  Sound off if ya' ain't been abducted by ya' robot cousins, yet.  Ovah.\""),
                },
            },
            no = ccb.content.text("&You boot up your radio unit and chirp Pat on the normal frequency.  After a short moment, Pat chirps back.  \"Pat heah, ovah.\""),
        },
        no = {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_knows_u_cyborg" } }),
            yes = {
                choices = {
                    ccb.content.text("Heya, Tin Man."),
                    ccb.content.text("What's up, Wi-Fi?"),
                    ccb.content.text("How's it hummin'?"),
                    ccb.content.text("Yo, Bluetooth!"),
                    ccb.content.text("Woah, easy there, Robocawp.  It's just me, hah!"),
                    ccb.content.text("Beep boop.  That's 'hi' in robot, yeah?"),
                    ccb.content.text("How ya' doin', Toastah?"),
                    ccb.content.text("How ya' livin', Half-Price Terminatah?"),
                    ccb.content.text("Hi."),
                    ccb.content.text("How's it goin'?"),
                    ccb.content.text("Yo."),
                    ccb.content.text("Whatsup?"),
                    ccb.content.text("They nod their head in greeting."),
                    ccb.content.text("They tilt their head up in greeting."),
                    ccb.content.text("Hey, howahyah."),
                    ccb.content.text("What's doin'?"),
                },
            },
            no = {
                choices = {
                    ccb.content.text("Hi."),
                    ccb.content.text("How's it goin'?"),
                    ccb.content.text("Yo."),
                    ccb.content.text("Whatsup?"),
                    ccb.content.text("They nod their head in greeting."),
                    ccb.content.text("They tilt their head up in greeting."),
                    ccb.content.text("Hey, howahyah."),
                    ccb.content.text("What's doin'?"),
                },
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Hi.  I'm <u_name>."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_GREETING_1",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_met" } })),
        },
        {
            text = ccb.content.text("No luck finding smokes, yet."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_SMOKES_NO",
            when = predicates.all({ predicates.has_mission("MISSION_ROBOFAC_PAT_1"), predicates.negate(predicates.has_inventory("speaker", "cig", 2)) }),
        },
        {
            text = ccb.content.text("I found smokes!"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_SMOKES_YES",
            when = predicates.all({ predicates.has_mission("MISSION_ROBOFAC_PAT_1"), predicates.has_inventory("speaker", "cig", 2) }),
            actions = { actions.handler("dlg_a_dda_cd911d038159"), actions.set_actor_value("speaker", "robofac_pat_friends", "yes"), actions.finish_mission("MISSION_ROBOFAC_PAT_1", { success = true }) },
        },
        {
            text = ccb.content.text("Anything I could do for you in the field?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_MISSION_FRIEND_1",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_friends" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_partners" } })), predicates.negate(predicates.has_mission("MISSION_ROBOFAC_PAT_2")) }),
        },
        {
            text = ccb.content.text("I found those electronics you asked for - here, use this pair of AR glasses."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_MISSION_FRIEND_1_COMPLETE",
            when = predicates.all({ predicates.has_mission("MISSION_ROBOFAC_PAT_2"), predicates.has_inventory("speaker", "eink_tablet_pc", 2), predicates.has_inventory("speaker", "ar_glasses_advanced", 1), predicates.has_inventory("speaker", "two_way_radio", 2), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } })) }),
            actions = { actions.handler("dlg_a_dda_fee2c81e6a6b"), actions.set_actor_value("speaker", "robofac_pat_partners", "yes"), actions.finish_mission("MISSION_ROBOFAC_PAT_2", { success = true }) },
        },
        {
            text = ccb.content.text("I found those electronics you asked for - here, use this badass military MVAS unit."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_MISSION_FRIEND_1_MVAS_HVAH",
            when = predicates.all({ predicates.has_mission("MISSION_ROBOFAC_PAT_2"), predicates.has_inventory("speaker", "eink_tablet_pc", 1), predicates.has_inventory("speaker", "military_vis_aug_system", 1), predicates.has_inventory("speaker", "two_way_radio", 1), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } })) }),
            actions = { actions.handler("dlg_a_dda_d14a2f08c2a5"), actions.set_actor_value("speaker", "robofac_pat_partners", "yes"), actions.finish_mission("MISSION_ROBOFAC_PAT_2", { success = true }), actions.handler("dlg_a_dda_772d908bcb93"), actions.set_actor_value("speaker", "robofac_waiting_on_pat", "yes"), actions.set_actor_value("speaker", "robofac_pat_is_holding", "military_vis_aug_system"), actions.set_actor_value("speaker", "robofac_pat_started_earpiece", "yes") },
        },
        {
            text = ccb.content.text("I found those electronics you asked for - here, use this badass Hub 01 headset."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_MISSION_FRIEND_1_MVAS_HVAH",
            when = predicates.all({ predicates.has_mission("MISSION_ROBOFAC_PAT_2"), predicates.has_inventory("speaker", "eink_tablet_pc", 1), predicates.has_inventory("speaker", "robofac_head_rig_ar", 1), predicates.has_inventory("speaker", "two_way_radio", 1), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } })) }),
            actions = { actions.handler("dlg_a_dda_63177be5ac0c"), actions.set_actor_value("speaker", "robofac_pat_partners", "yes"), actions.finish_mission("MISSION_ROBOFAC_PAT_2", { success = true }), actions.handler("dlg_a_dda_772d908bcb93"), actions.set_actor_value("speaker", "robofac_waiting_on_pat", "yes"), actions.set_actor_value("speaker", "robofac_pat_is_holding", "robofac_head_rig_ar"), actions.set_actor_value("speaker", "robofac_pat_started_earpiece", "yes") },
        },
        {
            text = ccb.content.text("It's been two days.  That gear ready?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_GEAR",
            when = predicates.handler("dlg_p_dda_7392ada3461d"),
            actions = { actions.set_actor_value("speaker", "robofac_pat_gave_gear", "yes"), actions.handler("dlg_a_dda_f47d75eca5b8") },
        },
        {
            text = ccb.content.text("So, no easy way to say this, but I let some robots turn me into a cyborg.  Pretty cool, yeah?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG",
            when = predicates.all({ predicates.has_trait("speaker", "CBM_Interface"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_knows_u_cyborg" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_gave_gear" } }) }),
        },
        {
            text = ccb.content.text("So, remember that whole cyborg thing?  I managed to get an AR system implanted.  Think we can use it to communicate and share info?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_EXODII_AR",
            when = predicates.all({ predicates.has_trait("speaker", "CBM_Interface"), predicates.has_inventory("speaker", "integrated_ar", 1), predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_knows_u_cyborg" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_said_no_to_exodii_AR_CBM" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_gave_gear" } }) }),
            actions = { actions.set_actor_value("speaker", "robofac_pat_said_no_to_exodii_AR_CBM", "yes") },
        },
        {
            text = ccb.content.text("Have you heard about the Cybernetic Enhancements Program?  Doc Stevens across the street hooked me up with a cybernetic interface, believe it or not."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_HUB01",
            when = predicates.all({ predicates.has_trait("speaker", "Hub01_CBM_Interface"), predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_gave_gear" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_knows_u_cyborg" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_knows_u_hub01_cyborg" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_said_no_to_exodii_AR_CBM" } })) }),
            actions = { actions.set_actor_value("speaker", "robofac_pat_knows_u_cyborg", "yes"), actions.set_actor_value("speaker", "robofac_pat_knows_u_hub01_cyborg", "yes") },
        },
        {
            text = ccb.content.text("Hey, remember that whole cyborg thing?  Have you heard about the Cybernetic Enhancements Program with Doc Stevens, across the street?  I've upgraded to a new cybernetic interface that has a USB port, believe it or not.  Maybe we can use it to communicate."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_HUB01",
            when = predicates.all({ predicates.has_trait("speaker", "Hub01_CBM_Interface"), predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_gave_gear" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_knows_u_cyborg" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_knows_u_hub01_cyborg" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_said_no_to_exodii_AR_CBM" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_gave_transponder_CBM" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_said_use_the_earpiece" } })) }),
            actions = { actions.set_actor_value("speaker", "robofac_pat_knows_u_hub01_cyborg", "yes") },
        },
        {
            text = ccb.content.text("Hey, remember that whole cyborg thing?  Have you heard about the Cybernetic Enhancements Program with Doc Stevens, across the street?  I've upgraded to a new cybernetic interface that has a USB port, believe it or not.  Think we can use my integrated AR system now?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_HUB01_AR",
            when = predicates.all({ predicates.has_trait("speaker", "Hub01_CBM_Interface"), predicates.has_inventory("speaker", "integrated_ar", 1), predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_gave_gear" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_knows_u_cyborg" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_said_no_to_exodii_AR_CBM" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_knows_u_hub01_cyborg" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_said_use_the_earpiece" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_gave_transponder_CBM" } })) }),
            actions = { actions.set_actor_value("speaker", "robofac_pat_knows_u_hub01_cyborg", "yes") },
        },
        {
            text = ccb.content.text("I picked up an Integrated AR System CBM.  Think we can use my integrated electronics to communicate, now?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_HUB01_AR",
            when = predicates.all({ predicates.has_trait("speaker", "Hub01_CBM_Interface"), predicates.has_inventory("speaker", "integrated_ar", 1), predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_gave_gear" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_knows_u_cyborg" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_knows_u_hub01_cyborg" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_said_use_the_earpiece" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_gave_transponder_CBM" } })) }),
        },
        {
            text = ccb.content.text("I picked up an Infolink CBM.  Think we can use my integrated electronics to communicate, now?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_HUB01_AR_INFOLINK_YES",
            when = predicates.handler("dlg_p_dda_85398ce4b99c"),
        },
        {
            text = ccb.content.text("Hey, check out this military-grade AR unit.  Think we can do something with it?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_MAKE_EARPIECE_MVAS",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_started_earpiece" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_gave_gear" } }), predicates.has_inventory("speaker", "military_vis_aug_system", 1), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } })) }),
        },
        {
            text = ccb.content.text("Hey, check out this Hub 01 AR unit.  Think we can do something with it?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_MAKE_EARPIECE_HVAH",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_started_earpiece" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_gave_gear" } }), predicates.has_inventory("speaker", "robofac_head_rig_ar", 1), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } })) }),
        },
        {
            text = ccb.content.text("So it's been a day.  Any progress on that AR headset?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_GIVE_EARPIECE",
            when = predicates.handler("dlg_p_dda_fec1631c1c08"),
            actions = { actions.set_actor_value("speaker", "robofac_pat_finished_earpiece", "yes"), actions.handler("dlg_a_dda_4d6dcc7a7ee5") },
        },
        {
            text = ccb.content.text("Check out this new Hub 01 headgear - they call it a LENS helmet.  Think we can use it?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_LENS_1",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_gave_gear" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_gave_LENS_upgrade" } })), predicates.has_inventory("speaker", "robofac_lens_helmet", 1), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } })) }),
        },
        {
            text = ccb.content.text("Let's talk about one of our jobs."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_partners" } }),
        },
        {
            text = ccb.content.text("So I've learned that the Hub will keep paying for HEW reports.  Guess that means we need anomalies to scan.  Can you start gathering intel on potential targets?"),
            next_topic = "TALK_PAT_RECON_DIRECTIONS_INTRO",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_partners" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_robofac_intercom_mws_4" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_talked_about_recon" } })) }),
        },
        {
            text = ccb.content.text("It hasn't been very long, but any new intel on HEW targets?"),
            next_topic = "TALK_PAT_RECON_DIRECTIONS_NO",
            when = predicates.handler("dlg_p_dda_b0a97945d8c8"),
        },
        {
            text = ccb.content.text("It's been a few days.  Any new intel on HEW targets?"),
            next_topic = "TALK_PAT_RECON_DIRECTIONS_YES",
            when = predicates.handler("dlg_p_dda_e22805bf79d4"),
            actions = { actions.handler("dlg_a_dda_0885d61f61ec") },
        },
        {
            text = ccb.content.text("Any ideas on places we've seen before that might be worth scanning with the HEW system?"),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_partners" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_robofac_intercom_mws_4" } }) }),
        },
        {
            text = ccb.content.text("About the equipment we use…"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_GEAR_MENU",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_gave_gear" } }),
        },
        {
            text = ccb.content.text("Let's talk about when we lost contact earlier…"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_LOST_SIGNAL",
            when = predicates.handler("dlg_p_dda_fc9dd853bbdf"),
        },
        {
            text = ccb.content.text("Just came by to chat."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_MORALE_CHAT",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_friends" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } })) }),
        },
        {
            text = ccb.content.text("Just calling you up to to chat.  Anything new?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_MORALE_CHAT",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_friends" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } }) }),
        },
        {
            text = ccb.content.text("I'll see you around."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } })),
        },
        {
            text = ccb.content.text("Later, Pat.  Over and out."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_GREETING_1",
    line = ccb.content.text("Hey, I'm Pat.  Hope ya weren't plannin' on usin' this office.  The bosses don't seem ta give a damn, so I'm callin' dibs."),
    replies = {
        {
            text = ccb.content.text("What do you do for our… employer?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_GREETING_2",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_GREETING_2",
    line = ccb.content.text("I kinda stumbled inta this place aftah everythin' went down, an' they started tossin' me odd jobs in exchange for some old weathah data I had lyin' around.  Used ta be a meteorologist - the computah kind, not the TV kind.  Now they got me takin' recordin's of those portal storms, but if I'm bein' straight with ya, I ain't really built for fieldwork.  Honestly, I'm shocked I'm still breathin'."),
    replies = {
        {
            text = ccb.content.text("They've contracted me to do the same."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_GREETING_3",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_GREETING_3",
    line = ccb.content.text("No kiddin'? Well, hey - good ta meet ya. Swing by once in a while, yeah?  You're a helluva lot friendlier than most a the assholes I've run inta round heah… not that theah's been a ton, but still."),
    replies = {
        {
            text = ccb.content.text("Nice to meet you.  See you around."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_GREETING_4",
        },
    },
}
