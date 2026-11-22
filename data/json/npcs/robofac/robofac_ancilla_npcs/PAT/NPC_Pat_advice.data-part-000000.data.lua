local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

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
