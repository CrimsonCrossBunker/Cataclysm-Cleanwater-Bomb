local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_mission {
    id = "RUBIK_ANUS_FETICK",
    name = ccb.content.text("Bring 1000 units of anesthetic to Rubik"),
    goal = "MGOAL_CONDITION",
    difficulty = 2,
    value = 240,
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("If'n us'll to add the metal an' plastic for ye, us'll need a thousand unit o' them anus-feticks, half for your thinkin'-meat an' half for our stock."),
        offer = ccb.content.text("If'n us'll to add the metal an' plastic for ye, us'll need a thousand unit o' them anus-feticks, half for your thinkin'-meat an' half for our stock."),
        accepted = ccb.content.text("King's own luck!"),
        rejected = ccb.content.text("That be a choice an' you can tass.  Come back to this'n if you like."),
        advice = ccb.content.text("Check round the chirurgery an' such, I'd razz."),
        inquire = ccb.content.text("Us'n waits patient-like for that anus-fetick."),
        success = ccb.content.text("Fine an' fine.  We can pass it in when you like."),
        success_lie = ccb.content.text("Fine an' fine.  We can pass it in when you like."),
        failure = ccb.content.text("Fine an' fine.  Come back to this'n if you like to try again."),
    },
    finish = { handler = "mark_mission_completed_anusfetick" },
}

ccb.content.define_mission {
    id = "EXODII_MISSION_CONTACT_HUB",
    name = ccb.content.text("Investigate the Mysterious Bunker"),
    goal = "MGOAL_GO_TO_TYPE",
    destination = "robofachq_surface_entrance",
    start = {
        target = {
            terrain = "robofachq_surface_entrance",
            special = "hub_01",
            reveal_radius = 1,
            random = false,
        },
    },
    finish = { handler = "mark_mission_completed_u_scouted_bunker" },
    difficulty = 2,
    value = 0,
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("-"),
        offer = ccb.content.text("-"),
        accepted = ccb.content.text("-"),
        rejected = ccb.content.text("-"),
        advice = ccb.content.text("-"),
        inquire = ccb.content.text("What've ye scolted, then, o'the clunker?"),
        success = ccb.content.text("Aye and fine!  One for the paper-claim an' so.  An I'm ken, these'n's could be a right thorn.  For ol' Rubik's sake, let's hope they be'n't for to drive us out o' your otherlands."),
        success_lie = ccb.content.text("Hm.  The escoltin' our way be less.  This'n'll yark at the Scythy mayhaps."),
        failure = ccb.content.text("Fine an' fine.  Come back to this'n if you like to try again."),
    },
}

ccb.content.define_mission {
    id = "EXODII_MISSION_CHOP_SHOP",
    name = ccb.content.text("Recover the Missing Exodii"),
    description = ccb.content.text("Rubik believes a missing Exodii scout is being kept hostage, or worse, has been killed, by members of Hub 01.  Rubik says the scout will look a bit like him: a mostly-metal cyborg, but with a recognizable red frame.  I either need to rescue the Exodii, or bring back a piece of their \"body\" as proof that they have perished."),
    goal = "MGOAL_NULL",
    destination = "robofac_strip_mall_x1y0",
    difficulty = 5,
    value = 0,
    start = {
        target = {
            terrain = "robofac_strip_mall_x1y0",
            special = "robofac_strip_mall",
            reveal_radius = 4,
            random = false,
        },
    },
    finish = { handler = "mark_mission_completed_exodii_mission_chop_shop" },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("…"),
        offer = ccb.content.text("…"),
        accepted = ccb.content.text("…"),
        rejected = ccb.content.text("…"),
        advice = ccb.content.text("…"),
        inquire = ccb.content.text("…"),
        success = ccb.content.text("…"),
        success_lie = ccb.content.text("…"),
        failure = ccb.content.text("…"),
    },
}

ccb.content.define_mission {
    id = "EXODII_MISSION_WAREHOUSE",
    name = ccb.content.text("Find the lost Exodii warehouse and reboot its locator antenna."),
    goal = "MGOAL_GO_TO_TYPE",
    destination = "exo_warehouse_1",
    start = {
        item_rewards = { { item = "warehouse_rebooter" } },
        handler = "set_world_exodii_mission_wh_chance_to_6",
    },
    finish = { handler = "mark_mission_completed_u_found_warehouse" },
    difficulty = 5,
    value = 2,
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = "",
        offer = "",
        accepted = ccb.content.text("King's own luck!"),
        rejected = ccb.content.text("That be a choice an' you can tass.  Come back to this'n if you like."),
        advice = ccb.content.text("What ye'r searching is safehouse-like, sand, stone, metal an' all."),
        inquire = ccb.content.text("Us'n waits patient-like for that'."),
        success = ccb.content.text("Fine an' fine.  We can pass it in when you like."),
        success_lie = ccb.content.text("Fine an' fine.  We can pass it in when you like."),
        failure = ccb.content.text("Fine an' fine.  Come back to this'n if you like to try again."),
    },
}

ccb.content.define_mission {
    id = "EXODII_MISSION_MEET_FREE_MERCHANTS",
    name = ccb.content.text("Go to the Refugee Center and negotiate a trade deal between the Free Merchants and the Exodii.  Don't forget to take the Exodii \"talk-rad talk-vid\"."),
    goal = "MGOAL_NULL",
    destination = "evac_center_18",
    start = {
        target = { terrain = "evac_center_18", special = "evac_center", reveal_radius = 4, random = false },
    },
    finish = { handler = "mark_mission_completed_exodii_mission_meet_free_merchants" },
    difficulty = 5,
    value = 2,
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = "",
        offer = "",
        accepted = "",
        rejected = "",
        advice = "",
        inquire = "",
        success = "",
        success_lie = "",
        failure = "",
    },
}

ccb.content.define_mission {
    id = "EXODII_MISSION_STRING_DIMENSION_EXODII",
    name = ccb.content.text("Download data from the other-dimension Exodii node"),
    goal = "MGOAL_NULL",
    start = { item_rewards = { { item = "exodii_usb_stick" } } },
    finish = { handler = "mark_mission_completed_u_returned_string_dimension_data" },
    difficulty = 5,
    value = 2,
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = "",
        offer = "",
        accepted = "",
        rejected = "",
        advice = "",
        inquire = "",
        success = "",
        success_lie = "",
        failure = "",
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_1_intro",
    line = ccb.content.text(
        --~ Just because you asked, I think we can work something out.  Yes, the Scythean has been bugging me about something.  It's not something a cyborg like me can do, but a mercenary would probably fit the bill.
        "Them as offer as can, an it be so.  How'd ye be twigged by a quick an' round, a nice escoltin' out to a place sommat of curiosity?  Aye, there's summat the old Scythy been larkin' up Rubik's tailpipe.  B'ain't tass right for a clanker like this'n, but a pop-an-work like you'n, maybe well and suited."),
    replies = {
        {
            text = ccb.content.text("What's \"the ol' Scythy\"?"),
            next_topic = "TALK_EXODII_MERCHANT_Scythean",
        },
        {
            text = ccb.content.text("Why can't one of you do this?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_1_explain",
        },
        {
            text = ccb.content.text("Tell me more about this job that you can't do."),
            next_topic = "TALK_EXODII_MERCHANT_mission_1_intro1",
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
    id = "TALK_EXODII_MERCHANT_mission_1_explain",
    line = ccb.content.text(
        --~ Have you seen our big stompy quads?  There's a lot of things we're good at, but sneaky and subtle we aren't.  If we want a meet cute, first we've got to lay out the hempen mats.
        "Hat ye kennt our great clanks an' stompers?  There be many a thing we can do right good, but for the supple an' smooth, we b'ain't.  Wish'n we to make a meet-cute, must we first lay out the hempen mats."),
    replies = {
        {
            text = ccb.content.text("Hold up, did you just say \"meet cute\"?"),
            next_topic = "TALK_EXODII_MERCHANT_Meetcute",
        },
        {
            text = ccb.content.text("I am guessing it doesn't matter, but what do you mean about hempen mats?"),
            actions = { actions.set_actor_value("speaker", "rubik_personal_questions", "hempen_mats") },
            next_topic = "TALK_EXODII_MERCHANT_Hempen1",
        },
        {
            text = ccb.content.text("OK, fine.  Tell me more about this job that you can't do."),
            next_topic = "TALK_EXODII_MERCHANT_mission_1_intro1",
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
    id = "TALK_EXODII_MERCHANT_mission_1_intro1",
    line = ccb.content.text(
        --~ It's a bit hard to explain, but I'll do my best.  The forces we send far out, what I'd call 'escolts'… explorers?  They've scouted a place with a bit of promise, as far as I can tell.  A wall of concrete around a bunker.  That's not so odd in a place like this, but this one has people coming and going.  There's something still in there, and I wonder who.  Are they friendly or not?  What would you think about doing some scouting yourself?
        "It be a right coddle to yark, but ol' Rubik'll do as can.  Them as we send a'far, what I'd assert as 'escolts'… explorers?  They's escolted a place with a mite o' promise, an I'm ken.  A wall o' crete-stone, abreast a rattlin' clunker… a 'bunker'.  Not so odd in a deadlands alas, but this'n gots the comin's and goin's.  Sommat's still in there, an' ol' Rubik wonders who.  Be they friend or foe?  What say ye t'helpin' with a mite o' escoltin' y'self?"),
    replies = {
        {
            text = ccb.content.text("Why can't one of you do this?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_1_explain",
        },
        {
            text = ccb.content.text("Well, today's your lucky day, my metal friend.  I already know the place quite well."),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_u_discovered_robofac_intercom" } }),
            next_topic = "TALK_EXODII_MERCHANT_mission_1_met_hub",
        },
        {
            text = ccb.content.text("What exactly do you want me to do?  Scout out this bunker and contact the people in it?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_1_intro2",
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
    id = "TALK_EXODII_MERCHANT_mission_1_intro2",
    line = ccb.content.text(
        --~ No, my friend, no!  Don't make contact, understand?  This is a covert op.  If you see that it's safe you can go in closer and look around, but for goodness' sake, don't talk to anyone and don't linger.
        "No, me fruit gum, no!  Make no contact, y'ken?  This be covert.  If ye kennit be safe, traipse along an' for a kennabout, but upon the chimes, speak none and tarry little."),
    replies = {
        {
            text = ccb.content.text("I get the impression this is important, but I don't know what you mean."),
            next_topic = "TALK_EXODII_MERCHANT_mission_1_intro2_translate",
        },
        {
            text = ccb.content.text("This sounds insanely dangerous.  They could just shoot me on sight."),
            next_topic = "TALK_EXODII_MERCHANT_mission_1_intro3",
        },
        {
            text = ccb.content.text("So you want me to go there, see what's inside the walls, look around a little, and then let you know if I see anything, but if someone tries to talk to me, not mention you or your people?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_1_understood",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("I'm gonna need to think on this one.  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_1_intro2_translate",
    line = ccb.content.text("*pauses for a moment, and lets out a slow sigh, speaking hesitantly as they catch themselves in idioms.  \"Make no contact.  We ken… we think the abroad o'… the outside o' the bunker be safe an'… be safe to explore, for one such as ye, who harks as from this'n land.  A wander in and escolt… a look around we ken as no… no risk.  If ye think ye been spotted, wave along and make no mention of ol' Rubik and the Exodii.  Not afore we be razzed some more o' this rattlin'… this bunker.\""),
    replies = {
        {
            text = ccb.content.text("How can you know that it's safe?  What if I'm shot on sight?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_1_intro3",
        },
        {
            text = ccb.content.text("So you want me to go there, see what's inside the walls, look around a little, and then let you know if I see anything, but if someone tries to talk to me, not mention you or your people?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_1_understood",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("I'm gonna need to think on this one.  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_1_intro3",
    line = ccb.content.text(
        --~ Our scouts have seen people who look like you wandering in the area safely.  If the scavengers can make it in and out, you should be fine.
        "Them as we've escolted seems a fair kin, an' we've eyed a scav or two wanderin' the premise unscathed.  If'n the scavs o' the dust can make it in an' out, so should ye be."),
    replies = {
        {
            text = ccb.content.text("So you want me to go there, see what's inside the walls, look around a little, and then let you know if I see anything, but if someone tries to talk to me, not mention you or your people?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_1_understood",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("I'm gonna need to think on this one.  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_1_understood",
    line = ccb.content.text("Aye, ye kennit well."),
    replies = {
        {
            text = ccb.content.text("This is insane.  I can't tell if you're leading me into a trap or not.  What's in it for me?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_1_pay_skeptic",
        },
        {
            text = ccb.content.text("Sure.  Don't know what good it'll do you, but I might be willing.  What are you paying?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_1_pay_nice",
        },
        {
            text = ccb.content.text("I'm gonna need to think on this one.  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_1_pay_skeptic",
    line = ccb.content.text(
        --~ I didn't know you'd be such a hard bargain!  Tell ya what, when you come back, I'll let you in on some of these fancy knick-knacks.
        "Rightly a trig barter, an I'm ken.  By ol' Rubik's word, on your saintly march home, for you'll have the pick of the bright and steelies roun' ol' Rubik's shop, choice o' your own finely.  What say?"),
    replies = {
        {
            text = ccb.content.text("I'll go check it out."),
            actions = { actions.assign_mission("EXODII_MISSION_CONTACT_HUB") },
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("I'm gonna need to think on this one.  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_1_pay_nice",
    line = ccb.content.text(
        --~ That's quite the spirit!  For an exchange, I'll give you some of these shiny tools, whatever you want.  How's that sound?
        "Ah, 'tis a fine spark.  F'r a switch an' clock, ol' Rubik can share y'like o' these bright and steelies roun' the shop, choice o' your finely.  What say?"),
    replies = {
        {
            text = ccb.content.text("I'll go check it out.  Thanks, Rubik."),
            actions = { actions.assign_mission("EXODII_MISSION_CONTACT_HUB") },
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("I'm gonna need to think on this one.  I'll see you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}

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

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_2_intro1",
    line = ccb.content.text("Just so.  'Tis like yarkin' fit f'r me beloved jaryi, y'kennit so fine.  What say you?"),
    replies = {
        {
            text = ccb.content.text("What, now that I think on it, I am not sure what you meant about juts and figs."),
            next_topic = "TALK_EXODII_MERCHANT_mission_2_clarify",
        },
        {
            text = ccb.content.text("Shouldn't your quads be able to do that?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_2_explain",
        },
        {
            text = ccb.content.text("Any clues on how to find it?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_2_find",
        },
        {
            text = ccb.content.text("What's in this for me?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_2_reward",
        },
        {
            text = ccb.content.text("Then I'll find it."),
            next_topic = "TALK_DONE",
            actions = { actions.assign_mission("EXODII_MISSION_WAREHOUSE") },
        },
        {
            text = ccb.content.text("Beloved jaryi?  What did you just call me?"),
            next_topic = "TALK_EXODII_MERCHANT_jaryi",
            actions = { actions.handler("dlg_a_dda_c9b772244028") },
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
    id = "TALK_EXODII_MERCHANT_jaryi",
    line = ccb.content.text(
        --~ No, I'm not calling you jaryi.  Jaryi is my mother's mother.  It's a King's Landing word for a grandmother, I'm making a little joke at you.
        "Ha, not callin' y'me jaryi.  Jaryi be the mother-twice.  'Tis but a King's Landing assert f'r a grandmother, Rubik's makin' a chestnut at ye."),
    replies = {
        {
            text = ccb.content.text("That word doesn't sound like any of the other Anglic words you've used, though.  What's it from?"),
            next_topic = "TALK_EXODII_MERCHANT_jaryi2",
        },
        {
            text = ccb.content.text("What were you talking about before?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_2_intro1",
        },
        {
            text = ccb.content.text("<end_talking_leave>  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_jaryi2",
    line = ccb.content.text(
        --~ That's right, I did.  My mother's mother was a woman of the old kind, and so was my father's father.  My father's mother, she was a grandma, a little piece of old London-Town, but I had a jaryi and a taita and a tamoi (these are words for grandparents in a guarani dialect).  They were all there, right to the end.  Standing by, we were, one and all.  No time for stories, though.  Back to the here and now.
        "Right so, a fine notice.  Rubik's mother-twice, she were a woman o'th'old kind.  And were her mate, and Rubik's father-twice.  Rubik's father-mother, she were a gran, a fitty bit of ol' London-Town, right so, but Rubik had a jaryi and a taita and a tamoi.\" Rubik's voice goes distant for a moment.  \"An' they was all there, right to the end.  Standin' by, we were, one and all.\" They pause, then seem to snap back.  \"No time for stories, kennit?  Back to the here an' now."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "knowledge_rubik_jaryi_u_knows_exodiilore", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Yeah, let's talk about business again."),
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

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_2_explain",
    line = ccb.content.text(
        --~ Without any indication of its location, there's too much ground to cover, and we have many other things to look for.  This one is pretty easy to see, so maybe some of the locals can help find it.
        "'Tis a gull's errand, with narry a sign.  Our stompers cannot cover each squarrel, and they've many a dropsy to search.  This'n be a right easy spot for keen eyes, so mayhap your sameworlds can be of a snap."),
    replies = {
        {
            text = ccb.content.text("Then I'll find it."),
            next_topic = "TALK_DONE",
            actions = { actions.assign_mission("EXODII_MISSION_WAREHOUSE") },
        },
        {
            text = ccb.content.text("Any clues on how to find it?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_2_find",
        },
        {
            text = ccb.content.text("What's in this for me?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_2_reward",
        },
        {
            text = ccb.content.text("I need a moment.  <done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("I'm gonna need to think on this one.  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_2_find",
    line = ccb.content.text(
        --~ that's up to you, I think.  If I could find it myself, I'd send quads out there.  Maybe it would be worth asking around to other survivors?  Seems like a good job for a local guide.
        "That's be for your assert, an I'm ken.  If ol' Rubik could find 'er, us'n'd send out the stompers.  For a yark an' a lark, though, couldst ask another of your sameworld?  Mercants or traveler-such?  It be a fine slick to a local guide."),
    replies = {
        {
            text = ccb.content.text("Then I'll find it."),
            next_topic = "TALK_DONE",
            actions = { actions.assign_mission("EXODII_MISSION_WAREHOUSE") },
        },
        {
            text = ccb.content.text("Shouldn't your quads be able to do that?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_2_explain",
        },
        {
            text = ccb.content.text("What's in this for me?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_2_reward",
        },
        {
            text = ccb.content.text("I need a moment.  <done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("I'm gonna need to think on this one.  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_2_reward",
    line = {
        when = predicates.has_trait("speaker", "CBM_Interface"),
        yes = ccb.content.text("Ye'll win the endless delight of ol' Rubik?\"  You hear a tinny chuckle from behind Rubik's faceplate.  \"O'course.  Ol' Rubik can find f'r ye something a mite special, from the ol' CBM vaults.  Mayahp a choice?  We're kickin' a thriceways.\"  Rubik reaches into the desk in front of them and pulls out a tiny, green-glowing CRT that, amid all the strange alien technology, looks bizarrely familiar, like something from a 1970's sci-fi movie.  They scroll rapidly down a list to find three items, which they tap to emphasize.  'air filtration CBM', 'blood analysis CBM', and 'radiation scrubber system CBM'.\n\n\"Think on it, decide on a last."),
        no = ccb.content.text("Ye'll win the endless delight of ol' Rubik?\"  You hear a tinny chuckle from behind Rubik's faceplate.  \"O'course.  Ol' Rubik can find f'r ye something a mite special from the ol' vaults, or, us'n can fix ye with some goods like ol' Rubik's, aye - stuck in the flesh and to the bone, wired into the brain."),
    },
    replies = {
        {
            text = ccb.content.text("Then I'll find it."),
            next_topic = "TALK_DONE",
            actions = { actions.assign_mission("EXODII_MISSION_WAREHOUSE") },
        },
        {
            text = ccb.content.text("Shouldn't your quads be able to do that?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_2_explain",
        },
        {
            text = ccb.content.text("Any clues on how to find it?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_2_find",
        },
        {
            text = ccb.content.text("I need a moment.  <done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("I'm gonna need to think on this one.  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}

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

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_4_intro",
    line = ccb.content.text(
        --~ Well, as it were, things are going well.  In fact, we've started doing some good deals, and not just with you.  And we've become aware of a group that calls themselves the Free Merchants.  We need a human from this earth to talk to them, so that maybe we can set up some more organized trade, with the time we have left on this rock.  We're willing to pay you to make introductions.  Interested?
        "&Rubik lets out a rather comfortable chuckle from their speakers, and slaps their robotic belly.  \"Well, well, things are goin' swell.  Us'n've started right an' proper jelly, and not wi' just you neither.  By the by we've come ken of some monicks themselves the \"Free Merchants,\" as it were.  Lots'o'scrap.  Stuff we like and need.  Need us a person'o'this'land t'parlay with'em, see if mayhap we can set up finer trade betwixt, for the good hours in the sun we've left here, 'least.  Us'nlll stand ye a mighty tidy reward for introductions.  What say, fruit gum?"),
    replies = {
        {
            text = ccb.content.text("So you want me to introduce you to the Free Merchants?  Sure, why not.  I'll do it."),
            when = predicates.any({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Gavin" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "exodii_told_u_about_free_merchants" } }) }),
            actions = { actions.assign_mission("EXODII_MISSION_MEET_FREE_MERCHANTS") },
            next_topic = "TALK_EXODII_MERCHANT_mission_4_accepted",
        },
        {
            text = ccb.content.text("Who are the Free Merchants?"),
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Gavin" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "exodii_told_u_about_free_merchants" } })) }),
            actions = { actions.set_actor_value("speaker", "exodii_told_u_about_free_merchants", "yes") },
            next_topic = "TALK_EXODII_MERCHANT_mission_4_who",
        },
        {
            text = ccb.content.text("So, why can't an Exodii do this?  Why me?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_4_explain",
        },
        {
            text = ccb.content.text("Don't you think my new cyborg body might be a problem?"),
            when = predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC"),
            next_topic = "TALK_EXODII_MERCHANT_mission_4_explain_cyborg",
        },
        {
            text = ccb.content.text("Maybe some other time.  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_4_who",
    line = ccb.content.text(
        --~ Merchants held up in some sort of large building.  They're proper traders as far as I can tell.  To have caravans so soon after the end times speaks something to their ingenuity, but maybe should also inspire caution.  They're smart, but maybe conniving.  Either way, they're not secretive like that bunker, so that's good
        "Mongers holed up in some great clunk of a buildin'.  Proper traders, far as ol' Rubik can tell.  To run a caravan so soon past the dyin'o'the'world, that speaks a mite to their grit an' know-how, but mayhaps it'd be wise to keep one eye sharp, too.  Keen as a tack, but maybe slippery ta'boot.  Either way, they be ain't secret.  Not hidin' behind crete n' iron like the bunker-folk.  So that's a fair mercy."),
    replies = {
        {
            text = ccb.content.text("So you want me to introduce you to the Free Merchants?  Sure, why not.  I'll do it."),
            when = predicates.any({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Gavin" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "exodii_told_u_about_free_merchants" } }) }),
            actions = { actions.assign_mission("EXODII_MISSION_MEET_FREE_MERCHANTS") },
            next_topic = "TALK_EXODII_MERCHANT_mission_4_accepted",
        },
        {
            text = ccb.content.text("Don't you think my new cyborg body might be a problem?"),
            when = predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC"),
            next_topic = "TALK_EXODII_MERCHANT_mission_4_explain_cyborg",
        },
        {
            text = ccb.content.text("Maybe some other time.  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_4_explain",
    line = ccb.content.text(
        --~ Well, I think it's obvious that someone people might be intimidated by our cybernetic enhancements. Rightfully so.  Might even think we're part of the Enemy.  You, though?  Normal, by their standards.  I think we stand a better chance.
        "Well an' surely, some folk'll take a mightly long squint at the bright'n'steelies on me an' feel a MITE uneasy, aye?  And rightly so, an I'm ken.  Might even reckon us kin'o'the Enemy.  But you?  By their reckonin', yer ordinary.  Normal.  Regular clap.  Gives us a finer chance, I'd razz."),
    replies = {
        {
            text = ccb.content.text("So you want me to introduce you to the Free Merchants?  Sure, why not.  I'll do it."),
            when = predicates.any({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Gavin" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "exodii_told_u_about_free_merchants" } }) }),
            actions = { actions.assign_mission("EXODII_MISSION_MEET_FREE_MERCHANTS") },
            next_topic = "TALK_EXODII_MERCHANT_mission_4_accepted",
        },
        {
            text = ccb.content.text("Don't you think my new cyborg body might be a problem?"),
            when = predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC"),
            next_topic = "TALK_EXODII_MERCHANT_mission_4_explain_cyborg",
        },
        {
            text = ccb.content.text("Maybe some other time.  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_4_explain_cyborg",
    line = ccb.content.text(
        --~ Well, correct, these days we look a lot alike, being cyborgs and all.  But you speak normal English for this Earth, not Anglic like me.  Lower chance they mistake us for the Enemy, or something like that.
        "Well an' surely, these days ye an' ol' Rubik look near alike, what with the whole cyborgin' an' all.  But ye parley THEIR, or rather YOUR Anglic, not mine.  Less chance they wrongly ken us for mates o' the Enemy or summit."),
    replies = {
        {
            text = ccb.content.text("So you want me to introduce you to the Free Merchants?  Sure, why not.  I'll do it."),
            when = predicates.any({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Gavin" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "exodii_told_u_about_free_merchants" } }) }),
            actions = { actions.assign_mission("EXODII_MISSION_MEET_FREE_MERCHANTS") },
            next_topic = "TALK_EXODII_MERCHANT_mission_4_accepted",
        },
        {
            text = ccb.content.text("Maybe some other time.  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_4_accepted",
    line = ccb.content.text("Aye, alright.  Good.  I'll give ye a chitchat - a talk-rad talk-vid.  Take it t'them, make the introductions, and mayhaps lend a mite o' translating, now ye've hopefully started kennin' ol' Rubik's yark."),
    replies = {
        {
            text = ccb.content.text("[Take the device] Will do, Rubik."),
            next_topic = "TALK_EXODII_MERCHANT_mission_4_accepted_0-2",
            when = predicates.handler("dlg_p_dda_44a013be011b"),
            actions = { actions.handler("dlg_a_dda_c5a3adb40afa") },
        },
        {
            text = ccb.content.text("[Take the device] Will do, Rubik."),
            next_topic = "TALK_EXODII_MERCHANT_mission_4_accepted_3-4",
            when = predicates.handler("dlg_p_dda_2279cdadb63f"),
            actions = { actions.handler("dlg_a_dda_c5a3adb40afa") },
        },
        {
            text = ccb.content.text("[Take the device] Will do, Rubik."),
            next_topic = "TALK_EXODII_MERCHANT_mission_4_accepted_5-6",
            when = predicates.handler("dlg_p_dda_aef2ed885b5d"),
            actions = { actions.handler("dlg_a_dda_c5a3adb40afa") },
        },
        {
            text = ccb.content.text("[Take the device] Will do, Rubik."),
            next_topic = "TALK_EXODII_MERCHANT_mission_4_accepted_7-8",
            when = predicates.handler("dlg_p_dda_2e007446fed9"),
            actions = { actions.handler("dlg_a_dda_c5a3adb40afa") },
        },
        {
            text = ccb.content.text("[Take the device] Will do, Rubik."),
            next_topic = "TALK_EXODII_MERCHANT_mission_4_accepted_9-10",
            when = predicates.handler("dlg_p_dda_4863760f1f04"),
            actions = { actions.handler("dlg_a_dda_c5a3adb40afa") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_4_accepted_0-2",
    line = ccb.content.text(
        --~ Remember, we picked you because you speak this Earth's English.  But I know you're no negotiator.  Beyond that, well, our expectations are low.  No offense.  Take it slow.  Five minutes of polite conversation will exceed my expectations.  Try not to cause any sort of real problems, please?
        "Keep keen.  We chose ye' cause ye' speak their Anglic.  But ol' Rubik knows yer' no parley barley.  Beyond that, well… let's call this an experiment in optimism.  Go easy, aye?  Five minutes'o polite conversation an ye'll exceed expectation.  Try not t'cause any real problems, aye?"),
    replies = { { text = ccb.content.text("Right."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_4_accepted_3-4",
    line = ccb.content.text(
        --~ Remember, you're introducting traders, not making threats.  If they start backing away while taking, try smiling.  If that makes it work, stop smiling.  You've clearly got some sense.  Follow it.  Try not to cause any incidents.
        "Remember yer a trader not a threater.  If folk back away, try smilin'.  If they don't like that, stop.  Ye' got a pinch of sense.  Follow it.  Try not t'cause any incidents, aye?"),
    replies = { { text = ccb.content.text("Right."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_4_accepted_5-6",
    line = ccb.content.text(
        --~ You're good enough with people.  Better than most surivivors.  Keep it friendly, don't mention the Enemy, and don't make expensive promises, please.
        "Ye've decent enough people-sense.  Better'an most scavvers.  Keep the yark friendly, don't menton the Enemy, an' try not t'promise anything too expensive, aye?"),
    replies = { { text = ccb.content.text("Right."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_4_accepted_7-8",
    line = ccb.content.text(
        --~ I can tell you're good at this, and I trust you more than I should.  If you get us a good deal, I'll owe you.
        "Got more faith'in'ye than Ol' Rubik mayhaps should.  If these Free Merchants leave thinkin' us'n are respectable traders instead'a vagabonds, ol' Rubik'll owe ye a favor.  And I don't say that lightly, aye?"),
    replies = { { text = ccb.content.text("Right."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_4_accepted_9-10",
    line = ccb.content.text(
        --~ I know you're good at this.  Sometimes I forget you're just a survivor, and not some sort of diplomat.  Try not to do better than I would do, yeah?
        "&\"Tell ye' true, I often forget ye're a scavver and not some sorta' treat-an'-sweety.  Do try not t'negotiate a bettter deal than ol' Rubik woul've got 'imself, aye?\"  Rubik chuckles."),
    replies = { { text = ccb.content.text("Right."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_4_complete",
    line = ccb.content.text("&Rubik chuckles and nods, leaning against the counter.  \"Aye, ye did us'n a fine turn.  What say ye for reward?\"  Rubik reaches into the desk in front of them and pulls out a tiny, green-glowing CRT, scrolling rapidly down a list you cannot understand, they click on an option, and some complex robot schematics come on screen.\n\n\"How'd ye like ta'be cut inta' this sort'o crowded space?\"  Rubik taps their metal torso.  \"This isn't like the bright'n'steelies on offer.  No goin' back.  And ye best be happy with the amount'a power you can generate.  This'ere needs contant power.  Without power, yer good as dead.  The power storage units?  Fer a case this'n kind, one'a the power storage units buys you a little-less'an an hour of walkin'.  Less for scrappin' and scramblin'.  Nothin's easy about it.\"\n\n\"Think on it, decide on a last.\""),
    replies = {
        {
            text = ccb.content.text("[Integrate your body into an Exodii Cyberframe] A robotic body I'll need to keep constantly powered?  Why not?  I'm ready."),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe",
            actions = { actions.adjust_faction_trust(5), actions.handler("dlg_a_dda_4b6b808ad998") },
            opinion = { trust = 7, value = 5 },
        },
        {
            text = ccb.content.text("[$2500 in store credit] How about store credit instead?"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_ab5ed3715805"), "start_trade" },
            opinion = { trust = 4, value = 3 },
        },
        {
            text = ccb.content.text("I don't need anything.  Just keep in mind that I'm always on your side, yeah?"),
            next_topic = "TALK_DONE",
            actions = { actions.adjust_faction_trust(4) },
            opinion = { trust = 7, value = 5 },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_4_complete_partial",
    line = ccb.content.text("Aye, they did indeed.  And aye, ye clearly tried.  That's the way'o'things.  Have a look about, tell me what ye like."),
    replies = {
        {
            text = ccb.content.text("[$1000 in store credit] How about store credit instead?"),
            next_topic = "TALK_DONE",
            actions = { actions.adjust_faction_trust(-4), actions.handler("dlg_a_dda_ff7fed64ffd0"), "start_trade" },
        },
        {
            text = ccb.content.text("I don't need anything.  Just keep in mind that I'm always on your side, yeah?"),
            next_topic = "TALK_DONE",
            actions = { actions.adjust_faction_trust(4) },
            opinion = { trust = 7, value = 5 },
        },
    },
}

-- Indeed, they failed.  That's how it goes, sometimes.  Maybe it's for the best.  Time will tell.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_4_complete_failed",
    line = ccb.content.text("Aye, failed they did.  That's the way'o'things.  Mayhaps for the best.  Time'll tell."),
    replies = { { text = ccb.content.text("Later, Rubik."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_String_Dimension_Exodii_Mission_Offer1",
    line = ccb.content.text(
        --~ All dead.  That's a shame.  Could I interest you in a mercenary contract to get me some more information on this place?
        "All dead, eh?  A sorry shame.  Ahh, but, might I tempt ye with a pop-n-work's bond t'fetch us'n more ken?"),
    replies = {
        {
            text = ccb.content.text("You want to pay me to go back?  Sure, tell me more."),
            next_topic = "TALK_EXODII_MERCHANT_String_Dimension_Exodii_Mission_Offer2",
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
    id = "TALK_EXODII_MERCHANT_String_Dimension_Exodii_Mission_Offer2",
    line = ccb.content.text(
        --~ If you can find your way back to that place, look all over for some sort of terminal or computer.  You may or may not find one with a plug for this contraption.  If you plug it in, and it works, and the Exodii there aren't too diverged from us, it should download lots of important data we can use.  Do this for me, and I'll reward you handsomely.
        "If ye wend back that way, escolt fer some manner o' terminal, computer, the like.  Ye mayhap upon one wi' a jack fer this contraption.\"  Rubik pulls out a small, scrap metal device that looks like an otherworldly USB drive.  \"If ye set it in, an' it takes, an' the node strayed not o'er far from us'n, it should draw down a trove o' vital reckonin' we can make use of.  Do this fer me, an' us'll pay ye right handsome."),
    replies = {
        {
            text = ccb.content.text("So you want me to take that device, plug it into a computer there, download the data, and return it to you?  Sure, I can do that."),
            next_topic = "TALK_EXODII_MERCHANT_String_Dimension_Exodii_Mission_Accepted",
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
    id = "TALK_EXODII_MERCHANT_String_Dimension_Exodii_Mission_Accepted",
    line = ccb.content.text(
        --~ &Rubik hands you the device and nods.  "Good luck."
        "&Rubik hands you the device and nods.  \"Good fortune.\""),
    replies = {
        {
            text = ccb.content.text("[Take the device]"),
            actions = { actions.assign_mission("EXODII_MISSION_STRING_DIMENSION_EXODII") },
            next_topic = "TALK_DONE",
        },
    },
}

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

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_ANUS_FETICK_ALT",
    line = ccb.content.text(
        --~ Maybe you could bring us a bit of good tea.  Not literally 'tea' of course.  That's my Anglic street slang.  I mean the stuff that puts you to sleep for surgery.  The Great Grey says your word for it is 'anesthetic'.  You bring us a thousand units of anesthetic, we'll fix you up with a wire and everything.
        "Mayhap ye bringin' us a nip o' good tea.  Not 'tea', o'course.  I'm yarkin dockside Anglic here.  Us means the stuff what puts y'to sleep f'r a chirurgery.  The Great Grey says y'r assert for it is 'anus fetick'.  You bring us a thousand unit of 'anus fetick', us'll fix'n ye up with a wire an' a tiff."),
    replies = {
        {
            text = ccb.content.text("One thousand units of, uh, anesthetic?  And you'll give me an upgrade?  Sure, I'd better start looking."),
            when = predicates.negate(predicates.any({ predicates.has_mission("RUBIK_ANUS_FETICK"), predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_anusfetick" } }) })),
            actions = { actions.assign_mission("RUBIK_ANUS_FETICK") },
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("What other work do you have?"),
            next_topic = "TALK_EXODII_MERCHANT_Jobs",
        },
    },
}

-- Dialogue for this mission is handled externally.
ccb.content.define_mission {
    id = "MISSION_EXODII_PAY_BACK_RIOT_GEAR",
    name = ccb.content.text("Pay Back The Riot Gear to Rubik"),
    goal = "MGOAL_NULL",
    difficulty = 1,
    value = 0,
    failure = { handler = "lose_exodii_trust_for_riot_gear" },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    deadline = { "20 days", "20 days" },
    dialogue = {
        describe = ccb.content.text("."),
        offer = ccb.content.text("."),
        accepted = ccb.content.text("."),
        rejected = ccb.content.text("."),
        advice = ccb.content.text("."),
        inquire = ccb.content.text("."),
        success = ccb.content.text("."),
        success_lie = ccb.content.text("."),
        failure = ccb.content.text("."),
    },
}

ccb.content.define_mission {
    id = "MISSION_EXODII_LABYRINTHS_INTRO",
    name = ccb.content.text("Exodii Labyrinths"),
    description = ccb.content.text("Rubik told me about a place described as interdimensional \"labyrinths\", where I might find all manner of things, including bionics.  He said I can go scout them out if I'm interested in trying to bring back valuable salvage.  I should go downstairs in the castle, and find a terminal next to a metal ring.  Somehow, using that will send me there."),
    goal = "MGOAL_NULL",
    destination = "exodii_base_x0y0z0",
    difficulty = 5,
    value = 0,
    start = {
        target = { terrain = "exodii_base_x0y0z0", special = "exodii_base", reveal_radius = 2, random = false },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("…"),
        offer = ccb.content.text("…"),
        accepted = ccb.content.text("…"),
        rejected = ccb.content.text("…"),
        advice = ccb.content.text("…"),
        inquire = ccb.content.text("…"),
        success = ccb.content.text("…"),
        success_lie = ccb.content.text("…"),
        failure = ccb.content.text("…"),
    },
}
