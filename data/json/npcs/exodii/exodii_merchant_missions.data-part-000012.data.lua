local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_2_complete",
    line = ccb.content.text("Aye?"),
    replies = {
        {
            text = ccb.content.text("Yes, I found it intact."),
            next_topic = "TALK_EXODII_MERCHANT_mission_2_complete_success",
            when = predicates.handler("dlg_p_dda_af0d147a6715"),
        },
        {
            text = ccb.content.text("Yes, but you should know that it was empty when I got there.  Someone must have beat us to it."),
            when = predicates.handler("dlg_p_dda_3118207dac64"),
            trial = { kind = "lie", difficulty = 30 },
            success = { next_topic = "TALK_EXODII_MERCHANT_mission_2_complete_double_crossed_empty_lie_success" },
            failure = { next_topic = "TALK_EXODII_MERCHANT_mission_2_complete_double_crossed_lie_failure" },
        },
        {
            text = ccb.content.text("Yes, but you should know that the people from that bunker may be poking around.  I think they caught on that I was looking for it while I asking around for information.  Sorry, Rubik."),
            when = predicates.handler("dlg_p_dda_e180e3e44181"),
            trial = { kind = "lie", difficulty = 60 },
            success = { next_topic = "TALK_EXODII_MERCHANT_mission_2_complete_double_crossed_hub_poking_lie_success" },
            failure = { next_topic = "TALK_EXODII_MERCHANT_mission_2_complete_double_crossed_lie_failure" },
        },
        {
            text = ccb.content.text("Yes, but you should know that I sold its location to someone else."),
            next_topic = "TALK_EXODII_MERCHANT_mission_2_complete_double_crossed_truth",
            when = predicates.handler("dlg_p_dda_e180e3e44181"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_2_complete_success",
    line = {
        when = predicates.handler("dlg_p_dda_8b9c6170c186"),
        yes = ccb.content.text("An' a fine farthing ye did, on that.  Thankee sai.  We've a crib on the walkway already."),
        no = ccb.content.text("*gives you a long look, and somehow you know they're doing a slow blink inside their metal shell.  \"An' did ye forget sommat?  The booter?  Me heart and skelpy, 'tis not so hard a job.  Alas and alack, give us some directions then.\"  They pull out a notepad and pass a pencil your way."),
    },
    replies = {
        {
            text = ccb.content.text("Long days and pleasant nights, Rubik.  Let's talk payment."),
            next_topic = "TALK_EXODII_MERCHANT_mission_2_complete_pay",
            when = predicates.handler("dlg_p_dda_8b9c6170c186"),
            actions = { actions.adjust_faction_trust(5) },
        },
        {
            text = ccb.content.text("[Detail the road to the warehouse.  This will advance time by ten minutes.]"),
            next_topic = "TALK_EXODII_MERCHANT_mission_2_complete_pay",
            when = predicates.handler("dlg_p_dda_249de356eba3"),
            actions = { actions.handler("dlg_a_dda_d05d0c5b676b"), actions.adjust_faction_trust(4) },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_2_complete_double_crossed_empty_lie_success",
    line = {
        when = predicates.handler("dlg_p_dda_8b9c6170c186"),
        yes = ccb.content.text("Ah, shame, that.  But not ye doin' and a fine farthing ye did, on that.  Thankee sai."),
        no = ccb.content.text("*gives you a long look, and somehow you know they're doing a slow blink inside their metal shell.  \"Ah, shame, that.  But not ye doin' and a fine farthing ye did, on that.  But did ye forget sommat?  The booter?  Me heart and skelpy, 'tis not so hard a job.  Alas and alack, give us some directions then.\"  They pull out a notepad and pass a pencil your way."),
    },
    replies = {
        {
            text = ccb.content.text("Bad luck I suppose, but I still found the warehouse.  So, let's talk payment."),
            next_topic = "TALK_EXODII_MERCHANT_mission_2_complete_pay",
            when = predicates.handler("dlg_p_dda_8b9c6170c186"),
            actions = { actions.adjust_faction_trust(5) },
        },
        {
            text = ccb.content.text("[Detail the road to the warehouse.  This will advance time by ten minutes.]"),
            next_topic = "TALK_EXODII_MERCHANT_mission_2_complete_pay",
            when = predicates.handler("dlg_p_dda_249de356eba3"),
            actions = { actions.handler("dlg_a_dda_d05d0c5b676b"), actions.adjust_faction_trust(4) },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_2_complete_double_crossed_hub_poking_lie_success",
    line = {
        when = predicates.handler("dlg_p_dda_8b9c6170c186"),
        yes = ccb.content.text("Ah, shame on ye!  Ye kennin these'n's could be a right thorn.  But, a fine farthing ye did, on that.  Thankee sai."),
        no = ccb.content.text("*gives you a long look, and somehow you know they're doing a slow blink inside their metal shell.  \"Ah, shame on ye!  Ye kennin these'n's could be a right thorn.  But did ye forget sommat?  The booter?  Me heart and skelpy, 'tis not so hard a job.  Alas and alack, give us some directions then.\"  They pull out a notepad and pass a pencil your way."),
    },
    replies = {
        {
            text = ccb.content.text("I'm sorry Rubik, I'll be more careful in the future."),
            next_topic = "TALK_EXODII_MERCHANT_mission_2_complete_pay",
            when = predicates.handler("dlg_p_dda_8b9c6170c186"),
            actions = { actions.adjust_faction_trust(1) },
        },
        {
            text = ccb.content.text("[Detail the road to the warehouse.  This will advance time by ten minutes.]"),
            next_topic = "TALK_EXODII_MERCHANT_mission_2_complete_pay",
            when = predicates.handler("dlg_p_dda_249de356eba3"),
            actions = { actions.handler("dlg_a_dda_d05d0c5b676b") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_2_complete_double_crossed_lie_failure",
    line = {
        when = predicates.handler("dlg_p_dda_8b9c6170c186"),
        yes = ccb.content.text("*gives you a long look and then addresses you in a skeptical tone.  \"As'n'ye say.  Alas and alack.\""),
        no = ccb.content.text("*gives you a long look and then addresses you in a skeptical tone.  \"An' did ye forget sommat?  The booter?  Me heart and skelpy, 'tis not so hard a job.  Alas and alack, give us some directions then.\"  They pull out a notepad and pass a pencil your way."),
    },
    replies = {
        {
            text = ccb.content.text("I guess we should talk payment."),
            next_topic = "TALK_EXODII_MERCHANT_mission_2_complete_pay",
            when = predicates.handler("dlg_p_dda_8b9c6170c186"),
            actions = { actions.adjust_faction_trust(-3) },
        },
        {
            text = ccb.content.text("[Detail the road to the warehouse.  This will advance time by ten minutes.]"),
            next_topic = "TALK_EXODII_MERCHANT_mission_2_complete_pay",
            when = predicates.handler("dlg_p_dda_249de356eba3"),
            actions = { actions.handler("dlg_a_dda_d05d0c5b676b"), actions.adjust_faction_trust(-4) },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_2_complete_double_crossed_truth",
    line = ccb.content.text("*looks you up and down, sizing you up fully before speaking in a matter-of-fact tone.  \"Alas and alack.  A pop-an-work you'n be, a pop-an-work you'n do.  Now, ye remember this… the Exodii remembers, aye?\""),
    replies = {
        {
            text = ccb.content.text("Right.  Guess I'll see you around."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_6a114d22da22") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_2_complete_pay",
    line = {
        when = predicates.has_trait("speaker", "CBM_Interface"),
        yes = ccb.content.text("Ol' Rubik's gone down into the stores an' slicked up a handful o' some dandies for ye.\"  They reach below the counter and take out three clear plastic bags, each containing a different cybernetic module.  \"Us'n can only spare one o', though.    We can slip an' crank 'em in as y'like."),
        no = ccb.content.text("Aye, which'll ye like?"),
    },
    replies = {
        {
            text = ccb.content.text("[Install Air Filtration CBM] I like the look of that air filtration thingy.  Does it come with pine-fresh scent?"),
            next_topic = "TALK_DONE",
            when = predicates.any({ predicates.has_trait("speaker", "CBM_Interface"), predicates.has_trait("speaker", "NL_CBM_Interface") }),
            actions = { actions.add_effect("speaker", "narcosis", { turns = 1800 }), actions.add_effect("speaker", "sleep", { turns = 1800 }), actions.handler("dlg_a_dda_eb9951a4ce11") },
            opinion = { trust = 4, value = 3 },
        },
        {
            text = ccb.content.text("[Install Blood Analysis CBM] I've always wondered what's in my veins.  Let's try that blood analysis module."),
            next_topic = "TALK_DONE",
            when = predicates.any({ predicates.has_trait("speaker", "CBM_Interface"), predicates.has_trait("speaker", "NL_CBM_Interface") }),
            actions = { actions.add_effect("speaker", "narcosis", { turns = 1800 }), actions.add_effect("speaker", "sleep", { turns = 1800 }), actions.handler("dlg_a_dda_ab4fcf6183c6") },
            opinion = { trust = 4, value = 3 },
        },
        {
            text = ccb.content.text("[Install Radiation Scrubber CBM] I have nightmares about ending up like Marie Curie.  Radiation scrubber it has to be."),
            next_topic = "TALK_DONE",
            when = predicates.any({ predicates.has_trait("speaker", "CBM_Interface"), predicates.has_trait("speaker", "NL_CBM_Interface") }),
            actions = { actions.add_effect("speaker", "narcosis", { turns = 1800 }), actions.add_effect("speaker", "sleep", { turns = 1800 }), actions.handler("dlg_a_dda_b9aab0564e57") },
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
            next_topic = "TALK_EXODII_MERCHANT_mission_2_ExodiiFrame_no",
            when = predicates.handler("dlg_p_dda_f1aec37706ce"),
        },
        {
            text = ccb.content.text("Actually, could you turn me into a full-blown robotic cyborg, like you?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_2_ExodiiFrame_yes",
            when = predicates.handler("dlg_p_dda_3f9b38cb4654"),
        },
        {
            text = ccb.content.text("How about store credit instead?  [adds $1500 in store credit]."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_9aa5aeb741c9"), "start_trade" },
            opinion = { trust = 4, value = 3 },
        },
        {
            text = ccb.content.text("How about instead, we turn this into a mutually beneficial relationship in the future.  I don't need anything from you at the moment, but now you know I get the job done."),
            next_topic = "TALK_DONE",
            actions = { actions.adjust_faction_trust(4) },
            opinion = { trust = 7, value = 5 },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_2_ExodiiFrame_no",
    line = ccb.content.text("No.  Too mighty an ask, and we can't spare the steelies.  I'll give ye a lump'a'ice.  Keep up the work, n' mayhaps somethin' changes one'a these days."),
    replies = {
        {
            text = ccb.content.text("[Install Air Filtration CBM] Okay, I like the look of that air filtration thingy.  Does it come with pine-fresh scent?"),
            next_topic = "TALK_DONE",
            when = predicates.any({ predicates.has_trait("speaker", "CBM_Interface"), predicates.has_trait("speaker", "NL_CBM_Interface") }),
            actions = { actions.add_effect("speaker", "narcosis", { turns = 1800 }), actions.add_effect("speaker", "sleep", { turns = 1800 }), actions.handler("dlg_a_dda_eb9951a4ce11") },
            opinion = { trust = 4, value = 3 },
        },
        {
            text = ccb.content.text("[Install Blood Analysis CBM] Okay, I've always wondered what's in my veins.  Let's try that blood analysis module."),
            next_topic = "TALK_DONE",
            when = predicates.any({ predicates.has_trait("speaker", "CBM_Interface"), predicates.has_trait("speaker", "NL_CBM_Interface") }),
            actions = { actions.add_effect("speaker", "narcosis", { turns = 1800 }), actions.add_effect("speaker", "sleep", { turns = 1800 }), actions.handler("dlg_a_dda_ab4fcf6183c6") },
            opinion = { trust = 4, value = 3 },
        },
        {
            text = ccb.content.text("[Install Radiation Scrubber CBM] Well, I guess I have nightmares about ending up like Marie Curie.  Radiation scrubber it has to be."),
            next_topic = "TALK_DONE",
            when = predicates.any({ predicates.has_trait("speaker", "CBM_Interface"), predicates.has_trait("speaker", "NL_CBM_Interface") }),
            actions = { actions.add_effect("speaker", "narcosis", { turns = 1800 }), actions.add_effect("speaker", "sleep", { turns = 1800 }), actions.handler("dlg_a_dda_b9aab0564e57") },
            opinion = { trust = 4, value = 3 },
        },
        {
            text = ccb.content.text("How about store credit instead?  [adds $1500 in store credit]."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_cdaebc5e6ffd"), "start_trade" },
            opinion = { trust = 4, value = 3 },
        },
        {
            text = ccb.content.text("I'm in this for the long haul.  I don't want a reward - just know I can get the job done."),
            next_topic = "TALK_DONE",
            actions = { actions.adjust_faction_trust(4) },
            opinion = { trust = 7, value = 5 },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_2_ExodiiFrame_yes",
    line = ccb.content.text("Hm.  A mighty ask on a mighty ask.  Ye certainly got the disposition, but you sure you wanna be cut inta' this crowded space?\"  Rubik taps their metal torso.  \"You sure ya' lump is screwed on tight?  This isn't like the bright'n'steelies on offer.  No goin' back.  And ye best be happy with the amount'a power you can generate.  This'ere needs contant power.  Without power, yer good as dead.  The power storage units?  Fer a case this'n kind, one'a the power storage units buys you a little-less'an an hour of walkin'.  Less for scrappin' and scramblin'.  Nothin's easy about it.\""),
    replies = {
        {
            text = ccb.content.text("[Integrate your body into an Exodii Cyberframe] A robotic body I'll need to keep constantly powered?  Why not?  I'm ready."),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe",
            actions = { actions.adjust_faction_trust(5), actions.handler("dlg_a_dda_b40d86db77e7") },
            opinion = { trust = 7, value = 5 },
        },
        {
            text = ccb.content.text("[Install Air Filtration CBM] Nevermind.  I like the look of that air filtration thingy.  Does it come with pine-fresh scent?"),
            next_topic = "TALK_DONE",
            when = predicates.any({ predicates.has_trait("speaker", "CBM_Interface"), predicates.has_trait("speaker", "NL_CBM_Interface") }),
            actions = { actions.add_effect("speaker", "narcosis", { turns = 1800 }), actions.add_effect("speaker", "sleep", { turns = 1800 }), actions.handler("dlg_a_dda_eb9951a4ce11") },
            opinion = { trust = 4, value = 3 },
        },
        {
            text = ccb.content.text("[Install Blood Analysis CBM] Nevermind.  I've always wondered what's in my veins.  Let's try that blood analysis module."),
            next_topic = "TALK_DONE",
            when = predicates.any({ predicates.has_trait("speaker", "CBM_Interface"), predicates.has_trait("speaker", "NL_CBM_Interface") }),
            actions = { actions.add_effect("speaker", "narcosis", { turns = 1800 }), actions.add_effect("speaker", "sleep", { turns = 1800 }), actions.handler("dlg_a_dda_ab4fcf6183c6") },
            opinion = { trust = 4, value = 3 },
        },
        {
            text = ccb.content.text("[Install Radiation Scrubber CBM] Nevermind.  I guess I have nightmares about ending up like Marie Curie.  Radiation scrubber it has to be."),
            next_topic = "TALK_DONE",
            when = predicates.any({ predicates.has_trait("speaker", "CBM_Interface"), predicates.has_trait("speaker", "NL_CBM_Interface") }),
            actions = { actions.add_effect("speaker", "narcosis", { turns = 1800 }), actions.add_effect("speaker", "sleep", { turns = 1800 }), actions.handler("dlg_a_dda_b9aab0564e57") },
            opinion = { trust = 4, value = 3 },
        },
        {
            text = ccb.content.text("On second thought, how about store credit instead?  [adds $1500 in store credit]."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_435a1df53793"), "start_trade" },
            opinion = { trust = 4, value = 3 },
        },
        {
            text = ccb.content.text("Actually, I don't want a reward - just know I can get the job done."),
            next_topic = "TALK_DONE",
            actions = { actions.adjust_faction_trust(4) },
            opinion = { trust = 7, value = 5 },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_3_intro",
    line = ccb.content.text(
        --~ Do you remember that bunker you found for us?  Well, turns out they're not so friendly.  We found out one of their people is running some sort of workshop, and we think that an explorer we lost is being held inside.  They're Exodii like me - lots of metal, not easy to miss.  I think they're being tortured, at the least.  If you, a mercenary, can recover them, we'd pay handsomely.
        "Ye mind that bunker ye ferreted fer us'n?  Turns they be no kindly folk.  Us'n learned one o'their scavs keep'n a second hall, an' we reckon an escolt we lost be held fast inside.  One kin t'me - Exodii - much metal, deep red shell, hard t'miss.  Torture'n the like - bad if tassed this'n.  If ye can fetch 'em back pop-n-work-like, us'll pay ye right handsome."),
    replies = {
        {
            text = ccb.content.text("Why can't one of you do this?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_3_explain",
        },
        {
            text = ccb.content.text("What if the worst has happened, and they're dead?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_3_advice_dead",
        },
        {
            text = ccb.content.text("So one of those scientists from the bunker abducted one of your people?  An exodii with a red frame?  You want me to find them?  I'll do it."),
            actions = { actions.assign_mission("EXODII_MISSION_CHOP_SHOP") },
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("I'm gonna need to think on this one.  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_3_explain",
    line = ccb.content.text(
        --~ I don't want them to know we are involved.  We've seen people like this in other otherlands, and we know it's dangerous to let them know too much about us.
        "Ol' Rubik don't want'n 'em kennin' us'n be involved.  Folk o' this kind we've spied in otherlands, an' we ken it be perilous t'let 'em learn o'er much about us'n."),
    replies = {
        {
            text = ccb.content.text("Right, so you don't want them to know that you're involved.  I'll see if I can find this exodii with a red frame."),
            actions = { actions.assign_mission("EXODII_MISSION_CHOP_SHOP") },
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("<end_talking_leave>  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_3_advice_dead",
    line = ccb.content.text(
        --~ If that's the case, just bring back proof.  We know them well, so any part of their frame will do.  It's a deep red color.  Hard to miss.
        "If that be the case, fetch back the proof ya' can.  Any piece'o'their frame will do, but I'd prefer all of it.  Deep red color.  Hard t'miss."),
    replies = {
        {
            text = ccb.content.text("If they're dead, just bring back a piece of their red frame as proof.  Let's hope they're alive.  I'll see if I can find this exodii."),
            actions = { actions.assign_mission("EXODII_MISSION_CHOP_SHOP") },
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("<end_talking_leave>  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}
