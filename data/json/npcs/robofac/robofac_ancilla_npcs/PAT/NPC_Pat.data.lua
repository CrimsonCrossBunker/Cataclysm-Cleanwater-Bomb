local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- Appears on the Hub service.
ccb.content.define_npc {
    id = "chief_meteorologist_pat",
    unique_name = ccb.content.text("Pat"),
    suffix = ccb.content.text("Hub Mercenary"),
    class = "NPC_ROBOFAC_MERC_PAT",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_ROBOFAC_MERC_PAT",
    faction = "robofac_auxiliaries",
    on_death = "record_hub_pat_death",
}

ccb.content.define_npc_class {
    id = "NPC_ROBOFAC_MERC_PAT",
    name = ccb.content.text("Hub Mercenary"),
    traits = { { trait = "RETURN_TO_START_POS" } },
    job_description = ccb.content.text("Fighting for the all-mighty dollar."),
    common = false,
    worn = "NPC_ROBOFAC_MERC_PAT_worn",
    carry = "NPC_ROBOFAC_MERC_PAT_carry",
}

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

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_GREETING_4",
    line = ccb.content.text("Hey, before ya take off… if ya happen ta run inta any smokes out theah, maybe bring 'em by, yeah?  Don't mattah what kind.  I got a little rum tucked away we can split, call it a trade."),
    on_enter = { { actions = { actions.set_actor_value("speaker", "robofac_pat_met", "yes") } } },
    replies = {
        {
            text = ccb.content.text("Absolutely.  I'll come back when I find some cigarettes."),
            next_topic = "TALK_DONE",
            actions = { actions.assign_mission("MISSION_ROBOFAC_PAT_1") },
        },
        {
            text = ccb.content.text("I'll think about it.  See you around."),
            next_topic = "TALK_DONE",
            actions = { actions.assign_mission("MISSION_ROBOFAC_PAT_1") },
        },
        {
            text = ccb.content.text("I don't smoke, but I'll keep an eye out.  See you around."),
            next_topic = "TALK_DONE",
            actions = { actions.assign_mission("MISSION_ROBOFAC_PAT_1") },
        },
        {
            text = ccb.content.text("I don't drink, but I'll keep an eye out.  See you around."),
            next_topic = "TALK_DONE",
            actions = { actions.assign_mission("MISSION_ROBOFAC_PAT_1") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_SMOKES_NO",
    line = ccb.content.text("No worries.  Good ta see you're still kickin', anyway."),
    replies = { { text = ccb.content.text("See you around."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_SMOKES_YES",
    line = ccb.content.text("They smile and produce a very small bottle of rum and a red plastic lighter.  \"Wicked.  It ain't much and it ain't good, and I ain't got glasses, but it's what I got.  Have a seat?"),
    replies = {
        {
            text = ccb.content.text("Enjoy.  I have to go."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_SMOKES_LEAVE_EARLY",
        },
        {
            text = ccb.content.text("Absolutely."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_SMOKES_MAKE_FRIENDS_1",
        },
        {
            text = ccb.content.text("No smokes for me, but I'll take a drink."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_SMOKES_MAKE_FRIENDS_1",
        },
        {
            text = ccb.content.text("No drink for me, but I'll take a smoke."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_SMOKES_MAKE_FRIENDS_1",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_SMOKES_LEAVE_EARLY",
    line = ccb.content.text("You're a bit of a mystery, but yeah, alright, let's wrap this up.  Far as I'm concerned, you're a friend a mine now, whether ya' like it or not.  Swing by sometime, maybe we can shoot the shit or work on somethin' togethah."),
    replies = { { text = ccb.content.text("See you around."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_SMOKES_MAKE_FRIENDS_1",
    line = ccb.content.text("You and Pat sit together for a long while, the room filled with smoke.  You learn that they're a bit of a weather nerd, and they like drinking, smoking, and baseball.  The topic inevitably turns to the cataclysm and how the first few days went for you both."),
    replies = {
        {
            text = ccb.content.text("[You enjoy the companionship and think this person could be a friend]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_SMOKES_MAKE_FRIENDS_2",
        },
        {
            text = ccb.content.text("[You enjoy the companionship but think making friends is futile]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_SMOKES_LEAVE_EARLY",
        },
        {
            text = ccb.content.text("[You're uncomfortable with this situation and try to end things early]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_SMOKES_LEAVE_EARLY",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_SMOKES_MAKE_FRIENDS_2",
    line = ccb.content.text("After a few somber moments the conversation turns to baseball, which Pat is passionate about and seems to miss.  A few minutes later Pat starts to clean up.  \"THAT was the most fun I've had in a while.  Good to make'a friend.  I'll clean up, yeah?  Swing by again sometime, maybe we can shoot the shit or work on somethin' togethah.\""),
    on_enter = {
        {
            actions = {
                "morale_chat_activity",
                actions.add_effect("interlocutor", "asked_to_socialize", { turns = 7000 }),
            },
        },
    },
    replies = { { text = ccb.content.text("See you around, Pat."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_MISSION_FRIEND_1_COMPLETE",
    line = ccb.content.text("Great.  I already have a wicked prototype and some software, but I think it'll still take a bit.  Come back heah in two days?"),
    replies = {
        {
            text = ccb.content.text("Sure, see you in two days."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_772d908bcb93"), actions.set_actor_value("speaker", "robofac_waiting_on_pat", "yes") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_MISSION_FRIEND_1_MVAS_HVAH",
    line = ccb.content.text("Great.  This should be easy.  Come back tomorrow, and I'll have somethin' for ya'."),
    replies = { { text = ccb.content.text("Sure, see you tomorrow."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_MORALE_CHAT",
    line = {
        choices = {
            ccb.content.text("Tell me ya haven't seen the LAST Sox game.  Found it recorded on a scrap tablet.  Absolute heartbreak, even now.  So in the ninth…"),
            ccb.content.text("You wouldn't believe the data I pulled last night.  Before all this, never seem storms like these.  Lemme tell ya'…"),
            ccb.content.text("Kinda weird, right?  Apocalypse an' I'm still doin' weathah modeling like it matters.  Look at this latest one…"),
            ccb.content.text("You drink rum before noon now, or we still pretendin' it's a bad habit?  Ya' know, I had this rum once…"),
            ccb.content.text("Portal storms ain't random, by the way.  Anyone tells ya that's full a shit.  Listen…"),
            ccb.content.text("This might sound stupid, but it reminds me a little a how things used ta be…"),
            ccb.content.text("So, uh… you trust these folks, or we just survivin' near 'em?  I got ideas…"),
            ccb.content.text("I been rationin' smokes, but yeah, this feels like a good exception…"),
            ccb.content.text("Nevah been a menthol-smoker, but post-apocalypse, they're not bad…"),
            ccb.content.text("Popcorn.  Hot dogs.  Some smuggled-in Rum.  THAT was a ball game…"),
            ccb.content.text("I was thinkin' about the Sox, an' now I'm in a wicked bad mood…"),
            ccb.content.text("I had this theory once, back before everythin' went ta hell…"),
            ccb.content.text("Wicked cool gear you got theah.  Tell me where ya' found it?"),
            ccb.content.text("You wouldn't believe the asshole came through heah earliah…"),
            ccb.content.text("So I been thinkin' about somethin' I saw out theah today…"),
            ccb.content.text("Yeah, sure.  Can I run somethin' by ya?  Nothin' serious…"),
            ccb.content.text("So, we callin' these things zombies?  I dunno…"),
            ccb.content.text("So I've been scannin' the radio waves, and…"),
            ccb.content.text("This reminds me of a bar back home…"),
            ccb.content.text("So what's ya favorite cocktail?"),
        },
    },
    on_enter = {
        {
            actions = {
                "morale_chat_activity",
                actions.add_effect("interlocutor", "asked_to_socialize", { turns = 7000 }),
            },
        },
    },
    replies = { { text = ccb.content.text("[Have a chat then say goodbye]"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_LOST_SIGNAL",
    line = ccb.content.text("Yeah, I was tryin' to ping ya' for a while.  What happened?"),
    replies = {
        {
            text = ccb.content.text("I was standing in a bit of water during a portal storm, and next thing I know, I found myself in some sort of field?  Stretched as far as the eye could see."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_lost_signal_highlands",
            when = predicates.handler("dlg_p_dda_19cbab0e7514"),
        },
        {
            text = ccb.content.text("During the storm, something…  spoke to me…  and took me there.  It's hard to explain."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_lost_signal_portal_storm_dungeon",
            when = predicates.handler("dlg_p_dda_5e2c0afc04fc"),
        },
        {
            text = ccb.content.text("I got tangled up in these webs, and then all of a sudden I'm in some sort of cavern, with the biggest spider I've ever seen."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_lost_signal_spider_dimension",
            when = predicates.handler("dlg_p_dda_4943c9783c0f"),
        },
        {
            text = ccb.content.text("I was standing on the roof of that cabin in a portal storm, when everything just…  it's like I was in a world of just, cabins.  Forever.  Repeating themselves."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_lost_signal_cabin_reverb",
            when = predicates.handler("dlg_p_dda_77b8094442b1"),
        },
        {
            text = ccb.content.text("I was standing up on a radio tower during a portal storm, when everything just…  I don't really know, it's like I fell.  But then there were radio towers.  Forever.  Repeating themselves."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_lost_signal_radiosphere",
            when = predicates.handler("dlg_p_dda_76542a1b502d"),
        },
        {
            text = ccb.content.text("Honestly, Pat, I don't even known what to say about this place, yet.  [ALPHA TEST LABYRINTH]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_lost_signal_labyrinth",
            when = predicates.handler("dlg_p_dda_32a33c437308"),
        },
        {
            text = ccb.content.text("You know that glowing string I was carrying around?  It started moving in the portal storm, and then I was in this…  place.  It's hard to describe."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_lost_signal_string_dimension",
            when = predicates.handler("dlg_p_dda_c289cf76d6f0"),
        },
        {
            text = ccb.content.text("Actually, maybe another time."),
            next_topic = "TALK_ROBOFAC_MERC_PAT",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_GEAR_MENU",
    line = ccb.content.text("Whatsup?"),
    replies = {
        {
            text = ccb.content.text("These glasses are a bit clunky.  Think we can improve them at all?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_IMPROVE_GEAR_NO",
            when = predicates.handler("dlg_p_dda_4b66d64ac935"),
        },
        {
            text = ccb.content.text("We've had these glasses for a while.  They're clunky, fragile, and go through batteries pretty quick.  Think we can improve them at all?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_IMPROVE_GEAR_YES",
            when = predicates.handler("dlg_p_dda_e0727570d7c1"),
        },
        {
            text = ccb.content.text("What do you need if I want another pair of AR glasses?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_REMAKE_AR_GLASSES_NO",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_gave_gear" } }),
            actions = { actions.set_actor_value("speaker", "robofac_pat_told_u_about_remaking_glasses", "yes") },
        },
        {
            text = ccb.content.text("Could I get another pair of AR glasses?  Here are the electronics you need."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_REMAKE_AR_GLASSES_YES",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_gave_gear" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_told_u_about_remaking_glasses" } }), predicates.has_inventory("speaker", "eink_tablet_pc", 2), predicates.has_inventory("speaker", "ar_glasses_advanced", 1), predicates.has_inventory("speaker", "two_way_radio", 2), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } })) }),
            actions = { actions.handler("dlg_a_dda_e3a1db2717d2"), actions.set_actor_value("speaker", "robofac_pat_remaking_glasses", "yes") },
        },
        {
            text = ccb.content.text("Could I get another pair of AR glasses?  Here's 10 HGC for supplies."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_REMAKE_AR_GLASSES_YES",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_gave_gear" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_told_u_about_remaking_glasses" } }), predicates.has_inventory("speaker", "RobofacCoin", 10), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } })) }),
            actions = { actions.handler("dlg_a_dda_7f503ec6d52a"), actions.set_actor_value("speaker", "robofac_pat_remaking_glasses", "yes") },
        },
        {
            text = ccb.content.text("It's been a day.  Are the AR glasses done?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_REMAKE_AR_GLASSES_DONE",
            when = predicates.handler("dlg_p_dda_68566bece6a5"),
            actions = { actions.handler("dlg_a_dda_e0e8bc2bd0a2"), actions.clear_actor_value("speaker", "robofac_pat_remaking_glasses") },
        },
        {
            text = ccb.content.text("What do you need if I want another earpiece?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_REMAKE_EARPIECE_NO",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_finished_earpiece" } }),
            actions = { actions.set_actor_value("speaker", "robofac_pat_told_u_about_remaking_earpiece", "yes") },
        },
        {
            text = ccb.content.text("Could I get another earpiece?  Here's a couple HGC for supplies."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_REMAKE_EARPIECE_YES",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_finished_earpiece" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_told_u_about_remaking_earpiece" } }), predicates.has_inventory("speaker", "RobofacCoin", 2), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } })) }),
            actions = { actions.handler("dlg_a_dda_d95d58a657a5"), actions.set_actor_value("speaker", "robofac_pat_remaking_earpiece", "yes") },
        },
        {
            text = ccb.content.text("Could you set up my new LENS helmet?  I've taken out any mods and software I need."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_LENS_REMAKE",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_gave_LENS_upgrade" } }), predicates.has_inventory("speaker", "robofac_lens_helmet", 1), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } })) }),
        },
        {
            text = ccb.content.text("It's been a day.  Is the earpiece done?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_REMAKE_EARPIECE_DONE",
            when = predicates.handler("dlg_p_dda_33d334fd0cea"),
            actions = { actions.handler("dlg_a_dda_6803713d7a4a"), actions.clear_actor_value("speaker", "robofac_pat_remaking_earpiece") },
        },
        {
            text = ccb.content.text("Let's talk about something else…"),
            next_topic = "TALK_ROBOFAC_MERC_PAT",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_REMAKE_AR_GLASSES_NO",
    line = ccb.content.text("Pair'a advanced AR glasses, 2 two-way radios, and 2 tablet PCs.  Or, ya' cough up 10 HGC, and I'll scrounge up the pahts myself.  Cool?"),
    replies = { { text = ccb.content.text("Cool."), next_topic = "TALK_ROBOFAC_MERC_PAT" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_REMAKE_EARPIECE_NO",
    line = ccb.content.text("No prob.  Just cough up 2 HGC, and I'll scrounge up the pahts myself.  Cool?"),
    replies = { { text = ccb.content.text("Cool."), next_topic = "TALK_ROBOFAC_MERC_PAT" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_REMAKE_AR_GLASSES_YES",
    line = ccb.content.text("&Pat whips out their soldering iron and starts to clear their desk.  \"Wicked.  Come back tomorrah.\""),
    replies = { { text = ccb.content.text("Thanks, Pat.  See you tomorrow."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_REMAKE_EARPIECE_YES",
    line = ccb.content.text("&Pat whips out their soldering iron and starts to clear their desk.  \"Wicked.  Come back tomorrah.\""),
    replies = { { text = ccb.content.text("Thanks, Pat.  See you tomorrow."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_REMAKE_AR_GLASSES_DONE",
    line = ccb.content.text("&Pat picks up a new pair of modified AR glasses, wipes the lenses, and hands them over to you.  \"Careful with this set, yeah?\""),
    replies = { { text = ccb.content.text("Thanks, Pat.  See you later."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_REMAKE_EARPIECE_DONE",
    line = ccb.content.text("&Pat whistles sharply and tosses the earpiece in the air.  You catch it.  Pat chuckles.  \"Don' lose that one, got it?\""),
    replies = { { text = ccb.content.text("Thanks, Pat.  See you later."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_MISSION_FRIEND_1",
    line = ccb.content.text("Actually, yeah, I been thinkin' about this a lot.  I'm probably bettah suited stayin' heah, an' you're bettah out in the field.  I'm wonderin' if maybe we team up.  Partners.  Whaddaya think?"),
    replies = {
        {
            text = ccb.content.text("Sure, I like it.  What do you have in mind?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_MISSION_FRIEND_2",
        },
        {
            text = ccb.content.text("Let me think about this.  We'll talk again later, maybe.  See you later, Pat."),
            next_topic = "TALK_DONE",
        },
        { text = ccb.content.text("I work alone.  I gotta go."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_MISSION_FRIEND_2",
    line = ccb.content.text("Pat taps their glasses - you see that they're a very expensive pair of AR glasses.  \"See these?  Handy, yeah.  Picked'em up after my last paycheck before it all happened.  I'm thinkin' if you can find yourself a pair, plus a couple'a tablet PCs for spare parts, and a couple'a two-way radios, we could set up a controller-operator thing, you know, like in the movies.  I've got a big cache of downloaded map data from my old gig, so no doubt I can keep you informed.  With internet and cell service down, it won't be easy, and we can't share video, but I think I could set up a LoRa system for audio and pictures here at the station - long range radio, yeah?  Wicked.  Anyway, you do the field work, you keep the rewards - all the while, I'll use the contraption I'm gonna make to collect data I can sell to our employers.  Win-Win."),
    replies = {
        {
            text = ccb.content.text("I like it.  1 pair of advanced AR glasses, 2 E-ink tablet PCs, and 2 two-way radios, coming right up."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_MISSION_FRIEND_3",
            actions = { actions.assign_mission("MISSION_ROBOFAC_PAT_2") },
        },
        {
            text = ccb.content.text("Where could I find a pair of those glasses?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_MISSION_FRIEND_2_advice",
        },
        {
            text = ccb.content.text("Actually, I've got this really advanced headset.  Will that work?"),
            when = predicates.any({ predicates.has_inventory("speaker", "military_vis_aug_system", 1), predicates.has_inventory("speaker", "robofac_head_rig_ar", 1) }),
            next_topic = "TALK_ROBOFAC_MERC_PAT_MISSION_FRIEND_2b",
        },
        {
            text = ccb.content.text("On second though, let's talk about this later.  I gotta go."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_MISSION_FRIEND_2b",
    line = ccb.content.text("Lemme see heah… Well, hole-lee shit, fahk yeah it'll work!  That thing's probably got a radio built in, yeah?  In that case, just get a radio and a tablet for me, for parts."),
    replies = {
        {
            text = ccb.content.text("I like it.  I'll find a two-way radio and an E-ink tablet PC."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_MISSION_FRIEND_3",
            actions = { actions.assign_mission("MISSION_ROBOFAC_PAT_2") },
        },
        {
            text = ccb.content.text("On second though, let's talk about this later.  I gotta go."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_MISSION_FRIEND_2_advice",
    line = ccb.content.text("Bought mine at an electronics shop back in town, but they were in demand before the end.  Pre-ordah only.  If you can't find one in a shop, I guess you could always rob someone dead, hah.  Or check out one'a them containah yahrds, or swipe it off a truck.  Don't matter to me."),
    replies = {
        {
            text = ccb.content.text("I like it.  1 pair of advanced AR glasses, 2 E-ink tablet PCs, and 2 two-way radios, coming right up."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_MISSION_FRIEND_3",
            actions = { actions.assign_mission("MISSION_ROBOFAC_PAT_2") },
        },
        {
            text = ccb.content.text("Actually, I've got this really advanced headset.  Will that work?"),
            when = predicates.any({ predicates.has_inventory("speaker", "military_vis_aug_system", 1), predicates.has_inventory("speaker", "robofac_head_rig_ar", 1) }),
            next_topic = "TALK_ROBOFAC_MERC_PAT_MISSION_FRIEND_2b",
        },
        {
            text = ccb.content.text("On second though, let's talk about this later.  I gotta go."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_MISSION_FRIEND_3",
    line = ccb.content.text("Pat laughs, nods, and offers a handshake.  \"See ya around?\""),
    replies = {
        {
            text = ccb.content.text("[Return the handshake]  See you around."),
            next_topic = "TALK_DONE",
        },
        { text = ccb.content.text("[Offer a fistbump]  See you around."), next_topic = "TALK_DONE" },
        {
            text = ccb.content.text("[Go for the shake and pull away last minute]  Hah, psych!  See you around."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_GEAR",
    line = ccb.content.text("Check this shit out, eh?  So ya' wear the glasses like normal, but I've made a leg-strap for the other bits.  The tablet heah is useless for ya', we just need it for extra processin' powah to run the long range radiowave emitter and receiver.  The pictures you send'll be shit, but it should work, long as you aren't stupid enough to drive off to Texas or some shit.  Ya' stick that earbud in ya' ear, and we should be able to chat.  Here's the trick - toggle the recording switch on, and I'll be able to collect pictures and audio now and again, and I'll keep an eye on the feed, even though it may be slow n' ugly.  You just keep that transmitter-receiver toggled on and I'll do what I can to give you some wicked fahkin' good advice and info."),
    replies = {
        {
            text = ccb.content.text("Sounds great.  Guess we'll talk soon."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_IMPROVE_GEAR_NO",
    line = ccb.content.text("We've only just made'em, come on.  Try it out for a couple weeks, then we can talk."),
    replies = { { text = ccb.content.text("Yeah, alright."), next_topic = "TALK_ROBOFAC_MERC_PAT" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_IMPROVE_GEAR_YES",
    line = ccb.content.text("I think this is about as good as my post-apocalyptic engineering will take us, eh?  Unless our employer chips in, or you can dig up one of those cutting-edge military AR units, I think we're S-O-L."),
    replies = {
        {
            text = ccb.content.text("Yeah, alright.  Maybe sometime in the future."),
            next_topic = "TALK_ROBOFAC_MERC_PAT",
            actions = {
                actions.set_actor_value("speaker", "robofac_pat_talked_about_gear_improvement", "yes"),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } }),
        yes = ccb.content.text("&The radio is silent for a moment, then Pat chirps back in, laughing.  \"Yeah, right.  Come by heah sometime and show me your integrated toastah, and maybe I'll believe ya'.\""),
        no = ccb.content.text("&Pat stares at you for a second, and then starts to laugh.  \"Oh, yah?  Well, no kiddin' huh?  If it wasn't for the whole end'a'the'world thing, I'd call ya' crazy, but this freakin' world keeps gettin' weirder by the day… wait, wait, wait, nah.  You're fahkin' with me, right?  Almost had me!\""),
    },
    replies = {
        {
            text = ccb.content.text("[Use your Infolink to chirp Pat's radio]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_80af6556c707"),
        },
        {
            text = ccb.content.text("[Open your finger and show off the Fingerhack]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_72b8a19c68d6"),
        },
        {
            text = ccb.content.text("[Light up your LED Tattoo]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_e962ad0af22f"),
        },
        {
            text = ccb.content.text("[Open your finger and show off the Fingerpick]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_ab82dca84eb2"),
        },
        {
            text = ccb.content.text("[Show off your Shotgun Arm] This…  is my BOOMSTICK!"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_a1150702cf50"),
        },
        {
            text = ccb.content.text("[Arm and trigger your Alarm System]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_44c74770e2b9"),
        },
        {
            text = ccb.content.text("[Extend your Bionic Claws] Check it out, bub."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_e3b016def5dc"),
        },
        {
            text = ccb.content.text("[Do some sick moves using your Uncanny Dodge]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_55c5c3002c81"),
        },
        {
            text = ccb.content.text("[Charge up your EMP Projector to make a cool noise]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_7867852f4ce5"),
        },
        {
            text = ccb.content.text("[Light your Finger Lighter] Need a light?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_4215f45fca37"),
        },
        {
            text = ccb.content.text("[Wiggle your Squeaky Ankles] Well, I didn't say it was anything useful…"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_268bb7bcbc95"),
        },
        {
            text = ccb.content.text("[Loudly ZAP your Super Stun Gun]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_d2a1e7e5e1e4"),
        },
        {
            text = ccb.content.text("[Use your Weather Reader to perfectly recite current atmospheric conditions] Who needs a weather station when you've got implants?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_86ad941963b9"),
        },
        {
            text = ccb.content.text("[Briefly activate your Cloaking Device]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_30939c5bf4f6"),
        },
        {
            text = ccb.content.text("[Activate your Chain Lightning to cast a bolt between your hands]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_1f63a4ba4885"),
        },
        {
            text = ccb.content.text("[Show off your Fingertip Razors and wiggle your eyebrows]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_7d717bbd7627"),
        },
        {
            text = ccb.content.text("[Activate your Protective Lenses]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_102670331900"),
        },
        {
            text = ccb.content.text("[Warp your face using your Facial Distortion]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_51e6bdc8575d"),
        },
        {
            text = ccb.content.text("[Blink in space using Probability Travel]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_4c999bc5d4ed"),
        },
        {
            text = ccb.content.text("[Show off your Monomolecular Blade]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_c6d96b776296"),
        },
        {
            text = ccb.content.text("[Unroll your Cable Charger from your hip] This is my charging system, believe it or not."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_24f55b5d7727"),
        },
        {
            text = ccb.content.text("[Zap the wall with your Finger Laser]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_c75ea311f6cc"),
        },
        {
            text = ccb.content.text("[Show off your Intravenous Needletip]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_d5f2a8f74049"),
        },
        {
            text = ccb.content.text("[Fire up your Integrated Multimeter and start touching things on Pat's desk]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_0513e239e925"),
        },
        {
            text = ccb.content.text("[Use your Artificial Night Generator to dim the room]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_df9541c49459"),
        },
        {
            text = ccb.content.text("[Fire up your Integrated Circuitry Toolset and touch a bit on solder on the desk]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_8eae28e0437c"),
        },
        {
            text = ccb.content.text("[Show off your Autonomous Surgical Scalpels]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_273cf9ed3600"),
        },
        {
            text = ccb.content.text("[ZIT-ZIT-ZOOO - whir up the impact wrench in your Integrated Multitool]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_fb0498f374e3"),
        },
        {
            text = ccb.content.text("Maybe I'll visit in person…"),
            next_topic = "TALK_ROBOFAC_MERC_PAT",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } }),
        },
        {
            text = ccb.content.text("Yeah, just kidding…"),
            next_topic = "TALK_ROBOFAC_MERC_PAT",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
    line = ccb.content.text("Well holy shit!  That's freakin' nuts!  Maybe you can score some kinda fancy implant so we can ditch the ugly-ass AR glasses, yeah?  Lemme know if ya' find one, ya' nut-ckle-head, hah!  Get it?  Nuts n' bolts."),
    replies = {
        {
            text = ccb.content.text("Actually, I have an implanted AR system.  Think you could use it?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_EXODII_AR",
            when = predicates.all({ predicates.has_inventory("speaker", "integrated_ar", 1), predicates.has_trait("speaker", "CBM_Interface") }),
            actions = {
                actions.set_actor_value("speaker", "robofac_pat_said_no_to_exodii_AR_CBM", "yes"),
                actions.set_actor_value("speaker", "robofac_pat_knows_u_cyborg", "yes"),
            },
        },
        {
            text = ccb.content.text("Yeah, alright."),
            next_topic = "TALK_ROBOFAC_MERC_PAT",
            actions = { actions.set_actor_value("speaker", "robofac_pat_knows_u_cyborg", "yes") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_EXODII_AR",
    line = ccb.content.text("Well, I don't see any freakin' plugs on ya', and unless you gone and shoved a Wi-Fi router up ya' ass, I don't see how we're gettin' the software we need on there.  Come back if you get some kind of interface I can work with, and we'll see what's what."),
    replies = {
        {
            text = ccb.content.text("Yeah, alright.  I'll come back if my bionic interface becomes accessible to you."),
            next_topic = "TALK_ROBOFAC_MERC_PAT",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_HUB01",
    line = ccb.content.text("I have, I have.  I hear they're stickin' radios in the skull's of some mercs.  You too, eh?  Crazy shit.  Maybe you can score some kinda fancy implant so we can ditch the ugly-ass AR glasses, yeah?  Lemme know if ya' find one, ya' nut-ckle-head, hah!  Get it?  Nuts n' bolts."),
    replies = {
        {
            text = ccb.content.text("Actually, I have an implanted AR system.  Think you could use it?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_HUB01_AR",
            when = predicates.all({ predicates.has_inventory("speaker", "integrated_ar", 1), predicates.has_trait("speaker", "Hub01_CBM_Interface") }),
        },
        { text = ccb.content.text("Yeah, alright."), next_topic = "TALK_ROBOFAC_MERC_PAT" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_HUB01_AR",
    line = ccb.content.text("No shit?  You also got some kind of internal radio we can use?  If so, I'll plug my computah heah into your USB port, and see what we can do.  Platonically, of course."),
    replies = {
        {
            text = ccb.content.text("Yup, I have an Infolink CBM, too."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_HUB01_AR_INFOLINK_YES",
            when = predicates.handler("dlg_p_dda_80af6556c707"),
        },
        {
            text = ccb.content.text("No, I don't have an internal radio CBM."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_HUB01_AR_INFOLINK_NO",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } })),
            actions = { actions.set_actor_value("speaker", "robofac_pat_said_use_the_earpiece", "yes") },
        },
        {
            text = ccb.content.text("Maybe I should come talk to you in person about this.  I'll swing by sometime."),
            next_topic = "TALK_ROBOFAC_MERC_PAT",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } }),
        },
        {
            text = ccb.content.text("Let's talk about this some other time."),
            next_topic = "TALK_ROBOFAC_MERC_PAT",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_HUB01_AR_INFOLINK_NO",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_finished_earpiece" } }),
        yes = ccb.content.text("Well, I guess an integrated radio'd be nice, but just use the earpiece you have for the headset, yeah?  It should work with that USB port just the same."),
        no = ccb.content.text("&Pat reaches into their pocket and pulls out a small earpiece with some inline electronics.  \"Heah, I've been workin' on this for a while.  You can plug it right into your USB port there, and stick this part here in your ear.  If the earpiece is active, I'll be able to chat and talk with you, yeah?  Turn it off if you need privacy.\""),
    },
    replies = {
        {
            text = ccb.content.text("Great, I'll just use the earpiece for now."),
            next_topic = "TALK_ROBOFAC_MERC_PAT",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_finished_earpiece" } }),
        },
        {
            text = ccb.content.text("Huh, cool.  Thanks, Pat.  Talk to you soon."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_finished_earpiece" } })),
            actions = { actions.handler("dlg_a_dda_6803713d7a4a"), actions.clear_actor_value("speaker", "robofac_pat_finished_earpiece") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_HUB01_AR_INFOLINK_YES",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } }),
        yes = ccb.content.text("Absolutely.  Come by heah sometime and show me, and we'll see what we can do."),
        no = ccb.content.text("&Pat pulls out their laptop, sparks the makeshift car battery they use to power it, then boots it up.  \"Alright, now we're talkin'.  Like I said, I'll have to plug into your USB jack, Jack.  Ready?\""),
    },
    replies = {
        {
            text = ccb.content.text("Sure, I'll come by in person."),
            next_topic = "TALK_ROBOFAC_MERC_PAT",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } }),
        },
        {
            text = ccb.content.text("[Give Pat access to your USB port] Let's do it."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_HUB01_AR_INFOLINK_INSTALLED",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } })),
            actions = { actions.set_actor_value("speaker", "robofac_pat_gave_transponder_CBM", "yes"), actions.handler("dlg_a_dda_ea81fc86a3a3") },
        },
        {
            text = ccb.content.text("Actually, let's talk about this some other time."),
            next_topic = "TALK_ROBOFAC_MERC_PAT",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_HUB01_AR_INFOLINK_INSTALLED",
    line = ccb.content.text("&Pat plugs their laptop into your USB port and starts to clack away.  After 10 minutes, you hear a BEEP.  Your Infolink resets, and Pat unplugs you.  \"All done.  The Hub made that shit theah easy.  All I had to do… well, it isn't impahtant.  Should be able to toggle ya' integrated transpondah to keep connected to me, now.  You can also just call me up on the comm, now, yeah?\""),
    replies = { { text = ccb.content.text("Thanks, Pat."), next_topic = "TALK_ROBOFAC_MERC_PAT" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_MAKE_EARPIECE_MVAS",
    line = ccb.content.text("Well hole-lee shit, look at that heah.  I read about these online before it all happened, eh?  Real assholes, Anduril, with that Tolkien reference.  Betcha he woulda' hated that.  Anyways.  Tell ya' what - ya' let that stay with me for a day, and I betcha I can work something out.  I may have to do a factory reset, so make sure ya' back up any data you need."),
    replies = {
        {
            text = ccb.content.text("Yeah, alright.  I'll see you in a day or so."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_bf1fc7827640"), actions.set_actor_value("speaker", "robofac_pat_started_earpiece", "yes"), actions.set_actor_value("speaker", "robofac_pat_is_holding", "military_vis_aug_system") },
        },
        {
            text = ccb.content.text("Maybe some other time.  See you around."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_MAKE_EARPIECE_HVAH",
    line = ccb.content.text("Well hole-lee shit, look at that heah.  Wicked.  Attached to the helmet and everything!  Tell ya' what - ya' let that stay with me for a day, and I betcha I can work something out.  I may have to do a factory reset, so make sure ya' back up any data you need."),
    replies = {
        {
            text = ccb.content.text("Yeah, alright.  I'll see you in a day or so."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_333a45f80cf4"), actions.set_actor_value("speaker", "robofac_pat_started_earpiece", "yes"), actions.set_actor_value("speaker", "robofac_pat_is_holding", "robofac_head_rig_ar") },
        },
        {
            text = ccb.content.text("Maybe some other time.  See you around."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_LENS_1",
    line = ccb.content.text("What in the evah-lovin' fahk is that supposed to be?  Jesus Christ.  Lemme see that thing.\"  Pat takes the helmet, puts it on, and starts the laugh.  \"There ain't even a goddamn visor on this thing.  Hah!\"\n\nPat takes off the helmet and wipes a hand over its smooth exterior, looking it over closely."),
    replies = {
        {
            text = ccb.content.text("Yeah, well, think you can make it work for our comm system?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_LENS_2",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_LENS_2",
    line = ccb.content.text("Alright, alright, alright let me take a look… yup… there.  Yeah, figures.  Lucky for us our employah's are cheap bastahds.  They slapped a fahkin' USB port on it.  Nothin' says \"sci-fi bullshit\" like a port ripped off a fahkin office printah\".\n\nPat sparks their car battery, hooks their laptop up to it, and boots it up.  \"Hang on a sec."),
    replies = {
        {
            text = ccb.content.text("[Wait quietly and patiently]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_LENS_3",
        },
        {
            text = ccb.content.text("[Laugh and relax]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_LENS_3",
        },
        {
            text = ccb.content.text("Make it quick, Pat."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_LENS_3",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_LENS_3",
    line = ccb.content.text("&After a few minutes, Pat disconnects their laptop from the helmet.  \"Hey, look at that.  No sweat.  This thing's fahkin' nuts, pal.  I just pretuned your software radio doohickey to our frequency.  Long as that helmet's powered up, I can link in.  No prob.  Can also give me a shout over the radio, yeah?  I dunno where you keep the fahkin' trigger for the walkie, but if it's in your ass don't go butt dialin' me while you're in the head, yeah?\""),
    on_enter = {
        { actions = { actions.set_actor_value("speaker", "robofac_pat_gave_LENS_upgrade", "yes"), actions.handler("dlg_a_dda_01132165fc15") } },
    },
    replies = {
        {
            text = ccb.content.text("Hah, will do, Pat.  Thanks.  I wanted to ask talk about something else, too."),
            next_topic = "TALK_ROBOFAC_MERC_PAT",
        },
        {
            text = ccb.content.text("Hah, will do, Pat.  Thanks.  See you around."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_LENS_REMAKE",
    line = ccb.content.text("&Pat boots up their laptop and hooks it to the LENS USB port.  After a few minutes, Pat disconnects their laptop from the helmet.  \"Hey, look at that.  No sweat.\""),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_01132165fc15") } },
    },
    replies = {
        {
            text = ccb.content.text("Thanks, Pat.  I wanted to ask talk about something else, too."),
            next_topic = "TALK_ROBOFAC_MERC_PAT",
        },
        {
            text = ccb.content.text("Thanks, Pat.  See you around."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_GIVE_EARPIECE",
    line = ccb.content.text("Right, so check this shit out.  I rigged up'a small radio transponder to an earpiece.  Just put it in your ear, plug it in'ta the port there on the headset, switch it on, and as long as your AR headset is on, I can see, heah, and talk.  Wicked, eh?  You just keep that transmitter-receiver toggled on and I'll do what I can to give you some wicked fahkin' good advice and info.  On my end, I'll sell data to the Hub to keep me afloat, and you keep whatever comes out of the jobs."),
    replies = {
        {
            text = ccb.content.text("Wicked.  Guess we'll talk soon, Pat.  Thanks."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_RECON_DIRECTIONS_INTRO",
    line = ccb.content.text("Yeah, absolutely.  I'll chat with mercs and traders as they come by.  Check in every 3 days or so?"),
    replies = {
        {
            text = ccb.content.text("Yeah, alright.  Thanks, Pat."),
            next_topic = "TALK_ROBOFAC_MERC_PAT",
            actions = { actions.set_actor_value("speaker", "robofac_pat_talked_about_recon", "yes"), actions.handler("dlg_a_dda_09d8d955a248") },
        },
    },
}
