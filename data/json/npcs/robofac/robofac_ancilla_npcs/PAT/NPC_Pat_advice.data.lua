local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE",
    line = ccb.content.text("What's on your mind?"),
    replies = {
        {
            text = ccb.content.text("Our employer wants me to take this NRE device into a portal storm.  Any advice?"),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_PORTAL_SM_1",
            when = predicates.has_mission("MISSION_ROBOFAC_INTERCOM_PORTAL_SM_1"),
        },
        {
            text = ccb.content.text("I was given one of these mobile weather stations to set up in a portal storm.  Have you ever used one?"),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_1",
            when = predicates.has_mission("MISSION_ROBOFAC_INTERCOM_MWS_1"),
        },
        {
            text = ccb.content.text("Our employer is sending me to something called a 'limnological station' to pick up some new tech.  Any idea what they're talking about?"),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_2",
            when = predicates.has_mission("MISSION_ROBOFAC_INTERCOM_MWS_2"),
        },
        {
            text = ccb.content.text("So, I'm supposed to take this cool weather station into a portal storm.  What do you make of this thing?"),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_3",
            when = predicates.has_mission("MISSION_ROBOFAC_INTERCOM_MWS_3"),
        },
        {
            text = ccb.content.text("Our employer wants me to scan odd weather and places with this HEW system.  Not sure what to make of that.  Have any ideas?"),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4",
            when = predicates.has_mission("MISSION_ROBOFAC_INTERCOM_MWS_4"),
        },
        {
            text = ccb.content.text("Our employer wants me to scan inside that 'thing.'  Have any advice?"),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_MONSTER_CORPSE",
            when = predicates.has_mission("MISSION_ROBOFAC_INTERCOM_MWS_MONSTER_CORPSE"),
        },
        {
            text = ccb.content.text("Our employer wants me to fetch something they lost in a convoy.  Do you know the location?"),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_2",
            when = predicates.has_mission("MISSION_ROBOFAC_INTERCOM_2"),
        },
        {
            text = ccb.content.text("Our employer wants me to fetch some data from this facility.  Do you know anything about it?"),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_LIXA_SM_1",
            when = predicates.has_mission("MISSION_ROBOFAC_INTERCOM_LIXA_SM_1"),
        },
        {
            text = ccb.content.text("Our employer wants me to go to this building and look for some high-tech thing.  Do you know anything about the location?"),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_3",
            when = predicates.has_mission("MISSION_ROBOFAC_INTERCOM_3"),
        },
        {
            text = ccb.content.text("You'll never guess, but our employer wants me to hunt another robot."),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1",
            when = predicates.all({ predicates.has_mission("MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_gave_electronics_books" } })) }),
        },
        {
            text = ccb.content.text("Our employer is sending my to some warehouse owned by 'Anduril Industries' to look for some military AR headset.  Know anything about it?"),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_IVAS",
            when = predicates.has_mission("MISSION_ROBOFAC_INTERCOM_IVAS"),
        },
        {
            text = ccb.content.text("So I've got an address for some kind of central refugee management facility.  Should I check it out?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_REACH_REFUGEE_CENTER",
            when = predicates.has_mission("MISSION_REACH_REFUGEE_CENTER"),
        },
        {
            text = ccb.content.text("Smokes asked me to kill off some zombies in the back bay of the refugee center.  Any thoughts?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_FREE_MERCHANTS_EVAC_1",
            when = predicates.has_mission("MISSION_FREE_MERCHANTS_EVAC_1"),
        },
        {
            text = ccb.content.text("Smokes wants me to take down a bandit camp.  Any ideas?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_FREE_MERCHANTS_EVAC_2",
            when = predicates.all({ predicates.has_mission("MISSION_FREE_MERCHANTS_EVAC_2"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_gave_directions_outpost" } })) }),
        },
        {
            text = ccb.content.text("Any thoughts about delivering a prospectus to some ranch run by the evac shelter crew?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_FREE_MERCHANTS_EVAC_3",
            when = predicates.has_mission("MISSION_FREE_MERCHANTS_EVAC_3"),
        },
        {
            text = ccb.content.text("Smokes wants some solar panels.  Any ideas where I can get some?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_FREE_MERCHANTS_EVAC_4",
            when = predicates.has_mission("MISSION_FREE_MERCHANTS_EVAC_4"),
        },
        {
            text = ccb.content.text("Smokes wants a lot of jars.  Any idea where I can get some?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_FREE_MERCHANTS_EVAC_5",
            when = predicates.all({ predicates.has_mission("MISSION_FREE_MERCHANTS_EVAC_5"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_gave_directions_supermarket" } })) }),
        },
        {
            text = ccb.content.text("So the broker at the shelter wants bigger jars."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_BROKER_1",
            when = predicates.has_mission("MISSION_BROKER_1"),
        },
        {
            text = ccb.content.text("How do you feel about finding the guy from the shelter some cigarettes?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_EVAC_SMOKER_GET_CIGARETTES",
            when = predicates.all({ predicates.has_mission("MISSION_EVAC_SMOKER_GET_CIGARETTES"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_gave_directions_container" } })) }),
        },
        {
            text = ccb.content.text("Should I go check out those farmers the teamster mentioned?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_directions_isherwood",
            when = predicates.has_mission("directions_isherwood"),
        },
        {
            text = ccb.content.text("The teamster told me about 'scrap metal castle' nearby.  You heard anything about it?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_directions_exodii",
            when = predicates.has_mission("directions_exodii"),
        },
        {
            text = ccb.content.text("Any thoughts on this so-called bullet bank?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_directions_artisans",
            when = predicates.has_mission("directions_artisans"),
        },
        {
            text = ccb.content.text("So there's this guy, Dino Dave…"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_BEGGAR_2",
            when = predicates.any({ predicates.has_mission("MISSION_BEGGAR_2_BOX_SMALL"), predicates.has_mission("MISSION_BEGGAR_2_DUCT_TAPE"), predicates.has_mission("MISSION_BEGGAR_2_BOX_MEDIUM"), predicates.has_mission("MISSION_BEGGAR_2_PLASTIC_SHEET"), predicates.has_mission("MISSION_BEGGAR_2_BOX_LARGE"), predicates.has_mission("MISSION_BEGGAR_2_PERMISSION") }),
        },
        {
            text = ccb.content.text("So, this Old Guard doctor…"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_SCIENCE_REP",
            when = predicates.any({ predicates.has_mission("MISSION_SCIENCE_REP_1"), predicates.has_mission("MISSION_SCIENCE_REP_2"), predicates.has_mission("MISSION_SCIENCE_REP_3"), predicates.has_mission("MISSION_SCIENCE_REP_4"), predicates.has_mission("MISSION_SCIENCE_REP_5") }),
        },
        {
            text = ccb.content.text("What do you think about helping out this bartender at the Tacoma Ranch?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_RANCH_BARTENDER",
            when = predicates.any({ predicates.has_mission("MISSION_RANCH_BARTENDER_1"), predicates.has_mission("MISSION_RANCH_BARTENDER_2"), predicates.has_mission("MISSION_RANCH_BARTENDER_3"), predicates.has_mission("MISSION_RANCH_BARTENDER_4"), predicates.has_mission("MISSION_RANCH_BARTENDER_5") }),
        },
        {
            text = ccb.content.text("Any idea where I can get some commercial fertilizer for this Makayla character?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_ARSONIST_1_AMMONIUM_NITRATE",
            when = predicates.all({ predicates.has_mission("MISSION_ARSONIST_1_AMMONIUM_NITRATE"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_gave_directions_farm_supply" } })) }),
        },
        {
            text = ccb.content.text("It seems like a lot of the refugees need help…"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_REFUGEES_misc",
            when = predicates.any({ predicates.has_mission("MISSION_REFUGEE_Boris_CLEANUP"), predicates.has_mission("MISSION_REFUGEE_Boris_WORKSPACE"), predicates.has_mission("MISSION_REFUGEE_Boris_LAPTOP"), predicates.has_mission("MISSION_REFUGEE_Dana_Sourdough"), predicates.has_mission("MISSION_REFUGEE_Draco_GET_GUITAR"), predicates.has_mission("MISSION_REFUGEE_Fatima_1"), predicates.has_mission("MISSION_REFUGEE_Jenny_GET_PNEUMATICS"), predicates.has_mission("MISSION_REFUGEE_Jenny_GET_MOTOR"), predicates.has_mission("MISSION_REFUGEE_Jenny_GET_TANK"), predicates.has_mission("MISSION_REFUGEE_Jenny_GET_TEXT"), predicates.has_mission("MISSION_REFUGEE_Uyen_1"), predicates.has_mission("MISSION_REFUGEE_Uyen_2"), predicates.has_mission("MISSION_REFUGEE_Uyen_3"), predicates.has_mission("MISSION_REFUGEE_Vanessa_1") }),
        },
        {
            text = ccb.content.text("What do you make of this Nunez family wanting to move to Tacoma?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_TACOMA_Nunez",
            when = predicates.has_mission("MISSION_TACOMA_Nunez"),
        },
        {
            text = ccb.content.text("So the Old Guard wants us to kill bandits…"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_OLD_GUARD_REP_1",
            when = predicates.all({ predicates.has_mission("MISSION_OLD_GUARD_REP_1"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_gave_grenade" } })) }),
        },
        {
            text = ccb.content.text("So the Old Guard wants us to track down an informant…"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_OLD_GUARD_REP_2",
            when = predicates.has_mission("MISSION_OLD_GUARD_REP_2"),
        },
        {
            text = ccb.content.text("So the Old Guard has an interest in robots…"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_OLD_GUARD_REP_3-NotMet",
            when = predicates.all({ predicates.has_mission("MISSION_OLD_GUARD_REP_3"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Rubik" } })) }),
        },
        {
            text = ccb.content.text("So the Old Guard has an interest in robots…"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_OLD_GUARD_REP_3-HasMet",
            when = predicates.all({ predicates.has_mission("MISSION_OLD_GUARD_REP_3"), predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Rubik" } }) }),
        },
        {
            text = ccb.content.text("So the Old Guard wants me to look into a monster that's affecting trade routes…"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_OLD_GUARD_REP_4",
            when = predicates.has_mission("MISSION_OLD_GUARD_REP_4"),
        },
        {
            text = ccb.content.text("So I guess I'm a Marshall now…"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_OLD_GUARD_REP_MARSHALL",
            when = predicates.any({ predicates.has_mission("MISSION_OLD_GUARD_REP_5"), predicates.has_mission("MISSION_OLD_GUARD_REPEATER_BEGIN") }),
        },
        {
            text = ccb.content.text("So I found these weird pictographs.  What do you think?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_directions_exodii_signpost",
            when = predicates.has_mission("directions_exodii_signpost"),
        },
        {
            text = ccb.content.text("Any ideas where I can get anesthetic for Rubik?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_RUBIK_ANUS_FETICK",
            when = predicates.all({ predicates.has_mission("RUBIK_ANUS_FETICK"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_gave_directions_hospital" } })) }),
        },
        {
            text = ccb.content.text("Any thoughts on scouting on Hub 01 for Rubik?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_EXODII_MISSION_CONTACT_HUB",
            when = predicates.has_mission("EXODII_MISSION_CONTACT_HUB"),
        },
        {
            text = ccb.content.text("So, Rubik wants us to find a lost interdimensional building…"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_EXODII_MISSION_WAREHOUSE",
            when = predicates.all({ predicates.has_mission("EXODII_MISSION_WAREHOUSE"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_looking_for_exodii_warehouse" } })) }),
        },
        {
            text = ccb.content.text("Any news on that warehouse?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_EXODII_MISSION_WAREHOUSE_NO_FOUND",
            when = predicates.handler("dlg_p_dda_1b302d251b08"),
        },
        {
            text = ccb.content.text("Any news on that warehouse?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_EXODII_MISSION_WAREHOUSE_YES_FOUND",
            when = predicates.handler("dlg_p_dda_8149944efd8f"),
        },
        {
            text = ccb.content.text("Get a load of this… I met this pizza-guy…"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_pizzaiolo",
            when = predicates.any({ predicates.has_mission("MISSION_pizzaiolo_1"), predicates.has_mission("MISSION_pizzaiolo_2"), predicates.has_mission("MISSION_pizzaiolo_3"), predicates.has_mission("MISSION_pizzaiolo_4") }),
        },
        {
            text = ccb.content.text("So these traders want us to hunt some slimes…"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_KILL_SLIMES",
            when = predicates.has_mission("MISSION_KILL_SLIMES"),
        },
        {
            text = ccb.content.text("So these traders want us to hunt some ants…"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_HUNT_ANTS",
            when = predicates.has_mission("MISSION_HUNT_ANTS"),
        },
        {
            text = ccb.content.text("So the traders want to build a camp.  Where should I gather supplies?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_BUILD_CAMP",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_gave_directions_lumbermill" } })), predicates.any({ predicates.has_mission("MISSION_BUILD_CAMP_1"), predicates.has_mission("MISSION_BUILD_CAMP_2"), predicates.has_mission("MISSION_BUILD_CAMP_3"), predicates.has_mission("MISSION_BUILD_CAMP_4"), predicates.has_mission("MISSION_BUILD_CAMP_5"), predicates.has_mission("MISSION_BUILD_CAMP_6") }) }),
        },
        {
            text = ccb.content.text("So about this guy in the cabin in the woods…"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_Warrener",
            when = predicates.any({ predicates.has_mission("directions_lapin"), predicates.has_mission("MISSION_Warrener_LOG_1"), predicates.has_mission("MISSION_pizzaioMISSION_Warrener_FOOD_2lo_3"), predicates.has_mission("MISSION_Warrener_ISHERWOOD") }),
        },
        {
            text = ccb.content.text("So the Isherwoods need some help…"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_ISHERWOOD",
            when = predicates.any({ predicates.has_mission("MISSION_ISHERWOOD_CARLOS_1"), predicates.has_mission("MISSION_ISHERWOOD_CARLOS_2"), predicates.has_mission("MISSION_ISHERWOOD_CHRIS_1"), predicates.has_mission("MISSION_ISHERWOOD_CLAIRE_1"), predicates.has_mission("MISSION_ISHERWOOD_CLAIRE_2"), predicates.has_mission("MISSION_ISHERWOOD_CLAIRE_3"), predicates.has_mission("MISSION_ISHERWOOD_EDDIE_1"), predicates.has_mission("MISSION_ISHERWOOD_EDDIE_2"), predicates.has_mission("MISSION_ISHERWOOD_EDDIE_3"), predicates.has_mission("MISSION_ISHERWOOD_JACK_1"), predicates.has_mission("MISSION_ISHERWOOD_JACK_2"), predicates.has_mission("MISSION_ISHERWOOD_JESSE_1"), predicates.has_mission("MISSION_ISHERWOOD_JESSE_2"), predicates.has_mission("MISSION_ISHERWOOD_LUKE_1"), predicates.has_mission("MISSION_ISHERWOOD_LUKE_2"), predicates.has_mission("MISSION_ISHERWOOD_BARRY_1") }),
        },
        {
            text = ccb.content.text("You know anything about how to troubleshoot a radio tower?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_ROBOFAC_MERC_1_RADIO",
            when = predicates.has_mission("MISSION_ROBOFAC_MERC_1_RADIO"),
        },
        {
            text = ccb.content.text("You heard anything about this monster I heard about at the bar?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_BEM_jabberwock_mission",
            when = predicates.has_mission("BEM_jabberwock_mission"),
        },
        {
            text = ccb.content.text("I met a guy at the bar that wants some kind of 'human sample'…"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_BEM_human_sample_mission",
            when = predicates.has_mission("BEM_human_sample_mission"),
        },
        {
            text = ccb.content.text("So I met this chemist in the woods…"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_CHEMIST",
            when = predicates.any({ predicates.has_mission("MISSION_CABIN_CHEMIST_GET_analytical_set_basic"), predicates.has_mission("MISSION_CABIN_CHEMIST_GET_60_chem_muriatic_acid"), predicates.has_mission("MISSION_CABIN_CHEMIST_GET_500_GAS"), predicates.has_mission("MISSION_CABIN_CHEMIST_SET_TRADE_ROUTE") }),
        },
        {
            text = ccb.content.text("Rubik has asked me to rescue an Exodii from some lab, but I think it might be run by our employer…"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_EXODII_CHOP_SHOP",
            when = predicates.all({ predicates.has_mission("EXODII_MISSION_CHOP_SHOP"), predicates.negate(predicates.has_mission("MISSION_ROBOFAC_INTERCOM_CHOP_SHOP")) }),
        },
        {
            text = ccb.content.text("So our employers wants us to \"shut down\" a lab doing human experiments…"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_ROBOFAC_CHOP_SHOP",
            when = predicates.all({ predicates.has_mission("MISSION_ROBOFAC_INTERCOM_CHOP_SHOP"), predicates.negate(predicates.has_mission("EXODII_MISSION_CHOP_SHOP")) }),
        },
        {
            text = ccb.content.text("This is a doozy… [take a deep breath] Rubik wants us to rescue a captured Exodii from a lab that our employer wants us to shut down, because the lab is allegedly performing unethical experiments on humans… any thoughts on that?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_BOTH_CHOP_SHOP",
            when = predicates.all({ predicates.has_mission("MISSION_ROBOFAC_INTERCOM_CHOP_SHOP"), predicates.has_mission("EXODII_MISSION_CHOP_SHOP") }),
        },
        {
            text = ccb.content.text("So, hunting a third robot for our employer.  One of those Exodii, this time…"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_CIRCUIT_SAFARI",
            when = predicates.all({ predicates.has_mission("MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI") }),
        },
        {
            text = ccb.content.text("That's all.  See you around."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_PORTAL_SM_1",
    line = ccb.content.text("That theah was one of the first jobs they had me do.  I'm not keen to do it again.  I say see if you can find one of these storms, and stay as close to the edge as ya' can, and once that thing beeps, get outta'theah."),
    replies = { { text = ccb.content.text("Thanks."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_1",
    line = ccb.content.text("That theah station's a BEAUT.  Real easy to set up.  We used to load 'em in trucks, so I suggest ya' throw it in the back of somethin', drive into one of those storms theah, set it up, start the recordin' routine, and get the fahk outta' there.  Go back in a day or two and pick it up."),
    replies = { { text = ccb.content.text("Thanks."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_2",
    line = ccb.content.text("We used to contract a few'a those for weather data.  Lemme see those coordinates.\"  Pat takes out his personal device and skims his offline map data.  After a minute, he looks puzzled and turns back to you.  \"The fahk they sending you?  It isn't nowhere I evah heard of.  But look, these places are deathtraps anyhow - little metal coffins in the lake.  I don't envy you."),
    replies = { { text = ccb.content.text("Thanks."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_3",
    line = ccb.content.text("Yeah, I was watchin' when you hauled that device in heah to the intercom.  Looks a lot like the standahd station, but all those strange devices?  I don't have any idea about them theah.  Same advice I'd give for even a nahrmal recordin': drop that thing off, set it up, and get the fahk outta dodge.  Go back the next day when the storm is ovah."),
    replies = { { text = ccb.content.text("Thanks."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_MONSTER_CORPSE",
    line = ccb.content.text("More important, I know the crew they sent as the advanced team.  Be careful with them.  Real careful, hear me?  They sold be some bunk electronics, and overcharged me for it.  Don't trust'em."),
    replies = { { text = ccb.content.text("Thanks."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_2",
    line = ccb.content.text("That's no highway, so whatever is going on there is no doubt cramped.  If it's zombies we're talking about, I suggest you take somethin' that makes a lot of noise.  Or a freakin' machine gun."),
    replies = { { text = ccb.content.text("Thanks a lot."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_LIXA_SM_1",
    line = ccb.content.text("Lemme check my maps.\" Pat looks at their personal device for a while before shaking their head.  \"Whatevah that is, isn't on the public maps I have downloaded.  Take your transpondah and proceed with caution, yeah?  I'll chime in when you get theah."),
    replies = { { text = ccb.content.text("Thanks a lot."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_3",
    line = ccb.content.text("Look, you didn't heah this from me, but I don't think you're the first person they've sent theah.  Whatevah it is, I'd bet a pack of smokes it's dangerous as all hell.  Take your transpondah and stay in touch."),
    replies = { { text = ccb.content.text("Thanks a lot."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } }),
        yes = ccb.content.text("Swing by heah and ask me about this again.  Got somethin' for ya'."),
        no = ccb.content.text("I saw that gun they gave ya' theah.  Cool shit.  I'd take their advice to heaht, though.  If you aren't up to snuff on workin' on electronics, I'd do a bit of reading.  That book they gave ya' is pretty advanced, so here, in case you need something to get stahted."),
    },
    replies = {
        {
            text = ccb.content.text("Sure, I'll swing by sometime."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } }),
        },
        {
            text = ccb.content.text("Thanks a lot."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } })),
            actions = { actions.handler("dlg_a_dda_faece938f91c"), actions.set_actor_value("speaker", "robofac_pat_gave_electronics_books", "yes") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_IVAS",
    line = ccb.content.text("Anduril?  Holy shit, real assholes those guys.  Defense contractah thinks they could get away with naming their weapons manufacturin' after the fahkin' sword of the West - Tolkien - Aragon, yeah?  Read a lot about'em online before it all.  If it's the headset I'm thinkin' of, you mind bringin' it by heah to me before giving it to our employers?  They may'a been assholes but maybe after the end'a the world we can do somethin' fahkin' cool with their tech."),
    replies = {
        {
            text = ccb.content.text("Thanks a lot.  If I find the headset, I'll think about bringing it by to you."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_REACH_REFUGEE_CENTER",
    line = ccb.content.text("Show me on the map.  Yeah, I rememberah them buildin' that place.  Like you I didn't beeline for that shit when it all happened.  Can't imagine anyone nice is runnin' it, but I guess that's true everywhere these days."),
    replies = { { text = ccb.content.text("Thanks a lot."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_FREE_MERCHANTS_EVAC_1",
    line = ccb.content.text("Take a gun.  After the shit you've done for our employahs here, this should be cake, eh?"),
    replies = { { text = ccb.content.text("Thanks a lot."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_FREE_MERCHANTS_EVAC_2",
    line = ccb.content.text("Now we're talkin'.  Seems to me the sorta' thing you should do from a distance, yeah?  Need you a sniper rifle!  I dunno where to get one'a those, but I do know the military had set up some bullshit camps out near my cousin's place before it all happened.  Maybe check it out, get yaself some fiah-powah, yeah?"),
    replies = {
        {
            text = ccb.content.text("Thanks a lot.  Maybe I'll check it out."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
            actions = {
                actions.assign_mission("MISSION_ROBOFAC_PAT_FIAH_POWAH"),
                actions.set_actor_value("speaker", "robofac_pat_gave_directions_outpost", "yes"),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_FREE_MERCHANTS_EVAC_3",
    line = ccb.content.text("Honestly, good to know people are buildin' things up.  Maybe we can get some use out'a'em, too, yeah?  Don't have much to say til we hear'em out."),
    replies = { { text = ccb.content.text("Thanks a lot."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_FREE_MERCHANTS_EVAC_4",
    line = ccb.content.text("This is the northeast, pal.  Go further northeast and every off-the-grid nerd you bump into'll have some on their house.  Check roofs."),
    replies = { { text = ccb.content.text("Thanks a lot."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_FREE_MERCHANTS_EVAC_5",
    line = ccb.content.text("So first they got you killin' bandits, and now you're collectin' jahrs?  This really worth the squeeze?  Anyway, just go to the fahkin' supahmahket and start emptyin' shit out for'em.  Here, I'll upload my favorite to your maps."),
    replies = {
        {
            text = ccb.content.text("Thanks a lot.  Maybe I'll check it out."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
            actions = {
                actions.assign_mission("MISSION_ROBOFAC_PAT_GROCERY"),
                actions.set_actor_value("speaker", "robofac_pat_gave_directions_supermarket", "yes"),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_BROKER_1",
    line = ccb.content.text("More jahrs.  You got me stumped on this one.  I'll leave this one up to you.  Fahkin' jahrs."),
    replies = {
        {
            text = ccb.content.text("Yeah, fair enough."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_EVAC_SMOKER_GET_CIGARETTES",
    line = ccb.content.text("Well, if you're gatherin' cigs, maybe bring some back for me, yeah?  Tell ya' what I bet they got crates full of them in shipping containahs, if you're willin' to dig around.  My cousin's fathah - not really my uncle, but long story - ran one close by.  His name's Mike.  If ya' see'im, ask how his mothah is.  But seriously, if ya' go, go careful, yeah?  I bet we ain't the first to think about this."),
    replies = {
        {
            text = ccb.content.text("Thanks a lot.  Maybe I'll check it out."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
            actions = {
                actions.assign_mission("MISSION_ROBOFAC_PAT_CONTAINAH"),
                actions.set_actor_value("speaker", "robofac_pat_gave_directions_container", "yes"),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_directions_isherwood",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_met_an_isherwood" } }),
        yes = ccb.content.text("It's just that Isherwood farm, yeah?"),
        no = ccb.content.text("More recon is good for me.  Go locked and loaded, yeah?"),
    },
    replies = { { text = ccb.content.text("Thanks a lot."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_directions_exodii",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Rubik" } }),
        yes = ccb.content.text("You've been there, remember?  It's got those fahkin' robots!"),
        no = ccb.content.text("I say this a lot, but go strapped, yeah?  Don't like the sound of that."),
    },
    replies = { { text = ccb.content.text("Thanks a lot."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_directions_artisans",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_met_isolated_road_artisans" } }),
        yes = ccb.content.text("You've been there, remember?  Cody n' Jay."),
        no = ccb.content.text("Could always use more bullets.  If it's like anywhere else, I bet they got work.  Make sure ya' check in if they do."),
    },
    replies = {
        {
            text = ccb.content.text("Right.  Thanks a lot."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_BEGGAR_2",
    line = ccb.content.text("Takes all kinds, I guess.  Never been much for lizards.  Let's treat this as a 'you' job, yeah?"),
    replies = {
        {
            text = ccb.content.text("Yeah… Right.  I guess I'll handle it.  Thanks."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_SCIENCE_REP",
    line = ccb.content.text("Workin' for the doctor is workin' for the feds.  Alright with me, but be careful."),
    replies = { { text = ccb.content.text("Thanks."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_RANCH_BARTENDER",
    line = ccb.content.text("I think it's a GREAT idea.  Maybe we help'em out, they hook us up with a steady supply, yeah?  I heard some other mercs talkin' about a still they used to keep in the woods, before it all.  Maybe that's a good place to look?"),
    replies = { { text = ccb.content.text("Thanks."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_ARSONIST_1_AMMONIUM_NITRATE",
    line = ccb.content.text("Easy, head out to one of those supply stores outta town.  I used'ta pass one when out doing field recahrdings.  Heah, I'll upload the location."),
    replies = {
        {
            text = ccb.content.text("Thanks, maybe I'll check it out."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
            actions = {
                actions.assign_mission("MISSION_ROBOFAC_PAT_OUTTA_TOWN"),
                actions.set_actor_value("speaker", "robofac_pat_gave_directions_farm_supply", "yes"),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_REFUGEES_misc",
    line = ccb.content.text("I think ya' shouldn't be so involved.  Doesn't seem like there's much pay in it.  This is a 'you' job, yeah?"),
    replies = {
        {
            text = ccb.content.text("Sure, that's fair."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_TACOMA_Nunez",
    line = ccb.content.text("I think you shouldn't be involved heah.  No pay in it.  Not your business.  But hey, ya' are.  Might as well see it through."),
    replies = {
        {
            text = ccb.content.text("Sure, that's fair."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_OLD_GUARD_REP_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } }),
        yes = ccb.content.text("Heh, alright, the Feds.  Tell ya' what I got somethin' special for yah'.  Swing by heah and see me."),
        no = ccb.content.text("The Feds.  If they're payin', let's do it.  If they're all laid up in a cabin, I think your best bet may be explosives.  Heah.  Take this grenade.  Don't ask."),
    },
    replies = {
        {
            text = ccb.content.text("Sure, I'll swing by."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } }),
        },
        {
            text = ccb.content.text("[take the grenade] Thanks, Pat.  I'll put it to good use?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } })),
            actions = { actions.set_actor_value("speaker", "robofac_pat_gave_grenade", "yes"), actions.handler("dlg_a_dda_4d9369728ac2") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_OLD_GUARD_REP_2",
    line = ccb.content.text("I don't have any recon in that place.  All up to you."),
    replies = { { text = ccb.content.text("Thanks."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_OLD_GUARD_REP_3-NotMet",
    line = ccb.content.text("Robots.  The fahk is the world comin' to.  Tread carefully."),
    replies = { { text = ccb.content.text("Thanks, will do."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_OLD_GUARD_REP_3-HasMet",
    line = ccb.content.text("Isn't this just that robot you met in that fahkin' castle?"),
    replies = {
        {
            text = ccb.content.text("Oh, right, I remember that.  Thanks."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_OLD_GUARD_REP_4",
    line = ccb.content.text("Monster's the least surprising thing to be fahkin' with a road, isn't it?  I don't have any intel on the area, so you're going in blind.  Lock'n'load."),
    replies = { { text = ccb.content.text("Thanks, will do."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_OLD_GUARD_REP_MARSHALL",
    line = ccb.content.text("Way I see it, you're the Fed, not me.  This is your side gig.  Handle this how you see fit.  And word of advice: don't tell our mutual employah about this."),
    replies = { { text = ccb.content.text("Thanks."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_directions_exodii_signpost",
    line = ccb.content.text("Let me check my maps… yeah… there's nothin' there.  Or, at least, there wasn't nothin' there.  If somethin's there, it happened after it all.  Lock'n'load."),
    replies = {
        {
            text = ccb.content.text("Great, more end-of-the-world stuff."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_RUBIK_ANUS_FETICK",
    line = ccb.content.text("Easy: the fahkin' hospital, ya' fahkin' stunad, hah!  Heah, I'll upload a map to one neahby."),
    replies = {
        {
            text = ccb.content.text("Thanks, mabye I'll check it out."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
            actions = {
                actions.assign_mission("MISSION_ROBOFAC_PAT_HOSPITAL"),
                actions.set_actor_value("speaker", "robofac_pat_gave_directions_hospital", "yes"),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_EXODII_MISSION_CONTACT_HUB",
    line = ccb.content.text("Yeah, don't cross our employahs.  Just tell them the basics, get paid, move on."),
    replies = { { text = ccb.content.text("Thanks."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_EXODII_MISSION_WAREHOUSE",
    line = ccb.content.text("Now THIS is what I'm good at.  Tell ya' what, I can take this one, if you want.  No guarantees on time, but check in once a week, and I'll let ya' know if I find it.  But listen, you should talk to our employah 'bout this, yeah?  I'm tellin' ya, they'd probably cough up a wicked pile'a coins for the tech in that thing.  Think about it."),
    replies = {
        {
            text = ccb.content.text("Absolutely.  I'll check in next week.  And I'll think about telling the intercom."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
            actions = { actions.assign_mission("MISSION_ROBOFAC_PAT_EXODII_WAREHOUSE"), actions.set_actor_value("speaker", "robofac_pat_looking_for_exodii_warehouse", "yes"), actions.handler("dlg_a_dda_0a0865d35a87") },
        },
        {
            text = ccb.content.text("No, I've got this for now.  If I change my mind, I'll let you know."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_EXODII_MISSION_WAREHOUSE_NO_FOUND",
    line = ccb.content.text("Nothin' yet.  Check back later.  Ya' tell our employah' about it yet?  You should."),
    replies = {
        {
            text = ccb.content.text("Thanks.  I'll check in later."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_EXODII_MISSION_WAREHOUSE_YES_FOUND",
    line = ccb.content.text("Boom!  Found it.  I think.  I'll upload the data.  Look, like I said befoah, maybe you go check this place out, but don' touch nothin'.  Negotiate somethin' with the intercom, yeah?"),
    replies = {
        {
            text = ccb.content.text("Thanks, Pat!  If it's what I'm looking for, I guess I'll have to decide if I want to activate the transponder for Rubik, or come talk to the intercom about it."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
            actions = {
                actions.finish_mission("MISSION_ROBOFAC_PAT_1", { success = true }),
                actions.assign_mission("mission_exodii_wh_directions"),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_pizzaiolo",
    line = ccb.content.text("Yeah………… how's'about you handle that one?"),
    replies = {
        {
            text = ccb.content.text("Right… fair enough."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_KILL_SLIMES",
    line = ccb.content.text("Take a mop.  Hah!"),
    replies = { { text = ccb.content.text("Right… thanks."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_HUNT_ANTS",
    line = ccb.content.text("Ants?  Can't be that bad."),
    replies = { { text = ccb.content.text("Sure… thanks."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_BUILD_CAMP",
    line = ccb.content.text("Best bet for all that shit they'll need is a lumbahmill.  In fact, I heard some mercs talkin' about one that's occupied by friendly-ish tradahs.  Heah, check it out."),
    replies = {
        {
            text = ccb.content.text("Thanks.  Maybe I'll check it out."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
            actions = {
                actions.assign_mission("MISSION_ROBOFAC_PAT_LUMBERMILL"),
                actions.set_actor_value("speaker", "robofac_pat_gave_directions_lumbermill", "yes"),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_Warrener",
    line = ccb.content.text("Don't know anything to help.  Sounds like a you job.  If I were you, I wouldn't get involved."),
    replies = { { text = ccb.content.text("Thanks."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_ISHERWOOD",
    line = ccb.content.text("I'm not fahkin' heahtless, but I don't think you should be involved.  Doesn't strike me as a lucrative deal, yeah?  That's all I got to say on that."),
    replies = { { text = ccb.content.text("Thanks."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_ROBOFAC_MERC_1_RADIO",
    line = ccb.content.text("Whateva' you got goin' on is between yous guys - and I mean you n' Cranberry.  We don't talk much."),
    replies = {
        {
            text = ccb.content.text("Well that's odd, but okay.  Thanks."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_BEM_jabberwock_mission",
    line = ccb.content.text("Sure fahkin' have - heard whispers all over that bahr about shit like that.  We know bettah than most monsters'r real, yeah?  Lock'n'load pal."),
    replies = {
        {
            text = ccb.content.text("You're not wrong.  Thanks."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_BEM_human_sample_mission",
    line = ccb.content.text("Yeah… sounds about right for heah.  Do it n' get paid."),
    replies = {
        {
            text = ccb.content.text("Sure, sounds good."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_CHEMIST",
    line = ccb.content.text("Yeah, that ain't how a good story starts, but see this through.  Might make a good tradin' pahrtnah."),
    replies = { { text = ccb.content.text("Yeah, alright."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_EXODII_CHOP_SHOP",
    line = ccb.content.text("Those robots give me the heebies, and I think it's in our bests interests if ya' don't go fahkin' around with something run by our employah, yeah?  Don' bite the hand that feeds."),
    replies = {
        {
            text = ccb.content.text("Yeah, you're probably right."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_ROBOFAC_CHOP_SHOP",
    line = ccb.content.text("Tell ya' what it's gonna be a real pissah.  I'm not sayin' someone has been blabbin', but I do know there's a group'a ex cops doing some kinda' secretive work for the intercom.  If it's them protectin' the place, they're geahed-up to the teeth.  'Hit Squad' wasn't on my bingo-list of post-apocalyptic dreams, but heah we are."),
    replies = {
        {
            text = ccb.content.text("Here are the coordinates.  Can you give me any intel from your old maps?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_CHOP_SHOP_INTEL",
        },
        { text = ccb.content.text("Thanks, Pat."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_BOTH_CHOP_SHOP",
    line = ccb.content.text("Tell ya' what it's gonna be a real pissah.  I'm not sayin' someone has been blabbin', but I do know there's a group'a ex cops doing some kinda' secretive work for the intercom.  If it's them protectin' the place, they're geahed-up to the teeth.  'Hit Squad' wasn't on my bingo-list of post-apocalyptic dreams, but heah we are.  In any case, those robots give me the heebies, and I don't think it's in our best interests to cross our employahs.  But, if they say you can loot the place, loot the place.  Maybe you find their little robot friend and take them back, get a fat payday.  I'd keep a log for the bosses though, yeah?"),
    replies = {
        {
            text = ccb.content.text("Here are the coordinates.  Can you give me any intel from your old maps?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_CHOP_SHOP_INTEL",
        },
        { text = ccb.content.text("Thanks, Pat."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_CHOP_SHOP_INTEL",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } }),
        yes = ccb.content.text("&Your HUD flicks on and low-resolution version of Pat's computer desktop becomes visible.  They start to scan old, grainy satellite images downloaded from Google maps.  \"Old strip mall, yeah?  But looky-theah.  Looks like theah's some window-vents ovah the fahkin' hoppah - the head - the fahkin' toilet.  If I were you, I'd climb up in theah, find ya' way in, make sure ya' set up an escape, and do what needs doin'.\""),
        no = ccb.content.text("&Pat flips open their laptop and wiggles the cable attached to a makeshift battery.  It boots up after a moment and they clack away, looking at old, grainy satellite images downloaded from Google maps.  \"Old strip mall, yeah?  But looky-theah.  Looks like theah's some window-vents ovah the fahkin' hoppah - the head - the fahkin' toilet.  If I were you, I'd climb up in theah, find ya' way in, make sure ya' set up an escape, and do what needs doin'.\""),
    },
    replies = { { text = ccb.content.text("Thanks, Pat."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_CIRCUIT_SAFARI",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_gave_circuit_safari_intel" } }),
        yes = ccb.content.text("Like I said befoah, you're doin' the whole damn world a favor.  Good luck.  Flip on ya' AR headset, and I'll keep an eye on ya' from heah.  Try not to end up beepin' when you back up, yeah?"),
        no = ccb.content.text("I been hearin' a lotta chatter 'bout those freakin' robots 'round heah.  Some kid swears the othah day some OTHAH guy saw one'a those busted-ass… pods, or containahs, or whatevah, and one of those tin-can-robot-fahks looked exactly like his buddy - a buddy who disappeared last week.  You ask me, that's shady as hell - I think those metal bastards are snatchin' people and turnin'em into more robots.  Like that Star Trek crap, yah?  The Blorgs, or whatevah.\n\nAnyway, if you're goin' out huntin' one, you're doin' everybody a favah.  And you'd be doing that poor bastard they turned into a friggin' robot a mercy, ya know?  Put'em outta his misery.\n\nActually, kid told me where that one's at.  You want the coordinates?"),
    },
    replies = {
        {
            text = ccb.content.text("Sure, I think it's worth checking out.  What are the coordinates?"),
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_gave_circuit_safari_intel" } })),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_CIRCUIT_SAFARI_INTEL",
        },
        {
            text = ccb.content.text("Actually, I've had a bit of experience with the Exodii.  In fact, they installed a bionic implant in my brain, and they made me work to get it.  Don't seem to me the type to abduct people."),
            when = predicates.all({ predicates.has_trait("speaker", "CBM_Interface"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_knows_u_cyborg" } })) }),
            actions = { actions.set_actor_value("speaker", "robofac_pat_knows_u_cyborg", "yes") },
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_CIRCUIT_SAFARI_TELL_PAT_ABOUT_IMPLANT",
        },
        {
            text = ccb.content.text("I think I got this, but thanks, Pat."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_CIRCUIT_SAFARI_INTEL",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } }),
        yes = ccb.content.text("&Your HUD flicks on and low-resolution version of Pat's computer desktop becomes visible.  They drop a pin on your map application.  \"Right heah'.  Make sure ya' leave ya' headset on so I can keep an eye on ya'.  And make sure you don't get yaself turned into a toaster.\""),
        no = ccb.content.text("&Pat flips open their laptop and wiggles the cable attached to a makeshift battery.  It boots up after a moment and they clack away, scanning an old, offline version of Google maps until they find a dropped pin.  \"Right heah'.  And hey, batteries ain't cheap anymore, so don't come back needin' em.\""),
    },
    replies = {
        {
            text = ccb.content.text("Thanks, Pat.  Maybe I'll check it out."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
            actions = {
                actions.assign_mission("MISSION_ROBOFAC_PAT_CIRCUIT_SAFARI_RECON"),
                actions.set_actor_value("speaker", "robofac_pat_gave_circuit_safari_intel", "yes"),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_CIRCUIT_SAFARI_TELL_PAT_ABOUT_IMPLANT",
    line = ccb.content.text("&Pat chortles.  \"Well, I dunno about all that, but it explains a lot about you, pal, not gonna lie.  In that case, just don't go lettin'em scan that ugly mug'a yours.  World's already sufferin' enough with extra copies of that goin' around, hah!\""),
    replies = {
        {
            text = ccb.content.text("Hah, will do, Pat.  So, about those coordinates…"),
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_gave_circuit_safari_intel" } })),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_CIRCUIT_SAFARI_INTEL",
        },
        {
            text = ccb.content.text("Hah, thanks, Pat.  Will do.  See you around."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
        },
    },
}
