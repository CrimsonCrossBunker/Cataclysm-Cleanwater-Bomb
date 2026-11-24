local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_EXODII_MERCHANT_New", "TALK_EXODII_MERCHANT_Talk", "TALK_EXODII_MERCHANT_Base2", "TALK_EXODII_MERCHANT_Dialect_Anglic", "TALK_EXODII_MERCHANT_DoneTrade", "TALK_EXODII_MERCHANT_Exodus2", "TALK_EXODII_MERCHANT_ExodizeNope", "TALK_EXODII_MERCHANT_Survival2" },
    replies = {
        {
            text = ccb.content.text("What've you got for trade?"),
            next_topic = "TALK_EXODII_MERCHANT_DoneTrade",
            when = predicates.handler("w16b_p_dda_f87ec3601d53"),
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Can you do something for me?"),
            next_topic = "TALK_EXODII_MERCHANT_DoSomething",
            when = predicates.handler("w16b_p_dda_037554c6f987"),
        },
        {
            text = ccb.content.text("I'm here to talk about a job."),
            next_topic = "TALK_EXODII_MERCHANT_TalkJob",
            when = predicates.handler("w16b_p_dda_a76cf81eed9a"),
        },
        {
            text = ccb.content.text("I don't understand a word you're saying."),
            next_topic = "TALK_EXODII_MERCHANT_Dialect",
            when = predicates.handler("w16b_p_dda_f87ec3601d53"),
        },
        {
            text = ccb.content.text("Are you some kind of robot?"),
            next_topic = "TALK_EXODII_MERCHANT_Robot",
            when = predicates.handler("w16b_p_dda_f87ec3601d53"),
        },
        {
            text = ccb.content.text("[INT 9] You're called Exodii?  Does that mean you were driven out of your home?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodus",
            when = predicates.handler("w16b_p_dda_c2e678cb6658"),
        },
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_EXODII_MERCHANT_Purpose",
            when = predicates.handler("w16b_p_dda_a76cf81eed9a"),
        },
        {
            text = ccb.content.text("What kind of place is this?"),
            next_topic = "TALK_EXODII_MERCHANT_Base",
            when = predicates.handler("w16b_p_dda_f87ec3601d53"),
        },
        {
            text = ccb.content.text("[PER 6] Some of this tech looks… weird."),
            next_topic = "TALK_EXODII_MERCHANT_Tech",
            when = predicates.handler("w16b_p_dda_dc51ec3d87da"),
        },
        {
            text = ccb.content.text("What's with those weird metal zombies I've been seeing?  They resemble some of the robots around here."),
            next_topic = "TALK_EXODII_MERCHANT_Zomborgs",
            when = predicates.handler("w16b_p_dda_de1e55061561"),
        },
        {
            text = ccb.content.text("I'd feel strange saying this to anyone else, but I think I may have found a place with similar tech to yours in… well… what you might call an \"otherworld\"."),
            next_topic = "TALK_EXODII_MERCHANT_String_Dimension_Exodii",
            when = predicates.handler("w16b_p_dda_5b9226edb420"),
        },
        {
            text = ccb.content.text("Actually, I was wondering were I might get more of these CBMs.  Anything I can do to help make or find them?"),
            next_topic = "TALK_EXODII_MERCHANT_netherum_labyrinth_intro",
            when = predicates.all({ predicates.has_trait("speaker", "CBM_Interface"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "rubik_told_about_labyrinth" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "scenario_trapped_in_labyrinth" } })) }),
        },
        {
            text = ccb.content.text("So you know about AltarOS, or at least where it's from.  Do you have a way to get back there?"),
            next_topic = "TALK_EXODII_MERCHANT_netherum_labyrinth_intro_NL_interface",
            when = predicates.all({ predicates.has_trait("speaker", "NL_CBM_Interface"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "rubik_told_about_labyrinth" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "scenario_trapped_in_labyrinth" } }) }),
        },
        {
            text = ccb.content.text("I think there's something wrong with that labyrinth teleporter computer.  It's giving some error when I try to use it."),
            next_topic = "TALK_EXODII_MERCHANT_netherum_labyrinth_exodii_wrist_computer",
            when = predicates.handler("w16b_p_dda_f3d7c0356e2f"),
        },
        {
            text = ccb.content.text("You wanted to ask me some questions earlier, and I think I was rude about it.  What did you want to ask?"),
            next_topic = "TALK_EXODII_MERCHANT_Talk_Intro1b",
            when = predicates.handler("w16b_p_dda_aef38dda53d8"),
        },
        {
            text = ccb.content.text("Can we continue our conversation about your arrival in this world?"),
            next_topic = "TALK_EXODII_MERCHANT_Talk_Intro2a",
            when = predicates.handler("w16b_p_dda_1710f68df35f"),
        },
        {
            text = ccb.content.text("So, now that I'm a cyborg, could I get a full bionic body like yours?"),
            next_topic = "TALK_EXODII_MERCHANT_Cyberframe_trust_no",
            when = predicates.handler("w16b_p_dda_7d64cdd41d7f"),
        },
        {
            text = ccb.content.text("So, I'm ready for the next step.  How do I get a full bionic body like yours?"),
            next_topic = "TALK_EXODII_MERCHANT_Cyberframe_trust_yes",
            when = predicates.handler("w16b_p_dda_3aac3d7c917f"),
        },
        {
            text = ccb.content.text("I'm ready to become a true cyborg."),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "Rubik_promised_cyberframe" } }),
            actions = { actions.clear_actor_value("speaker", "Rubik_promised_cyberframe"), actions.handler("w16b_a_dda_6232d39e724f") },
        },
        {
            text = ccb.content.text("Any chance I can buy some riot armor?  I need five complete sets."),
            next_topic = "TALK_EXODII_MERCHANT_You_Buy_Riot_Gear",
            when = predicates.handler("w16b_p_dda_de8b9088eb74"),
        },
        {
            text = ccb.content.text("Remember that riot gear you gave me?"),
            next_topic = "TALK_EXODII_MERCHANT_You_Buy_Riot_Gear_Payback",
            when = predicates.has_mission("MISSION_EXODII_PAY_BACK_RIOT_GEAR"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT",
    line = {
        when = predicates.handler("w16b_p_dda_1e86b617dd38"),
        yes = ccb.content.text("&Before you stands a towering mass of metal, at least seven feet high, with a large reflective glass plate in the center of its torso.  It turns as you enter the room, and moves to raise its hand before it suddenly freezes.  A gravelly voice resonates from unseen speakers in the steel frame.  \"The Good Folk, an I'm ken.\"  There is a pause, and then before you can speak its tone changes and it repeats in a sing-song voice, \"Fire we hath, but nor drop o' milk, nor taste o' meat, nor crumb o' bread.  A fine wander to ye.\"  Then it turns around and very obviously begins ignoring you."),
        no = {
            when = predicates.handler("w16b_p_dda_f8ac3175f0cf"),
            yes = ccb.content.text("&The towering mass of metal rests its hands on its exotic rifle, albeit rather naturally and calmly.  After a brief pause, a hefty finger gently toggles a safety switch on the side of the firearm: *click*."),
            no = {
                when = predicates.has_effect("speaker", "u_exodii_interaction_timer_short"),
                yes = {
                    choices = {
                        ccb.content.text("Back in a blink and a whiff, eh?"),
                        ccb.content.gendered_line("Forgot sommat?", { "speaker" }),
                        ccb.content.text("Ah, a returnin', an I'm ken."),
                    },
                },
                no = {
                    when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Rubik" } }),
                    yes = {
                        choices = {
                            ccb.content.text("&\"And a fine return, matey.\"  Rubik puts a hand on the countertop, and gestures you closer with the other."),
                            ccb.content.text("Fine and you still ain't dead.\"  Their gravelly voice is cheerful.  \"What brings ye roun' Rubik's neckawoods?"),
                            ccb.content.text("Bright and sunny, you're back!\"  There's a bit of a friendly chuckle in Rubik's gravelly voice.  \"Rubik's got goods for ye, if you got goods for Rubik."),
                        },
                    },
                    no = ccb.content.text("&Before you stands a towering mass of metal, at least seven feet high, with a large reflective glass plate in the center of its torso.  It turns as you enter the room, and raises its hand in a surprisingly natural motion of greeting.  A gravelly voice resonates from unseen speakers in the steel frame.  Its tone is bizarrely normal, in complete contrast with everything else around you.  \"Oy, you ain't dead.  Lookin' t'trade?\"  The accent sounds vaguely British, but not familiar; like a terrible imitation of Cockney."),
                },
            },
        },
    },
    on_enter = {
        { when = predicates.negate(predicates.has_effect("speaker", "u_exodii_interaction_timer_short")), actions = { actions.add_effect("speaker", "u_exodii_interaction_timer_short", { turns = 108000 }), actions.adjust_faction_trust(1) } },
        { when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Rubik" } })), once = "first_meeting_effects", actions = { actions.handler("w16b_a_dda_fb6c2131bf11") } },
        { when = predicates.handler("w16b_p_dda_e40c0706bcf4"), actions = { actions.handler("w16b_a_dda_5874f511da07"), actions.adjust_faction_trust(1) } },
        { when = predicates.negate(predicates.has_effect("speaker", "u_exodii_interaction_timer_long")), actions = { actions.add_effect("speaker", "u_exodii_interaction_timer_long", { turns = 604800 }), actions.adjust_faction_trust(1) } },
    },
    replies = {
        {
            text = ccb.content.text("What's going on?"),
            next_topic = "TALK_EXODII_MERCHANT_Hates_Hub_Cyborgs",
            when = predicates.handler("w16b_p_dda_8a0ddf33a30b"),
        },
        {
            text = ccb.content.text("Who are you?  What is this place?"),
            next_topic = "TALK_EXODII_MERCHANT_New",
            when = predicates.handler("w16b_p_dda_439c117de034"),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_Rubik", "yes") },
        },
        {
            text = ccb.content.text("This all looks vaguely familiar to me.  Who are you?  What is this place?"),
            next_topic = "TALK_EXODII_MERCHANT_New_NL_Interface",
            when = predicates.handler("w16b_p_dda_b8a61b70c35e"),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_Rubik", "yes") },
        },
        {
            text = ccb.content.text("What've you got for trade?"),
            next_topic = "TALK_EXODII_MERCHANT_DoneTrade",
            when = predicates.handler("w16b_p_dda_49b3fd9b74fd"),
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Actually, I wanted to talk."),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
            when = predicates.handler("w16b_p_dda_49b3fd9b74fd"),
        },
        {
            text = ccb.content.text("Can you do something for me?"),
            next_topic = "TALK_EXODII_MERCHANT_DoSomething",
            when = predicates.handler("w16b_p_dda_49b3fd9b74fd"),
        },
        {
            text = ccb.content.text("I'm here to talk about a job."),
            next_topic = "TALK_EXODII_MERCHANT_TalkJob",
            when = predicates.handler("w16b_p_dda_49b3fd9b74fd"),
        },
        {
            text = ccb.content.text("Hell no, I'm out of here."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_3f1f3df96845"),
        },
        {
            text = ccb.content.text("What?"),
            next_topic = "TALK_EXODII_MERCHANT_Wont_Talk_To_Fair_Folk",
            when = predicates.handler("w16b_p_dda_1e86b617dd38"),
            actions = { actions.set_first_topic("TALK_EXODII_MERCHANT_Wont_Talk_To_Fair_Folk") },
        },
        {
            text = ccb.content.text("Just popping in to say hi.  See you later, alligator."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_49b3fd9b74fd"),
        },
        {
            text = ccb.content.text("How is my buddy doing?"),
            next_topic = "TALK_EXODII_MERCHANT_Experiment_Cyborg_Rescue_Ongoing",
            when = predicates.handler("w16b_p_dda_26458169301f"),
        },
        {
            text = ccb.content.text("How is my buddy doing?"),
            next_topic = "TALK_EXODII_MERCHANT_Experiment_Cyborg_Rescue_Complete",
            when = predicates.handler("w16b_p_dda_49b6a452e65e"),
        },
        {
            text = ccb.content.text("Fast, can you help this lad?"),
            next_topic = "TALK_EXODII_MERCHANT_Experiment_Cyborg_Rescue",
            when = predicates.handler("w16b_p_dda_c54f80cbe79c"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_New",
    line = ccb.content.text(
        --~ We call ourselves the Exodii, eh?  And other things, but that's good.  This is our home, such as it is.  I'm called Rubik, and I've been assigned to trade with you.  Are you looking to trade?  We're always looking for scrap, metal and more.
        "Us call us the Exodii, eh?  An' other things, but that'n's good.  This're our home, such as it.  This'n's monicked as Rubik, and tassed with a trade an'.  You lookin' to trade?  Us'n's alay for the scrap, metal an' more as it be."),
    replies = {
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_New_NL_Interface",
    line = ccb.content.text(
        --~ We call ourselves the Exodii, eh?  And other things, but that's good.  This is our home, such as it is.  I'm called Rubik, and I've been assigned to trade with you.  Are you looking to trade?  We're always looking for scrap, metal and more.
        "Us call us the Exodii, eh?  An' other things, but that'n's good.  This're our home, such as it.  This'n's monicked as Rubik, and tassed with a trade an'.  You lookin' to trade?  Us'n's alay for the scrap, metal an' more as it be."),
    replies = {
        {
            text = ccb.content.text("This is gonna sound strange, and I'm not an \"Exodii\", but I think I may be a bit like you.  [Tell Rubik about your experience with AltarOS]"),
            next_topic = "TALK_EXODII_MERCHANT_New_NL_Interface2",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_New_NL_Interface2",
    line = ccb.content.text(
        --~ Now that's a story.  Sometimes, we find places we call "labyrinths."  Stairs down to other worlds.  We keep track of them.  And, one is nearby, spotted by a novice Exodii, themselves.  That'd be the one you were trapped in, I believe.  So, I guess we're related, by circumstance, at least.  You're welcome here, and I'll remember and tell your story.
        "&The towering cyborg listens intently, bowing its entire torso now and again, in a sort of understanding nod.  Unseen speakers emit a whistle, like a human impressed, tinged with only the faintest amount of static.  \"S'a tale, no doubt.  At times, we happen by places this'n might call \"labyrinths.\"   Apples an' pears down to otherlands, in their own right.  The Exodii keeps the reckonin'.  An there's one \"nearby\", so t'speak, spotted by a green Exodii 'emself.  That's the one, this'n takes it.  So we've got accord.  We're kin by circumstance has it, aye?  Yer welcome here, n' this'n will remember n' yark the tale.\""),
    replies = {
        {
            text = ccb.content.text("Now, with that out of the way…"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_DoneTrade",
    line = {
        choices = {
            ccb.content.text("Good an' fine, then."),
            ccb.content.text("Have it as ye'll see."),
            ccb.content.text("For a card an' a wink, eh?"),
        },
    },
    on_enter = {
        { when = predicates.handler("dlg_p_dda_da66e2d84e95"), actions = { actions.handler("dlg_a_dda_88ab5cdd0752"), actions.adjust_faction_trust(1) } },
    },
    replies = {
        {
            text = ccb.content.text("How come that dude is selling medieval gear in addition to all those guns?"),
            next_topic = "TALK_EXODII_MERCHANT_Stock_Medieval",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_met_weaponmaster" } }),
        },
        {
            text = ccb.content.text("You seem to have a bunch of blueprints.  Can you tell me more about those?"),
            next_topic = "TALK_EXODII_MERCHANT_Stock_Nomad",
        },
        {
            text = ccb.content.text("Have you anything more back there?"),
            next_topic = "TALK_EXODII_MERCHANT_AskedRestock",
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Stock_Medieval",
    line = ccb.content.text(
        --~ It's a bit of a surprise, isn't it?  Before we came here, we were in a place about 600 years earlier in time, or so.  We landed in the middle of a war that turned wrong when the dead started joining back in.  Truth be told, not a very unusual situation.  The Enemy makes us fight.  By and by, we came in, and by then the killing fields were ready for us to harvest their bronze.  It's not Avalonian steel, but it's a good strong metal for stopping a nibbling mouth, so we kept some of their armor and weapons to trade.
        "That be a right welcher, eh?  Afore us'n were to this land, the preface were on a half-score century by the reckonin'.  Landed us in amidst of a war'd turned wrong, for an' as the dead had come back in.  By the butcher's block, not much an unusual case, really.  The Enemy makes us fight.  By an' by, we came in, an' by then the killin' fields were plump and ready to harvest the bronze.  'Tain't no steel-of-the-lake, but 'tis a good dross metal for holdin' off a nibblin' mouth, so we kept a few o' their vestments an' stickers for to trade."),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "u_talk_exodii_about_medieval_stock", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("You seem to have a bunch of blueprints.  Can you tell me more about those?"),
            next_topic = "TALK_EXODII_MERCHANT_Stock_Nomad",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Stock_Nomad",
    line = ccb.content.text(
        --~ Ah, you've got a discerning eye.  They're the result of many years of work.  We've been fighting the Enemy for a long time, and over the years we've worked out some armor for the job.  Keeps you going a bit longer in the field, if you ask me.  I keep some of the parts in stock, but you'll have to put it together yourself.
        "Ah, a real monger's eye, ye be.  Them's the mettle o' many a year of trials.  Us'n've been clashin wi' the Enemy for a long an' then, an' o'er the turns us've worked out some vestments for the job.  Keep's a walker walkin' longer, an I'm ken.  This'n keeps some o' the parst in an' around, but ye'd be tassed to make the vestment with the grease o' your own brow."),
    replies = {
        {
            text = ccb.content.text("What makes your specific armor so great?"),
            next_topic = "TALK_EXODII_MERCHANT_Stock_Nomad2",
        },
        {
            text = ccb.content.text("Why do I have to make it myself?"),
            next_topic = "TALK_EXODII_MERCHANT_Stock_Nomad3",
        },
        {
            text = ccb.content.text("Why are your lockers full of medieval gear?"),
            next_topic = "TALK_EXODII_MERCHANT_Stock_Medieval",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Stock_Nomad2",
    line = ccb.content.text(
        --~ This and that, you know.  It's made for a traveling scavenger, you see.  What I mean is, it's well suited to carry around whatever you pick up in the wastelands, without making it too hard to get around nor giving any easy handholds for scrambling arms.  That, and I'd say it's as tough as nails.
        "This 'n that, an I'm ken.  It be made for a fine wander, beladen with the goods o' the hunt, y'see.  By which I'm to say, 'tis well suited to carry all ye can wrest from the cold arms o' the deadlands, without troublin' your gait nor makin' it easy for the cold clutch o' the scrabblin' arm.  Be an' it is tough as a tarket's nut, I'd razz."),
    replies = {
        {
            text = ccb.content.text("Why do I have to make it myself?"),
            next_topic = "TALK_EXODII_MERCHANT_Stock_Nomad3",
        },
        {
            text = ccb.content.text("Why are your lockers full of medieval gear?"),
            next_topic = "TALK_EXODII_MERCHANT_Stock_Medieval",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Stock_Nomad3",
    line = ccb.content.text(
        --~ It's a simple matter of how we teleport.  Our clothes are often made from cloth and hides from wherever we visit, and our teleporter tears living stuff apart here and there when we travel.  Some can be saved if we take care, but there's no room to store nearly enough extra.  That, and our fabricators are always busy, no time to waste on stuff we don't need for ourselves.
        "'Tis as simple as comes to a wobble.  Our vestment be oft made from the fine clothes and hides of the land, and our jibber tears the stuff o' life apart here and there when us'n travel.  For as some can be saved if care be taken, there be no case to store nigh enough o' this.  That, an' our manuc-makers run as hot as a sunstone, no spit'n taste for that which we don't use usselves."),
    replies = {
        {
            text = ccb.content.text("What makes your specific armor so great?"),
            next_topic = "TALK_EXODII_MERCHANT_Stock_Nomad2",
        },
        {
            text = ccb.content.text("Why are your lockers full of medieval gear?"),
            next_topic = "TALK_EXODII_MERCHANT_Stock_Medieval",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_AskedRestock",
    line = ccb.content.text(
        --~ HEH, you can't get enough of old Rubik's merchandise, eh?  Sure as hell, come back after <restock_time_point>.
        "HEH, ye c'nnae get enough o' ol' Rubik's merchandise, eh?  Sure as 'ell, come back after <restock_time_point>."),
    replies = {
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
    id = "TALK_EXODII_MERCHANT_Talk",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_started_rubik_intro" } }),
        yes = ccb.content.text(
            --~ You can surely try.  I'm not the greatest speaker, and I won't just chat forever for free, you know.
            "Sure as you c'n try.  Us're not the greatest yarker, nor do it all for gratis, kennit."),
        no = ccb.content.text(
            --~ Hey, can I ask you something first?
            "Oy, c'n I bark you summat first?"),
    },
    on_enter = { { actions = { actions.set_actor_value("speaker", "dialogue_started_rubik_intro", "yes") } } },
    replies = {
        {
            text = ccb.content.text("Like, ask me a question?  Sure, I guess."),
            next_topic = "TALK_EXODII_MERCHANT_Talk_Intro1a",
        },
        {
            text = ccb.content.text("Know where I can find any work?"),
            next_topic = "TALK_EXODII_MERCHANT_Jobs",
        },
        {
            text = ccb.content.text("No.  I'm too busy to answer your questions, you're supposed to answer mine.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_DoSomething",
    line = ccb.content.text(
        --~ Of course, what can I do for you?
        "Sure as can,\" the gravelly voice takes on an unmistakeable 'customer service' tone.  \"What'll ye tass this'n for?"),
    replies = {
        {
            text = ccb.content.text("What've you got for trade?"),
            native_actions = { "start_trade" },
            next_topic = "TALK_EXODII_MERCHANT_DoneTrade",
        },
        {
            text = ccb.content.text("I think I'm ready to try becoming a cyborg now."),
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_anusfetick" } }), predicates.negate(predicates.has_trait("speaker", "CBM_Interface")), predicates.negate(predicates.has_trait("speaker", "NL_CBM_Interface")), predicates.negate(predicates.has_flag("speaker", "NO_CBM_INSTALLATION")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "Rubik_exodized_u" } })) }),
            next_topic = "TALK_EXODII_MERCHANT_ExodizeMe2",
        },
        {
            text = ccb.content.text("Any chance you could help me get some of those sweet bionic upgrades?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodize",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "knowledge_exodization_u_knows_exodiilore" } }), predicates.negate(predicates.any({ predicates.has_mission("RUBIK_ANUS_FETICK"), predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_anusfetick" } }), predicates.negate(predicates.has_trait("speaker", "CBM_Interface")), predicates.negate(predicates.has_trait("speaker", "NL_CBM_Interface")), predicates.negate(predicates.has_flag("speaker", "NO_CBM_INSTALLATION")) })) }),
        },
        {
            text = ccb.content.text("Would you be willing to sell some of your robots?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_exodii_rubik_offered_robosell" } }),
            next_topic = "TALK_EXODII_MERCHANT_Robot_Buy",
        },
        {
            text = ccb.content.text("Can you help me with CBM surgery?"),
            next_topic = "TALK_EXODII_MERCHANT_Bionic_Install",
            when = predicates.any({ predicates.has_trait("speaker", "CBM_Interface"), predicates.has_trait("speaker", "NL_CBM_Interface"), predicates.has_trait("speaker", "Hub01_CBM_Interface") }),
        },
        {
            text = ccb.content.text("Can you turn me into a cyborg RIGHT NOW?  I'm a developer for this game, you know."),
            when = predicates.has_trait("speaker", "DEBUG_NODMG"),
            next_topic = "TALK_EXODII_MERCHANT_ExodizeTest",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("Actually, I changed my mind.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_TalkJob",
    line = ccb.content.text("Aye, business afore, 'tis said.  What'll ye tass to ol' Rubik?"),
    replies = {
        {
            text = ccb.content.text("Do the Exodii have any work I could do?"),
            next_topic = "TALK_EXODII_MERCHANT_Jobs",
        },
        {
            text = ccb.content.text("Are there any materials the Exodii need?"),
            next_topic = "TALK_EXODII_MERCHANT_ANUS_FETICK_ALT",
            when = predicates.all({ predicates.any({ predicates.has_trait("speaker", "CBM_Interface"), predicates.has_trait("speaker", "NL_CBM_Interface") }), predicates.negate(predicates.has_mission("RUBIK_ANUS_FETICK")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_anusfetick" } })) }),
        },
        {
            text = ccb.content.text("I've brought the anesthetic for you.  Can you help me out?"),
            next_topic = "TALK_EXODII_MERCHANT_ExodizeMe2",
            when = predicates.all({ predicates.has_inventory("speaker", "anesthetic", 1000), predicates.has_mission("RUBIK_ANUS_FETICK") }),
            actions = { actions.transfer_items("anesthetic", 1000), actions.finish_mission("RUBIK_ANUS_FETICK", { success = true }) },
        },
        {
            text = ccb.content.text("I paid a visit to the bunker."),
            next_topic = "TALK_EXODII_MERCHANT_mission_1_complete",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_u_scouted_bunker" } }) }),
            actions = { actions.clear_actor_value("speaker", "mission_completed_u_scouted_bunker"), actions.handler("dlg_a_dda_e3d719172842") },
        },
        {
            text = ccb.content.text("I found the warehouse."),
            next_topic = "TALK_EXODII_MERCHANT_mission_2_complete",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_u_found_warehouse" } }) }),
            actions = { actions.clear_actor_value("speaker", "mission_completed_u_found_warehouse"), actions.handler("dlg_a_dda_ca47b5501c73") },
        },
        {
            text = ccb.content.text("I found the missing Exodii.  I'm sorry to say that they're dead, but I recovered their head."),
            next_topic = "TALK_EXODII_MERCHANT_mission_3_complete",
            when = predicates.all({ predicates.has_inventory("speaker", "exodii_chop_shop_head", 1), predicates.has_mission("EXODII_MISSION_CHOP_SHOP") }),
            actions = { actions.handler("dlg_a_dda_d1be8bff804a"), actions.finish_mission("EXODII_MISSION_CHOP_SHOP", { success = true }) },
        },
        {
            text = ccb.content.text("So, we seem to be done with the negotiations.  Let's talk payment."),
            next_topic = "TALK_EXODII_MERCHANT_mission_4_complete",
            when = predicates.handler("dlg_p_dda_103fd2568028"),
            actions = { actions.finish_mission("EXODII_MISSION_MEET_FREE_MERCHANTS", { success = true }) },
        },
        {
            text = ccb.content.text("Well, the deal went through.  I did my best, Rubik."),
            next_topic = "TALK_EXODII_MERCHANT_mission_4_complete_partial",
            when = predicates.handler("dlg_p_dda_5246ac7028f5"),
            actions = { actions.finish_mission("EXODII_MISSION_MEET_FREE_MERCHANTS", { success = true }) },
        },
        {
            text = ccb.content.text("Those negotiations didn't go so well, did they?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_4_complete_failed",
            when = predicates.handler("dlg_p_dda_9ea6d88123e8"),
            actions = { actions.finish_mission("EXODII_MISSION_MEET_FREE_MERCHANTS", { success = true }), actions.adjust_faction_trust(-10) },
        },
        {
            text = ccb.content.text("I managed to find a computer in that other-Exodii place we talked about.  Here's the data."),
            next_topic = "TALK_EXODII_MERCHANT_String_Dimension_Exodii_Mission_Complete",
            when = predicates.all({ predicates.has_inventory("speaker", "exodii_usb_stick_full", 1), predicates.has_mission("EXODII_MISSION_STRING_DIMENSION_EXODII") }),
            actions = { actions.handler("dlg_a_dda_cac82ea89c70"), actions.finish_mission("EXODII_MISSION_STRING_DIMENSION_EXODII", { success = true }) },
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("Actually, I changed my mind.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Experiment_Cyborg_Rescue_Ongoing",
    line = ccb.content.text("Nah, mate, still operatin'."),
    replies = {
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        { text = ccb.content.text("Ok.  <end_talking_bye>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Experiment_Cyborg_Rescue_Complete",
    line = ccb.content.text("Gimme spek, 'n  fetch 'em 'ere."),
    replies = {
        {
            text = ccb.content.text("Of course, it is time for us to talk."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yank_out_all_bionics_from_prototype", { scope = "speaker", key = "dialogue_exodii_cybor_rescue_ongoing_current_type" } }),
            actions = { actions.set_actor_value("speaker", "dialogue_exodii_cybor_rescue_ongoing", "no"), actions.set_actor_value("speaker", "dialogue_exodii_cybor_rescue_ongoing_current_type", "none"), actions.handler("dlg_a_dda_fa45b3adc710") },
        },
        {
            text = ccb.content.text("Of course, it is time for us to talk."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "repair_and_rescue_prototype", { scope = "speaker", key = "dialogue_exodii_cybor_rescue_ongoing_current_type" } }),
            actions = { actions.set_actor_value("speaker", "dialogue_exodii_cybor_rescue_ongoing", "no"), actions.set_actor_value("speaker", "dialogue_exodii_cybor_rescue_ongoing_current_type", "none"), actions.handler("dlg_a_dda_441dbf0d2d0d") },
        },
        {
            text = ccb.content.text("Of course, it is time for us to talk."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "reverse_cybernization_prototype", { scope = "speaker", key = "dialogue_exodii_cybor_rescue_ongoing_current_type" } }),
            actions = { actions.set_actor_value("speaker", "dialogue_exodii_cybor_rescue_ongoing", "no"), actions.set_actor_value("speaker", "dialogue_exodii_cybor_rescue_ongoing_current_type", "none"), actions.handler("dlg_a_dda_ba9865e060b2") },
        },
        {
            text = ccb.content.text("Let's see what I get."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "pull_out_from_rotten_cyborg", { scope = "speaker", key = "dialogue_exodii_cybor_rescue_ongoing_current_type" } }),
            actions = { actions.set_actor_value("speaker", "dialogue_exodii_cybor_rescue_ongoing", "no"), actions.set_actor_value("speaker", "dialogue_exodii_cybor_rescue_ongoing_current_type", "none"), actions.handler("dlg_a_dda_32d0bdeebb48") },
        },
        {
            text = ccb.content.text("It is time to put this body to rest."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "dress_up_rotten_cyborg", { scope = "speaker", key = "dialogue_exodii_cybor_rescue_ongoing_current_type" } }),
            actions = { actions.set_actor_value("speaker", "dialogue_exodii_cybor_rescue_ongoing", "no"), actions.set_actor_value("speaker", "dialogue_exodii_cybor_rescue_ongoing_current_type", "none"), actions.handler("dlg_a_dda_c0c90eb7d35f") },
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Experiment_Cyborg_Rescue",
    line = ccb.content.text(
        --~ Let me see.  Will do what I can for a coin.
        "Lemme poke.  Will tass what ye can for a shiny."),
    replies = {
        {
            text = ccb.content.text("[Prototype Cyborg] Can you help this guy it seems like they have lost their mind?"),
            when = predicates.has_inventory("speaker", "bot_prototype_cyborg", 1),
            next_topic = "TALK_EXODII_MERCHANT_Experiment_Prototype_Cyborg_Rescue",
        },
        {
            text = ccb.content.text("[Broken Cyborg] Can you save my buddy who looks a bit rough around the edges, but they still haven't flatlined?"),
            when = predicates.has_inventory("speaker", "bot_broken_cyborg", 1),
            next_topic = "TALK_EXODII_MERCHANT_Experiment_Broken_Cyborg_Rescue",
        },
        {
            text = ccb.content.text("Actually, forget it's not my problem."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Experiment_Prototype_Cyborg_Rescue",
    line = ccb.content.text("Fer this 'un, I can yank out their bits 'n give 'em to ya, or I can jus' take out the busted pieces so they can still use th' rest o' stuff in 'em. Elsewise, why don't ya jest give 'im to me?  I reckon I can turn 'im into a right useful worker."),
    replies = {
        {
            text = ccb.content.text("[$300] Take everything from him and if there is something useful, put it aside for me."),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
            when = predicates.handler("dlg_p_dda_a88b1d9a27dc"),
            actions = { actions.handler("dlg_a_dda_2172f5c1c7c0"), actions.set_actor_value("speaker", "dialogue_exodii_cybor_rescue_ongoing", "yes"), actions.handler("dlg_a_dda_822f4d122b5f"), actions.set_actor_value("speaker", "dialogue_exodii_cybor_rescue_ongoing_current_type", "yank_out_all_bionics_from_prototype") },
        },
        {
            text = ccb.content.text("[200$] Just remove broken bits so they can control themselves."),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
            when = predicates.handler("dlg_p_dda_e1b6dba94f89"),
            actions = { actions.handler("dlg_a_dda_04c92d015381"), actions.set_actor_value("speaker", "dialogue_exodii_cybor_rescue_ongoing", "yes"), actions.handler("dlg_a_dda_822f4d122b5f"), actions.set_actor_value("speaker", "dialogue_exodii_cybor_rescue_ongoing_current_type", "repair_and_rescue_prototype") },
        },
        {
            text = ccb.content.text("[95$] Pull everything out, you can keep what works.  Just bring my buddy back."),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
            when = predicates.handler("dlg_p_dda_bf2e523c29cd"),
            actions = { actions.handler("dlg_a_dda_f11832a75b0b"), actions.set_actor_value("speaker", "dialogue_exodii_cybor_rescue_ongoing", "yes"), actions.handler("dlg_a_dda_822f4d122b5f"), actions.set_actor_value("speaker", "dialogue_exodii_cybor_rescue_ongoing_current_type", "reverse_cybernization_prototype") },
        },
        {
            text = ccb.content.text("They are all yours.  [Adds 200$]"),
            next_topic = "TALK_DONE",
            when = predicates.has_inventory("speaker", "bot_prototype_cyborg", 1),
            actions = { actions.handler("dlg_a_dda_fbd68f46e57c") },
        },
        {
            text = ccb.content.text("Actually, forget it's not my problem."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Experiment_Broken_Cyborg_Rescue",
    line = ccb.content.text("This 'unwon't be twitching', too much grey lost to dead.  But ye can salvage bits from 'em or born 'em for a walker, or just cut out the rot 'n grey link so ya can miss 'em proper."),
    replies = {
        {
            text = ccb.content.text("[200$] Pull out CBM if he can't use it, I can."),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
            when = predicates.handler("dlg_p_dda_e1b6dba94f89"),
            actions = { actions.handler("dlg_a_dda_53c8e22fd393"), actions.set_actor_value("speaker", "dialogue_exodii_cybor_rescue_ongoing", "yes"), actions.handler("dlg_a_dda_822f4d122b5f"), actions.set_actor_value("speaker", "dialogue_exodii_cybor_rescue_ongoing_current_type", "pull_out_from_rotten_cyborg") },
        },
        {
            text = ccb.content.text("[25$] Pull everything out, you can keep what works.  He deserves a burial."),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
            when = predicates.handler("dlg_p_dda_3e621d135700"),
            actions = { actions.handler("dlg_a_dda_d71efea66826"), actions.set_actor_value("speaker", "dialogue_exodii_cybor_rescue_ongoing", "yes"), actions.handler("dlg_a_dda_822f4d122b5f"), actions.set_actor_value("speaker", "dialogue_exodii_cybor_rescue_ongoing_current_type", "dress_up_rotten_cyborg") },
        },
        {
            text = ccb.content.text("They are all yours.  [Adds 150$]"),
            next_topic = "TALK_DONE",
            when = predicates.has_inventory("speaker", "bot_prototype_cyborg", 1),
            actions = { actions.handler("dlg_a_dda_99d373d5ee50") },
        },
        {
            text = ccb.content.text("Actually, forget it's not my problem."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Talk_Intro1a",
    line = ccb.content.text("'Ow long's it been since the mess happened?"),
    replies = { { text = ccb.content.text("[Tell them.]"), next_topic = "TALK_EXODII_MERCHANT_Talk_Intro2" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Talk_Intro1b",
    line = ccb.content.text("Thank ye.  When you an' Rubik first met, how long'd it been since the mess begun?"),
    replies = { { text = ccb.content.text("[Tell them.]"), next_topic = "TALK_EXODII_MERCHANT_Talk_Intro2" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Talk_Intro2",
    line = ccb.content.text(
        --~ Lovely!  Benzete (this is a name) is going to be beside themselves, that's for sure.  I mean, they'll be really happy.  This is their first jump, and it's a lucky one.
        "Lovely!  Benzete's gonna be a pair, that's a track!  I mean, they'll be right happy.  This is their first jump, and it's a flappin' duck."),
    on_enter = { { actions = { actions.set_actor_value("speaker", "dialogue_midpoint_rubik_intro", "yes") } } },
    replies = {
        {
            text = ccb.content.text("What makes it such a good jump?"),
            next_topic = "TALK_EXODII_MERCHANT_Talk_Intro3",
        },
        {
            text = ccb.content.text("Who is Benzete?"),
            next_topic = "TALK_EXODII_MERCHANT_Talk_IntroBenzete1",
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
    id = "TALK_EXODII_MERCHANT_Talk_Intro2a",
    line = ccb.content.text(
        --~ As I recall, we were talking about Benzete and how this is a great jump for their first time.
        "So 'twere an I recalt, us're yarkin' of Benzete an' their great first jump."),
    replies = {
        {
            text = ccb.content.text("What makes it such a good jump?"),
            next_topic = "TALK_EXODII_MERCHANT_Talk_Intro3",
        },
        {
            text = ccb.content.text("Who is Benzete?"),
            next_topic = "TALK_EXODII_MERCHANT_Talk_IntroBenzete1",
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
    id = "TALK_EXODII_MERCHANT_Talk_Intro3",
    line = ccb.content.text(
        --~ We've got to leave the old world before it gets too worn out, you see, and find a nice fresh one on the other side.  Your deadland is as fresh as it gets.
        "Us gotta leave the old world afore it's worn right to the gums, an y'ken, and find a nice twitchy one on t'other side.  Your deadland be a brand shiny"),
    replies = {
        {
            text = ccb.content.text("I'm not following that at all."),
            next_topic = "TALK_EXODII_MERCHANT_Talk_Intro3a",
        },
        {
            text = ccb.content.text("[INT 9] So you mean, we have a nice, freshly dead world for you to visit?"),
            when = predicates.minimum_attribute("speaker", "intelligence", 9),
            next_topic = "TALK_EXODII_MERCHANT_Talk_Intro4b",
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
    id = "TALK_EXODII_MERCHANT_Talk_Intro3a",
    line = ccb.content.text(
        --~ No worries.  I mean, the Enemy is new here, and we have a bit of safe time ahead of us before we have to jump away again.
        "Neverken.  Right and so, the Enemy is new here, and us'n have a few good hours in the sun beforenext the jump."),
    replies = {
        {
            text = ccb.content.text("Oh, you mean you got here early in the Cataclysm.  Why is that so good?"),
            next_topic = "TALK_EXODII_MERCHANT_Talk_Intro4a",
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
    id = "TALK_EXODII_MERCHANT_Talk_Intro4a",
    line = ccb.content.text(
        --~ That's a part of it, sure, but this is nice for other reasons, and much better than our last jump.  Otherlands with fusillies and mobbings are really useful to us.
        "That be a part an' switch, but this be'n nice for all, overtop the last jump by heads.  Otherlands with fusillies and mobbings, us'n gets a fine change on that."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "knowledge_exodii_transdimensional_u_knows_exodiilore", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("I don't know what fusillies and mobbings are."),
            next_topic = "TALK_EXODII_MERCHANT_Talk_Intro5",
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
    id = "TALK_EXODII_MERCHANT_Talk_Intro4b",
    line = ccb.content.text(
        --~ That's exactly it!  This is nice for many reasons, and much better than our last jump.  Otherlands with fusillies and mobbings are really useful to us.
        "You kennit rightly!  That and this be'n nice for all, overtop the last jump by heads.  Otherlands with fusillies and mobbings, us'n gets a fine change on that."),
    replies = {
        {
            text = ccb.content.text("I don't know what fusillies and mobbings are."),
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dictionary_known_fussily" } })),
            next_topic = "TALK_EXODII_MERCHANT_Talk_Intro5",
        },
        {
            text = ccb.content.text("Wait, am I following this right?  You're from a place where this happened before, and you escaped to our world?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodus3",
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
    id = "TALK_EXODII_MERCHANT_Talk_Intro5",
    line = ccb.content.text("Oh, rights.  Many lands be'd assert on thosun's.  A fusilly, she's a weapon, shoots a shot at high speeds usin' bang.  A mobbing, he's a grand box o' metal, pushed by burnin' and boomin' from wit'in, kennit?"),
    replies = {
        {
            text = ccb.content.text("[INT 7] Sounds like you mean a fusilly is a gun, and a mobbing is a car?"),
            next_topic = "TALK_EXODII_MERCHANT_Talk_Intro6",
            when = predicates.minimum_attribute("speaker", "intelligence", 7),
            actions = { actions.set_actor_value("speaker", "dictionary_known_fussily", "yes"), actions.handler("dlg_a_dda_f3ca9f11fc01") },
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
    id = "TALK_EXODII_MERCHANT_Talk_Intro6",
    line = ccb.content.text(
        --~ Great, I'll put that in the dictionary.  Here's a token of my gratitude for your explanation.
        "Right so, us'n'll write it in the dicky.  Here, a shiny brass farthing for crossin' the nation."),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "dialogue_completed_rubik_intro", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("Now that we've sorted that out, I have to ask.  You're from a place where this happened before, and you escaped to our world?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodus3",
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
    id = "TALK_EXODII_MERCHANT_Talk_IntroBenzete1",
    line = ccb.content.text(
        --~ They're an otherlander from around three jumps ago, a real optimistic greenhorn.  They're really interested in how we do tracking, you see?
        "Them's an otherlander from thrice jumps an' change, wide as the sky.  They's got happily on sommat for the tracking, you ken?"),
    replies = {
        {
            text = ccb.content.text("I… didn't really follow that."),
            next_topic = "TALK_EXODII_MERCHANT_Talk_IntroBenzete2",
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
    id = "TALK_EXODII_MERCHANT_Talk_IntroBenzete2",
    line = ccb.content.text(
        --~ Like an apprentice to the old tracker.
        "Hmm.  They… planned out the last jump?  Like as an apprentice to the ol' sexten."),
    replies = {
        {
            text = ccb.content.text("Oh, like a navigator?"),
            next_topic = "TALK_EXODII_MERCHANT_Talk_IntroBenzete3",
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
    id = "TALK_EXODII_MERCHANT_Talk_IntroBenzete3",
    line = ccb.content.text(
        --~ Sure, that word is fine, I think.
        "Sure an' that's a fine enough word, an I'm ken."),
    replies = {
        {
            text = ccb.content.text("You said this was an especially good jump?"),
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_completed_rubik_intro" } })),
            next_topic = "TALK_EXODII_MERCHANT_Talk_Intro3",
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
    id = "TALK_EXODII_MERCHANT_Aliens",
    line = ccb.content.text(
        --~ Yeah, you could say that.  We're from otherlands, most of the time.  Not otherworlds though.  Too risky bringing those monsters into our safe haven.
        "Yeah, you could call us as it.  Us're from otherlands mostlike.  Not otherworlds though.  Too risky bringin' them squelchies into the fold."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "knowledge_exodii_transdimensional_u_knows_exodiilore", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("I don't know the difference between otherlands and otherworlds."),
            next_topic = "TALK_EXODII_MERCHANT_Aliens2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Aliens2",
    line = ccb.content.text(
        --~ Yeah, that's a big question.  Otherworlds are how you got those ugly bug-creatures around here, you know?  Walking plants, talking mushroom, stuff like that.  Otherlands are closer related.  I'm from Earth, just a different Earth.  You shouldn't be asking what the Exodii are doing in Earth, because some of us are feeling pretty at home here, I think.  You should be asking what we're doing hanging out in your part of town.
        "Sure an that's a biggun'.  Otherworlds be the wherefore o' them uggo buggers you got round and here, eh?  Walkin' plants and talkin' mushrooms and whatlike.  Otherlands be tassed more of a kinship.  I be from Earth, but my Earth be differed.  So you's shouldno be asked what the Exodii is doin' on Earth, because some is feelin' of us fine an' fine at home, an I'm ken.  You's should be askin' what the Exodii is doin' razzin up your green and brown."),
    replies = {
        {
            text = ccb.content.text("OK then, what are you meaning with 'razzing up our green and brown'?"),
            next_topic = "TALK_EXODII_MERCHANT_Purpose2",
        },
        {
            text = ccb.content.text("Tell me about your own world."),
            next_topic = "TALK_EXODII_MERCHANT_Home",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Home",
    line = ccb.content.text(
        --~ Ah.  Home.  That's a long time gone, you know?  Yours isn't too different.  I… don't think I want to talk about it.  I've changed too much between then and now.
        "*becomes distant for a moment.  \"Ah.  Home.  It were a long time gone, kennit.  Your'n be not too far.  This'n… I don't think I want to talk 'bout it.  Too much metal atwixt now an' then.\""),
    replies = {
        {
            text = ccb.content.text("That's rough, maybe we should talk about something else."),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("What are you meaning with 'razzing up our green and brown'?"),
            next_topic = "TALK_EXODII_MERCHANT_Purpose2",
        },
        {
            text = ccb.content.text("How did you come to be made of metal like this?"),
            next_topic = "TALK_EXODII_MERCHANT_Metal",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Metal",
    line = ccb.content.text(
        --~ I realized that it was a no-brainer question.  There was only one other option, you see, if I didn't join the Exodii.
        "Us'n saw this were a pidgeon's road, I'd razz.  Only one way, I'm ken, if I'm not to join the rank an' file."),
    replies = {
        {
            text = ccb.content.text("I think I know what you mean.  The only way to survive is to… \"upgrade\".  Can you help me with that?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodize",
            when = predicates.negate(predicates.any({ predicates.has_mission("RUBIK_ANUS_FETICK"), predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_anusfetick" } }), predicates.has_trait("speaker", "CBM_Interface"), predicates.has_trait("speaker", "NL_CBM_Interface") })),
            actions = {
                actions.set_actor_value("speaker", "knowledge_exodization_u_knows_exodiilore", "yes"),
            },
        },
        {
            text = ccb.content.text("What are you meaning with 'razzing up our green and brown'?"),
            next_topic = "TALK_EXODII_MERCHANT_Purpose2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Robot",
    line = ccb.content.text("Robot?  What assert is f'r it?  Ahold…\"  Rubik stops for a moment, as if thinking.  \"Ah, an automate?  No, this'n be flesh 'n blood as ye be, encased in a shell o' metal an' wire.  Not so much flesh as there were.  The wire is amixed an' afloat with the flesh, all as one, kennit."),
    on_enter = {
        { actions = { actions.set_actor_value("speaker", "knowledge_rubik_is_cyborg_u_knows_exodiilore", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("<fcl_exodii_cyborg_question>"),
            false_text = ccb.content.text("[INT 9] So you're a cyborg of some kind?  That's awesome.  How do I become a cyborg?"),
            text_when = predicates.handler("dlg_p_dda_d292f701cba7"),
            next_topic = "TALK_EXODII_MERCHANT_Exodize",
            when = predicates.all({ predicates.minimum_attribute("speaker", "intelligence", 9), predicates.negate(predicates.any({ predicates.has_mission("RUBIK_ANUS_FETICK"), predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_anusfetick" } }), predicates.has_trait("speaker", "CBM_Interface"), predicates.has_trait("speaker", "NL_CBM_Interface") })) }),
            actions = { actions.set_actor_value("speaker", "knowledge_exodization_u_knows_exodiilore", "yes") },
        },
        {
            text = ccb.content.text("I don't have any idea what you mean.  You're kind of a robot, but you're also flesh and blood?"),
            next_topic = "TALK_EXODII_MERCHANT_Robot2",
        },
        {
            text = ccb.content.text("What are you meaning 'razzing up our green and brown'?"),
            next_topic = "TALK_EXODII_MERCHANT_Purpose2",
        },
        {
            text = ccb.content.text("I don't understand a word you're saying."),
            next_topic = "TALK_EXODII_MERCHANT_Dialect",
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Robot2",
    line = ccb.content.text(
        --~ Yeah, that's the basic explanation.  A bit of both now, but I used to be just like you.
        "Yeah, that be the soggy leaves, an I'm ken.  A bit o' both, but Rubik were once as a kin, to you be."),
    replies = {
        {
            text = ccb.content.text("What are you meaning 'razzing up our green and brown'?"),
            next_topic = "TALK_EXODII_MERCHANT_Purpose2",
        },
        {
            text = ccb.content.text("This is confusing.  <done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("I don't understand a word you're saying."),
            next_topic = "TALK_EXODII_MERCHANT_Dialect",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Base",
    line = ccb.content.text(
        --~ A junker base, obviously.  A jury-rigged mess.  We'll pack it up and leave eventually.
        "A junker base, innit?  Pile o' gamp.  Us'll pack it up and sing along soon enough."),
    replies = {
        {
            text = ccb.content.text("Pack it up?  How can you pack up something like this?"),
            next_topic = "TALK_EXODII_MERCHANT_Base2",
        },
        {
            text = ccb.content.text("Soon?  How long will you still be here?"),
            next_topic = "TALK_EXODII_MERCHANT_BaseTimeLeft",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_BaseTimeLeft",
    line = ccb.content.text(
        --~ The otherlands we were in before had only little time left, so we can't say for sure.  But this land is as fresh as it can be.
        "Yon aforetime otherland, 'twere a right soggy biscuit.  This'n be crisp an' fresh yet.  Us'n'll try as might stay a fair tick."),
    replies = {
        {
            text = ccb.content.text("Good to know you will be here for a while."),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Base2",
    line = ccb.content.text(
        --~ To understand how, you've gotta think eleven-dimensionally.  We'll open up a gate and teleport out, the same as we came.
        "For an' how, ye be needin' to think wi' them elevens o' directions, kennit?  Us'll open a gate an' wibble-an-wobble.  Same as us came."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "knowledge_exodii_transdimensional_u_knows_exodiilore", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Zomborgs",
    line = ccb.content.text(
        --~ Ah, good question.  Enough cybernetic implants can keep someone from coming back as a zombie, but it's not a sure thing.  Some come back anyway, and some just don't have enough cybernetics.  Most of them aren't full Exodii like old Rubik, they're more our friends - like you.  Sooner or later we'll get out there, put them down, and bring their parts back for cleaning.
        "'Tis a good an' yark, sooth.  Them as can have the metal deep in, can be saved for the risen, but it b'ain't a sure course.  Some as comes back anyway, an' some be too much flesh.  The grander lot are no Exodii like ol' Rubik, most be friends more kin to thyself.  Us'll hearken out and trundle home the pieces for a scrub-and-bucket."),
    replies = {
        {
            text = ccb.content.text("So you use these cybernetics to prevent zombification, but they don't work perfectly?  Why not?"),
            next_topic = "TALK_EXODII_MERCHANT_Robot_Make",
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

-- Lore note: Rubik is an unreliable narrator here, by giving part-truths.  Nothing here is a lie but they're omitting some important details.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Robot_Make",
    line = ccb.content.text(
        --~ I don't think I'm the best to explain that, but I'll do my best.  Our technology might seem pretty high-tech and well made to you, but on the inside I'm still mostly human meat bound up in wires and steel.  Nobody's left that remembers exactly how it all goes, and much of it is cobbled together from a few different dimensions.  It's a miracle they work as well as they do, but somehow it's actually pretty functional.  Still, it can be hard to know exactly what could go wrong.  The ones who come back as zombies, they're generally less well made than me.  Some even did their own cybernetic conversions, and didn't exactly follow best practices.
        "Rubik's not the finest dandy to yark it, an I'm ken, but this'n'll do best as can.  Ol' Rubik an' the stompy-clanker gang be shiny an' fine as can be, for y'see so well, but on the wind-up, the guts be nigh so fleshy as they were afore, twixt as they be with wire and steel.  Ain't none so left as remembers precise how it all goes, and much is boggled from bits and drabs o' a dozen elsewheres.  'Tis a marked fine they work at all, though work they do, and nicely.  Still, 'tis hard to know what'll crumple out from the can.  Those as return, they be… less well made as ol' Rubik.  Some as did work themselves, even, and mayhap against the good old ways."),
    replies = {
        {
            text = ccb.content.text("You seem to have a lot of standardized robotic helpers, like those quads.  Is that a different thing?"),
            next_topic = "TALK_EXODII_MERCHANT_Robot_Quads",
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

-- Ah, they're an inbetween, but more machine than meat.  We use the softer bits of other critters for those, but the walker itself is printed.  It's complicated.
-- Rubik is not giving you the whole story here and will avoid giving you the whole story unless you force them.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Robot_Quads",
    line = ccb.content.text("*'s tone changes slightly, sounding a bit pained.  \"Ah, them be an in-between, more machiner.  Us'n use the softer bits o' other critters for them, an' there be a manufactory for the walker.  A hard but needed choice.\""),
    replies = {
        {
            text = ccb.content.text("How long does it take you to make one of these walkers?"),
            next_topic = "TALK_EXODII_MERCHANT_Robot_Make_Time",
        },
        {
            text = ccb.content.text("Can I buy one of your machines?"),
            next_topic = "TALK_EXODII_MERCHANT_Robot_Buy",
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
    id = "TALK_EXODII_MERCHANT_Robot_Make_Time",
    line = ccb.content.text(
        --~ Faster than you might guess, but it can still take a while, the hardest part is sourcing the materials for one.  We've got printers that make the body, and others that make the tools and equipment the walker will use.  Some of the special parts have to be manufactured by hand, so we have a small team that does that.  Right now, it's very slow, we're still setting up our operations.
        "Blinker than a bat, but downer than a cat.  Razzin' up the bits be a trick and some.  The draw-make automates can manufactorize the outer shell, and there be automates for the most o' the tools.  Some bits be more a breakfast o' rats, an' for them, us'n has some artisanals.  Us'n b'ain't on the solid now, so 'tis a longer down."),
    replies = {
        {
            text = ccb.content.text("Can I buy one of your machines?"),
            next_topic = "TALK_EXODII_MERCHANT_Robot_Buy",
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

-- In the future, Rubik should be able to sell the player a robot.  This is a placeholder until that time arrives.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Robot_Buy",
    line = ccb.content.text(
        --~ I don't know about that.  Each one we make is very important to our operations here, and they're extremely expensive.  I might be able to sell you one later, but not right now.
        "*sounds thoughtful.  \"This'n can't make a call o' the quarter.  The stompers be a king's necklace, and the manufactory don't run on dreams.  Mayhap when us'n be more on the solid, but for the tick and tumble, no.\""),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "dialogue_exodii_rubik_offered_robosell", "yes") },
        },
    },
    replies = {
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
    id = "TALK_EXODII_MERCHANT_String_Dimension_Exodii",
    line = ccb.content.text(
        --~ Ah, you found another node - another community of Exodii.  Tell me what you saw?
        "Ahh, mayhaps ye've found another node - kin o' us'n Exodii.  Tell ol' Rubik:  what'd ye escolt there?  Exodii alive?  Trade?  Stompers?  Manufactory?"),
    replies = {
        {
            text = ccb.content.text("It was a large domed structure, with some towers around it.  The entire thing looked like it was made of metal - a lot like your castle.  Looked like it was a ruin, or abandoned.  If there was anyone alive, I didn't find them."),
            next_topic = "TALK_EXODII_MERCHANT_String_Dimension_Exodii_Mission_Offer1",
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
    id = "TALK_EXODII_MERCHANT_Jobs",
    line = ccb.content.text("*pulls out a sheaf of mismatched papers, and leafs through the pages for a second.  Their broad metallic fingers look surprisingly deft and delicate, and incongruous on the otherwise unremarkable looseleaf.  \"Aye, an' there's room for a pop-an-work roun' here.  Rubik's got tassed a lissy, right and clean."),
    replies = {
        {
            text = ccb.content.text("[Pop-an-Work: Escoltin' sommat of curiosity]"),
            next_topic = "TALK_EXODII_MERCHANT_mission_1_intro",
            when = predicates.handler("dlg_p_dda_814187ad8ba4"),
        },
        {
            text = ccb.content.text("[Pop-an-Work: A pop-an-squeak]"),
            next_topic = "TALK_EXODII_MERCHANT_mission_2_intro",
            when = predicates.handler("dlg_p_dda_589f4090ddc0"),
        },
        {
            text = ccb.content.text("[Pop-an-Work: Escolt, held fast]"),
            next_topic = "TALK_EXODII_MERCHANT_mission_3_intro",
            when = predicates.handler("dlg_p_dda_ba181616e62b"),
        },
        {
            text = ccb.content.text("[Pop-an-Work: Free Merchants]"),
            next_topic = "TALK_EXODII_MERCHANT_mission_4_intro",
            when = predicates.handler("dlg_p_dda_2e2b48a542d0"),
        },
        {
            text = ccb.content.text("I'm not interested in anything right now.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Dialect",
    line = ccb.content.text(
        --~ Sure you can, at least a bit.  I'll do my best to speak your Anglic, but seeing as we're from otherlands and all, it's not that simple.
        "Sure as ye can, at least sommat.  Us'n'll try as we might to parley your Anglic, but so ye kennit as us be from otherlands and all, it ain't that simple."),
    replies = {
        {
            text = ccb.content.text("[INT or PER 7] How come you speak English, or uh, 'Anglic' like that?"),
            when = predicates.any({ predicates.minimum_attribute("speaker", "intelligence", 7), predicates.minimum_attribute("speaker", "perception", 7) }),
            next_topic = "TALK_EXODII_MERCHANT_Dialect_Anglic",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Exodus",
    line = ccb.content.text("Oh yeah, right and so.  Each and every.  We wander, we make do.  It's a livin'."),
    replies = {
        {
            text = ccb.content.text("What drove you out?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodus2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Exodus2",
    line = ccb.content.text(
        --~ Same as you, I'd guess.  The Enemy.  The dead.
        "Same as you will be, an I'm ken.  The Enemy.  The dead."),
    replies = {
        {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "knowledge_exodii_transdimensional_u_knows_exodiilore" } }),
            text = ccb.content.text("Wait, am I following this right?  You're from a place where this happened before, and you escaped to our world?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodus3",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Exodus3",
    line = ccb.content.text("Just so, aye.  Again an' again, this'n has seen it.  Too many times."),
    replies = {
        {
            text = ccb.content.text("Do you know what's going on?  What caused all this?"),
            next_topic = "TALK_EXODII_MERCHANT_Talk_CataclysmCause",
        },
        {
            text = ccb.content.text("Is it always like this?  What's going to happen to us?"),
            next_topic = "TALK_EXODII_MERCHANT_Talk_CataclysmTimeline",
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
    id = "TALK_EXODII_MERCHANT_Talk_CataclysmCause",
    line = ccb.content.text(
        --~ You want to get religious, eh?  I can't tell you for sure, but the people who claim to know, they talk about the Enemy.  Most folks have a fairy tale like that, I think.  A monster from ancient memory, returned.  I don't know much about that, but something makes those bodies walk and moan, and it doesn't seem to be anything human.  How it gets in, well, that's anyone's guess.  It can come the way we came, through a portal, but it doesn't always.  How it was for your world, I can't tell you.
        "F'r to wax religious, eh?\n\n*Rubik pauses for a while.  When they start talking again, their voice is slow and more serious than usual.*\n\nThis'n can't tell ye, rightly, but those what have a bottle an' a cork what fits it, they yark about the Enemy.  Most folks got a story like that in their ol' hearth-tales, an I'm ken.  A bad way, from times old, come back.  Ol' Rubik don't know much about that, but something makes them bodies walk and moan, and it don't seem to be somethin' of the way o' our kin.  How it gets in, well, that be anyone's for a guess.  It can come the way we came, wibbling and wobbling, but it don't always.  How it be'd the end for your deadland, Rubik can't say for ye."),
    replies = {
        {
            text = ccb.content.text("Wait, it can come like you did?  Did you bring this here?!"),
            next_topic = "TALK_EXODII_MERCHANT_Talk_CataclysmCause2",
        },
        {
            text = ccb.content.text("Is it always like this?  What's going to happen to us?"),
            next_topic = "TALK_EXODII_MERCHANT_Talk_CataclysmTimeline",
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
    id = "TALK_EXODII_MERCHANT_Talk_CataclysmCause2",
    line = ccb.content.text("No!  Bluster an' clouds, no!\"  Rubik's voice comes haltingly, as if they are picking their words with unusual care for clarity.  \"We done a few things what Rubik don't like to pickle an'… to think about, but never that!  We came after the fall, long after.  Always."),
    replies = {
        {
            text = ccb.content.text("Is it always like this?  What's going to happen to us?"),
            next_topic = "TALK_EXODII_MERCHANT_Talk_CataclysmTimeline",
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
    id = "TALK_EXODII_MERCHANT_Talk_CataclysmTimeline",
    line = ccb.content.text(
        --~ This is a deadland, you see.  Take a moment and look around, know what I mean?  What's left for you?  The dead will be in the fields, the forests, all over the world.  Anything that walks, they'll make it so it doesn't, and most will come back as undead.  Those that don't, the Enemy will change them as well.  Every deadland is the same.  You've years and more to go, but one way or another, this place is dead.  Though, as far as I can see, you've got quite a few years to go yet.
        "This be a deadland, kennit.  Spend a farthing at the pastor's house, d'ye razz?  What be left for ye?  The dead'll be in the fields, the forests, all around the green and brown.  Anything what walks, they'll salt 'n fallow, and most'll rise up and rejoin.  Those what don't, the Enemy twists and turns as well.  Every deadland be the same.  Ye've turns and twain, but come as it may, this land be dead.  Though, an I'm ken, ye've quite a few turns and twain to go yet."),
    replies = {
        {
            text = ccb.content.text("What then?  What happens after the whole planet dies?  Could it spread to other worlds from here?"),
            next_topic = "TALK_EXODII_MERCHANT_Talk_CataclysmTimeline2",
        },
        {
            text = ccb.content.text("That's pretty hopeless talk.  I've killed a lot of zombies, I can beat this 'Enemy' too."),
            next_topic = "TALK_EXODII_MERCHANT_Talk_CataclysmTimelineTough",
        },
        {
            text = ccb.content.text("Do you know what's going on?  What caused all this?"),
            next_topic = "TALK_EXODII_MERCHANT_Talk_CataclysmCause",
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

-- The probes don't return variable is not yet used but we should store it for when players might be offered the option to try going to previous deadlands, so they can object if they want.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Talk_CataclysmTimeline2",
    line = ccb.content.text(
        --~ Spread, yes, through the portals, but we don't know how.  After the world is down to dust, I'm long gone.  Once or twice we've send back a probe to the deadlands we left behind, but none have returned.  As far as I know, there's only one way it goes from here.
        "Spread, aye, through the wibbles, but we ain't ken on how.  After the green an' brown be to grey and black, so t'speak, Rubik be long gone.  On a moment, we folk've sent back a lover's robe or so t'the deadlands what left, but narry have returned.  An I'm ken, there be only one course from here."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "knowledge_probes_dont_return_u_knows_exodiilore", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("So traveling off-world is definitely an option.  Or getting to the ISS, maybe stepping off from there."),
            next_topic = "TALK_EXODII_MERCHANT_Talk_CataclysmTimeline3",
        },
        {
            text = ccb.content.text("It sounds like a secure base with a safe perimeter could last a long time.  Maybe forever."),
            next_topic = "TALK_EXODII_MERCHANT_Talk_CataclysmTimeline3",
        },
        {
            text = ccb.content.text("I haven't seen many zombies underground.  Seems like it might be possible to make a safe base down there."),
            next_topic = "TALK_EXODII_MERCHANT_Talk_CataclysmTimeline3",
        },
        {
            text = ccb.content.text("That's pretty hopeless talk.  I've killed a lot of zombies, I can beat this 'Enemy' too."),
            next_topic = "TALK_EXODII_MERCHANT_Talk_CataclysmTimelineTough",
        },
        {
            text = ccb.content.text("So what do you do, then?  How do you get out, and how do I do that?"),
            next_topic = "TALK_EXODII_MERCHANT_Survival",
        },
        {
            text = ccb.content.text("Do you know what's going on?  What caused all this?"),
            next_topic = "TALK_EXODII_MERCHANT_Talk_CataclysmCause",
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
    id = "TALK_EXODII_MERCHANT_Talk_CataclysmTimeline3",
    line = ccb.content.text(
        --~ If you want to try it, I won't stop you.  In fact, I'll sell you equipment that might help.
        "If ye be champed t'try, this'n won't stop ye.  Right so, Rubik'll sell ye the pieces ye might use t'do."),
    replies = {
        {
            text = ccb.content.text("Do you know what's going on?  What caused all this?"),
            next_topic = "TALK_EXODII_MERCHANT_Talk_CataclysmCause",
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
    id = "TALK_EXODII_MERCHANT_Talk_CataclysmTimelineTough",
    line = ccb.content.text("Fine an' fine.  Rubik'll clarion for ye when ye stand o'er the garried trick o' Anubine hisself."),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_d62a3b691c5f") } },
    },
    replies = {
        {
            text = ccb.content.text("Do you know what's going on?  What caused all this?"),
            next_topic = "TALK_EXODII_MERCHANT_Talk_CataclysmCause",
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
    id = "TALK_EXODII_MERCHANT_Dialect_Anglic",
    line = ccb.content.text(
        --~ I'm a lowlife from old Upper Landing, this is my way of talking.  Everyone from where I come from talks like this.
        "Be an' as us're a dock climber from ol' Upper Landin', this'll be our way o' yarkin'.  All an' all from our green an' brown yark like this'n."),
    replies = {
        {
            text = ccb.content.text("Tell me about \"ol' Upper Landing\".  What was your home like?"),
            next_topic = "TALK_EXODII_MERCHANT_Home",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Scythean",
    line = ccb.content.text(
        --~ Ha!  A new part of our crew.  Signed up early on in the world we were in before.  He's a really tough guy, and the node appreciates his grit.  (Recites some poetry), as it were.  I think he's pretty good as a military commander.
        "Ha!  A new string and beans, an I'm ken.  Latched and keyed in the bright shine o' the deadland afore this'n.  He be a thing o' fire and bronze, an' the node appreciates his grit.  \"A cnight of old, clade in shining steel, leading the hoste onward to glorie,\" as 'twere.  This'n finds him an apt one to give rede.  To command in battle, that's t'yark."),
    replies = {
        {
            text = ccb.content.text("You know, every so often you talk normally and I realize you could probably drop the whole accent if you wanted to."),
            next_topic = "TALK_EXODII_MERCHANT_Anglic_Tease",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("I think I've had about enough of trying to figure out what you're talking about, see you later."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Anglic_Tease",
    line = ccb.content.text(
        --~ Maybe, but where's the fun in that?  Besides, quoting poetry is one thing, but changing the way I speak all the time takes a lot of practice.
        "Mayhap, but where'd be the fun in that?  Asides, quoth poetry is one thing, but changin' this'n's whole yark for always takes a lot o' practice."),
    replies = {
        {
            text = ccb.content.text("What was it you were saying before, about the mission you had for me?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_1_intro",
        },
        {
            text = ccb.content.text("Well, a person can get sick of trying to piece it together.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Meetcute",
    line = ccb.content.text(
        --~ Right.  You see, it's when two compatible people randomly happen into each other and take a liking to one another.  It's a bit of Anglic slang.
        "Aye.  Ye kennit, when two of a sort happen upon each other as per chance, an' find a liking to another?  'Tis a bit o' Anglic yark."),
    replies = {
        {
            text = ccb.content.text("Yeah, that's what I thought it meant, just… nevermind.  What were you saying about the job?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_1_intro",
        },
        {
            text = ccb.content.text("I don't know what kind of game you're playing, but I'm out for a bit."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Hempen1",
    line = ccb.content.text(
        --~ That takes me way back.  That's a bit of the old King's Landing right there, you know, calling back from when I was just little.  It… ah, it's really hard for me to think about those old days.  Maybe another time.
        "*seems to become wistful for a moment.  \"Harks this'n yonder, right so.  'Tis a bit o' t'ol' King's Landing right there, kennit, yarkin' from back when Rubik were nigh smaller than a kelpie.  It…\"  Rubik's gravelly voice falters.  \"Ah, 'tis mightily tassed to hearken back yonder.  Mayhap another time.\""),
    replies = {
        {
            text = ccb.content.text("Maybe later then.  What were you saying about the job?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_1_intro",
        },
        {
            text = ccb.content.text("You know, I think it'd be best if I just got going."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Purpose",
    line = ccb.content.text(
        --~ Making do, making do, same as you I'd imagine.  Our last home got too dead and putrid around the edges, basically.  It happens to the best of them.  We caught some news that brought us along to your place here, fired up the engines, and boom!  Now, quick as can be, here we are.  We got a good timing this time, seems to me you'd only been dead a few days when we got here.  Freshest corpse I've seen in a while.
        "Makin' do, makin' do, same as you, an I'm ken.  Last home got a bit too dead 'n putrid roun' the edges, like.  Happens to the best of 'em.  Caught a jibber that made us ken 'bout your place here, fired up the ol' wibble-wammles and boom!  Now it's all tick-tock on a zimmer, here we be.  Got a good timing this time, I razz you only been dead a few days when we wobbled in.  Freshest corpse this'n's seen in a kitchen sink."),
    replies = {
        { text = ccb.content.text("…what?"), next_topic = "TALK_EXODII_MERCHANT_Purpose_Dialect" },
        {
            text = ccb.content.text("[INT or PER 9] Where did you come from then?  Are you aliens or something?"),
            when = predicates.any({ predicates.minimum_attribute("speaker", "intelligence", 9), predicates.minimum_attribute("speaker", "perception", 9) }),
            next_topic = "TALK_EXODII_MERCHANT_Aliens",
        },
        {
            text = ccb.content.text("Is there anything else you want from this place?"),
            next_topic = "TALK_EXODII_MERCHANT_Purpose2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Purpose_Dialect",
    line = ccb.content.text(
        --~ We're just here to survive, you understand?  Our last world got too overrun with undead.  So, we came to a new world.  This one.  If I'm not mistaken, it's not so long dead around here just yet.
        "Us're here to live and breathe, kennit?  After our last otherland got a li'l too dead an' all.  So, us'n came to a new place.  This'n.  An I'm ken, it's not so long dead round here jus' yet."),
    replies = {
        {
            text = ccb.content.text("[INT or PER 7] Otherland?  Are you aliens or something?"),
            when = predicates.any({ predicates.minimum_attribute("speaker", "intelligence", 7), predicates.minimum_attribute("speaker", "perception", 7) }),
            next_topic = "TALK_EXODII_MERCHANT_Aliens",
        },
        {
            text = ccb.content.text("Is there anything else you want from this place?"),
            next_topic = "TALK_EXODII_MERCHANT_Purpose2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Purpose2",
    line = ccb.content.text(
        --~ Aside from just having a safe place to live?  We're here to mine, you understand.  Picking the scraps, seeing if this world has any tech worth reverse engineering.  No sense letting good scraps go to waste.  If we're lucky, maybe we'll get some new Exodii before we teleport out.  Pickin' up the pieces of our sweet, shattered dreams, such as they are.
        "Aside from jus' livin' in such a cozy nook?  Us be minin', ye kennit.  Pickin' the scraps, seein' if for your otherland has any tech worth an upside-down.  No sense lettin' good scraps go to waste.  If we're lucky, pickin' a few new Exodii afore we wobble out.  Pickin' up the pieces of our sweet, shattered dreams, suchlike."),
    on_enter = { { actions = { actions.set_actor_value("speaker", "u_know_exodii_purpose2", "yes") } } },
    replies = {
        {
            text = ccb.content.text("What do you mean 'go to waste'?  The zombies aren't using the scrap, and there's plenty to go around."),
            next_topic = "TALK_EXODII_MERCHANT_Purpose3",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Purpose3",
    line = ccb.content.text(
        --~ This is a deadland, don't you see?  You've already got an infestation and it's not going away.  There's no cure for the zombies.
        "This'n be a deadland, an I'm ken.  You gots you a case o' the willies ain't gonna sing along.  No cure for these rats and fleas."),
    replies = {
        {
            text = ccb.content.text("What the hell does that mean?"),
            next_topic = "TALK_EXODII_MERCHANT_Purpose4",
        },
        {
            text = ccb.content.text("[INT 8] Are you saying you think we're doomed?  Why would you have come here if there wasn't some way to survive?"),
            when = predicates.minimum_attribute("speaker", "intelligence", 8),
            next_topic = "TALK_EXODII_MERCHANT_Survival",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Purpose4",
    line = ccb.content.text(
        --~ It means what it means.  Your land's dead already, it's just still kicking is all.
        "Means what it means.  Your land's a deadun', still kickin' is all."),
    replies = {
        {
            text = ccb.content.text("Are you saying you think we're doomed?  Why would you have come here if there wasn't some way to survive?"),
            next_topic = "TALK_EXODII_MERCHANT_Survival",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Survival",
    line = ccb.content.text(
        --~ Oh, we can teleport along as we need to.  We send the scrap along, then the food, and shake off some baddies, you understand.  It's no good for you though, it won't take too much flesh and bone.
        "Oh, us can wobble along as needs.  Sends the scrap back, brings in the foods, and shakes off a willie or three, kennit.  No good for you, won't take too much meat-an'-bone."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "knowledge_exodization_u_knows_exodiilore", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Well… could you help me fix that?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodize",
            when = predicates.negate(predicates.any({ predicates.has_mission("RUBIK_ANUS_FETICK"), predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_anusfetick" } }), predicates.has_trait("speaker", "CBM_Interface"), predicates.has_trait("speaker", "NL_CBM_Interface") })),
        },
        {
            text = ccb.content.text("Wait.  I thought you were still flesh and bone, under that metal."),
            next_topic = "TALK_EXODII_MERCHANT_Survival2",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "knowledge_rubik_is_cyborg_u_knows_exodiilore" } }),
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Survival2",
    line = ccb.content.text(
        --~ Haha, not mostly, mate.  It's not worth risking the side effects, you see?  I keep the parts of me that make me Rubik, but the rest is all solid.
        "Haha, not mostly, mate.  Not worth riskin' the willies, innit?  I keep what's Rubik, but the rest is all solid."),
    replies = {
        {
            text = ccb.content.text("What?  I mean, really, it seems like you're being hard to understand on purpose.  What are the 'willies'?"),
            next_topic = "TALK_EXODII_MERCHANT_Survival3",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Survival3",
    line = ccb.content.text(
        --~ Oh, sure, that's a fair assessment.  I mean, I do get a bit of a laugh out of the look on your face sometimes.  What I'm saying is, if my body were flesh and bone, the device we use to travel around dimensions would rip up the meat and leave me quite a mess.  We can take a bit, but too much… one time, I felt a bit of that, and I'm not in any rush to try it again.
        "Oh, sure an it's bagged in a coffer an' all that.  That is t'say, this'n does get a wipe o' a grinny t'see the perplexion upon a visage, an I'm ken.*  You're pretty sure you hear a faint chuckle in the metallic voice.  *What I be meanin' is at, for my body were t'be meat-an'-bone, the tool what we be usin' for t'travel to an' fro, it rips up the meat an' leaves it a right mess.  A bit can come along for a right fun, but too much… on a time, an earlier Rubik felt a spot o' those willies, an' this'n be not in the farrier's hut for t'try it again."),
    replies = {
        {
            text = ccb.content.text("What?  I mean, really, it seems like you're being hard to understand on purpose."),
            next_topic = "TALK_EXODII_MERCHANT_Survival3",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Tech",
    line = ccb.content.text(
        --~ Not to me it doesn't.  We didn't get it from around here though.  I bet it looks pretty nice to you.
        "Not to me it don't.  We ain't tassed from around here though.  Looks fine an' fine to you I'd razz."),
    replies = {
        {
            text = ccb.content.text("[INT or PER 7] Not from around here?  Are you aliens or something?"),
            when = predicates.any({ predicates.minimum_attribute("speaker", "intelligence", 7), predicates.minimum_attribute("speaker", "perception", 7) }),
            next_topic = "TALK_EXODII_MERCHANT_Aliens",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Bionic_Install",
    line = ccb.content.text(
        --~ If you've got what I need, I'm happy to call ahead and make the arrangements, for a fee.
        "If'n you're full an' plenty, this'n's happy to make the call, for a shiny farthing."),
    replies = {
        {
            text = ccb.content.text("I've got some stuff I'd like to install."),
            when = predicates.any({ predicates.has_trait("speaker", "CBM_Interface"), predicates.has_trait("speaker", "NL_CBM_Interface") }),
            next_topic = "TALK_DONE",
            native_actions = { "bionic_install" },
        },
        {
            text = ccb.content.text("Would you be able to take out one of my implants?"),
            when = predicates.any({ predicates.has_trait("speaker", "CBM_Interface"), predicates.has_trait("speaker", "NL_CBM_Interface") }),
            next_topic = "TALK_DONE",
            native_actions = { "bionic_remove" },
        },
        {
            text = ccb.content.text("I've got some stuff I'd like to install."),
            when = predicates.has_trait("speaker", "Hub01_CBM_Interface"),
            next_topic = "TALK_EXODII_MERCHANT_Found_Hub01_CBM_interface",
        },
        {
            text = ccb.content.text("Would you be able to take out one of my implants?"),
            when = predicates.has_trait("speaker", "Hub01_CBM_Interface"),
            next_topic = "TALK_EXODII_MERCHANT_Found_Hub01_CBM_interface",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_You_Buy_Riot_Gear_On_Credit",
    line = ccb.content.text("If'n you survive, we can give you a fortnight and six odd days to pay us'n back."),
    replies = {
        {
            text = ccb.content.text("Thanks Rubik, I'll be back with your payment soon."),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
            actions = { actions.handler("dlg_a_dda_93f3ca32d409"), actions.assign_mission("MISSION_EXODII_PAY_BACK_RIOT_GEAR"), actions.set_actor_value("interlocutor", "npc_dialogue_exodii_npc_bought_riot_gear", "yes") },
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
    id = "TALK_EXODII_MERCHANT_Found_Hub01_CBM_interface",
    line = ccb.content.text("&Rubik pulls out a glowing, green terminal while a surgical robot rolls in to do standard pre-surgical checks.  \"Rightly then, let us'n see what can do 'ye for.\"  Then the surgical robot starts to beep loudly and blurts out words you don't understand in a mechanical voice.  Rubik stares at it a moment, then stares at you.  \"Well now.  Seems to this'n ye've had yer interface swapped.  I'll hear no excuses.  We've had some tech an' stompers gone missin', an' word aroun' says a certain bunker offerin' stolen steelies.  Ye've two minutes to traipse out o'here.  Ken it.\""),
    replies = {
        {
            text = ccb.content.text("Two minutes?  Ah, shit."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_26a76d0c6d1d") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_You_Buy_Riot_Gear",
    line = ccb.content.text("Mayhaps this gear will do you better than it did the scuffers wot trained with it. [$400]"),
    replies = {
        {
            text = ccb.content.text("I'll buy it."),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
            actions = { actions.handler("w16b_a_dda_3bad465bd877") },
        },
        {
            text = ccb.content.text("Any chance I can buy gear this on layaway?"),
            next_topic = "TALK_EXODII_MERCHANT_You_Buy_Riot_Gear_On_Credit",
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
    id = "TALK_EXODII_MERCHANT_You_Buy_Riot_Gear_Payback",
    line = ccb.content.text("Right and done, don't let whatever you are going after turn you into a pork loin well done.  I's expectin' you back."),
    replies = {
        {
            text = ccb.content.text("Here's the money to pay off that debt."),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
            actions = { actions.handler("w16b_a_dda_3bad465bd877") },
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
    id = "TALK_EXODII_MERCHANT_Hates_Hub_Cyborgs",
    line = ccb.content.text("Shinies an' stompers missin', an' escoltin' a bunker offerin' stolen steelies.  Thine steelies.  Ne.  Ye ain't tassed from around here.  Ye've two minutes to traipse out o'here.  Ken it."),
    replies = {
        {
            text = ccb.content.text("Two minutes to get out of here?  Ah, shit."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_26a76d0c6d1d") },
        },
    },
}
