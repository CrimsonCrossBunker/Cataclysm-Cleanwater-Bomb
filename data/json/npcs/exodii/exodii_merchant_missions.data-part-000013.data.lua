local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_3_complete",
    line = ccb.content.text("&Rubik sighs, takes the head, stares at it for a moment, then sets it gently down on the counter.  They then reach below the counter and take out three clear plastic bags, each containing a different cybernetic module.  \"Ye've done us'n a true service, so as us'n promised, take one o' these dandies as true reward.  Which'll it be?  As y'like."),
    replies = {
        {
            text = ccb.content.text("[Install Diamond Cornea CBM] I like the look of those eye implants.  Let's try that."),
            next_topic = "TALK_DONE",
            actions = { actions.add_effect("speaker", "narcosis", { turns = 1800 }), actions.add_effect("speaker", "sleep", { turns = 1800 }), actions.handler("dlg_a_dda_4b8688f52f05") },
            opinion = { trust = 4, value = 3 },
        },
        {
            text = ccb.content.text("[Install Muscle Augmentation CBM] Some new muscle fibers sound great.  Let's do those."),
            next_topic = "TALK_DONE",
            actions = { actions.add_effect("speaker", "narcosis", { turns = 1800 }), actions.add_effect("speaker", "sleep", { turns = 1800 }), actions.handler("dlg_a_dda_6d1032b61ca8") },
            opinion = { trust = 4, value = 3 },
        },
        {
            text = ccb.content.text("[Install Cerebral Booster CBM] Don't think I'd consider a brain implant before all of this, but didn't think I'd ever meet an alien, either.  Let's do that."),
            next_topic = "TALK_DONE",
            actions = { actions.add_effect("speaker", "narcosis", { turns = 1800 }), actions.add_effect("speaker", "sleep", { turns = 1800 }), actions.handler("dlg_a_dda_2752f0af69e9") },
            opinion = { trust = 4, value = 3 },
        },
        {
            text = ccb.content.text("Actually, could you turn me into a full-blown robotic cyborg, like you?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_3_ExodiiFrame_no",
            when = predicates.handler("dlg_p_dda_28a006214a5d"),
        },
        {
            text = ccb.content.text("Actually, could you turn me into a full-blown robotic cyborg, like you?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_3_ExodiiFrame_yes",
            when = predicates.handler("dlg_p_dda_29c3b08650ee"),
        },
        {
            text = ccb.content.text("How about store credit instead?  [adds $1500 in store credit]."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_6968b05d882b"), "start_trade" },
            opinion = { trust = 4, value = 3 },
        },
        {
            text = ccb.content.text("I don't need anything from you at the moment.  Let's call this a favor for a friend.  See you around, Rubik."),
            next_topic = "TALK_DONE",
            actions = { actions.adjust_faction_trust(4) },
            opinion = { trust = 7, value = 5 },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_3_ExodiiFrame_no",
    line = ccb.content.text("No.  As ye' can see, us'n can't spare the steelies.  Too much to danger."),
    replies = {
        {
            text = ccb.content.text("[Install Diamond Cornea CBM] I like the look of those eye implants.  Let's try that."),
            next_topic = "TALK_DONE",
            actions = { actions.add_effect("speaker", "narcosis", { turns = 1800 }), actions.add_effect("speaker", "sleep", { turns = 1800 }), actions.handler("dlg_a_dda_4b8688f52f05") },
            opinion = { trust = 4, value = 3 },
        },
        {
            text = ccb.content.text("[Install Muscle Augmentation CBM] Some new muscle fibers sound great.  Let's do those."),
            next_topic = "TALK_DONE",
            actions = { actions.add_effect("speaker", "narcosis", { turns = 1800 }), actions.add_effect("speaker", "sleep", { turns = 1800 }), actions.handler("dlg_a_dda_6d1032b61ca8") },
            opinion = { trust = 4, value = 3 },
        },
        {
            text = ccb.content.text("[Install Cerebral Booster CBM] Don't think I'd consider a brain implant before all of this, but didn't think I'd ever meet an alien, either.  Let's do that."),
            next_topic = "TALK_DONE",
            actions = { actions.add_effect("speaker", "narcosis", { turns = 1800 }), actions.add_effect("speaker", "sleep", { turns = 1800 }), actions.handler("dlg_a_dda_2752f0af69e9") },
            opinion = { trust = 4, value = 3 },
        },
        {
            text = ccb.content.text("How about store credit instead?  [adds $1500 in store credit]."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_8e2f3cd3d303"), "start_trade" },
            opinion = { trust = 4, value = 3 },
        },
        {
            text = ccb.content.text("I don't need anything from you at the moment.  Let's call this a favor for a friend.  See you around, Rubik."),
            next_topic = "TALK_DONE",
            actions = { actions.adjust_faction_trust(4) },
            opinion = { trust = 7, value = 5 },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_3_ExodiiFrame_yes",
    line = ccb.content.text("Hm.  A mighty ask on a mighty ask.  Ye certainly got the disposition, but you sure you wanna be cut inta' this crowded space?\"  Rubik taps their metal torso.  \"You sure ya' lump is screwed on tight?  This isn't like the bright'n'steelies on offer.  No goin' back.  And ye best be happy with the amount'a power you can generate.  This'ere needs contant power.  Without power, yer good as dead.  The power storage units?  Fer a case this'n kind, one'a the power storage units buys you a little-less'an an hour of walkin'.  Less for scrappin' and scramblin'.  Nothin's easy about it.\""),
    replies = {
        {
            text = ccb.content.text("[Integrate your body into an Exodii Cyberframe] A robotic body I'll need to keep constantly powered?  Why not?  I'm ready."),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe",
            actions = { actions.adjust_faction_trust(5), actions.handler("dlg_a_dda_a6cbeb01e188") },
            opinion = { trust = 7, value = 5 },
        },
        {
            text = ccb.content.text("[Install Diamond Cornea CBM] I like the look of those eye implants.  Let's try that."),
            next_topic = "TALK_DONE",
            actions = { actions.add_effect("speaker", "narcosis", { turns = 1800 }), actions.add_effect("speaker", "sleep", { turns = 1800 }), actions.handler("dlg_a_dda_4b8688f52f05") },
            opinion = { trust = 4, value = 3 },
        },
        {
            text = ccb.content.text("[Install Muscle Augmentation CBM] Some new muscle fibers sound great.  Let's do those."),
            next_topic = "TALK_DONE",
            actions = { actions.add_effect("speaker", "narcosis", { turns = 1800 }), actions.add_effect("speaker", "sleep", { turns = 1800 }), actions.handler("dlg_a_dda_6d1032b61ca8") },
            opinion = { trust = 4, value = 3 },
        },
        {
            text = ccb.content.text("[Install Cerebral Booster CBM] Don't think I'd consider a brain implant before all of this, but didn't think I'd ever meet an alien, either.  Let's do that."),
            next_topic = "TALK_DONE",
            actions = { actions.add_effect("speaker", "narcosis", { turns = 1800 }), actions.add_effect("speaker", "sleep", { turns = 1800 }), actions.handler("dlg_a_dda_2752f0af69e9") },
            opinion = { trust = 4, value = 3 },
        },
        {
            text = ccb.content.text("How about store credit instead?  [adds $1500 in store credit]."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_cf641f8b6e7e"), "start_trade" },
            opinion = { trust = 4, value = 3 },
        },
        {
            text = ccb.content.text("I don't need anything from you at the moment.  Let's call this a favor for a friend.  See you around, Rubik."),
            next_topic = "TALK_DONE",
            actions = { actions.adjust_faction_trust(4) },
            opinion = { trust = 7, value = 5 },
        },
    },
}
