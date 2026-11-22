local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions



ccb.content.define_dialogue_topic {
    id = { "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations" },
    line = ccb.content.text("&You boot up the strange TV-radio device.  There is a sharp squeal from the device as the screen, first covered in only static, blips into life.  After a moment, the image on the screen wobbles and Rubik appears, offering a stiff bow.  You hold the screen up so Smokes can see it."),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_151c8a5d8b85") } },
    },
    replies = {
        {
            text = ccb.content.text("[Neutral] Introduce Rubik and Smokes to each other, then give them the floor.  Offer occasional help translating."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_2",
        },
        {
            text = ccb.content.text("[Antagonize] Introduce Rubik as an alien and compare the Exodii to a few \"unfriendly\" robots from your Earth's popular culture.  \"So, they're sort of like the Borg, the Terminator, those machines from The Matrix, you know, that kind of thing…\""),
            trial = { kind = "persuade", difficulty = 15 },
            success = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_2", actions = { actions.handler("dlg_a_dda_52b6d7dd05e0") } },
            failure = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_2", actions = { actions.handler("dlg_a_dda_6bd097eca79f") } },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_2" },
    line = ccb.content.text("&Rubik explains they are primarily looking for plastics, metals, and media.  Rubik and Smokes start to talk about the nature of the trade.  Guaranteed shipments?  First right of refusal?  What about prices for bulk goods?"),
    replies = {
        {
            text = ccb.content.text("[Neutral] Sit quietly and let them negotiate.  Offer occasional help translating."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_3",
        },
        {
            text = ccb.content.text("[Favor Exodii] Point out that the Exodii's needs are predictable and simple.  \"They need a lot of things other survivors may not buy.\""),
            trial = { kind = "persuade", difficulty = 60, modifiers = { { score = "TRUST", scale = 3 } } },
            success = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_3", actions = { actions.handler("dlg_a_dda_66dc51fce0db") } },
            failure = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_3", actions = { actions.handler("dlg_a_dda_7cfb491fa9a3") } },
        },
        {
            text = ccb.content.text("[Favor Merchants] Remind Rubik that the Free Merchants are taking on the risk of the shipments, and need to stick around Earth even if the Exodii leave.  \"I think thats worth a small premium, no?\""),
            trial = { kind = "persuade", difficulty = 60, modifiers = { { score = "TRUST", scale = 3 } } },
            success = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_3", actions = { actions.handler("dlg_a_dda_c82aefea1f07") } },
            failure = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_3", actions = { actions.handler("dlg_a_dda_7cfb491fa9a3") } },
        },
        {
            text = ccb.content.text("[Antagonize] Rush them.  \"Let's get to it!  A quick deal is a good deal.  Do you want to trade, or not?\""),
            trial = { kind = "persuade", difficulty = 15 },
            success = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_3", actions = { actions.handler("dlg_a_dda_52b6d7dd05e0") } },
            failure = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_3", actions = { actions.handler("dlg_a_dda_f6d504f6b67f") } },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_3" },
    line = ccb.content.text("&Smokes and Rubik start to discuss what exactly the Exodii have to offer.  Rubik first offers up firearms, hefting one of their zombie hunting rifles into the frame…"),
    replies = {
        {
            text = ccb.content.text("[Neutral] Sit quietly and let them negotiate.  Offer occasional help translating."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_4",
        },
        {
            text = ccb.content.text("[Favor Exodii] Explain to Smokes the unique nature of the firearms you have seen.  \"They're really well tuned for taking down a <zombie>.\""),
            trial = { kind = "persuade", difficulty = 60, modifiers = { { score = "TRUST", scale = 3 } } },
            success = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_4", actions = { actions.handler("dlg_a_dda_66dc51fce0db") } },
            failure = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_4", actions = { actions.handler("dlg_a_dda_7cfb491fa9a3") } },
        },
        {
            text = ccb.content.text("[Favor Merchants] Remind Rubik & Smokes that these firearms use ammunition not from this world.  \"They're great guns, but be sure to work ammunition into the deal.\""),
            trial = { kind = "persuade", difficulty = 60, modifiers = { { score = "TRUST", scale = 3 } } },
            success = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_4", actions = { actions.handler("dlg_a_dda_c82aefea1f07") } },
            failure = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_4", actions = { actions.handler("dlg_a_dda_7cfb491fa9a3") } },
        },
        {
            text = ccb.content.text("[Antagonize] Look knowingly at Smokes.  \"They have a LOT of guns.  And they know how to use them.\""),
            trial = { kind = "persuade", difficulty = 15 },
            success = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_4", actions = { actions.handler("dlg_a_dda_52b6d7dd05e0") } },
            failure = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_4", actions = { actions.handler("dlg_a_dda_f6d504f6b67f") } },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_4" },
    line = ccb.content.text("&Rubik moves on to medical services and starts to explain the nature of their medical robots.  Smokes talks a bit about the Old Guard and a medical doctor stationed at the center…"),
    replies = {
        {
            text = ccb.content.text("[Neutral] Sit quietly and let them negotiate.  Offer occasional help translating."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_5",
        },
        {
            text = ccb.content.text("[Favor Exodii] Explain to Smokes the miraculous nature of their medical technology, and how it's definitely worth the price for access to it."),
            trial = { kind = "persuade", difficulty = 60, modifiers = { { score = "TRUST", scale = 3 } } },
            success = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_5", actions = { actions.handler("dlg_a_dda_66dc51fce0db") } },
            failure = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_5", actions = { actions.handler("dlg_a_dda_7cfb491fa9a3") } },
        },
        {
            text = ccb.content.text("[Favor Merchants] Encourage Smokes to negotiate a medical robot be installed at the Evacuee Center."),
            trial = { kind = "persuade", difficulty = 60, modifiers = { { score = "TRUST", scale = 3 } } },
            success = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_5", actions = { actions.handler("dlg_a_dda_3a5986f50373") } },
            failure = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_5", actions = { actions.handler("dlg_a_dda_7cfb491fa9a3") } },
        },
        {
            text = ccb.content.text("[Antagonize] Undermine the negotiation by bringing up Hub 01.  \"Actually, Smokes, those Hub 01 people you trade with have some pretty advanced tech, or at least it seems like they do.  Maybe this isn't worth being part of the deal.\""),
            when = predicates.handler("dlg_p_dda_e65b26caff69"),
            trial = { kind = "persuade", difficulty = 15 },
            success = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_5", actions = { actions.handler("dlg_a_dda_52b6d7dd05e0") } },
            failure = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_5", actions = { actions.handler("dlg_a_dda_f6d504f6b67f") } },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_5" },
    line = ccb.content.text("&There is a lull in the discussion as Smokes and Rubik quietly consider everything on the table."),
    replies = {
        {
            text = ccb.content.text("[Neutral] Let them move at their own pace."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_6",
        },
        {
            text = ccb.content.text("[Favor Exodii] Whisper to Smokes: \"Listen, I know these guys.  Sweeten the deal as a gesture of good will, and things will go well for you.\""),
            trial = { kind = "persuade", difficulty = 60, modifiers = { { score = "TRUST", scale = 3 } } },
            success = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_6", actions = { actions.handler("dlg_a_dda_66dc51fce0db") } },
            failure = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_6", actions = { actions.handler("dlg_a_dda_7cfb491fa9a3") } },
        },
        {
            text = ccb.content.text("[Favor Merchants] Whisper to Smokes and encourage him to ask for a bit more."),
            trial = { kind = "persuade", difficulty = 60, modifiers = { { score = "TRUST", scale = 3 } } },
            success = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_6", actions = { actions.handler("dlg_a_dda_c82aefea1f07") } },
            failure = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_6", actions = { actions.handler("dlg_a_dda_7cfb491fa9a3") } },
        },
        {
            text = ccb.content.text("[Antagonize] Rush them along - don't give them time to think."),
            trial = { kind = "persuade", difficulty = 15 },
            success = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_6", actions = { actions.handler("dlg_a_dda_52b6d7dd05e0") } },
            failure = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_6", actions = { actions.handler("dlg_a_dda_f6d504f6b67f") } },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_6" },
    line = ccb.content.text("&After a quiet moment, the discussion moves on to the nature of the caravans.  The Free Merchants will want to set up an encampment near the Exodii's butte…"),
    replies = {
        {
            text = ccb.content.text("[Neutral] Sit quietly and let them negotiate.  Offer occasional help translating."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_7",
        },
        {
            text = ccb.content.text("[Favor Exodii] Suggest deliveries be managed through a nearby camp, rather than something more permanent.  Whisper to Smokes: \"Outside of the Exodii's protection, but also outside of their influence\"."),
            trial = { kind = "persuade", difficulty = 60, modifiers = { { score = "TRUST", scale = 3 } } },
            success = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_7", actions = { actions.handler("dlg_a_dda_66dc51fce0db") } },
            failure = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_7", actions = { actions.handler("dlg_a_dda_7cfb491fa9a3") } },
        },
        {
            text = ccb.content.text("[Favor Merchants] Subtly hint to Smokes that they could probably negotiate protection, or a fortified structure for the Free Merchants."),
            trial = { kind = "persuade", difficulty = 60, modifiers = { { score = "TRUST", scale = 3 } } },
            success = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_7", actions = { actions.handler("dlg_a_dda_c3dbed4b8a47") } },
            failure = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_7", actions = { actions.handler("dlg_a_dda_7cfb491fa9a3") } },
        },
        {
            text = ccb.content.text("[Antagonize] Hype up how far away and dangerous it is to trade with the Exodii.  \"Think carefully on this.  It's really nasty over there.  Shame they couldn't set up somewhere else!\""),
            trial = { kind = "persuade", difficulty = 15 },
            success = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_7", actions = { actions.handler("dlg_a_dda_52b6d7dd05e0") } },
            failure = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_7", actions = { actions.handler("dlg_a_dda_f6d504f6b67f") } },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_7" },
    line = ccb.content.text("&Rubik broaches the topic of recruitment & CBM interfaces…"),
    replies = {
        {
            text = ccb.content.text("[Neutral] Sit quietly and let them negotiate.  Offer occasional help translating."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_8",
        },
        {
            text = ccb.content.text("[Favor Exodii] Talk about the benefits of CBMs."),
            trial = { kind = "persuade", difficulty = 60, modifiers = { { score = "TRUST", scale = 3 } } },
            success = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_8", actions = { actions.handler("dlg_a_dda_66dc51fce0db") } },
            failure = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_8", actions = { actions.handler("dlg_a_dda_7cfb491fa9a3") } },
        },
        {
            text = ccb.content.text("[Favor Merchants] Point out that the Exodii are asking for access to people, which should be negotiated like anything else.  \"Rubik, maybe it's worth sweetening the deal some, if you're going to be courting some of their people.\""),
            trial = { kind = "persuade", difficulty = 60, modifiers = { { score = "TRUST", scale = 3 } } },
            success = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_8", actions = { actions.handler("dlg_a_dda_c82aefea1f07") } },
            failure = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_8", actions = { actions.handler("dlg_a_dda_7cfb491fa9a3") } },
        },
        {
            text = ccb.content.text("[Antagonize] Make a mocking, robotic voice: \"Hahaha, we will add your biological and technological distinctiveness to our own!\""),
            trial = { kind = "persuade", difficulty = 15 },
            success = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_8", actions = { actions.handler("dlg_a_dda_52b6d7dd05e0") } },
            failure = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_8", actions = { actions.handler("dlg_a_dda_f6d504f6b67f") } },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_8" },
    line = ccb.content.text("&The negotiation is coming to an end…"),
    replies = {
        {
            text = ccb.content.text("[Neutral] Let them finish, and offer occasional help translating."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_DONE",
        },
        {
            text = ccb.content.text("[Antagonize] Well, that went way worse than I expected!  Smoke, Rubik, I don't think we have a deal here."),
            trial = { kind = "persuade", difficulty = 15 },
            success = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_DONE", actions = { actions.handler("dlg_a_dda_52b6d7dd05e0") } },
            failure = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_DONE", actions = { actions.handler("dlg_a_dda_f6d504f6b67f") } },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_FAVORS_MERCHANTS" },
    line = ccb.content.text("&Smokes rubs his chin thoughtfully.  \"Yeah, it did, in no small part to you, I think.  How about I repay the favor?  You have anything in mind?\""),
    replies = {
        {
            text = ccb.content.text("[$100 credit] Some store credit would do nicely."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_7ac8c914e00e"), "start_trade" },
        },
        {
            text = ccb.content.text("Happy to help.  Just remember I'm a friend to the Center, yeah?"),
            next_topic = "TALK_DONE",
            actions = { actions.adjust_faction_trust(5) },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_DONE" },
    line = {
        when = predicates.handler("w16b_p_dda_c49833a17225"),
        yes = ccb.content.text("&Rubik unceremoniously shuts off the the screen, leaving nothing but static.  Smokes leans back in his chair, wiping his brow.  \"Well, that didn't go well.  Something tells me it isn't gonna work out, and it's for the best.\""),
        no = {
            when = predicates.handler("w16b_p_dda_679bee254e20"),
            yes = ccb.content.text("&Rubik and Smokes finish their negotiation and agree to a complex set of terms.  Caravans will begin in about a week.  Rubik offers a stiff bow over the screen before it switches to static.  Smokes leans back, offering an easy smile.  \"Well, didn't expect that today, but that went well.  You were, uh, well, let's just say I think you should stick to scavenging, yeah?\""),
            no = ccb.content.text("&Rubik and Smokes finish their negotiation and agree to a complex set of terms.  Caravans will begin in about a week.  Rubik offers a stiff bow over the screen before it switches to static.  Smokes leans back, offering an easy smile.  \"Well, didn't expect that today - negotiations with, well, whatever they are - but that went well.  I appreciate you.  Not sure we would've come to a deal without someone to do a bit of translating.\""),
        },
    },
    replies = {
        {
            text = ccb.content.text("Yeah, it's definitely for the best.  See you around.  Maybe."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_c49833a17225"),
            actions = { actions.handler("w16b_a_dda_df2b41f36920") },
        },
        {
            text = ccb.content.text("Hm.  See you around, I guess."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_b4a71b11572d"),
            actions = { actions.handler("w16b_a_dda_6b33ca9a0565") },
        },
        {
            text = ccb.content.text("Glad to be of service.  I better get back to the Exodii.  See you around."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_7676c8d1ead1"),
            actions = { actions.handler("w16b_a_dda_6b33ca9a0565") },
        },
        {
            text = ccb.content.text("Glad to be of service.  Seems the deal went pretty well for you, yeah?"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations_FAVORS_MERCHANTS",
            when = predicates.handler("w16b_p_dda_73f94f9c82ab"),
            actions = { actions.handler("w16b_a_dda_6b33ca9a0565") },
        },
    },
}
