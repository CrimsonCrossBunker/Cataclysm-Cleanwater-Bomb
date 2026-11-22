local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_ExodizeTest",
    line = ccb.content.text("Sure an' I can make you a cyborg, here an' now, since you're a developer an' all."),
    replies = {
        {
            text = ccb.content.text("[Install CBM Interface] Let's do it."),
            next_topic = "TALK_EXODII_MERCHANT_Exodized",
            when = predicates.negate(predicates.any({ predicates.has_flag("speaker", "NO_CBM_INSTALLATION"), predicates.has_trait("speaker", "CBM_Interface"), predicates.has_trait("speaker", "NL_CBM_Interface") })),
            actions = { actions.add_effect("speaker", "narcosis", { turns = 7200 }), actions.add_effect("speaker", "sleep", { turns = 7200 }), actions.handler("dlg_a_dda_24c42f18ee3c"), actions.replace_mutation("speaker", "CBM_Interface"), actions.handler("dlg_a_dda_95371a187a54") },
        },
        {
            text = ccb.content.text("I changed my mind.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("I changed my mind.  <end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Exodize",
    line = {
        when = predicates.handler("dlg_p_dda_8d831997809d"),
        yes = ccb.content.text("Oh HO!  Well, well.  Now you're yarkin' the King's Anglic.  Aye, us'n can fix ye good, if'n ye're tassed to repay it in kind.  Us'll speak it as clear-like as this Rubik can.  If ye'n use it to put the dead back in the ground, us'n can fix ye with some goods like this, aye.  Stuck in the flesh and to the bone, wired into the brain.  Ye kennit?  If no, us'll speak to the Great Grey for a pint o' the ol' clarity-draught."),
        no = {
            when = predicates.handler("dlg_p_dda_ef264459b360"),
            yes = ccb.content.text("Oh HO!  Well, well.  Now you're yarkin' the King's Anglic.  Aye, us'n can fix ye good, if'n ye're tassed to repay it in kind.  Us'll speak it as clear-like as this Rubik can.  If ye'n use it to put the dead back in the ground, us'n can fix ye with some goods like this, aye.  Stuck in the flesh and to the bone, wired into the brain.  Ye kennit?  If no, us'll speak to the Great Grey for a pint o' the ol' clarity-draught."),
            no = ccb.content.text("Ah, well.  Us'll put that into the key and lock, if'n you're ken.  Mayhap you could bring us a mite and trade, and we'll see if we can fix you good soon and soon.  Let no Exodii turn away a willin' Benny, and so it is."),
        },
    },
    replies = {
        {
            text = ccb.content.text("If I just keep on killing zombies, you'll help turn me into a cyborg?  Why are we still yarkin', then?  Sign me the heck up."),
            next_topic = "TALK_EXODII_MERCHANT_ExodizeMe1",
            when = predicates.handler("dlg_p_dda_973b457b3cfa"),
        },
        {
            text = ccb.content.text("On second thought, I'm not sure I want to let a bunch of unfamiliar alien robots do brain surgery on me."),
            next_topic = "TALK_EXODII_MERCHANT_ExodizeNope",
            when = predicates.handler("dlg_p_dda_973b457b3cfa"),
        },
        {
            text = ccb.content.text("Maybe try that clarity-draught?"),
            next_topic = "TALK_EXODII_MERCHANT_ExodizeTranslate",
            when = predicates.handler("dlg_p_dda_973b457b3cfa"),
        },
        {
            text = ccb.content.text("OK, well, I've got some stuff I could trade right now."),
            next_topic = "TALK_EXODII_MERCHANT_DoneTrade",
            when = predicates.handler("dlg_p_dda_f0e3a14b36fb"),
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("OK, maybe I'll come back when I've traded a bit more."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_f0e3a14b36fb"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_ExodizeTranslate",
    line = ccb.content.text("Hmm.\n\n*Rubik's voice becomes mechanical and distant for a moment, as if a computer takes over speaking.*\n\nIn exchange for the guarantee that you will use these gifts to combat the Great Enemy, this Exodii Node is willing to provide you with a bionic module command plexus, a power supply, and all the necessary infrastructure to obtain further upgrades with standardized CBMs - compact bionic modules.  We will require only a token fee, or an act of service, to earn this package.  We will provide further upgrades as purchased.  Your personal improvement serves our mutual benefit.\n\n*Rubik's voice takes over again.*\n\nClear as a draught?"),
    replies = {
        {
            text = ccb.content.text("If I just keep on killing zombies, you'll help turn me into a cyborg?  Why are we still yarkin', then?  Sign me the heck up."),
            next_topic = "TALK_EXODII_MERCHANT_ExodizeMe1",
            when = predicates.handler("dlg_p_dda_63b529d40afa"),
        },
        {
            text = ccb.content.text("If I just keep on killing zombies, you'll help turn me into a cyborg?  Why are we still yarkin', then?  Sign me the heck up."),
            next_topic = "TALK_EXODII_MERCHANT_ExodizeMe1",
            when = predicates.handler("dlg_p_dda_a3af36b24f10"),
            actions = { actions.adjust_faction_trust(-2), actions.handler("dlg_a_dda_fed44208bf32") },
        },
        {
            text = ccb.content.text("On second thought, I'm not sure I want to let a bunch of unfamiliar alien robots do brain surgery on me."),
            next_topic = "TALK_EXODII_MERCHANT_ExodizeNope",
        },
        {
            text = ccb.content.text("Why can't you talk that clearly all the time?  You have no idea how hard it is to understand your accent, let alone your words."),
            next_topic = "TALK_EXODII_MERCHANT_ExodizeDialect",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_ExodizeDialect",
    line = ccb.content.text("THIS'n's accent?  Ye've never egged y'r own yark, an' that's a fine fiddle.  Great Grey has a bit o' work on it, kennit?  This'n has to keep usselves useful, an' keep Great Grey doin' what it's tassed.  Asides, yarkin' to the local brights keeps us young an' shines our chrome, an I'm ken."),
    replies = {
        {
            text = ccb.content.text("Fine, whatever.  It doesn't matter, if you're gonna turn me into a horrifying fusion of machine and human, sign me the heck up."),
            next_topic = "TALK_EXODII_MERCHANT_ExodizeMe1",
            when = predicates.handler("dlg_p_dda_63b529d40afa"),
        },
        {
            text = ccb.content.text("Fine, whatever.  It doesn't matter, if you're gonna turn me into a horrifying fusion of machine and human, sign me the heck up."),
            next_topic = "TALK_EXODII_MERCHANT_ExodizeMe1",
            when = predicates.handler("dlg_p_dda_a3af36b24f10"),
            actions = { actions.adjust_faction_trust(-2), actions.handler("dlg_a_dda_fed44208bf32") },
        },
        {
            text = ccb.content.text("The more I talk to you, the more I'm not sure I want to let a bunch of unfamiliar alien robots do brain surgery on me."),
            next_topic = "TALK_EXODII_MERCHANT_ExodizeNope",
        },
        {
            text = ccb.content.text("OK, OK.  What was it you said?  I was distracted by the voice change."),
            next_topic = "TALK_NONE",
        },
    },
}
