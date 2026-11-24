local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- The voice behind the Hub 01 intercom. They handle all front-facing stuff for mercenaries, and trade items using a tray embedded into the wall.
-- This isn't a single person, but rather a rotating group of staff managing the intercom. Be mindful of tone when writing dialogue, since there's no guarantee that the same person will be on the intercom at any given time that the player speaks with Hub 01.
-- Note: Using '*' for non-quoted text will result in the sentence starting out lowercase due to the unique name being an improper noun. Use '&The intercom ' if you want to produce the same effect while maintaining proper grammar!
ccb.content.define_npc {
    id = "robofac_intercom",
    unique_name = ccb.content.text("the intercom"),
    gender = "female",
    class = "NC_ROBOFAC_INTERCOM",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_ROBOFAC_INTERCOM",
    missions_offered = { "MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1", "MISSION_ROBOFAC_INTERCOM_2" },
    faction = "robofac",
}

ccb.content.define_npc_class {
    id = "NC_ROBOFAC_INTERCOM_BASE",
    name = ccb.content.text("intercom (base)"),
    job_description = ccb.content.text("."),
    common = false,
    strength = { rng = { 8, 10 } },
    intelligence = { rng = { 1, 2 } },
    perception = { rng = { 1, 2 } },
    skills = { { skill = "speech", level = { dice = { 2, 2 } } } },
    carry = "EMPTY_GROUP",
    worn = "EMPTY_GROUP",
    weapon = "EMPTY_GROUP",
}

ccb.content.define_npc_class {
    id = "NC_ROBOFAC_INTERCOM",
    copy_from = "NC_ROBOFAC_INTERCOM_BASE",
    name = ccb.content.text("intercom"),
    job_description = ccb.content.text("."),
    shop_groups = {
        { id = "NC_ROBOFAC_INTERCOM_trade", rigid = true },
        {
            id = "NC_ROBOFAC_INTERCOM_trade_armor",
            rigid = true,
            refusal = ccb.content.text("You're not yet qualified to buy this"),
            condition_handler = "hub_armor_stock_unlocked",
        },
        {
            id = "NC_ROBOFAC_INTERCOM_trade_military",
            rigid = true,
            strict = true,
            condition_handler = "hub_military_stock_unlocked",
        },
        {
            id = "robofac_robots",
            rigid = true,
            strict = true,
            condition_handler = "hub_portal_robots_unlocked",
        },
        {
            id = "robofac_gun_mags",
            rigid = true,
            refusal = ccb.content.text("You need to earn an HWP first"),
            condition_handler = "hub_gun_stock_unlocked",
        },
        { id = "robofac_gun_kit", rigid = true, strict = true, condition_handler = "hub_gun_stock_unlocked" },
        {
            id = "robofac_gun_exodii",
            rigid = true,
            strict = true,
            condition_handler = "hub_exodii_gun_stock_unlocked",
        },
        {
            id = "NC_ROBOFAC_INTERCOM_trade_hm12",
            rigid = true,
            strict = true,
            condition_handler = "hub_hm12_stock_unlocked",
        },
        {
            id = "NC_ROBOFAC_INTERCOM_trade_envirosuit",
            rigid = true,
            refusal = ccb.content.text("You're not yet qualified to buy this"),
            condition_handler = "hub_envirosuit_stock_unlocked",
        },
        {
            id = "NC_ROBOFAC_INTERCOM_XM_EXOSKELETONS",
            rigid = true,
            strict = true,
            condition_handler = "hub_autodoc_exoskeletons_unlocked",
        },
        {
            id = "NC_ROBOFAC_INTERCOM_LENS",
            rigid = true,
            strict = true,
            condition_handler = "hub_autodoc_lenses_unlocked",
        },
        {
            id = "NC_ROBOFAC_INTERCOM_MVAS",
            rigid = true,
            strict = true,
            condition_handler = "hub_mvas_stock_unlocked",
        },
    },
    blacklist = "robofac_blacklist",
}

ccb.content.define_npc_class {
    id = "NC_ROBOFAC_INTERCOM_DAY",
    copy_from = "NC_ROBOFAC_INTERCOM_BASE",
    name = ccb.content.text("intercom (day)"),
    job_description = ccb.content.text("."),
    work_hours = { 6, 18 },
    worn = "NC_ROBOFAC_SCIENTIST_worn",
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "RETURN_TO_START_POS" },
        { trait = "INTERCOM_OPERATOR" },
        { trait = "IGNORE_SOUND" },
    },
}

ccb.content.define_npc_class {
    id = "NC_ROBOFAC_INTERCOM_NIGHT",
    copy_from = "NC_ROBOFAC_INTERCOM_BASE",
    name = ccb.content.text("intercom (night)"),
    job_description = ccb.content.text("."),
    work_hours = { 18, 6 },
    worn = "NC_ROBOFAC_SCIENTIST_worn",
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "RETURN_TO_START_POS" },
        { trait = "INTERCOM_OPERATOR" },
        { trait = "IGNORE_SOUND" },
    },
}

-- Day shift operator for Hub 01 intercom. Placed at z=-1 ops room.
ccb.content.define_npc {
    id = "robofac_intercom_day",
    suffix = ccb.content.text("Intercom Operator"),
    class = "NC_ROBOFAC_INTERCOM_DAY",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_ROBOFAC_INTERCOM",
    faction = "robofac",
}

-- Night shift operator for Hub 01 intercom. Placed at z=-1 ops room.
ccb.content.define_npc {
    id = "robofac_intercom_night",
    suffix = ccb.content.text("Intercom Operator"),
    class = "NC_ROBOFAC_INTERCOM_NIGHT",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_ROBOFAC_INTERCOM",
    faction = "robofac",
}

ccb.content.define_npc_class {
    id = "NC_ROBOFAC_INTERCOM_SUPPLY",
    copy_from = "NC_ROBOFAC_INTERCOM",
    name = ccb.content.text("Hub 01 representative"),
    job_description = ccb.content.text("."),
    worn = "NC_ROBOFAC_SCIENTIST_worn",
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "RETURN_TO_START_POS" },
        { trait = "IGNORE_SOUND" },
        { trait = "NO_BASH" },
        { trait = "TRADE_BACKEND" },
    },
}

-- Backend trade actor for Hub 01 intercom. Holds shared shop inventory.
ccb.content.define_npc {
    id = "robofac_intercom_supply",
    suffix = ccb.content.text("Hub 01 Representative"),
    class = "NC_ROBOFAC_INTERCOM_SUPPLY",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_ROBOFAC_INTERCOM",
    faction = "robofac",
}

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

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM",
    line = {
        when = predicates.handler("w16b_p_dda_05358c4abb14"),
        yes = ccb.content.text("&The intercom is dead.  No light, no static, nothing."),
        no = {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_robofac_intercom_1" } }),
            yes = {
                choices = {
                    ccb.content.text("&The intercom is silent."),
                    ccb.content.text("&The intercom crackles on."),
                    ccb.content.text("&The intercom's red LED blinks on."),
                    ccb.content.text("&The intercom says something unintelligible."),
                },
            },
            no = {
                when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_u_discovered_robofac_intercom" } }),
                yes = ccb.content.text("&The intercom is silent."),
                no = ccb.content.text("&An intercom is embedded into the wall here, just next to the card reader.  It's a metal box about as big as a dinner plate, with a speaker shaped like a downwards curve and a large camera prominently featured in the center.  You see a single metal button with a dark LED next to it.  The intercom is silent."),
            },
        },
    },
    replace_native_replies = true,
    on_enter = {
        { once = "discovered_intercom", actions = { actions.set_actor_value("speaker", "dialogue_intercom_u_discovered_robofac_intercom", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("[Leave the dead intercom.]"),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_05358c4abb14"),
        },
        {
            text = ccb.content.text("[Identify yourself before the intercom.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            when = predicates.handler("w16b_p_dda_a851a16c0202"),
            actions = { actions.handler("w16b_a_dda_6aa122c05524") },
        },
        {
            text = ccb.content.text("[Identify yourself before the intercom.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_LEARNS_U_CYBORG",
            when = predicates.handler("w16b_p_dda_9212c5541e94"),
            actions = { actions.set_actor_value("speaker", "robofac_knows_about_u_cyberframe", "yes"), actions.add_effect("speaker", "robofac_surveillance", { turns = 2592000 }) },
        },
        {
            text = ccb.content.text("[Press the button.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_INTRO",
            when = predicates.handler("w16b_p_dda_b23e0697bc03"),
        },
        {
            text = ccb.content.text("[Press the button.]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_1_INQUIRE",
            when = predicates.handler("w16b_p_dda_50779c75cf34"),
        },
        {
            text = ccb.content.text("[Press the button.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_INTRO_3",
            when = predicates.handler("w16b_p_dda_08c1915085bb"),
        },
        {
            text = ccb.content.text("[Press the button.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_INTRO_4",
            when = predicates.handler("w16b_p_dda_405869359679"),
        },
        {
            text = ccb.content.text("[Bang on the metal door.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM",
            when = predicates.handler("w16b_p_dda_fcab9102c2fe"),
        },
        {
            text = ccb.content.text("[Leave.]"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_ROBOFAC_INTERCOM_INTRO_1", "TALK_ROBOFAC_INTERCOM_INTRO_SILENCE" },
    line = ccb.content.text("&The intercom hisses.  A voice of indeterminate sex speaks flatly.  \"I don't know who you are or how you got to this location, but we have nothing to gain from one another.  If you have a reason to be here, then please state your business.  Otherwise, please leave the area.\""),
    replies = {
        {
            text = ccb.content.text("I have a delivery from the Free Merchants.  You requested a hard drive from them."),
            next_topic = "TALK_ROBOFAC_INTERCOM_FREE_MERCHANT_DELIVERY_1",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_robofac_intercom_1" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_free_merchants_hub_delivery_1" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_u_started_robofac_hdd_trade" } })), predicates.has_mission("MISSION_FREE_MERCHANTS_HUB_DELIVERY_1") }),
            actions = { actions.handler("dlg_a_dda_5eabcb8a3b97") },
        },
        {
            text = ccb.content.text("Wait, what?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_INTRO_SILENCE",
        },
        {
            text = ccb.content.text("You do realize that the front door is just open?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_INTRO_SILENCE",
        },
        {
            text = ccb.content.text("It's the apocalypse out here!  Please just let me in!"),
            next_topic = "TALK_ROBOFAC_INTERCOM_INTRO_SILENCE",
        },
        {
            text = ccb.content.text("I'm just looking for valuables.  Maybe we can trade?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_INTRO_SILENCE",
        },
        {
            text = ccb.content.text("Look, there must be something we can work out."),
            next_topic = "TALK_ROBOFAC_INTERCOM_INTRO_2",
            actions = { actions.handler("dlg_a_dda_5eabcb8a3b97") },
        },
        {
            text = ccb.content.text("Well truth be told, this encounter ain't quite so random."),
            next_topic = "TALK_ROBOFAC_WHO_SENT_YOU",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_u_scouted_bunker" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "u_informed_robofac_of_exodii" } })) }),
            actions = { actions.handler("dlg_a_dda_5eabcb8a3b97") },
        },
        {
            text = ccb.content.text("[Leave.]"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_ROBOFAC_INTERCOM_CYBORG_INTRO_1", "TALK_ROBOFAC_INTERCOM_INTRO_CYBORG_SILENCE" },
    line = ccb.content.text("&The intercom hisses.  You hear a series of beeps, then a THUNK as if someone were touching a microphone.  Muffled voices argue in the background.  A brief moment of clarity allows you to hear \"-o that didn't work.\"  After a moment, a voice of indeterminate sex speaks flatly.  \"Saluton.  Greetings.  Ĉu vi povas kompreni min?  Or do you speak English, by chance?\""),
    replies = {
        {
            text = ccb.content.text("Wait, what?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_CYBORG_INTRO_2",
            actions = { actions.handler("dlg_a_dda_5eabcb8a3b97") },
        },
        {
            text = ccb.content.text("You do realize that the front door is just open?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_CYBORG_INTRO_2",
            actions = { actions.handler("dlg_a_dda_5eabcb8a3b97") },
        },
        {
            text = ccb.content.text("It's the apocalypse out here!  Please just let me in!"),
            next_topic = "TALK_ROBOFAC_INTERCOM_CYBORG_INTRO_2",
            actions = { actions.handler("dlg_a_dda_5eabcb8a3b97") },
        },
        {
            text = ccb.content.text("I'm just looking for valuables.  Maybe we can trade?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_CYBORG_INTRO_2",
            actions = { actions.handler("dlg_a_dda_5eabcb8a3b97") },
        },
        {
            text = ccb.content.text("Look, there must be something we can work out."),
            next_topic = "TALK_ROBOFAC_INTERCOM_CYBORG_INTRO_2",
            actions = { actions.handler("dlg_a_dda_5eabcb8a3b97") },
        },
        {
            text = ccb.content.text("[Leave.]"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic { id = "TALK_ROBOFAC_INTERCOM_INTRO_SILENCE", line = ccb.content.text("&The intercom is silent.") }

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_INTRO_CYBORG_SILENCE",
    line = ccb.content.text("&The intercom is silent."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_INTRO_2",
    line = ccb.content.text("I promise you, there is nothing you can do for us.  Now leave, before I'm forced to-\"  They stop suddenly.  You hear a short, muffled conversation from the other end.  There's a brief pause.  \"Alright.  We might be able to gain some mutual benefit.  It's a dangerous task, but if you complete it then we would be willing to open up limited trading access."),
    replies = {
        {
            text = ccb.content.text("I'm listening."),
            next_topic = "MISSION_ROBOFAC_INTERCOM_1_OFFER",
        },
        {
            text = ccb.content.text("Risk my neck for the privilege of trading with you?  Maybe another time."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_CYBORG_INTRO_2",
    line = ccb.content.text("You hear a short, muffled conversation from the other end.  There's a brief pause.  \"English it is.  We believe we could gain some mutual benefit by talking and trading.  We would like to extend you trading access.  But we need something in return.  We would like to know more about your nature.  And we have a task.  It is dangerous, but from the look of you, you'll know exactly how to handle it.\""),
    replies = {
        {
            text = ccb.content.text("I'm listening."),
            next_topic = "TALK_ROBOFAC_INTERCOM_CYBORG_INTRO_3",
            actions = {
                actions.add_effect("speaker", "robofac_surveillance", { turns = 7776000 }),
                actions.set_actor_value("speaker", "robofac_knows_about_u_cyberframe", "yes"),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_CYBORG_INTRO_3",
    line = ccb.content.text("&\"Did someone send you?  Are you… human?  Our scann- I mean, our camera feed suggests you are some sort of cybernetic being?\"\n\nYou detect a slight elevation in their voice, with a start you realize they are nervous."),
    replies = {
        {
            text = ccb.content.text("Yeah, I'm human.  I was turned into a cyborg by beings called Exodii."),
            next_topic = "TALK_ROBOFAC_INTERCOM_CYBORG_INTRO_4",
        },
        {
            text = ccb.content.text("This was some kind of government experiment before everything happened.  I don't fully understand it myself."),
            next_topic = "TALK_ROBOFAC_INTERCOM_CYBORG_INTRO_5",
            trial = { kind = "lie", difficulty = 90 },
            failure = { actions = { actions.adjust_faction_trust(-3) } },
        },
        {
            text = ccb.content.text("Honestly, I have no idea how all of this happened."),
            next_topic = "TALK_ROBOFAC_INTERCOM_CYBORG_INTRO_5",
            trial = { kind = "lie", difficulty = 30 },
            failure = { actions = { actions.adjust_faction_trust(-3) } },
        },
        {
            text = ccb.content.text("I'm an alien robot!  But, I come in peace."),
            next_topic = "TALK_ROBOFAC_INTERCOM_CYBORG_INTRO_5",
            trial = { kind = "lie", difficulty = 15 },
            failure = { actions = { actions.adjust_faction_trust(-3) } },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_CYBORG_INTRO_4",
    line = ccb.content.text("Exodii?  What can you tell us about them?"),
    on_enter = {
        { actions = { actions.set_actor_value("speaker", "u_give_robofac_exodii_info", "yes"), actions.set_actor_value("speaker", "u_informed_robofac_of_exodii", "yes"), actions.handler("dlg_a_dda_419b707aa4cf") } },
    },
    replies = {
        {
            text = ccb.content.text("I mean, just look at me!  They're cyborgs from another dimension.  They turn humans and maybe other beings into cyborgs, and jump from here to there, dodging cataclysms like ours."),
            next_topic = "TALK_ROBOFAC_INTERCOM_CYBORG_INTRO_5",
            actions = { actions.adjust_faction_trust(1), actions.handler("dlg_a_dda_6174ecbde742") },
        },
        {
            text = ccb.content.text("They are a race of inter-dimensional beings.  These guys are more metal than man in my opinion and use automated machinery to do their fighting and heavy lifting.  They do understand English to a certain extent and when talking they use a strange dialect they like to call Anglic."),
            next_topic = "TALK_ROBOFAC_INTERCOM_CYBORG_INTRO_5",
            actions = { actions.adjust_faction_trust(2), actions.handler("dlg_a_dda_6174ecbde742") },
        },
        {
            text = ccb.content.text("They are a race of inter-dimensional beings that use a mix of futuristic and ancient technology, the latter being mostly due to their last landing place being an ancient battlefield of some sort.  These guys are more metal than man in my opinion and use automated machinery to do their fighting and heavy lifting.  While their choice for personal defense was more along the lines of ancient gear like spears and swords.  They do understand English to a certain extent and when talking they use a strange dialect they like to call Anglic."),
            next_topic = "TALK_ROBOFAC_INTERCOM_CYBORG_INTRO_5",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_talk_exodii_about_medieval_stock" } }),
            actions = { actions.adjust_faction_trust(3), actions.handler("dlg_a_dda_6174ecbde742") },
        },
        {
            text = ccb.content.text("They are a race of inter-dimensional beings.  These guys are more metal than man in my opinion and use automated machinery to do their fighting and heavy lifting.  They do understand English to a certain extent and when talking they use a strange dialect they like to call Anglic.  They are here to mine this place of any useful metal, gather any tech they deem worth saving and maybe even grab a couple of survivors to join their ranks before they move out."),
            next_topic = "TALK_ROBOFAC_INTERCOM_CYBORG_INTRO_5",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_know_exodii_purpose2" } }),
            actions = { actions.adjust_faction_trust(4), actions.handler("dlg_a_dda_6174ecbde742") },
        },
        {
            text = ccb.content.text("They are a race of inter-dimensional beings that use a mix of futuristic and ancient technology the latter being mostly due to their last landing place being an ancient battlefield of some sort.  These guys are more metal than man in my opinion and use automated machinery to do their fighting and heavy lifting.  However their choice for personal defense was more along the lines of ancient gear like spears and swords.  They do understand English to a certain extent and when talking they use a strange dialect they like to call Anglic.  They are here to mine this place of any useful metal, gather any tech they deem worth saving and maybe even grab a couple of survivors to join their ranks before they move out."),
            next_topic = "TALK_ROBOFAC_INTERCOM_CYBORG_INTRO_5",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "u_know_exodii_purpose2" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "u_talk_exodii_about_medieval_stock" } }) }),
            actions = { actions.adjust_faction_trust(5), actions.handler("dlg_a_dda_6174ecbde742") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_CYBORG_INTRO_5",
    line = ccb.content.text("Interesting, interesting, interesting.  Hm.  I'll note that information.  Now, about that dangerous task."),
    replies = {
        {
            text = ccb.content.text("I'm listening."),
            next_topic = "MISSION_ROBOFAC_INTERCOM_1_OFFER",
        },
        {
            text = ccb.content.text("Risk my neck for the privilege of trading with you?  Maybe another time."),
            next_topic = "TALK_DONE",
            actions = { actions.add_effect("speaker", "robofac_surveillance", { turns = 7776000 }) },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_WHO_SENT_YOU",
    line = ccb.content.text("&\"We are listening…\"\n\nYou detect a slight elevation in their voice, with a start you realize they are nervous."),
    replies = {
        {
            text = ccb.content.text("Actually I was just joking.  Our meeting is indeed a fortunate accident but now that I have your attention would you be interested in trading in some goods?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_INTRO",
            trial = { kind = "lie", difficulty = 80 },
            failure = {
                actions = {
                    actions.adjust_faction_trust(-3),
                    actions.add_effect("speaker", "robofac_surveillance", { turns = 2592000 }),
                },
            },
        },
        {
            text = ccb.content.text("Some mercenaries I met mentioned this place, said it's a good place to find some work and possibly some valuable post-apocalyptic gear."),
            next_topic = "TALK_ROBOFAC_INTERCOM_INTRO",
            trial = { kind = "lie", difficulty = 90 },
            failure = {
                actions = {
                    actions.adjust_faction_trust(-3),
                    actions.add_effect("speaker", "robofac_surveillance", { turns = 2592000 }),
                },
            },
        },
        {
            text = ccb.content.text("You guys aren't as slick as you think.  You think no one's gonna notice a pristine looking meteorological station in the middle of nowhere with not a potted plant out of place?"),
            next_topic = "TALK_ROBOFAC_EXODII_EXISTENCE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_EXODII_EXISTENCE",
    line = ccb.content.text("Not without significantly advanced surveillance tech most of which were either decommissioned or destroyed post cataclysm."),
    replies = {
        {
            text = ccb.content.text("Actually a bunch of high tech dudes HAVE scouted out this place and wanted me to check it out."),
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "knowledge_exodii_transdimensional_u_knows_exodiilore" } })),
            next_topic = "TALK_ROBOFAC_ABOUT_EXODII_1",
        },
        {
            text = ccb.content.text("I am in tight with a bunch of inter-dimensional travellers who observed this base and sent me out to investigate this place."),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "knowledge_exodii_transdimensional_u_knows_exodiilore" } }),
            next_topic = "TALK_ROBOFAC_ABOUT_EXODII_2",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_ABOUT_EXODII_1",
    line = ccb.content.text("I see and do you have more information regarding these interested parties?"),
    on_enter = {
        { actions = { actions.set_actor_value("speaker", "u_informed_robofac_of_exodii", "yes"), actions.handler("dlg_a_dda_419b707aa4cf"), actions.add_effect("speaker", "robofac_surveillance", { turns = 2592000 }), actions.adjust_faction_trust(1) } },
    },
    replies = {
        {
            text = ccb.content.text("Not really."),
            next_topic = "TALK_ROBOFAC_EXODII_MORE_INFO",
        },
        {
            text = ccb.content.text("Not much actually but I do know they have pretty sweet looking technology as I saw them having advanced machinery everywhere.  Nothing like I've ever seen."),
            next_topic = "TALK_ROBOFAC_EXODII_MORE_INFO",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_EXODII_MORE_INFO",
    line = ccb.content.text("We need more information on these folks, we will be making covert visual contact ourselves but for obvious reasons we can't get inside information without alerting these guys.  That's where you come in…we want you to gather as much information on these people without raising any suspicions and bring it back to us.  Most importantly find who they are and why are they here."),
    replies = {
        {
            text = ccb.content.text("Right.  I'll be back with the juicy details."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("I don't know man sounds kind of dangerous.  What can I expect in return?"),
            next_topic = "TALK_ROBOFAC_EXODII_INFO_REWARD",
        },
        {
            text = ccb.content.text("Absolutely not, these guys are far more powerful than me and one wrong move will get me killed, besides I'm no rat."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_ABOUT_EXODII_2",
    line = ccb.content.text("Inter-dimensional travellers you say?  What kind of tech do these beings operate?  And how were you able to communicate with them?"),
    on_enter = {
        { actions = { actions.set_actor_value("speaker", "u_informed_robofac_of_exodii", "yes"), actions.handler("dlg_a_dda_419b707aa4cf"), actions.add_effect("speaker", "robofac_surveillance", { turns = 2592000 }), actions.adjust_faction_trust(1) } },
    },
    replies = {
        {
            text = ccb.content.text("Alright listen up."),
            next_topic = "TALK_GIVE_ROBOFAC_EXODII_INFO",
        },
        {
            text = ccb.content.text("Information doesn't come cheap my friend."),
            next_topic = "TALK_ROBOFAC_EXODII_INFO_REWARD",
        },
        {
            text = ccb.content.text("I've said more than I ought to have.  I'm leaving."),
            next_topic = "TALK_DONE",
            actions = { actions.adjust_faction_trust(-1) },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GIVE_ROBOFAC_EXODII_INFO",
    line = ccb.content.text("Well?"),
    on_enter = {
        { actions = { actions.set_actor_value("speaker", "u_give_robofac_exodii_info", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("They are a race of inter-dimensional beings who call themselves the Exodii.  These guys are more metal than man in my opinion and use automated machinery to do their fighting and heavy lifting.  They do understand English to a certain extent and when talking they use a strange dialect they like to call Anglic."),
            next_topic = "TALK_FINISH_ROBOFAC_EXODII_DISCUSSION",
            actions = { actions.adjust_faction_trust(1), actions.handler("dlg_a_dda_6174ecbde742") },
        },
        {
            text = ccb.content.text("They are a race of inter-dimensional beings who call themselves the Exodii and they use a mix of futuristic and ancient technology the latter being mostly due to their last landing place being an ancient battlefield of some sort.  These guys are more metal than man in my opinion and use automated machinery to do their fighting and heavy lifting.  While their choice for personal defense was more along the lines of ancient gear like spears and swords.  They do understand English to a certain extent and when talking they use a strange dialect they like to call Anglic."),
            next_topic = "TALK_FINISH_ROBOFAC_EXODII_DISCUSSION",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_talk_exodii_about_medieval_stock" } }),
            actions = { actions.adjust_faction_trust(2), actions.handler("dlg_a_dda_6174ecbde742") },
        },
        {
            text = ccb.content.text("They are a race of inter-dimensional beings who call themselves the Exodii.  These guys are more metal than man in my opinion and use automated machinery to do their fighting and heavy lifting.  They do understand English to a certain extent and when talking they use a strange dialect they like to call Anglic.  They are here to mine this place of any useful metal, gather any tech they deem worth saving and maybe even grab a couple of survivors to join their ranks before they move out."),
            next_topic = "TALK_FINISH_ROBOFAC_EXODII_DISCUSSION",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_know_exodii_purpose2" } }),
            actions = { actions.adjust_faction_trust(2), actions.handler("dlg_a_dda_6174ecbde742") },
        },
        {
            text = ccb.content.text("They are a race of inter-dimensional beings who call themselves the Exodii and they use a mix of futuristic and ancient technology the latter being mostly due to their last landing place being an ancient battlefield of some sort.  These guys are more metal than man in my opinion and use automated machinery to do their fighting and heavy lifting.  However their choice for personal defense was more along the lines of ancient gear like spears and swords.  They do understand English to a certain extent and when talking they use a strange dialect they like to call Anglic.  They are here to mine this place of any useful metal, gather any tech they deem worth saving and maybe even grab a couple of survivors to join their ranks before they move out."),
            next_topic = "TALK_FINISH_ROBOFAC_EXODII_DISCUSSION",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "u_know_exodii_purpose2" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "u_talk_exodii_about_medieval_stock" } }) }),
            actions = { actions.adjust_faction_trust(3), actions.handler("dlg_a_dda_6174ecbde742") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FINISH_ROBOFAC_EXODII_DISCUSSION",
    line = ccb.content.text("Thank you for bringing this information to us…"),
    replies = {
        {
            text = ccb.content.text("Let's talk reward."),
            next_topic = "TALK_ROBOFAC_EXODII_INFO_REWARD",
        },
        {
            text = ccb.content.text("No problem, if you ask me to choose between us and cyborg tyrants, you best believe I ain't betraying my race.  It's unnatural you know?  Please let me know if there is anything else I can do for you guys."),
            next_topic = "TALK_ROBOFAC_INTERCOM_INTRO_4",
            actions = { actions.adjust_faction_trust(2) },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_EXODII_INFO_REWARD",
    line = ccb.content.text("For your services rendered we can either offer you some riot gear armor or the USP 9x19mm pistol with compatible magazines."),
    replies = {
        {
            text = ccb.content.text("Sounds equitable to me.  Be back with that information in a jiff."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "knowledge_exodii_transdimensional_u_knows_exodiilore" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "u_give_robofac_exodii_info" } })) }),
        },
        {
            text = ccb.content.text("That's too little for a whole lot of risk.  I'll pass on this."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "knowledge_exodii_transdimensional_u_knows_exodiilore" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "u_give_robofac_exodii_info" } })) }),
        },
        {
            text = ccb.content.text("Deal!  Now listen close."),
            next_topic = "TALK_GIVE_ROBOFAC_EXODII_INFO",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "knowledge_exodii_transdimensional_u_knows_exodiilore" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "u_give_robofac_exodii_info" } })) }),
        },
        {
            text = ccb.content.text("I'll take the riot armor."),
            next_topic = "TALK_ROBOFAC_INTERCOM_INTRO_4",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_give_robofac_exodii_info" } }),
            actions = { actions.handler("dlg_a_dda_54d5f5b21399") },
        },
        {
            text = ccb.content.text("I'll take the USP."),
            next_topic = "TALK_ROBOFAC_INTERCOM_INTRO_4",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_give_robofac_exodii_info" } }),
            actions = { actions.handler("dlg_a_dda_1abaa1b8273b") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_LEARNS_U_CYBORG",
    line = {
        when = predicates.handler("dlg_p_dda_8fcbe2fd16ae"),
        yes = ccb.content.text("&The intercom flicks on slower than usual.  \"You sound like <u_name>.  But you look like an Exodii.  What's happened, exactly?\""),
        no = ccb.content.text("&The intercom flicks on slower than usual.  \"You sound like <u_name>.  But you look like some sort of cyborg.  What's happened, exactly?\""),
    },
    replies = {
        {
            text = ccb.content.text("I volunteered for this.  A group of cyborgs called the Exodii sold me everything I needed to get these cool mechanical bits."),
            next_topic = "TALK_ROBOFAC_INTERCOM_LEARNS_U_CYBORG_EXODII_INFO",
            when = predicates.handler("dlg_p_dda_22c8f45ae117"),
            actions = { actions.add_effect("speaker", "robofac_surveillance", { turns = 2592000 }) },
        },
        {
            text = ccb.content.text("I volunteered for the Exodii to give me these implants.  Gotta do what you gotta do to survive, no?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_LEARNS_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_8fcbe2fd16ae"),
            actions = { actions.add_effect("speaker", "robofac_surveillance", { turns = 1209600 }) },
        },
        {
            text = ccb.content.text("I volunteered for the Exodii to give me these implants, but don't worry, there's still a red white and blue American in this shell, ready to serve science and humanity."),
            next_topic = "TALK_ROBOFAC_INTERCOM_LEARNS_U_CYBORG_2",
            when = predicates.handler("dlg_p_dda_8fcbe2fd16ae"),
            actions = { actions.add_effect("speaker", "robofac_surveillance", { turns = 1209600 }) },
        },
        {
            text = ccb.content.text("Those crazed cyborgs did this against my will!  But I managed to escape, and it's still me, in here."),
            when = predicates.handler("dlg_p_dda_8fcbe2fd16ae"),
            trial = { kind = "lie", difficulty = 30 },
            success = { next_topic = "TALK_ROBOFAC_INTERCOM_LEARNS_U_CYBORG_2", actions = { actions.add_effect("speaker", "robofac_surveillance", { turns = 1209600 }) } },
            failure = { next_topic = "TALK_ROBOFAC_INTERCOM_LEARNS_U_CYBORG_2", actions = { actions.adjust_faction_trust(-10), actions.add_effect("speaker", "robofac_surveillance", { turns = 2592000 }) } },
        },
        {
            text = ccb.content.text("Not much to say, because I'm not sure.  I just woke up like this.  Crazy stuff, isn't it?"),
            trial = { kind = "lie", difficulty = 15 },
            success = { next_topic = "TALK_ROBOFAC_INTERCOM_LEARNS_U_CYBORG_2", actions = { actions.add_effect("speaker", "robofac_surveillance", { turns = 1209600 }) } },
            failure = { next_topic = "TALK_ROBOFAC_INTERCOM_LEARNS_U_CYBORG_2", actions = { actions.adjust_faction_trust(-10), actions.add_effect("speaker", "robofac_surveillance", { turns = 2592000 }) } },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_LEARNS_U_CYBORG_EXODII_INFO",
    line = ccb.content.text("Exodii?  What can you tell us about them?"),
    on_enter = {
        { actions = { actions.set_actor_value("speaker", "u_give_robofac_exodii_info", "yes"), actions.set_actor_value("speaker", "u_informed_robofac_of_exodii", "yes"), actions.handler("dlg_a_dda_419b707aa4cf") } },
    },
    replies = {
        {
            text = ccb.content.text("I mean, just look at me!  They're cyborgs from another dimension, or dimensions, really.  They turn humans and maybe other beings into cyborgs, and jump from here to there, dodging cataclysms like ours."),
            next_topic = "TALK_ROBOFAC_INTERCOM_LEARNS_U_CYBORG_2",
            actions = { actions.adjust_faction_trust(1), actions.handler("dlg_a_dda_6174ecbde742") },
        },
        {
            text = ccb.content.text("They are a race of inter-dimensional beings.  These guys are more metal than man in my opinion and use automated machinery to do their fighting and heavy lifting.  They do understand English to a certain extent and when talking they use a strange dialect they like to call Anglic."),
            next_topic = "TALK_ROBOFAC_INTERCOM_LEARNS_U_CYBORG_2",
            actions = { actions.adjust_faction_trust(2), actions.handler("dlg_a_dda_6174ecbde742") },
        },
        {
            text = ccb.content.text("They are a race of inter-dimensional beings that use a mix of futuristic and ancient technology, the latter being mostly due to their last landing place being an ancient battlefield of some sort.  These guys are more metal than man in my opinion and use automated machinery to do their fighting and heavy lifting.  While their choice for personal defense was more along the lines of ancient gear like spears and swords.  They do understand English to a certain extent and when talking they use a strange dialect they like to call Anglic."),
            next_topic = "TALK_ROBOFAC_INTERCOM_LEARNS_U_CYBORG_2",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_talk_exodii_about_medieval_stock" } }),
            actions = { actions.adjust_faction_trust(3), actions.handler("dlg_a_dda_6174ecbde742") },
        },
        {
            text = ccb.content.text("They are a race of inter-dimensional beings.  These guys are more metal than man in my opinion and use automated machinery to do their fighting and heavy lifting.  They do understand English to a certain extent and when talking they use a strange dialect they like to call Anglic.  They are here to mine this place of any useful metal, gather any tech they deem worth saving and maybe even grab a couple of survivors to join their ranks before they move out."),
            next_topic = "TALK_ROBOFAC_INTERCOM_LEARNS_U_CYBORG_2",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_know_exodii_purpose2" } }),
            actions = { actions.adjust_faction_trust(4), actions.handler("dlg_a_dda_6174ecbde742") },
        },
        {
            text = ccb.content.text("They are a race of inter-dimensional beings that use a mix of futuristic and ancient technology the latter being mostly due to their last landing place being an ancient battlefield of some sort.  These guys are more metal than man in my opinion and use automated machinery to do their fighting and heavy lifting.  However their choice for personal defense was more along the lines of ancient gear like spears and swords.  They do understand English to a certain extent and when talking they use a strange dialect they like to call Anglic.  They are here to mine this place of any useful metal, gather any tech they deem worth saving and maybe even grab a couple of survivors to join their ranks before they move out."),
            next_topic = "TALK_ROBOFAC_INTERCOM_LEARNS_U_CYBORG_2",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "u_know_exodii_purpose2" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "u_talk_exodii_about_medieval_stock" } }) }),
            actions = { actions.adjust_faction_trust(5), actions.handler("dlg_a_dda_6174ecbde742") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_LEARNS_U_CYBORG_2",
    line = ccb.content.text("Curious.  Very curious.  We'll be interested to follow your… let us say, progress, with these Exodii.  We are glad you still seem so human."),
    replies = {
        {
            text = ccb.content.text("So about those services…"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
        {
            text = ccb.content.text("Right… maybe we'll talk again sometime soon."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_INTRO_3",
    line = {
        when = predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC"),
        yes = ccb.content.text("Ah, yes, our cybernetic visitor.  Would you be willing to tell us more about the cyborgs that did this to you?"),
        no = ccb.content.text("Ah, it's you.  Mind giving your fellow American information regarding possible terrorist cyborgs?"),
    },
    replies = {
        {
            text = ccb.content.text("You know what?  I've changed my mind.  I'll do your dirty work.  Give me some time to chat up these folks."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "knowledge_exodii_transdimensional_u_knows_exodiilore" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "u_give_robofac_exodii_info" } })) }),
        },
        {
            text = ccb.content.text("Please… I stopped being an American the moment the government left us to fend for ourselves."),
            when = predicates.negate(predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC")),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("Maybe some other time…"),
            when = predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC"),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("Fine.  I'll tell you about these inter-dimensional beings."),
            next_topic = "TALK_ROBOFAC_ABOUT_EXODII_2",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "knowledge_exodii_transdimensional_u_knows_exodiilore" } }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_INTRO_4",
    line = ccb.content.text("There is something else that has come up on our side which requires some field agents.  Would you like to hear about it?"),
    replies = {
        {
            text = ccb.content.text("Sounds like you have work for me?  Count me in."),
            next_topic = "MISSION_ROBOFAC_INTERCOM_1_OFFER",
        },
        { text = ccb.content.text("Maybe not right now."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_1_JOBS",
    line = ccb.content.text("Right.  Your handling of this situation was exemplary, and it's clear to us that we greatly underestimated our potential for mutual benefit.  If you are interested, we are willing to offer you more work going forward, and all of it will have proper compensation from now on."),
    replies = {
        {
            text = ccb.content.text("And the trading we agreed on?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_1_JOBS_2",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_1_JOBS_2",
    line = ccb.content.text("Certainly.  I've just finished speaking with a certain individual, who has authorized you limited access to a selection of our internal stores.  We will provide you with pay for contracts in the form of tokens to be used as an exchange currency, which you can then trade for goods.  We are also amenable to bartering in exchange for supplies that are currently difficult for us to obtain from outside the facility."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_npc_intercom_trade", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_trade_unlocked" }, { "yes" }),
                actions.set_actor_value("speaker", "dialogue_intercom_completed_robofac_intercom_1", "yes"),
                actions.finish_mission("MISSION_ROBOFAC_INTERCOM_1", { success = true }),
            },
            once = "unlocked_trade",
        },
    },
    replies = {
        {
            text = ccb.content.text("I'll keep that in mind.  Let's get down to business."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES_FIRST",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SERVICES_FIRST",
    line = ccb.content.text("We look forward to working with you."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_ARMOR_NANO_ASK",
    line = ccb.content.text("Thank you.  This might be of use to us, but we will need at least a day to read the contents of the template.  Please speak with us again once we've had time to look it over."),
    on_enter = {
        { once = "gave_armor_template", actions = { actions.handler("dlg_a_dda_a1cb2e64d7fa"), actions.adjust_faction_trust(2), actions.handler("dlg_a_dda_efd74ae5915b"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_gave_armor_disk", "yes"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_project_ongoing", "yes"), actions.set_actor_value("speaker", "dialogue_intercom_u_hub_prototypes", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("Very well."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
        {
            text = ccb.content.text("I'll see you then."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_ROBOFAC_INTERCOM_FREE_MERCHANT_DELIVERY_1", "TALK_ROBOFAC_INTERCOM_FREE_MERCHANT_DELIVERY_2", "TALK_ROBOFAC_INTERCOM_FREE_MERCHANT_DELIVERY_3" },
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_u_started_robofac_hdd_trade" } }),
        yes = ccb.content.text("&The intercom's tray wordlessly slides open."),
        no = ccb.content.text("&The intercom erupts into static.  Then, it resolves into a voice.  It clears its throat, then speaks slowly and carefully.  \"Understood.  There is a tray embedded beneath the intercom.  Please place the drive into it.\"  On cue, a small portion of the wall beneath the intercom slides out along rails, revealing a large tray several inches deep.  \"You are welcome to leave afterwards.\""),
    },
    on_enter = {
        { once = "started_hdd_trade", actions = { actions.set_actor_value("speaker", "dialogue_intercom_u_started_robofac_hdd_trade", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("[Hand over the FEMA data.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_FREE_MERCHANT_DELIVERY_END",
            when = predicates.has_inventory("speaker", "fema_data", 1),
            actions = { actions.handler("dlg_a_dda_4ba535467f39"), actions.set_actor_value("speaker", "dialogue_intercom_completed_free_merchants_hub_delivery_1", "yes") },
        },
        {
            text = ccb.content.text("Hold on, who are you?  And what do you want with the data?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_FREE_MERCHANT_DELIVERY_2",
        },
        {
            text = ccb.content.text("What am I getting out of this?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_FREE_MERCHANT_DELIVERY_3",
        },
        {
            text = ccb.content.text("Sorry, forgot to grab the drive.  I'll return with it."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_FREE_MERCHANT_DELIVERY_2",
    line = ccb.content.text("&The intercom is silent."),
}

ccb.content.define_dialogue_topic { id = "TALK_ROBOFAC_INTERCOM_FREE_MERCHANT_DELIVERY_3", line = ccb.content.text("Ask Gavin.") }

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_FREE_MERCHANT_DELIVERY_END",
    line = ccb.content.text("&The tray slides shut.  \"Thank you.\"  The intercom turns off without another word."),
    replies = { { text = ccb.content.text("[Leave.]"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_FREE_MERCHANT_DELIVERY_MERCENARY",
    line = ccb.content.text("Oh!  Good.  We had written that off as a non-starter.  Just drop it into the tray and we'll bring it in."),
    replies = {
        {
            text = ccb.content.text("[Hand over the FEMA data.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_FREE_MERCHANT_DELIVERY_MERCENARY_END",
            when = predicates.has_inventory("speaker", "fema_data", 1),
            actions = { actions.handler("dlg_a_dda_4ba535467f39"), actions.set_actor_value("speaker", "dialogue_intercom_completed_free_merchants_hub_delivery_1", "yes") },
        },
        {
            text = ccb.content.text("I don't have the drive with me right now; I'll give it to you when I have it."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_FREE_MERCHANT_DELIVERY_MERCENARY_END",
    line = ccb.content.text("Thank you.  Was there anything else you needed?"),
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_PORTAL_STORMS",
    line = ccb.content.text("That question has… a complicated answer."),
    replies = {
        {
            text = ccb.content.text("I'd like to hear it."),
            next_topic = "TALK_ROBOFAC_INTERCOM_PORTAL_STORMS_1",
        },
        { text = ccb.content.text("Later, then."), next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES" },
    },
}

-- These lines are being paraphrased mostly from written information, so repeating things or using distinct phrasing is fine
ccb.content.define_dialogue_topic {
    id = {
        "TALK_ROBOFAC_INTERCOM_PORTAL_STORMS_1", "TALK_ROBOFAC_INTERCOM_PORTAL_STORMS_2",
        "TALK_ROBOFAC_INTERCOM_PORTAL_STORMS_3", "TALK_ROBOFAC_INTERCOM_PORTAL_STORMS_4",
        "TALK_ROBOFAC_INTERCOM_PORTAL_STORMS_5", "TALK_ROBOFAC_INTERCOM_PORTAL_STORMS_6",
    },
    line = ccb.content.text("Understand that I'm not an expert about this.\"  The voice sighs.  You hear the person on the other side typing on a keyboard for several seconds.  \"I will explain it as best I can, but again, I'm not a professional.  Whatever caused the apocalypse, it… broke something about the way our world works.  I'm sure you've noticed that 'normal' physics don't always apply anymore.  We are, as of right now, uncertain if our models were wrong, or if this is something fundamentally different to our reality.\"\n\n\"From what we've observed, these events are what happen at the peak of a cyclical effect.  This is gross oversimplification, and I don't know the science behind it, but… I guess the simplest way to think of it is that 'our' reality is moving closer and further from this other place, or model, or so on.  Like a yo-yo.  When these two things are closest together, we get portal storms.  Otherwise, things are… I wouldn't say normal, not anymore, but they are as close to normal as we get now.\"\n\n\"Reading a footnote here… we're looking to gather data about these storms using a device developed specifically for the purpose.  I'll add that to your contracts list, if you want to know more about it."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_told_about_portal_storms", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_told_portal_storms" }, { "yes" }),
            },
            once = "told_about_portal_storms",
        },
    },
    replies = {
        {
            text = ccb.content.text("Are there any warning signs?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PORTAL_STORMS_2",
        },
        {
            text = ccb.content.text("Is there any way to stay safe during one?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PORTAL_STORMS_3",
        },
        {
            text = ccb.content.text("That sounds pretty bad.  Is this going to get worse?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PORTAL_STORMS_4",
        },
        {
            text = ccb.content.text("How can you know all this?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PORTAL_STORMS_5",
        },
        {
            text = ccb.content.text("Is there anything useful I could find in one of these storms?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PORTAL_STORMS_6",
        },
        {
            text = ccb.content.text("Thank you for the information."),
            next_topic = "TALK_ROBOFAC_INTERCOM_PORTAL_STORMS_END",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_PORTAL_STORMS_2",
    line = ccb.content.text("In a way.  In the days and hours leading up to one of these events, you may see things that are obviously out of place, or that don't make sense.  This is most clear during the nighttime, but you can see it during the day, too.  If this happens once, take note of it.  If it happens again, be ready for anything."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_PORTAL_STORMS_3",
    line = ccb.content.text("Yes and no.  When something like this is going on, the storm is going to affect you one way or another, but being outside is much more dangerous.  If you can, find a solid shelter.  Stay as far away from the outer walls as you can.  Being underground is probably a good idea.  There are likely undocumented psychological effects; use your best judgment and your common sense."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_PORTAL_STORMS_4",
    line = ccb.content.text("Unfortunately, it seems likely.  This isn't exactly something we can measure with traditional instruments, but observation has shown that they're not likely to get better.  By far the strongest so far was at the start of the Cataclysm, and while we cannot accurately predict what the future holds, our projections are not optimistic.  I wish I could tell you anything else, but I would advise you get used to seeing them going forward."),
}

-- this is lie of omission. Hub 01 is explicitly aware of XEDRA and the work they were doing, and the staff likely had an indication just before the Cataclysm hit that things were about to get really bad, leading them to back up a vast amount of online information before the internet was completely knocked out.
ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_PORTAL_STORMS_5",
    line = ccb.content.text("We have a vested interest in determining how these events will influence the future of the planet - as should you.  Most of the equipment inside of this facility has remained in working order, and although the Internet no longer exists in a functional way, we still have a plethora of information that was stored locally prior to <the_cataclysm>.  We are monitoring and documenting these portal storms, and we will continue to do so for the foreseeable future."),
}

-- A recording to give proof without requiring those who know the most about portal storms to risk their agents.
ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_PORTAL_STORMS_6",
    line = ccb.content.text("Potentially.  We recently came into possession of a video taken during the first days of <the_cataclysm> using a home camcorder.  We have ruled out possible tampering, and conclude that the recording is legitimate.  It depicts an entity that appeared to rapidly change shape, but responded especially strongly to human presence.  Eventually, the entity reshaped itself into a small object, which the author of the recording claimed had anomalous properties.\"\n\n\"Subsequent entities of this type have failed to manifest during remote observation of the phenomenon.  We hypothesize that, if they do exist at all, they may only appear in response to human presence.  While we consider the hypothesis too dangerous and too uncertain to test using our own resources, we would be eager to hear the results if you attempted to do so yourself."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_ARMOR_ASK",
    line = ccb.content.text("We've been working on specialized gear for potential agents in the field, given the hardware we have available.  Given the risks we've observed from here, it seemed astute.  It seems we still have some work to do."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_told_about_armor", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_told_armor" }, { "yes" }),
            },
            once = "told_about_armor",
        },
    },
    replies = {
        { text = ccb.content.text("…"), next_topic = "TALK_ROBOFAC_INTERCOM_ARMOR_NEUTRAL" },
        {
            text = ccb.content.text("[INT 10] The pieces seemed warped.  Whatever you're using to reinforce the armor isn't strong enough."),
            when = predicates.minimum_attribute("speaker", "intelligence", 10),
            next_topic = "TALK_ROBOFAC_INTERCOM_ARMOR_POSITIVE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_ARMOR_NEUTRAL",
    line = ccb.content.text("&The intercom goes quiet for a moment.  You hear a brief exchange on the other end, and then the microphone squeals as the voice gets closer again.  \"As additional payment for helping resolve the situation, feel free to keep the modular defense system.  The core armor platform is solid, and we have been iterating on supplementary pieces that we would be willing to trade to you.\""),
    replies = {
        { text = ccb.content.text("Thank you."), next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES" },
        {
            text = ccb.content.text("I've always wanted to be a lab rat."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
        { text = ccb.content.text("If you say so."), next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_ARMOR_POSITIVE",
    line = ccb.content.text("We've solved that issue with our more recent prototypes.\"  There is a brief pause.  \"You seem like a good candidate.  We will transfer over the additional pieces to complete that prototype set, with the goal of collecting additional field data.  The core armor platform is solid, and we have been iterating on supplementary pieces we would be willing to trade to you.  Any feedback on their performance would be appreciated."),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_ae90e528a11f") } },
    },
    replies = {
        {
            text = ccb.content.text("Thank you."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            actions = { actions.handler("dlg_a_dda_b452b1ce4f53") },
        },
        {
            text = ccb.content.text("Hopefully it serves me better than the good doctor."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            actions = { actions.handler("dlg_a_dda_b452b1ce4f53") },
        },
        {
            text = ccb.content.text("We'll see what happens."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            actions = { actions.handler("dlg_a_dda_b452b1ce4f53") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_PROTOTYPE_ASK",
    line = ccb.content.text("It was a modified Wraitheon chassis, with a custom AI.  We'd hoped that it would interact with the outside world for us, but you know how well that went.  That particular line of study is now on hiatus, given that the project lead… well, you know."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_told_about_prototype", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_told_prototype" }, { "yes" }),
            },
            once = "told_about_prototype",
        },
    },
    replies = { { text = ccb.content.text("Right."), next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_ASK_INTERVAL",
    line = {
        choices = {
            ccb.content.text("We have no other disposable equipment right now.  You'll have to come back after <restock_time_point>."),
            ccb.content.text("No. Come back after <restock_time_point>."),
        },
    },
    replies = { { text = ccb.content.text("Right…"), next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_INTRODUCE_EXODII_VIA_WAREHOUSE",
    line = ccb.content.text("What kind of exotic tech?  I'll need more information than that to even consider payment."),
    replies = {
        {
            text = ccb.content.text("It's a warehouse owned by a race of inter-dimensional beings who call themselves the Exodii.  They're… robots?  Cyborgs?  More metal than man in my opinion.  They use automated machinery to do their fighting and heavy lifting.  They do understand English to a certain extent, but when talking they use a strange dialect they like to call Anglic."),
            next_topic = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE",
            actions = { actions.adjust_faction_trust(1), actions.handler("dlg_a_dda_687c0fab6ae8") },
        },
        {
            text = ccb.content.text("It's a warehouse owned by a race of inter-dimensional beings who call themselves the Exodii.  They're… robots?  Cyborgs?  More metal than man in my opinion.  They use automated machinery to do their fighting and heavy lifting, and they seem to have a preference for large firearms, swords, and spears.  They do understand English to a certain extent, but when talking they use a strange dialect they like to call Anglic."),
            next_topic = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_talk_exodii_about_medieval_stock" } }),
            actions = { actions.adjust_faction_trust(2), actions.handler("dlg_a_dda_687c0fab6ae8") },
        },
        {
            text = ccb.content.text("It's a warehouse owned by a race of inter-dimensional beings who call themselves the Exodii.  They're… robots?  Cyborgs?  More metal than man in my opinion.  They use automated machinery to do their fighting and heavy lifting.  They do understand English to a certain extent, but when talking they use a strange dialect they like to call Anglic.  From what I understand, they are here to mine this place of any useful metal, gather any tech they deem worth saving and maybe even grab a couple of survivors to join their ranks before they move out."),
            next_topic = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_know_exodii_purpose2" } }),
            actions = { actions.adjust_faction_trust(2), actions.handler("dlg_a_dda_687c0fab6ae8") },
        },
        {
            text = ccb.content.text("It's a warehouse owned by a race of inter-dimensional beings who call themselves the Exodii.  They're… robots?  Cyborgs?  More metal than man in my opinion.  They use automated machinery to do their fighting and heavy lifting, and they seem to have a preference for large firearms, swords, and spears.  They do understand English to a certain extent, but when talking they use a strange dialect they like to call Anglic.  From what I understand, they are here to mine this place of any useful metal, gather any tech they deem worth saving and maybe even grab a couple of survivors to join their ranks before they move out."),
            next_topic = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "u_know_exodii_purpose2" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "u_talk_exodii_about_medieval_stock" } }) }),
            actions = { actions.adjust_faction_trust(3), actions.handler("dlg_a_dda_687c0fab6ae8") },
        },
        {
            text = ccb.content.text("Actually, nevermind."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE",
    line = ccb.content.text("&The intercom is silent for a long moment, before a different voice replies:  \"If this warehouse is indeed full of inter-dimensional cyborg technology, we would be willing to pay generously for its location.\""),
    replies = {
        {
            text = ccb.content.text("I can give you the coordinates, for a price."),
            next_topic = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE_2a",
            when = predicates.handler("dlg_p_dda_88b494c31259"),
        },
        {
            text = ccb.content.text("I'll give you the coordinates free of charge - consider it part of our ongoing professional relationship."),
            next_topic = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE_3",
            when = predicates.handler("dlg_p_dda_88b494c31259"),
            actions = { actions.adjust_faction_trust(3), actions.handler("dlg_a_dda_17ca1cc4d07b") },
        },
        {
            text = ccb.content.text("Actually, nevermind.  I don't know where it is."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE_2a",
    line = ccb.content.text("Very well.  We are prepared to offer 5 HGCs, which is generous, given that this is a considerable risk."),
    replies = {
        {
            text = ccb.content.text("Deal!  5 HGCs in exchange for the coordinates."),
            next_topic = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE_3",
            actions = { actions.adjust_faction_trust(1), actions.handler("dlg_a_dda_3c564ddaa56c") },
        },
        {
            text = ccb.content.text("I don't need any coins, but I'd like you to tell me about the tech you find inside."),
            next_topic = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE_3",
            actions = { actions.adjust_faction_trust(1), actions.handler("dlg_a_dda_729e39bdeb38") },
        },
        {
            text = ccb.content.text("I want 10 HGCs."),
            trial = { kind = "persuade", difficulty = 20 },
            success = { next_topic = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE_3", actions = { actions.adjust_faction_trust(1), actions.handler("dlg_a_dda_7ece42511df9") } },
            failure = { next_topic = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE_2b" },
        },
        {
            text = ccb.content.text("I want 5 HGCs and information on the tech you find."),
            trial = { kind = "persuade", difficulty = 20 },
            success = { next_topic = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE_3", actions = { actions.adjust_faction_trust(1), actions.handler("dlg_a_dda_383f4e5a2e01") } },
            failure = { next_topic = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE_2b" },
        },
        {
            text = ccb.content.text("I want 10 HGCs and information on the tech you find."),
            trial = { kind = "persuade", difficulty = 10 },
            success = { next_topic = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE_3", actions = { actions.adjust_faction_trust(1), actions.handler("dlg_a_dda_1de9d516ef01") } },
            failure = { next_topic = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE_2b" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE_2b",
    line = ccb.content.text("We can only offer you 5 HGCs.  Alternatively, we could give you information on the tech once it's recovered, if that is more interesting to you."),
    replies = {
        {
            text = ccb.content.text("Deal!  5 HGCs in exchange for the coordinates."),
            next_topic = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE_3",
            actions = { actions.adjust_faction_trust(1), actions.handler("dlg_a_dda_3c564ddaa56c") },
        },
        {
            text = ccb.content.text("Deal!  Information on the tech in exchange for the coordinates."),
            next_topic = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE_3",
            actions = { actions.adjust_faction_trust(1), actions.handler("dlg_a_dda_729e39bdeb38") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE_3",
    line = ccb.content.text("Excellent.  We will scout the area and send a team to recover the materials.  We will dispatch the team immediately, but it will take a full day until we have any more information.  We thank you for your contributions to the future of humanity."),
    replies = {
        {
            text = ccb.content.text("Nice doing business with you."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            when = predicates.handler("dlg_p_dda_656434aaa958"),
            actions = { actions.adjust_faction_trust(-3), actions.handler("dlg_a_dda_bb58c961d492"), actions.set_actor_value("speaker", "dialogue_hub_u_waiting_on_warehouse", "yes") },
        },
        {
            text = ccb.content.text("Nice doing business with you."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            when = predicates.handler("dlg_p_dda_6b2a493d9e87"),
            actions = { actions.adjust_faction_trust(1), actions.handler("dlg_a_dda_4b808a776918"), actions.set_actor_value("speaker", "dialogue_hub_u_waiting_on_warehouse", "yes"), actions.update_map("exo_warehouse_1_robofac_looted", "exo_warehouse_1") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE_4a",
    line = {
        when = predicates.handler("dlg_p_dda_a73b7872f690"),
        yes = ccb.content.text("Indeed, we have found the warehouse, and as you promised, it is full of exotic technology.  Your services are appreciated."),
        no = ccb.content.text("The recovery process is still ongoing."),
    },
    replies = {
        {
            text = ccb.content.text("Glad to hear it."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            when = predicates.handler("dlg_p_dda_a73b7872f690"),
            actions = { actions.clear_actor_value("speaker", "dialogue_hub_u_waiting_on_warehouse"), actions.clear_actor_value("speaker", "timer_hub_waiting_on_warehouse"), actions.handler("dlg_a_dda_2675ed36767c") },
        },
        {
            text = ccb.content.text("I'll check in later."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE_4b",
    line = {
        when = predicates.handler("dlg_p_dda_a73b7872f690"),
        yes = ccb.content.text("Indeed, we have found the warehouse, and as you promised, it is full of exotic technology.  As promised, we have additional details on the contents.  We have discovered components for what appears to be some sort of surgical robot.  We are currently reverse engineering it in an attempt to understand it better.  If we have needs of your services in these efforts - and we very well may - we'll be sure to let you know."),
        no = ccb.content.text("The recovery process is still ongoing."),
    },
    replies = {
        {
            text = ccb.content.text("Great.  I'll check in later about helping out, if I can."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            when = predicates.handler("dlg_p_dda_a73b7872f690"),
            actions = { actions.clear_actor_value("speaker", "dialogue_hub_u_waiting_on_warehouse"), actions.clear_actor_value("speaker", "timer_hub_waiting_on_warehouse"), actions.handler("dlg_a_dda_74f94310dceb") },
        },
        {
            text = ccb.content.text("I'll check in later."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE_4c",
    line = {
        when = predicates.handler("dlg_p_dda_a73b7872f690"),
        yes = ccb.content.text("Indeed, but curiously, these \"Exodii\" beat us there.  We were not able to recover the contents of the warehouse.  We hope your future intel will be more complete."),
        no = ccb.content.text("The recovery process is still ongoing."),
    },
    replies = {
        {
            text = ccb.content.text("Right."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            when = predicates.handler("dlg_p_dda_a73b7872f690"),
            actions = { actions.clear_actor_value("speaker", "dialogue_hub_u_waiting_on_warehouse"), actions.clear_actor_value("speaker", "timer_hub_waiting_on_warehouse") },
        },
        {
            text = ccb.content.text("I'll check in later."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODI_INTERCOM_AUTODOC_A",
    line = {
        when = predicates.handler("dlg_p_dda_b7d7d0397e2b"),
        yes = ccb.content.text("&The intercom clicks off and there is a long moment of silence, before it clicks back on again with a new person on the other end.  \"Yes, hello.  Right.  Yes.  Indeed, the technology we recovered was instrumental in developing new medical technology we are making available for our contractors, like yourself.  You can find a new, public medical suite across the street, in the old basement of the weather station - you should be able to find the stairs just inside the entrance.  Please feel free to make use of its services.\""),
        no = {
            when = predicates.handler("dlg_p_dda_a8aa712606ab"),
            yes = ccb.content.text("Our newest project will be ready for field testing within the week.  We suggest checking back regularly."),
            no = {
                when = predicates.handler("dlg_p_dda_4c0d289091f3"),
                yes = ccb.content.text("This project is ongoing, but is advancing quickly.  We expect research to be done in a matter of weeks."),
                no = ccb.content.text("The project is ongoing, and we expect it will take weeks or months until it is ready for testing.  We suggest you check back in next week."),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("A new medical facility across the street, in the basement?  I guess I can go check it out."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            when = predicates.handler("dlg_p_dda_b7d7d0397e2b"),
            actions = { actions.clear_actor_value("speaker", "dialogue_hub_u_waiting_on_autodoc"), actions.clear_actor_value("speaker", "timer_hub_waiting_on_autodoc") },
        },
        {
            text = ccb.content.text("I'll check in later."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            when = predicates.handler("dlg_p_dda_98d2c880556a"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODI_INTERCOM_AUTODOC_B",
    line = {
        when = predicates.handler("dlg_p_dda_b7d7d0397e2b"),
        yes = ccb.content.text("&The intercom clicks off and there is a long moment of silence, before it clicks back on again with a new person on the other end.  \"Yes, hello.  Right.  Yes.  Indeed, we have been able to reconstruct the automatic medical device, and due to your efforts, and the efforts of other contractors and Hub scientists, we were able to reverse engineer the cybernetic implants the Exodii make use of.  You can find a new, public medical suite across the street, in the old basement of the weather station - you should be able to find the stairs just inside the entrance.  Please feel free to make use of its services.  As previously discussed, we would like to invite you to join our new program, where select mercenaries will be allowed to field test new cybernetic enhancements.  Doctor Stevens at the facility will give you more information.  In fact, as a reward for your service, we are prepared to install some very useful cybernetic enhancements that we developed as a part of these efforts.\""),
        no = {
            when = predicates.handler("dlg_p_dda_a8aa712606ab"),
            yes = ccb.content.text("Our newest project will be ready for field testing within days.  We suggest checking back regularly."),
            no = {
                when = predicates.handler("dlg_p_dda_4c0d289091f3"),
                yes = ccb.content.text("We expect the surgical suite to be ready in approximately one week."),
                no = ccb.content.text("The project is ongoing, and we expect it will take weeks or months until it is ready for testing.  We suggest you check back in next week."),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("<fcl_hub_has_interface>"),
            false_text = ccb.content.text("Actually, I'm familiar with these cybernetics.  I already have one."),
            text_when = predicates.handler("dlg_p_dda_d292f701cba7"),
            next_topic = "TALK_EXODI_INTERCOM_AUTODOC_B_EXODII_INTERFACE",
            when = predicates.handler("dlg_p_dda_bb45537eefe5"),
            actions = { actions.clear_actor_value("speaker", "dialogue_hub_u_waiting_on_autodoc"), actions.clear_actor_value("speaker", "timer_hub_waiting_on_autodoc"), actions.handler("dlg_a_dda_aaefecbdde37") },
        },
        {
            text = ccb.content.text("Ah, well, I guess this could be useful for me, being a cyborg myself.  I'll go check it out."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            when = predicates.handler("dlg_p_dda_604824d886c4"),
            actions = { actions.clear_actor_value("speaker", "dialogue_hub_u_waiting_on_autodoc"), actions.clear_actor_value("speaker", "timer_hub_waiting_on_autodoc"), actions.handler("dlg_a_dda_aaefecbdde37") },
        },
        {
            text = ccb.content.text("<fcl_hub_new_cybernetics>"),
            false_text = ccb.content.text("Cybernetics?  What do you mean by that?"),
            text_when = predicates.handler("dlg_p_dda_d292f701cba7"),
            next_topic = "TALK_EXODI_INTERCOM_AUTODOC_B_CYBERNETICS_INFO",
            when = predicates.handler("dlg_p_dda_d98308d74f14"),
            actions = { actions.clear_actor_value("speaker", "dialogue_hub_u_waiting_on_autodoc"), actions.clear_actor_value("speaker", "timer_hub_waiting_on_autodoc"), actions.handler("dlg_a_dda_aaefecbdde37") },
        },
        {
            text = ccb.content.text("I guess I can go check the new medical facility out.  Across the street in the basement, right?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            when = predicates.handler("dlg_p_dda_b7d7d0397e2b"),
            actions = { actions.clear_actor_value("speaker", "dialogue_hub_u_waiting_on_autodoc"), actions.clear_actor_value("speaker", "timer_hub_waiting_on_autodoc"), actions.handler("dlg_a_dda_aaefecbdde37") },
        },
        {
            text = ccb.content.text("I'll check in later."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            when = predicates.handler("dlg_p_dda_98d2c880556a"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODI_INTERCOM_AUTODOC_B_EXODII_INTERFACE",
    line = ccb.content.text("&The intercom is silent for a long moment, then it clicks off, then back on, with the same voice as before:  \"Interesting.  We'll inform Doc Stevens.  We would be willing to pay you to study this device, whether you wish to participate in the field testing units or not.  Unfortunately, based on our research, this Exodii technology was a complete dead end, with no room for improvement, and it carries significant risks, including cancer and increased risk of internal bleeding.  Our improved interface is completely safe and will be of great benefit to u- to mankind.  To boot, it will remain compatible with whatever bionic modules we can continue to recover from the Exodii.  We suggest you have Doc Stevens swap it out immediately.\""),
    replies = {
        {
            text = ccb.content.text("I'll keep that in mind, and maybe I'll check out the new facility.  Across the street in the basement, right?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODI_INTERCOM_AUTODOC_B_CYBERNETICS_INFO",
    line = ccb.content.text("The Exodii made their \"workers\" out of human beings, each implanted with a computer-brain interface.  This allows to interface with electronic bionic modules, including things like integrated toolsets, rangefinders, and radios.  Unfortunately, the Exodii interfaces are not particularly advanced or safe, and come with serious cancer risks, among other problems.  Our improved interface is completely safe and will be of great benefit to u- to mankind.  To boot, it will remain compatible with whatever bionic modules we can continue to recover from the Exodii."),
    replies = {
        {
            text = ccb.content.text("I'll keep that in mind, and maybe I'll check out the new facility.  Across the street in the basement, right?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}

-- migration from older saved games - remove existing NPCs
ccb.content.define_mapgen {
    kind = "update",
    id = "nest_robofac_add_free_merchant_camp",
    layout = {
        nested = { { x = 0, y = 0, id = "robofac_hq_surface_freemerchant_camp" } },
        npc_removals = {
            { id = "roabofac_free_merchant", x = 0, y = 0 },
            { id = "guard", x = 0, y = 0 },
            { id = "NC_ROBOFAC_FREE_MERCHANT", x = 0, y = 0 },
            { id = "NC_BOUNTY_HUNTER", x = 0, y = 0 },
        },
    },
}
