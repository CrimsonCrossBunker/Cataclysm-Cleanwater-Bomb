local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

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
