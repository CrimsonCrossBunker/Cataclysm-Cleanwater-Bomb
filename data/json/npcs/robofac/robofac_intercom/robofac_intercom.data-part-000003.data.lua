local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_ROBOFAC_INTERCOM_SERVICES", "TALK_ROBOFAC_INTERCOM_SERVICES_FIRST", "TALK_ROBOFAC_INTERCOM_PORTAL_STORMS_END", "TALK_ROBOFAC_INTERCOM_FREE_MERCHANT_DELIVERY_MERCENARY_END", "TALK_ROBOFAC_INTERCOM_PROTOTYPE_NO" },
    line = {
        when = predicates.handler("dlg_p_dda_ef264459b360"),
        yes = {
            choices = {
                ccb.content.text("Good to see you."),
                ccb.content.text("Hello again.  Brought us anything good?"),
                ccb.content.text("What do you need?"),
                ccb.content.text("Oh, hi.  Doing okay?"),
                ccb.content.text("How's that armor working?"),
                ccb.content.text("Sorry, I didn't catch that."),
                ccb.content.text("-ello?  Hello?\"  [Thump thump.]  \"Oh, there we go."),
                ccb.content.text("&The voice on the intercom is humming a tune."),
                ccb.content.text("What's up with the interference in this thing?"),
                ccb.content.text("Speak slowly and clearly.  Please."),
                ccb.content.text("Say again?"),
            },
        },
        no = {
            choices = {
                ccb.content.text("So, do you need something?"),
                ccb.content.text("Yes, mercenary?"),
                ccb.content.text("Mercenary."),
                ccb.content.text("Well?"),
                ccb.content.text("Say it."),
                ccb.content.text("Get with it."),
                ccb.content.text("Make it quick."),
                ccb.content.text("Don't loiter."),
                ccb.content.text("Don't do anything stupid."),
                ccb.content.text("Ugh, I hate intercom duty… oh, um.  Hello."),
                ccb.content.text("Please don't bother us senselessly."),
                ccb.content.text("What's up with the interference in this thing?"),
                ccb.content.text("Speak slowly and clearly.  Please."),
                ccb.content.text("Say again?"),
                ccb.content.text("If/you speak to/understand… you/me. Yes?"),
            },
        },
    },
    on_enter = {
        { actions = { actions.add_effect("interlocutor", "npc_said", { turns = 600 }) } },
    },
    replies = {
        {
            text = ccb.content.text("Let's discuss contracts."),
            next_topic = "TALK_ROBOFAC_INTERCOM_CONTRACTS",
        },
        {
            text = ccb.content.text("Let's trade."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Is there anything fancier you can sell?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_ASK_INTERVAL",
        },
        {
            text = ccb.content.text("Let's discuss prototypes."),
            next_topic = "TALK_ROBOFAC_INTERCOM_PROTOTYPE_MENU",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_u_hub_prototypes" } }),
        },
        {
            text = ccb.content.text("The traders at the refugee center asked me to deliver this drive of FEMA data…"),
            next_topic = "TALK_ROBOFAC_INTERCOM_FREE_MERCHANT_DELIVERY_MERCENARY",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_free_merchants_hub_delivery_1" } })), predicates.has_mission("MISSION_FREE_MERCHANTS_HUB_DELIVERY_1") }),
        },
        {
            text = ccb.content.text("You mentioned portal storms.  What are those?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PORTAL_STORMS",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "global_portal_storms_u_heard_of_portal_storms" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "global_portal_storms_u_witnessed_portal_storm" } })), predicates.negate(predicates.any({ predicates.any_equal({ "yes", { scope = "global", key = "hub01_intercom_told_portal_storms" } }), predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_intercom_told_about_portal_storms" } }) })) }),
        },
        {
            text = ccb.content.text("Listen, something happened earlier.  The world got… bad.  Things felt very wrong.  Do you know anything about what that was?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PORTAL_STORMS",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "global_portal_storms_u_witnessed_portal_storm" } }), predicates.negate(predicates.any({ predicates.any_equal({ "yes", { scope = "global", key = "hub01_intercom_told_portal_storms" } }), predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_intercom_told_about_portal_storms" } }) })) }),
        },
        {
            text = ccb.content.text("I have some portal storm recordings."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_PORTAL_STORM_DATA",
            when = predicates.any({ predicates.has_inventory("speaker", "nre_anomaly_printout_data", 1), predicates.has_inventory("speaker", "small_printout_portal_storm_data", 1), predicates.has_inventory("speaker", "medium_printout_portal_storm_data", 1), predicates.has_inventory("speaker", "large_printout_portal_storm_data", 1) }),
        },
        {
            text = ccb.content.text("I have some HEW recordings."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_accepted_robofac_intercom_mws_4" } }), predicates.any({ predicates.has_inventory("speaker", "HEW_printout_data_portal", 1), predicates.has_inventory("speaker", "HEW_printout_data_portal_storm", 1), predicates.has_inventory("speaker", "HEW_printout_data_vitrified", 1), predicates.has_inventory("speaker", "HEW_printout_data_exodii", 1), predicates.has_inventory("speaker", "HEW_printout_data_strange_temple", 1), predicates.has_inventory("speaker", "HEW_printout_data_lixa", 1), predicates.has_inventory("speaker", "HEW_printout_data_highlands", 1), predicates.has_inventory("speaker", "HEW_printout_data_labyrinth", 1), predicates.has_inventory("speaker", "HEW_printout_data_physics_lab", 1), predicates.has_inventory("speaker", "HEW_printout_data_amigara", 1), predicates.has_inventory("speaker", "HEW_printout_data_radiosphere", 1), predicates.has_inventory("speaker", "HEW_printout_data_monster_corpse", 1), predicates.has_inventory("speaker", "HEW_printout_data_cabin_reverb", 1), predicates.has_inventory("speaker", "HEW_printout_data_cabin_reverb_dimension", 1), predicates.has_inventory("speaker", "HEW_printout_data_barricaded_church", 1), predicates.has_inventory("speaker", "HEW_printout_data_morgantown", 1), predicates.has_inventory("speaker", "HEW_printout_data_void_spider_lair", 1), predicates.has_inventory("speaker", "HEW_printout_data_inner_cabins_open_field", 1), predicates.has_inventory("speaker", "HEW_printout_data_inner_cabins_warped_cabin", 1), predicates.has_inventory("speaker", "HEW_printout_data_inner_cabins_home_cabin", 1), predicates.has_inventory("speaker", "HEW_printout_data_portal_storm_dungeon", 1) }) }),
        },
        {
            text = ccb.content.text("I have found more of those golden robots, can you make anything of them yet?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_YRAX_TOYS",
            when = predicates.all({ predicates.any({ predicates.has_inventory("speaker", "broken_yrax_trifacet", 1), predicates.has_inventory("speaker", "broken_yrax_triakis", 1), predicates.has_inventory("speaker", "broken_golden_monolith", 1), predicates.has_inventory("speaker", "broken_yrax_delta", 1), predicates.has_inventory("speaker", "broken_yrax_quadraphract_leg", 1), predicates.has_inventory("speaker", "broken_yrax_quadraphract", 1), predicates.has_inventory("speaker", "bot_yrax_trifacet", 1), predicates.has_inventory("speaker", "bot_yrax_triakis", 1), predicates.has_inventory("speaker", "bot_golden_monolith", 1), predicates.has_inventory("speaker", "bot_yrax_delta", 1) }), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_robofac_intercom_robot_sm_1" } }) }),
        },
        {
            text = ccb.content.text("What the hell were you testing out there?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PROTOTYPE_ASK",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_robofac_intercom_1" } }), predicates.negate(predicates.any({ predicates.any_equal({ "yes", { scope = "global", key = "hub01_intercom_told_prototype" } }), predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_intercom_told_about_prototype" } }) })) }),
        },
        {
            text = ccb.content.text("Your scientist was wearing some kind of armor.  What is it?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_ARMOR_ASK",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_robofac_intercom_1" } }), predicates.negate(predicates.any({ predicates.any_equal({ "yes", { scope = "global", key = "hub01_intercom_told_armor" } }), predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_intercom_told_about_armor" } }) })) }),
        },
        {
            text = ccb.content.text("I found this in the collapsed tower with the other data.  Is it useful to your people?  [Hand over the UHMWPE nanofabricator template.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_ARMOR_NANO_ASK",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_robofac_intercom_1" } }), predicates.has_inventory("speaker", "template_armor", 1) }),
        },
        {
            text = ccb.content.text("I saw that your mercs have specialty rifles.  Would I be able to get one of those?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PROTOTYPE_NO",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_robofac_merc_1_robofac_merc_1_HWP" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_hub_rnd_u_can_research_rifle" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_u_hub_prototypes" } })) }),
        },
        {
            text = ccb.content.text("I think one of your operatives has vouched for my competency.  I'd like one of those rifles."),
            next_topic = "TALK_ROBOFAC_INTERCOM_PROTOTYPE_GUN_YES",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_robofac_merc_1_robofac_merc_1_HWP" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_hub_rnd_u_can_research_rifle" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_u_hub_prototypes" } })) }),
        },
        {
            text = ccb.content.text("So, about that protective gear?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_BUY_PROTECTIVE_GEAR",
            when = predicates.all({ predicates.has_mission("MISSION_ROBOFAC_INTERCOM_3"), predicates.negate(predicates.any({ predicates.any_equal({ "yes", { scope = "global", key = "hub01_intercom_bought_protective_gear" } }), predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_intercom_npc_bought_protective_gear" } }) })) }),
        },
        {
            text = ccb.content.text("You mentioned you had a map of the area?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_BUY_LOCAL_MAP",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_robofac_intercom_2" } }), predicates.negate(predicates.any({ predicates.any_equal({ "yes", { scope = "global", key = "hub01_intercom_sold_local_map" } }), predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_intercom_sold_local_map" } }) })) }),
        },
        {
            text = ccb.content.text("I need some gear to outfit my crew, I think five sets of police riot armor would do the trick."),
            next_topic = "TALK_ROBOFAC_INTERCOM_BUY_RIOT_GEAR",
            when = predicates.handler("dlg_p_dda_81e6f79d27c9"),
        },
        {
            text = ccb.content.text("I'm here and I've got the goods."),
            next_topic = "TALK_ROBOFAC_INTERCOM_PAY_BACK_RIOT_GEAR",
            when = predicates.all({ predicates.any({ predicates.any_equal({ "yes", { scope = "global", key = "hub01_intercom_pay_back_on_cash" } }), predicates.any_equal({ "yes", { scope = "interlocutor", key = "npc_dialogue_intercom_u_pay_back_on_cash" } }) }), predicates.has_inventory("speaker", "RobofacCoin", 8), predicates.has_mission("MISSION_HUB01_PAY_BACK_RIOT_GEAR") }),
        },
        {
            text = ccb.content.text("Cost of the armor plus everything left in the tower."),
            next_topic = "TALK_ROBOFAC_INTERCOM_PAY_BACK_RIOT_GEAR_SPECIMENS",
            when = predicates.handler("dlg_p_dda_1e75107c89bd"),
        },
        {
            text = ccb.content.text("I have information about a warehouse full of inter-dimensional Exodii tech.  Are you interested?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE",
            when = predicates.handler("dlg_p_dda_da644a19c6d8"),
        },
        {
            text = ccb.content.text("I have information about a warehouse full of exotic tech.  Are you interested?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_INTRODUCE_EXODII_VIA_WAREHOUSE",
            when = predicates.handler("dlg_p_dda_6d11e6c2a474"),
        },
        {
            text = ccb.content.text("Any news on the Exodii warehouse?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE_4a",
            when = predicates.handler("dlg_p_dda_9f5d87c4d5d0"),
        },
        {
            text = ccb.content.text("Any news on the Exodii warehouse?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE_4b",
            when = predicates.handler("dlg_p_dda_fbf314db7395"),
        },
        {
            text = ccb.content.text("Any news on the Exodii warehouse?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE_4c",
            when = predicates.handler("dlg_p_dda_2adf51ff1726"),
        },
        {
            text = ccb.content.text("You mentioned that the Exodii I brought you would be useful for some kind of technology.  Any news on that?"),
            next_topic = "TALK_EXODI_INTERCOM_AUTODOC_A",
            when = predicates.handler("dlg_p_dda_fdfcb8f5ce03"),
        },
        {
            text = ccb.content.text("Any news on that Exodii surgical-thing?"),
            next_topic = "TALK_EXODI_INTERCOM_AUTODOC_B",
            when = predicates.handler("dlg_p_dda_1fbf45f854de"),
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_INTRO",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_u_met_robofac_intercom" } }),
        yes = ccb.content.text("&The intercom is silent."),
        no = ccb.content.text("&The intercom crackles with static as it turns on.  The LED next to the button lights up a bright red, and the camera lens whirs as it focuses on you.  There is no immediate response."),
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "dialogue_intercom_u_met_robofac_intercom", "yes"),
            },
            once = "met_intercom",
        },
    },
    replies = {
        {
            text = ccb.content.text("…Hello?"),
            when = predicates.negate(predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC")),
            next_topic = "TALK_ROBOFAC_INTERCOM_INTRO",
        },
        {
            text = ccb.content.text("Um, can anyone hear me?"),
            when = predicates.negate(predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC")),
            next_topic = "TALK_ROBOFAC_INTERCOM_INTRO",
        },
        {
            text = ccb.content.text("[Tap the camera lens.]  Look, I know someone's listening.  What is this place?"),
            when = predicates.negate(predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC")),
            next_topic = "TALK_ROBOFAC_INTERCOM_INTRO_1",
        },
        {
            text = ccb.content.text("The merchant at the refugee center sent me.  You were looking for a hard drive from them?"),
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_robofac_intercom_1" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_free_merchants_hub_delivery_1" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_u_started_robofac_hdd_trade" } })), predicates.has_mission("MISSION_FREE_MERCHANTS_HUB_DELIVERY_1"), predicates.negate(predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC")) }),
            next_topic = "TALK_ROBOFAC_INTERCOM_FREE_MERCHANT_DELIVERY_1",
        },
        {
            text = ccb.content.text("About that hard drive…"),
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_robofac_intercom_1" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_free_merchants_hub_delivery_1" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_u_started_robofac_hdd_trade" } }), predicates.has_mission("MISSION_FREE_MERCHANTS_HUB_DELIVERY_1"), predicates.negate(predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC")) }),
            next_topic = "TALK_ROBOFAC_INTERCOM_FREE_MERCHANT_DELIVERY_1",
        },
        {
            text = ccb.content.text("The traders mentioned you were looking for help."),
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_robofac_intercom_1" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_free_merchants_hub_delivery_1" } }), predicates.negate(predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC")) }),
            trial = { kind = "lie", difficulty = 1 },
            success = { next_topic = "TALK_ROBOFAC_INTERCOM_INTRO_2" },
            failure = { next_topic = "TALK_ROBOFAC_INTERCOM_INTRO_2" },
        },
        {
            text = ccb.content.text("…Hello?"),
            when = predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC"),
            next_topic = "TALK_ROBOFAC_INTERCOM_CYBORG_INTRO_1",
        },
        {
            text = ccb.content.text("Um, can anyone hear me?"),
            when = predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC"),
            next_topic = "TALK_ROBOFAC_INTERCOM_CYBORG_INTRO_1",
        },
        {
            text = ccb.content.text("[Tap the camera lens.]  Look, I know someone's listening.  What is this place?"),
            when = predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC"),
            next_topic = "TALK_ROBOFAC_INTERCOM_CYBORG_INTRO_1",
        },
        { text = ccb.content.text("[Leave.]"), next_topic = "TALK_DONE" },
    },
}
