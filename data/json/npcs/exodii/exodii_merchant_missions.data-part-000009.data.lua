local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_1_met_hub",
    line = ccb.content.text("Ah, would ye be willin' ta yark with me about it?"),
    replies = {
        {
            text = ccb.content.text("*Tell him."),
            next_topic = "TALK_DONE",
            actions = { actions.adjust_faction_trust(10), actions.handler("dlg_a_dda_e3d719172842") },
        },
        {
            text = ccb.content.text("Maybe later, can we talk about something else?"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("Not right now.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_1_complete",
    line = ccb.content.text("'Tis a fine an' dandy!  What can ol' Rubik stand ye for, then?"),
    replies = {
        {
            text = ccb.content.text("Let's see what you have in stock."),
            next_topic = "TALK_DONE",
            actions = { actions.adjust_faction_trust(5), actions.handler("dlg_a_dda_13efa4e52843"), "start_trade" },
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
            text = ccb.content.text("I'm just glad to help, I don't need any payment."),
            next_topic = "TALK_DONE",
            actions = { actions.adjust_faction_trust(10) },
            opinion = { trust = 7, value = 5 },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_2_intro",
    line = {
        when = predicates.handler("dlg_p_dda_bb99692097c5"),
        yes = ccb.content.text("Well an surely, fruit gum!  How'd ye be twigged by a pop-an-squeak?  Or as y'r tassed, a treasure hunt?  'Tis a store-cabin, mayhap the likes you've seen.  This'n be older'n most, clade o' iron and crete-stone.  Abreast the ceil, high atop, there be a steely jut, piercin' the heavens.  In times ordinary, Great Grey could call out and screed the jut, kennit, and send aloft an escolt to razz 'er.  Oft times, the jut is wibbled on the wobble, an' it be coals'n coke.  Ol' Rubik can give you'n a dandy to pop 'er back aloft, and that's a fig and a fiddle."),
        no = {
            when = predicates.handler("dlg_p_dda_1a47555b13ec"),
            yes = ccb.content.text("Well an surely, fruit gum!  How'd ye be twigged by a pop-an-squeak?  Or as y'r tassed, a treasure hunt?  Mayhap this be a chance to show y'self a true, for Rubik's got sommat to ask yet again.  The way o' the Exode is t'shimmy an' wobble, an' on thislike wobble, a few bits wobbled off, kennit?  'Tis rightful common, alack.  One such is hidden for our escolts an' our screeds.  Mayhap as y'know the lands, ye'd have a see of it?  Aye, ye kennit well.  'Tis a store-cabin, mayhap the likes you've seen.  This'n be older'n most, clade o' iron and crete-stone.  Abreast the ceil, high atop, there be a steely jut, piercin' the heavens.  In times ordinary, Great Grey could call out and screed the jut, kennit, and send aloft an escolt to razz 'er.  Oft times, the jut is wibbled on the wobble, an' it be coals'n coke.  Ol' Rubik can give you'n a dandy to pop 'er back aloft, and that's a fig and a fiddle."),
            no = {
                when = predicates.handler("dlg_p_dda_0f3fab873de7"),
                yes = ccb.content.text("Well an surely, fruit gum!  For an' such as ye've done us a good.  How'd ye be twigged by a pop-an-squeak?  Or as y'r tassed, a treasure hunt?  'Tis a store-cabin, mayhap the likes you've seen.  This'n be older'n most, clade o' iron and crete-stone.  Abreast the ceil, high atop, there be a steely jut, piercin' the heavens.  In times ordinary, Great Grey could call out and screed the jut, kennit, and send aloft an escolt to razz 'er.  Oft times, the jut is wibbled on the wobble, an' it be coals'n coke.  Ol' Rubik can give you'n a dandy to pop 'er back aloft, and that's a fig and a fiddle."),
                no = ccb.content.text("Well an surely, fruit gum!  How'd ye be twigged by a pop-an-squeak?  Or as y'r tassed, a treasure hunt?  'Tis a store-cabin, mayhap the likes you've seen.  This'n be older'n most, clade o' iron and crete-stone.  Abreast the ceil, high atop, there be a steely jut, piercin' the heavens.  In times ordinary, Great Grey could call out and screed the jut, kennit, and send aloft an escolt to razz 'er.  Oft times, the jut is wibbled on the wobble, an' it be coals'n coke.  Ol' Rubik can give you'n a dandy to pop 'er back aloft, and that's a fig and a fiddle."),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("I think I got most of that.  A metal and concrete building with some kind of metal pole on top that you want me to fix?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_2_intro1",
        },
        {
            text = ccb.content.text("What?  A jut?  Fig and a fiddle?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_2_clarify",
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("<end_talking_leave>  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_2_clarify",
    line = ccb.content.text(
        --~ A jut is a long, thin pole.  The warehouse is made of concrete and rusty iron, and atop it there's a glistening pole.  The pole is broken, turned off.  I got a tool for you to turn it back on.
        "A jut be a long, thin post, kennit.  The store-cabin be made o' con-crete an' rusty iron, and atop it be a glintin' post.  The post be broken, I'd razz.  Turnt off.  Rubik's got a tool for you to pop, make it turnt on."),
    replies = {
        {
            text = ccb.content.text("OK, got it.  A metal and concrete building with some kind of metal pole on top that you want me to fix"),
            next_topic = "TALK_EXODII_MERCHANT_mission_2_intro1",
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
