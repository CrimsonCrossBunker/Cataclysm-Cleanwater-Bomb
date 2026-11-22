local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_String_Dimension_Exodii_Mission_Complete",
    line = {
        when = predicates.has_trait("speaker", "CBM_Interface"),
        yes = ccb.content.text("&Rubik takes the device and nods.  \"Aye, that ye did.  A spell t'tease this out, no doubt.  Mayhap more than these lands see us'n.  But yer work be prized.  VERY prized.  What say ye for reward?\"  Rubik reaches into the desk in front of them and pulls out a tiny, green-glowing CRT, scrolling rapidly down a list to find three items, which they click slowly through.  'teleporter CBM', 'time dilation CBM', and 'probability travel CBM'.\n\n\"Think on it, decide on a last.\""),
        no = ccb.content.text("&Rubik takes the device and nods.  \"Aye, that ye did.  A spell t'tease this out, no doubt.  Mayhap more than these lands see us'n.  But yer work be prized.  VERY prized.  What say ye for reward?\""),
    },
    replies = {
        {
            text = ccb.content.text("[Install Teleporter CBM] Teleporting sounds dangerous, but after this interdimensional travel, maybe I can handle it."),
            next_topic = "TALK_DONE",
            when = predicates.any({ predicates.has_trait("speaker", "CBM_Interface"), predicates.has_trait("speaker", "NL_CBM_Interface") }),
            actions = { actions.add_effect("speaker", "narcosis", { turns = 1800 }), actions.add_effect("speaker", "sleep", { turns = 1800 }), actions.handler("dlg_a_dda_574864f90d13") },
            opinion = { trust = 4, value = 3 },
        },
        {
            text = ccb.content.text("[Install Time Dilation CBM] \"Time Dilation\" sounds like something that should surprise me.  But after the places I've now been?  I'm ready for it."),
            next_topic = "TALK_DONE",
            when = predicates.any({ predicates.has_trait("speaker", "CBM_Interface"), predicates.has_trait("speaker", "NL_CBM_Interface") }),
            actions = { actions.add_effect("speaker", "narcosis", { turns = 1800 }), actions.add_effect("speaker", "sleep", { turns = 1800 }), actions.handler("dlg_a_dda_1204c1f36db7") },
            opinion = { trust = 4, value = 3 },
        },
        {
            text = ccb.content.text("[Install Probability Travel CBM] Phasing through barriers?  Would've helped in that maze of a node.  Let's do it."),
            next_topic = "TALK_DONE",
            when = predicates.any({ predicates.has_trait("speaker", "CBM_Interface"), predicates.has_trait("speaker", "NL_CBM_Interface") }),
            actions = { actions.add_effect("speaker", "narcosis", { turns = 1800 }), actions.add_effect("speaker", "sleep", { turns = 1800 }), actions.handler("dlg_a_dda_b700a894f435") },
            opinion = { trust = 4, value = 3 },
        },
        {
            text = ccb.content.text("Could I become a cyborg, like yourself?"),
            next_topic = "TALK_EXODII_MERCHANT_ExodizeMe2",
            when = predicates.all({ predicates.negate(predicates.has_trait("speaker", "CBM_Interface")), predicates.negate(predicates.has_trait("speaker", "NL_CBM_Interface")), predicates.negate(predicates.has_flag("speaker", "NO_CBM_INSTALLATION")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "Rubik_exodized_u" } })) }),
            actions = { actions.adjust_faction_trust(5) },
            opinion = { trust = 4, value = 3 },
        },
        {
            text = ccb.content.text("Actually, could you turn me into a full-blown robotic cyborg, like you?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_string_dimension_ExodiiFrame_no",
            when = predicates.handler("dlg_p_dda_28a006214a5d"),
        },
        {
            text = ccb.content.text("Actually, could you turn me into a full-blown robotic cyborg, like you?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_string_dimension_ExodiiFrame_yes",
            when = predicates.handler("dlg_p_dda_29c3b08650ee"),
        },
        {
            text = ccb.content.text("How about store credit instead?  [adds $1500 in store credit]."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_2d750802791c"), "start_trade" },
            opinion = { trust = 4, value = 3 },
        },
        {
            text = ccb.content.text("I don't need anything.  Helping you out is its own reward, Rubik."),
            next_topic = "TALK_DONE",
            actions = { actions.adjust_faction_trust(4) },
            opinion = { trust = 7, value = 5 },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_string_dimension_ExodiiFrame_no",
    line = ccb.content.text("No.  Can't offer ye that."),
    replies = {
        {
            text = ccb.content.text("[Install Teleporter CBM] Teleporting sounds dangerous, but after this interdimensional travel, maybe I can handle it."),
            next_topic = "TALK_DONE",
            when = predicates.any({ predicates.has_trait("speaker", "CBM_Interface"), predicates.has_trait("speaker", "NL_CBM_Interface") }),
            actions = { actions.add_effect("speaker", "narcosis", { turns = 1800 }), actions.add_effect("speaker", "sleep", { turns = 1800 }), actions.handler("dlg_a_dda_574864f90d13") },
            opinion = { trust = 4, value = 3 },
        },
        {
            text = ccb.content.text("[Install Time Dilation CBM] \"Time Dilation\" sounds like something that should surprise me.  But after the places I've now been?  I'm ready for it."),
            next_topic = "TALK_DONE",
            when = predicates.any({ predicates.has_trait("speaker", "CBM_Interface"), predicates.has_trait("speaker", "NL_CBM_Interface") }),
            actions = { actions.add_effect("speaker", "narcosis", { turns = 1800 }), actions.add_effect("speaker", "sleep", { turns = 1800 }), actions.handler("dlg_a_dda_1204c1f36db7") },
            opinion = { trust = 4, value = 3 },
        },
        {
            text = ccb.content.text("[Install Probability Travel CBM] Phasing through barriers?  Would've helped in that maze of a node.  Let's do it."),
            next_topic = "TALK_DONE",
            when = predicates.any({ predicates.has_trait("speaker", "CBM_Interface"), predicates.has_trait("speaker", "NL_CBM_Interface") }),
            actions = { actions.add_effect("speaker", "narcosis", { turns = 1800 }), actions.add_effect("speaker", "sleep", { turns = 1800 }), actions.handler("dlg_a_dda_b700a894f435") },
            opinion = { trust = 4, value = 3 },
        },
        {
            text = ccb.content.text("How about store credit instead?  [adds $1500 in store credit]."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_0d001ec716bc"), "start_trade" },
            opinion = { trust = 4, value = 3 },
        },
        {
            text = ccb.content.text("I don't need anything.  Helping you out is its own reward, Rubik."),
            next_topic = "TALK_DONE",
            actions = { actions.adjust_faction_trust(4) },
            opinion = { trust = 7, value = 5 },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_string_dimension_ExodiiFrame_yes",
    line = ccb.content.text("Hm.  A mighty ask on a mighty ask.  Ye certainly got the disposition, but you sure you wanna be cut inta' this crowded space?\"  Rubik taps their metal torso.  \"You sure ya' lump is screwed on tight?  This isn't like the bright'n'steelies on offer.  No goin' back.  And ye best be happy with the amount'a power you can generate.  This'ere needs contant power.  Without power, yer good as dead.  The power storage units?  Fer a case this'n kind, one'a the power storage units buys you a little-less'an an hour of walkin'.  Less for scrappin' and scramblin'.  Nothin's easy about it.\""),
    replies = {
        {
            text = ccb.content.text("[Integrate your body into an Exodii Cyberframe] A robotic body I'll need to keep constantly powered?  Why not?  I'm ready."),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe",
            actions = { actions.adjust_faction_trust(5), actions.handler("dlg_a_dda_598c69d2b0a0") },
            opinion = { trust = 7, value = 5 },
        },
        {
            text = ccb.content.text("[Install Teleporter CBM] Teleporting sounds dangerous, but after this interdimensional travel, maybe I can handle it."),
            next_topic = "TALK_DONE",
            when = predicates.any({ predicates.has_trait("speaker", "CBM_Interface"), predicates.has_trait("speaker", "NL_CBM_Interface") }),
            actions = { actions.add_effect("speaker", "narcosis", { turns = 1800 }), actions.add_effect("speaker", "sleep", { turns = 1800 }), actions.handler("dlg_a_dda_574864f90d13") },
            opinion = { trust = 4, value = 3 },
        },
        {
            text = ccb.content.text("[Install Time Dilation CBM] \"Time Dilation\" sounds like something that should surprise me.  But after the places I've now been?  I'm ready for it."),
            next_topic = "TALK_DONE",
            when = predicates.any({ predicates.has_trait("speaker", "CBM_Interface"), predicates.has_trait("speaker", "NL_CBM_Interface") }),
            actions = { actions.add_effect("speaker", "narcosis", { turns = 1800 }), actions.add_effect("speaker", "sleep", { turns = 1800 }), actions.handler("dlg_a_dda_1204c1f36db7") },
            opinion = { trust = 4, value = 3 },
        },
        {
            text = ccb.content.text("[Install Probability Travel CBM] Phasing through barriers?  Would've helped in that maze of a node.  Let's do it."),
            next_topic = "TALK_DONE",
            when = predicates.any({ predicates.has_trait("speaker", "CBM_Interface"), predicates.has_trait("speaker", "NL_CBM_Interface") }),
            actions = { actions.add_effect("speaker", "narcosis", { turns = 1800 }), actions.add_effect("speaker", "sleep", { turns = 1800 }), actions.handler("dlg_a_dda_b700a894f435") },
            opinion = { trust = 4, value = 3 },
        },
        {
            text = ccb.content.text("How about store credit instead?  [adds $1500 in store credit]."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_bfd095415577"), "start_trade" },
            opinion = { trust = 4, value = 3 },
        },
        {
            text = ccb.content.text("I don't need anything.  Helping you out is its own reward, Rubik."),
            next_topic = "TALK_DONE",
            actions = { actions.adjust_faction_trust(4) },
            opinion = { trust = 7, value = 5 },
        },
    },
}
