local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

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
