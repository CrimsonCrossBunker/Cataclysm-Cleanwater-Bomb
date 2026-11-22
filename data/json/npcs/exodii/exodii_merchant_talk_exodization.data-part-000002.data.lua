local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_ExodizeMe2",
    line = ccb.content.text("Fine an' fine, an' fine an' fine!  Ha!  Now as us've got the good tea, us'll rubber up the ol' gristle mill.  You jus' set along with ol' Rubik."),
    replies = {
        {
            text = ccb.content.text("[Install CBM Interface] All right.  Let's do this."),
            next_topic = "TALK_EXODII_MERCHANT_Exodized",
            when = predicates.any({ predicates.negate(predicates.has_trait("speaker", "CBM_Interface")), predicates.negate(predicates.has_flag("speaker", "NO_CBM_INSTALLATION")), predicates.negate(predicates.has_trait("speaker", "Hub01_CBM_Interface")), predicates.negate(predicates.has_trait("speaker", "NL_CBM_Interface")) }),
            actions = { actions.add_effect("speaker", "narcosis", { turns = 7200 }), actions.add_effect("speaker", "sleep", { turns = 7200 }), actions.handler("dlg_a_dda_cf12cf160f61"), actions.replace_mutation("speaker", "CBM_Interface"), actions.set_actor_value("speaker", "Rubik_exodized_u", "yes") },
        },
        {
            text = ccb.content.text("[Install Power Storage Mk. II CBM] I guess since I'm already a cyborg, I could use some more power."),
            next_topic = "TALK_DONE",
            when = predicates.any({ predicates.has_trait("speaker", "CBM_Interface"), predicates.has_trait("speaker", "NL_CBM_Interface") }),
            actions = { actions.adjust_faction_trust(2), actions.add_effect("speaker", "narcosis", { turns = 1800 }), actions.add_effect("speaker", "sleep", { turns = 1800 }), actions.handler("dlg_a_dda_0ee4f18310e0") },
        },
        {
            text = ccb.content.text("Actually, Rubik.  This feels strange to say, but I already have a bionic interface.  The scientists from that bunker, Hub 01, installed it.  What I really want is for you to remove it, and replace it with your interface."),
            next_topic = "TALK_EXODII_MERCHANT_Remove_Hub01_CBM_interface_1",
            when = predicates.all({ predicates.has_trait("speaker", "Hub01_CBM_Interface"), predicates.negate(predicates.has_trait("speaker", "CBM_Interface_brain_lesion")) }),
        },
        {
            text = ccb.content.text("How about store credit instead?  [adds $400 in store credit]."),
            next_topic = "TALK_DONE",
            when = predicates.any({ predicates.has_trait("speaker", "CBM_Interface"), predicates.has_trait("speaker", "NL_CBM_Interface") }),
            actions = { actions.handler("dlg_a_dda_9910aee7f205"), actions.adjust_faction_trust(2), "start_trade" },
        },
        {
            text = ccb.content.text("Consider it a favor, Rubik."),
            next_topic = "TALK_DONE",
            when = predicates.any({ predicates.has_trait("speaker", "CBM_Interface"), predicates.has_trait("speaker", "NL_CBM_Interface") }),
            actions = { actions.adjust_faction_trust(4) },
            opinion = { trust = 7, value = 5 },
        },
        {
            text = ccb.content.text("Hold on.  I need to rethink it again."),
            next_topic = "TALK_DONE",
            when = predicates.any({ predicates.has_trait("speaker", "CBM_Interface"), predicates.has_trait("speaker", "NL_CBM_Interface") }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_ExodizeNope",
    line = ccb.content.text("An' that's a fine choice, I'd razz.  If'n ye change mind, ol' Rubik's here for the long an' short.  You get to know us'n better, us'n get to know you better, an' that's a good tassin'."),
    on_enter = {
        { when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "decisions_blobpsychosis_u_declined_exodization" } })), actions = { actions.adjust_faction_trust(2), actions.handler("dlg_a_dda_0ef3f45fa682"), actions.set_actor_value("speaker", "decisions_blobpsychosis_u_declined_exodization", "yes"), actions.handler("dlg_a_dda_7e656488b422") } },
    },
    replies = {
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Exodized",
    line = ccb.content.text("*makes a stiff, bowing gesture and leads you out of the shop and down a stone pathway towards one of the larger buildings in the compound.  A thick steel door slides aside to reveal a gloomy, rust-dusted corridor.  At the end of the corridor is a clean appearing surgical suite, not too different from any other surgical suite aside from the dim lighting and the surgeon itself.  At the head of the surgical table is a contraption reminiscent of an upside-down spider, its multiple glistening medical limbs curling gently in eager anticipation of your approach.  You have little time to question your choices before you feel a sharp pinch in your left shoulder, and the world drifts away.\n\nYou awaken on a comfortable bed, your chest and throat sore but otherwise well.  As the haze of anesthesia fades, you notice several tiny, sore wounds on your chest and arms.  A humanoid cyborg, not Rubik, notices that you are awake and wordlessly gestures you to follow, leading you back to Rubik's store.\n\n\"Ah, an' you're with the stars 'n lights again, an I'm ken.  'Tis grand.  Those wee CBMs will do ye little an fine, but they are a start.  Now us'n can sell you all you like, an' help with install, should ye wish.\""),
    on_enter = {
        { actions = { actions.update_map("tier1_CBM_shop_update", "exodii_base_x0y2z1") } },
    },
    replies = {
        {
            text = ccb.content.text("So I'm a cyborg now?  I don't really feel much different."),
            next_topic = "TALK_EXODII_MERCHANT_Exodized2",
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("<end_talking_leave>  Thanks for the brain implants.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Exodized_Alt",
    line = ccb.content.text("*makes a stiff, bowing gesture and leads you out of the shop and down a stone pathway towards one of the larger buildings in the compound.  A thick steel door slides aside to reveal a gloomy, rust-dusted corridor.  At the end of the corridor is a clean appearing surgical suite, not too different from any other surgical suite aside from the dim lighting and the surgeon itself.  At the head of the surgical table is a contraption reminiscent of an upside-down spider, its multiple glistening medical limbs curling gently in eager anticipation of your approach.  You have little time to question your choices before you feel a sharp pinch in your left shoulder, and the world drifts away.\n\nYou awaken on a comfortable bed, your chest and throat sore but otherwise well.  As the haze of anesthesia fades, you notice several tiny, sore wounds on your chest and arms.  A humanoid cyborg, not Rubik, notices that you are awake and wordlessly gestures you to follow, leading you back to Rubik's store.\n\n\"Ah, an' you're with the stars 'n lights again, an I'm ken.  'Tis grand.  Those wee CBMs will do ye little an fine, but they are a start.  Now us'n can sell you all you like, an' help with install, should ye wish.\""),
    on_enter = {
        { actions = { actions.update_map("tier1_CBM_shop_update", "exodii_base_x0y2z1") } },
    },
    replies = {
        {
            text = ccb.content.text("Feels good to get that Hub 01 tech out of my head, but I don't really feel much different.  So I'm a cyborg like you, now?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodized2",
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("<end_talking_leave>  Thanks for swapping out my brain implants.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
