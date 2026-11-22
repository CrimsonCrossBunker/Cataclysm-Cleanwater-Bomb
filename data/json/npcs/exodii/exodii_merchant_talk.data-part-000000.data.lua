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
