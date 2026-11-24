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

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_ExodizeMe1",
    line = ccb.content.text(
        --~ Great, great, great!  Ha!  We'll fire up the old meat grinder.  Maybe you do a job for us, we do a job for you?  Or we could trade, maybe if you bring us a bit of good tea.  Not literally 'tea' of course.  That's my Anglic street slang.  I mean the stuff that puts you to sleep for surgery.  The Great Grey says your word for it is 'anesthetic'.  You bring us a thousand units of anesthetic, we'll fix you up with a wire and everything.
        "Fine an' fine, an' fine an' fine!  Ha!  Us'll rubber up the ol' gristle mill.  Mayhap a tit-for-tat, aye?  Or a trade, aye, mayhap wi' bringin' us a nip o' good tea.  Not 'tea', o'course.  I'm yarkin dockside Anglic here.  Us means the stuff what puts y'to sleep f'r a chirurgery.  The Great Grey says y'r assert for it is 'anus fetick'.  You bring us a thousand unit of 'anus fetick', us'll fix'n ye up with a wire an' a tiff."),
    replies = {
        {
            text = ccb.content.text("So I could bring you one thousand units of, uh, anesthetic?  And you'll give me this \"upgrade?\"  Sure, coming right up.  I'd better start looking."),
            when = predicates.negate(predicates.any({ predicates.has_mission("RUBIK_ANUS_FETICK"), predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_anusfetick" } }) })),
            actions = { actions.assign_mission("RUBIK_ANUS_FETICK") },
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("Could I do something else, maybe some kind of job, to earn this \"upgrade?\""),
            next_topic = "TALK_EXODII_MERCHANT_Jobs",
        },
    },
}

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

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Remove_Hub01_CBM_interface_1",
    line = ccb.content.text("&Rubik stares at you for a very long moment, rubs their chin, and scratches at a bit of metal on their head.  \"Rightly then, that tells where the missin' shinies n' stompers went.  Ye came clean, an' ol' Rubik prizes that.  Aye.  We can take it out.  But not wi'out risk.  Might leave ye wi' a mite less wits than afore, I'm afeared.  Yet for all yet honesty, we can't trade wi' ye nor let ye tarry if ye refuse, now.  So we take it out, an' ye may be the duller for it.  Or ye keep it, an' I'll grant ye' ten minutes' head start afore the stompers come huntin'.  Sorry.  Must be so.\""),
    replies = {
        {
            text = ccb.content.text("[Replace Hub 01 CBM interface with Exodii CBM interface; -1 Intelligence, -1 Dexterity]  I think it's worth the risk, especially so we can keep working together.  Get this thing out of me."),
            next_topic = "TALK_EXODII_MERCHANT_Exodized_Alt",
            actions = { actions.add_effect("speaker", "narcosis", { turns = 7200 }), actions.add_effect("speaker", "sleep", { turns = 7200 }), actions.handler("w16b_a_dda_09221323f43d"), actions.replace_mutation("speaker", "CBM_Interface"), actions.replace_mutation("speaker", "CBM_Interface_brain_lesion"), actions.handler("w16b_a_dda_7a90366fcd0b"), actions.set_actor_value("speaker", "Rubik_exodized_u", "yes") },
        },
        {
            text = ccb.content.text("Sorry, Rubik, but that doesn't sound worth it.  Thanks for the head start.  Guess I better go, before the Exodii start shooting."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_21d1c1428822") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Exodized2",
    line = ccb.content.text(
        --~ This is what you'd call a 'starter package', if I understand it.  Suitable to get you started, but for the really sweet parts you're going to want what I'm selling.  As we get to know each other better, I'll be able to get access to even more stuff.
        "This're what ye'd razz a 'starter package', an I'm ken.  Tassed to get ye started, but for the real lemony tarts you'd be wantin' what this'n's got for sale.  As us'n can come to see you clairly-like, this'n can be tassed to offer more an' more."),
    replies = {
        {
            text = ccb.content.text("So you can sell me more bionics, and as I get to know you better you'll have more?  Mind showing me what you've got right now?"),
            native_actions = { "start_trade" },
            next_topic = "TALK_EXODII_MERCHANT_DoneTrade",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Cyberframe_trust_no",
    line = ccb.content.text("Not today.  Too mighty an ask, and we can't spare the steelies.  But, I'll give ye a lump'a'ice.  Keep up work'n'trade, n' mayhaps somethin' changes one'a these days."),
    replies = {
        {
            text = ccb.content.text("I'm just really eager to shed this fleshy prison.  You sure there's nothing we can do?"),
            next_topic = "TALK_EXODII_MERCHANT_Cyberframe_trust_no_weirdo",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "decisions_blobpsychosis_u_too_eager_cyborg_body" } })),
            actions = { actions.set_actor_value("speaker", "decisions_blobpsychosis_u_too_eager_cyborg_body", "yes"), actions.handler("dlg_a_dda_d62a3b691c5f"), actions.adjust_faction_trust(-2) },
        },
        {
            text = ccb.content.text("I guess I'll ask again another time.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("I guess I'll ask again another time.  <end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

-- Rubik is skeptical of you if you are over-eager to get dissected down to your guts.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Cyberframe_trust_no_weirdo",
    line = ccb.content.text(
        --~ No, I don't think so.  Not today.
        "&Rubik is quiet for a long moment, and is clearly sizing you up.  \"No, methinks not today.\""),
    replies = {
        {
            text = ccb.content.text("Well, I guess I'll ask again another time.  <end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Cyberframe_trust_yes",
    line = ccb.content.text("Hm.  A mighty ask on a mighty ask.  Ye certainly got the disposition, but you sure you wanna be cut inta' this crowded space?\"  Rubik taps their metal torso.  \"You sure ya' lump is screwed on tight?  This isn't like the bright'n'steelies on offer.  No goin' back.  And ye best be happy with the amount'a power you can generate.  This'ere needs contant power.  Without power, yer good as dead.  The power storage units?  Fer a case this'n kind, one'a the power storage units buys you a little-less'an an hour of walkin'.  Less for scrappin' and scramblin'.  Nothin's easy about it.\""),
    replies = {
        {
            text = ccb.content.text("[Integrate your body into an Exodii Cyberframe] A robotic body I'll need to keep constantly powered?  Why not?  I'm ready."),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe",
            actions = { actions.adjust_faction_trust(5), actions.handler("dlg_a_dda_dd8915c46668") },
            opinion = { trust = 7, value = 5 },
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
    id = "TALK_EXODII_MERCHANT_Exodize_Cyberframe",
    line = ccb.content.text(
        --~ This Exodii is named Venn.  You've met before.  Venn and the Autodoc will do some serious work on you.  They'll take out all of your important organs and stick them in a Cyberframe, like these.  It will take a long time.  We can offer you one of two basic Cyberframes.  If your mind is set on doing this, you can pick.
        "&Rubik makes a stiff, bowing gesture and leads you out of the shop and down a stone pathway towards a familiar building - the gloomy surgical suite.  Rubik greets the humanoid cyborg that operates the suite, then stares a long moment in wordless communication.  The cyborg brings out a bulbous CRT monitor with a wired mechanical clicker, which they hand to you.  Rubik's joints hiss as they crouch to view the screen with you.\n\n\"This'ere Exodii monicked Venn.  Ye've met'afore.  Venn'n'the'robot here'll do you somethin' fierce.  They'll carve out all yer important meat bits, and stick'em in a Cyberframe, like this'n.  It'll take time.  Lots'o'time.  We've the means for two basic frames.  If yer lump is set, ye can pick.\"\n\nRubik gestures to the glowing terminal.  Displayed is an outline of what looks like a human.  Beside it are two other outlines.  The first, which Rubik calls \"one-aye,\" looks a lot like Rubik himself.  It towers over the human shape, and can only be called humanoid.  Its center mass is a thick, squat shape, with the head and torso hard to distinguish from one another.  The second, which Rubik calls \"one-bay,\" looks slender, traced by hard, mechanical lines, but is nevertheless distinctly human-like."),
    replies = {
        {
            text = ccb.content.text("Can you tell me a bit more about how Cyberframes work?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_info",
        },
        {
            text = ccb.content.text("What about my existing bionics?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_bionics",
        },
        {
            text = ccb.content.text("Tell me more about Cyberframe 1a."),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_1a",
        },
        {
            text = ccb.content.text("Tell me more about Cyberframe 1b."),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_1b",
        },
        {
            text = ccb.content.text("So, will I be an Exodii after this?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_exodii_question",
        },
        {
            text = ccb.content.text("Actually, can we wait?  I'll ask you about this again later."),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_back_out",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_info",
    line = ccb.content.text(
        --~ Simple, really.  You'll still be human on the inside.  Most of your meat will be there.  Even a lot of your muscle and bone.  But your arms and legs will mostly be robotic.  Your eyes, too.  You'll keep the inside parts, but they'll be part of the armored interface.  They'll all need power to work properly.  It'll all still work a bit without it, but it's not pleasant.  Your torso and head, and everything in them, will be integrated into the shell itself.  Your body will keep everything going as it is now, so no need for power there.  You'll be more sturdy, and the machines will do most of the hard work for you, so no more worrying about getting out of breath while running from the dead.  But that's only if you keep it powered and in good repair.
        "Peasey, truly.  You'll still be mostly mince, like ol' Rubik here.  Even much'a muscle n' bone.  Human inside.  But yer wiggles and wobs, that is yer limbs and digits, will be mostly steel.\"  Rubik motions to your eyes.  \"Yer berry pies, too.  Ye'll keep the see-ey bits, but they'll be part'a the new interface.  So, arms, legs, eyes, it'll all need power to work.  They'll work without, but tassed it isn't nice.\"  Rubik motions to your torso and head.  \"Now, yer chest n' lump, and everything in'em, will go inside the tidy bell.  Yer heart n' lungs n' all of that will keep going as it is now, no need for power.  All in all, you'll be more sturdy, n' the steel'll do the hard work for ye.  No more losin' breath on a scramble with the dead… if ye can stay powered n' in fine repair."),
    replies = {
        {
            text = ccb.content.text("What about my existing bionics?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_bionics",
        },
        {
            text = ccb.content.text("Tell me more about Cyberframe 1a."),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_1a",
        },
        {
            text = ccb.content.text("Tell me more about Cyberframe 1b."),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_1b",
        },
        {
            text = ccb.content.text("So, will I be an Exodii after this?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_exodii_question",
        },
        {
            text = ccb.content.text("Actually, can we wait?  I'll ask you about this again later."),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_back_out",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_bionics",
    line = ccb.content.text(
        --~ Since we're stripping you down to flesh and bone you need to survive, we can take the time to salvage your CBMs, and keep it all intact, reinstalled in your new Cyberframe.  But your limbs and other parts will be exchangeable, like bionics.  In the future, if you take off a limb, you'll have to remove your CBMs, fix them, clean them, and reinstall them.
        "Since ye've gotta strip down t'vital flesh n' hard scones, we'll salvage your bright'n'steelies, and repackage them in the new frame.  After, you can swap your wiggles and wobs, that is yer limbs and digits, like steelies, with a bit of effort.  If ye plan to do that, also plan to remove your implants, fix'em, clean'em, and shove'em back in."),
    replies = {
        {
            text = ccb.content.text("Can you tell me a bit more about how Cyberframes work?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_info",
        },
        {
            text = ccb.content.text("Tell me more about Cyberframe 1a."),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_1a",
        },
        {
            text = ccb.content.text("Tell me more about Cyberframe 1b."),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_1b",
        },
        {
            text = ccb.content.text("So, will I be an Exodii after this?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_exodii_question",
        },
        {
            text = ccb.content.text("Actually, can we wait?  I'll ask you about this again later."),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_back_out",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_1a",
    line = ccb.content.text(
        --~ Aye, so this one's a lot like mine.  Real popular among this Exodii node.  It's heavy duty, but as you can see, it's a little less human-like than maybe you're comfortable with.  It's a good, sturdy design, that will keep you safe.  But you'll have to get used to going without most clothing and armor.  The body just isn't made for them.  This is my suggestion.
        "&Rubik flicks a heavy plastic switch and the terminal whirs.  The image changes to a more detailed blueprint of the bulky, humanoid frame.  \"Aye, so this'n like thisn's, ol' Rubik's I mean.  Popular with us'n.  It's heavy n' tough.  Keep yer mince meat safe.  But if ye' wanna be real human, yer out of luck, as ye'll have to get used to goin' without cloth n' steel gear.  The frame just isn't made for them.  Won't fit.  But who needs'em?  Not me.  My lump'a'ice is ta' seal yourself up in this one.\""),
    replies = {
        {
            text = ccb.content.text("Can you tell me a bit more about how Cyberframes work?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_info",
        },
        {
            text = ccb.content.text("What about my existing bionics?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_bionics",
        },
        {
            text = ccb.content.text("[Integrate your body into an Exodii Cyberframe 1a] Okay, I'll take 1a, the bulky, armored frame."),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_1a_yes",
        },
        {
            text = ccb.content.text("Tell me more about Cyberframe 1b."),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_1b",
        },
        {
            text = ccb.content.text("So, will I be an Exodii after this?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_exodii_question",
        },
        {
            text = ccb.content.text("Actually, can we wait?  I'll ask you about this again later."),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_back_out",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_1b",
    line = ccb.content.text(
        --~ This one's for the nostalgic, I suppose, like Venn here.  You'll still have a human shape, and can still do and wear all your human things.  Downside is it can't be plated as well, so it's a bit more vulnerable by itself.
        "&Rubik flicks a heavy plastic switch and the terminal whirs.  The image changes to a more detailed blueprint of the human-like frame.  It's very familiar, and has all of the body parts one expects to find, albeit made of plates and metal joints.  \"This'n for those'n can't help'a look back, like Venn, aye?  You'll still have the shape'o'yerself, and ye'd still wear yer human things.  But can't be plated like this'n's and keep'at shape, so it's more tattarrattat, less thunk, should somethin' come and smash ya' up.  That is to say, yer less tough.\""),
    replies = {
        {
            text = ccb.content.text("Can you tell me a bit more about how Cyberframes work?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_info",
        },
        {
            text = ccb.content.text("What about my existing bionics?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_bionics",
        },
        {
            text = ccb.content.text("Tell me more about Cyberframe 1a."),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_1a",
        },
        {
            text = ccb.content.text("[Integrate your body into an Exodii Cyberframe 1b] Okay, I'll take 1b, the human-like frame."),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_1b_yes",
        },
        {
            text = ccb.content.text("So, will I be an Exodii after this?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_exodii_question",
        },
        {
            text = ccb.content.text("Actually, can we wait?  I'll ask you about this again later."),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_back_out",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_exodii_question",
    line = ccb.content.text(
        --~ No.  You'll be wearing an Exodii-suit, but nobody is Exodii until they jump with the Exodii, and that remains to be seen.
        "No.  Ye'll have the Exodii-suit, but nobody Exodii until there's a scrabble and jump to otherlands or otherworlds.  Who'at'll be remains to be."),
    replies = {
        {
            text = ccb.content.text("Can you tell me a bit more about how Cyberframes work?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_info",
        },
        {
            text = ccb.content.text("What about my existing bionics?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_bionics",
        },
        {
            text = ccb.content.text("Tell me more about Cyberframe 1a."),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_1a",
        },
        {
            text = ccb.content.text("Tell me more about Cyberframe 1b."),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_1b",
        },
        {
            text = ccb.content.text("Actually, can we wait?  I'll ask you about this again later."),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_back_out",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_back_out",
    line = ccb.content.text(
        --~ Yes, of course.  I'll go back to the shop.  Find me if you reconsider.
        "&Rubik lets out a mechanical chuckle.  \"Aye, 'course.  Escolt this'n out if ya' reconsider.\"\n\nWith that, Rubik gets up and leaves, offering a backward wave on his way out."),
    replies = {
        {
            text = ccb.content.text("…"),
            actions = { actions.set_actor_value("speaker", "Rubik_promised_cyberframe", "yes") },
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_1a_yes",
    line = ccb.content.text("&Rubik stares at Venn, and after a long silence, they offer each other a stiff bow.  Rubik places a hand upon your shoulder.  It's a familiar, warm gesture.  A stark juxtaposition to the chill of their metal hand.  You lay back upon the table, and you hear a mechanical whirr as the spider-like surgical robot starts to greedily tap away at your extremities.  You barely have a moment to consider your actions before it all goes black…"),
    replies = {
        {
            text = ccb.content.text("…"),
            next_topic = "TALK_DONE",
            actions = { actions.add_effect("speaker", "narcosis", { turns = 43200 }), actions.add_effect("speaker", "sleep", { turns = 43200 }), actions.handler("w16b_a_dda_9ce35a2a90df"), actions.replace_mutation("speaker", "EXODII_CYBERFRAME_GENERIC"), actions.handler("w16b_a_dda_93293e0035eb") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_1b_yes",
    line = ccb.content.text("&Rubik stares at Venn, and after a long silence, they offer each other a stiff bow.  Rubik places a hand upon your shoulder.  It's a familiar, warm gesture.  A stark juxtaposition to the chill of their metal hand.  You lay back upon the table, and you hear a mechanical whirr as the spider-like surgical robot starts to greedily tap away at your extremities.  You barely have a moment to consider your actions before it all goes black…"),
    replies = {
        {
            text = ccb.content.text("…"),
            next_topic = "TALK_DONE",
            actions = { actions.add_effect("speaker", "narcosis", { turns = 43200 }), actions.add_effect("speaker", "sleep", { turns = 43200 }), actions.handler("w16b_a_dda_9ce35a2a90df"), actions.replace_mutation("speaker", "EXODII_CYBERFRAME_GENERIC"), actions.handler("w16b_a_dda_644db66b5949") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_done",
    line = ccb.content.text("&You awaken.  Your vision is blurry, and it's as if there's something hiding at the edges of your sight that you can't shake.  You try to swat it away, only to find that your limbs don't work.  You become suddenly aware that none of your senses are truly working.  You're just staring at a great sea of nothing, through a non-existent window you can't discern the edges of.\n\nBefore you have time to panic, you come to.  Your head is swimming.  You see Rubik and Venn standing before you with a device wired to your chest.  But is it your chest?  You move your hands to feel, and all you sense is metal on metal.  You're no longer just flesh.  All you can see and feel is your new, mechanical Cyberframe.\n\nVenn detaches the wires and Rubik speaks:  \"Easy.\""),
    replies = {
        {
            text = ccb.content.text("Is it over?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_done2",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_done2",
    line = ccb.content.text(
        --~ Yes, it's done.  Don't waste time thinking about what's different.  You're still there, just inside a tough steel case.  It won't be easy to adapt, but keep a stiff upper lip - or be brave - as you might say.  Try to keep everything intact, but if you get any damage, come back here.  Venn'll do repairs in exchange for materials.
        "Aye, done'n'done.  Don' tarry on what's left.  Yer still there, just tougher'n steelies, now.  Time fer the stiff upper lip, as might be y'assert.\"  Rubik chuckles.  \"Anyhow, try'ta keep'er intact, but Ven'll keep ya' fixed up fer trade.  Got it?"),
    replies = {
        {
            text = ccb.content.text("I guess so.  I'll come talk to Venn if I need repairs.  Guess I'll be seeing you around, Rubik."),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_done3",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_done3",
    line = ccb.content.text("&Rubik offers you a shallow bow, then lumbers down the dusty hallway, leaving you alone in the surgical suite with Venn and your new bionic body."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}
