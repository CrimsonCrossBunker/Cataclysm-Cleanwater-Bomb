local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- Appears in the surface of Hub 01 as an external mercenary.
ccb.content.define_npc {
    id = "robofac_merc_1",
    unique_name = ccb.content.text("Cranberry Foster"),
    suffix = ccb.content.text("Hub Mercenary"),
    missions_offered = "MISSION_ROBOFAC_MERC_1_RADIO",
    class = "NC_ROBOFAC_MERC_1",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_ROBOFAC_MERC_1",
    faction = "robofac_auxiliaries",
}

-- Cranberry is a former park ranger that held out at home for a while during and after the Cataclysm.  They lived near Hub 01's headquarters and was curious what was inside the building, so when they left their home, they went to it.
-- They are generally laid back and talk in an informal, relaxed way.  Things have been hard, but they're generally optimistic and have largely come to terms with the new state of the world.
-- Writing note: Cranberry's appearance and voice are androgynous, and so their gender is never specified; they directly tease the player about it in a dialogue option that appears once they have enough trust with the player.  Use neutral terms and pronouns when referring to them.
ccb.content.define_npc_class {
    id = "NC_ROBOFAC_MERC_1",
    name = ccb.content.text("Hub Mercenary"),
    job_description = ccb.content.text("Fighting for the all-mighty dollar."),
    common = false,
    traits = {
        { trait = "TOUGH" },
        { trait = "QUICK" },
        { trait = "OPTIMISTIC" },
        { trait = "FORGETFUL" },
        { trait = "PACIFIST" },
        { trait = "TRUTHTELLER" },
        { trait = "hair_medium", variant = "blond" },
        { trait = "natural_hair_color_blond" },
        { trait = "eye_color", variant = "blue" },
        { trait = "SKIN_PINK" },
        { trait = "RETURN_TO_START_POS" },
    },
    strength = 2,
    dexterity = 3,
    perception = 1,
    worn = "NC_ROBOFAC_MERC_1_worn",
    carry = "NC_ROBOFAC_MERC_1_carry",
    weapon = "NC_ROBOFAC_MERC_1_wield",
    skills = {
        { skill = "gun", bonus = 4 },
        { skill = "rifle", bonus = 4 },
        { skill = "pistol", bonus = 1 },
        { skill = "melee", bonus = 4 },
        { skill = "cutting", bonus = 3 },
        { skill = "fabrication", bonus = 1 },
        { skill = "firstaid", bonus = 1 },
        { skill = "swimming", bonus = 3 },
        { skill = "survival", bonus = 4 },
        { skill = "cooking", bonus = 4 },
        { skill = "computer", bonus = 6 },
        { skill = "electronics", bonus = 4 },
        { skill = "driving", bonus = 3 },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Cranberry" } }),
        yes = {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_robofac_merc_1_robofac_merc_1_stay" } }),
            yes = {
                when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_robofac_merc_1_temporal_follower" } }),
                yes = {
                    choices = {
                        ccb.content.text("Better keep our eyes on the road."),
                        ccb.content.text("*looks at you expectantly."),
                        ccb.content.text("Better be careful around here."),
                        ccb.content.text("Yeah?"),
                        ccb.content.text("What's up?"),
                    },
                },
                no = {
                    choices = {
                        ccb.content.text("Got something to say?"),
                        ccb.content.text("I charge hourly, y'know."),
                        ccb.content.text("Hey."),
                        ccb.content.text("*looks at you expectantly."),
                        ccb.content.text("Yeah?"),
                        ccb.content.text("What's up?"),
                        ccb.content.text("Good to see you."),
                    },
                },
            },
            no = {
                choices = {
                    ccb.content.text("Did I scare you off the first time?"),
                    ccb.content.text("Hi again, other person."),
                    ccb.content.text("*waves."),
                },
            },
        },
        no = ccb.content.text("&There's a person reclined on the sofa here.  They're very tall, with their legs reaching to the other armrest, and they're wearing a set of Hub 01's modular armor.  An environmental suit in blue-and-brown is crumpled in a misshapen heap on the floor near the table, and leaning against the far armrest is a rifle looking like nothing you've seen before.\n\nThey look up towards you as you come through the door and wave a hand.  \"Placeholder text.\""),
    },
    on_enter = {
        { once = "robofac_merc_1_first_meeting", actions = { actions.set_actor_value("speaker", "general_meeting_u_met_Cranberry", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("…Did you just say \"placeholder text\" out loud?"),
            next_topic = "TALK_ROBOFAC_MERC_1_PLACEHOLDER_TEXT",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Cranberry" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_robofac_merc_1_robofac_merc_1_stay" } })) }),
        },
        {
            text = ccb.content.text("Uh… okay.  Who are you?"),
            next_topic = "TALK_ROBOFAC_MERC_1_WHO",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Cranberry" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_robofac_merc_1_robofac_merc_1_stay" } })) }),
        },
        {
            text = ccb.content.text("Who are you, exactly?"),
            next_topic = "TALK_ROBOFAC_MERC_1_WHO",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Cranberry" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_robofac_merc_1_robofac_merc_1_stay" } })) }),
        },
        {
            text = ccb.content.text("About that job…"),
            next_topic = "TALK_MISSION_INQUIRE",
            when = predicates.assigned_missions(1, 1),
        },
        {
            text = ccb.content.text("About those jobs…"),
            next_topic = "TALK_MISSION_LIST_ASSIGNED",
            when = predicates.assigned_missions(2),
        },
        {
            text = ccb.content.text("I wanted to talk."),
            next_topic = "TALK_ROBOFAC_MERC_1_MAIN",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_robofac_merc_1_robofac_merc_1_stay" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_robofac_merc_1_temporal_follower" } })) }),
        },
        {
            text = ccb.content.text("Want help with something else?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.handler("dlg_p_dda_d2342c198178"),
        },
        {
            text = ccb.content.text("Let's set up a combat strategy."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_robofac_merc_1_temporal_follower" } }),
            actions = { "npc_rules_menu" },
        },
        {
            text = ccb.content.text("<end_talking_nevermind>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_ROBOFAC_MERC_1_MAIN", "TALK_ROBOFAC_MERC_1_STAY_AWHILE", "TALK_ROBOFAC_MERC_1_GOLD_MISSION_ACCEPTED" },
    line = {
        choices = {
            ccb.content.text("Rough out there, isn't it?"),
            ccb.content.text("Good to have some company."),
            ccb.content.text("Have something to say?"),
            ccb.content.text("Did you want something?"),
            ccb.content.text("*waits expectantly."),
        },
    },
    replies = {
        {
            text = ccb.content.text("So what's going on?"),
            next_topic = "TALK_ROBOFAC_MERC_1_GOING_ON",
        },
        {
            text = ccb.content.text("Anything on your mind?"),
            next_topic = "TALK_ROBOFAC_MERC_1_COINS",
            when = predicates.handler("dlg_p_dda_2c20491e4c6b"),
        },
        {
            text = ccb.content.text("Anything on your mind?"),
            next_topic = "TALK_ROBOFAC_MERC_1_RANDOM_THOUGHTS",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_robofac_merc_1_has_gold_deal" } }),
        },
        {
            text = ccb.content.text("What was <the_cataclysm> like for you?"),
            next_topic = "TALK_ROBOFAC_MERC_1_BACKGROUND_NO",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_robofac_merc_1_helped_with_missions" } })),
        },
        {
            text = ccb.content.text("What was <the_cataclysm> like for you?"),
            next_topic = "TALK_ROBOFAC_MERC_1_BACKGROUND",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_robofac_merc_1_helped_with_missions" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_robofac_merc_1_heard_backstory" } })) }),
        },
        {
            text = ccb.content.text("Want help with something?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_robofac_merc_1_helped_with_missions" } })),
        },
        {
            text = ccb.content.text("What do you know about our employers?"),
            next_topic = "TALK_ROBOFAC_MERC_1_ASK_HUB",
        },
        {
            text = ccb.content.text("That gun isn't like anything I've ever seen.  What am I looking at?"),
            next_topic = "TALK_ROBOFAC_MERC_1_HWP",
            when = predicates.handler("dlg_p_dda_507b4950adea"),
        },
        {
            text = ccb.content.text("What's the deal with your gun again?"),
            next_topic = "TALK_ROBOFAC_MERC_1_HWP_EXPLANATION",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_robofac_merc_1_robofac_merc_1_HWP" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_hub_rnd_u_can_research_rifle" } })) }),
        },
        {
            text = ccb.content.text("I've helped you out now.  Do you think you could vouch for me with our employers?"),
            next_topic = "TALK_ROBOFAC_MERC_1_HWP_YES",
            when = predicates.handler("dlg_p_dda_11254f2d418d"),
        },
        {
            text = ccb.content.text("How can I get a gun like that?"),
            next_topic = "TALK_ROBOFAC_MERC_1_HWP_NO",
            when = predicates.handler("dlg_p_dda_f782335365a7"),
        },
        {
            text = ccb.content.text("I just realized, we've been in touch for a while now and I don't actually know; are you a man or a woman?"),
            next_topic = "TALK_ROBOFAC_MERC_1_GENDER",
            when = predicates.handler("dlg_p_dda_e9c924b77994"),
        },
        {
            text = ccb.content.text("About the gold you wanted…"),
            next_topic = "TALK_ROBOFAC_MERC_1_GOLD_MISSION_QUERY",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_robofac_merc_1_has_gold_deal" } }),
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_GENDER",
    line = ccb.content.text("Yes."),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "dialogue_robofac_merc_1_asked_gender", "yes") },
            once = "robofac_merc_1_asked_gender",
        },
    },
    replies = {
        {
            text = ccb.content.text("I don't know what I was expecting."),
            next_topic = "TALK_ROBOFAC_MERC_1_MAIN",
        },
    },
}

ccb.content.define_dialogue_topic { id = "TALK_ROBOFAC_MERC_1_STAY_AWHILE", line = ccb.content.text("Cool.") }

ccb.content.define_dialogue_topic {
    id = { "TALK_ROBOFAC_MERC_1_PLACEHOLDER_TEXT", "TALK_ROBOFAC_MERC_1_OTHER_MERCS" },
    line = ccb.content.text("I sure did.  Sorry, just a stupid icebreaker.  Old habits and all that.\"  They sit up.  \"What's up?"),
    replies = {
        { text = ccb.content.text("Who exactly are you?"), next_topic = "TALK_ROBOFAC_MERC_1_WHO" },
        {
            text = ccb.content.text("I thought I was the only one working for the people here."),
            next_topic = "TALK_ROBOFAC_MERC_1_OTHER_MERCS",
        },
        {
            text = ccb.content.text("Just saying hi.  I'll be on my way now."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_OTHER_MERCS",
    line = ccb.content.gendered_line("Surprise!\"  They do jazz hands.  \"Sorry.  Well, I'm told that I'm part of a small group right now.  Maybe you were the first.", { "speaker" }),
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_WHO",
    line = ccb.content.text("Just the same as you.  Some nobody doing dirty work for scraps.  Uh, no offense."),
    replies = {
        {
            text = ccb.content.text("None taken.  I guess that makes two of us."),
            next_topic = "TALK_ROBOFAC_MERC_1_TWO_OF_US",
        },
        { text = ccb.content.text("Well, never mind."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_TWO_OF_US",
    line = ccb.content.text("I guess so.\"  They beam sheepishly.  \"Uh, call me Cranberry.  Cran is fine too.  It's nice to meet someone else from here.  I guess having some company for once wouldn't be awful."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "dialogue_robofac_merc_1_robofac_merc_1_stay", "yes"),
            },
            once = "robofac_merc_1_stay",
        },
    },
    replies = {
        { text = ccb.content.text("Alright."), next_topic = "TALK_ROBOFAC_MERC_1_MAIN" },
        {
            text = ccb.content.text("I guess I could stay for a while."),
            next_topic = "TALK_ROBOFAC_MERC_1_STAY_AWHILE",
        },
        {
            text = ccb.content.text("Actually, I have some places to be right now.  Good to meet you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = {
        "TALK_ROBOFAC_MERC_1_ASK_HUB",
        "TALK_ROBOFAC_MERC_1_ASK_HUB_DOCS",
        "TALK_ROBOFAC_MERC_1_ASK_HUB_NETWORK",
    },
    line = ccb.content.text("Not a whole lot, really.  They made me track down and destroy some government documents a while back.  Obviously I read them first, but it wasn't much.  As far as I know, this place had an experimental computer network before everything went to hell.  What's going on in there now is anybody's guess."),
    replies = {
        {
            text = ccb.content.text("Hold on, government documents?"),
            next_topic = "TALK_ROBOFAC_MERC_1_ASK_HUB_DOCS",
        },
        {
            text = ccb.content.text("Computer network?"),
            next_topic = "TALK_ROBOFAC_MERC_1_ASK_HUB_NETWORK",
        },
        { text = ccb.content.text("Strange bedfellows…"), next_topic = "TALK_ROBOFAC_MERC_1_MAIN" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_ASK_HUB_DOCS",
    line = ccb.content.text("Yeah!  Crazy shit.  They sent me to an office building to find a folder with a certain serial and get rid of it.  They didn't even care what was on it.  By the time I got there, though, the building was pretty much a wreck.  The folder had been sitting in a puddle for God knows how long, and there was nothing even remotely legible by then."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_ASK_HUB_NETWORK",
    line = ccb.content.text("That's what the news said, anyway.  It was only about a 20-minute trip from my apartment and sometimes I'd drive past it, so I was curious and I did some research into it.  The only info I could find about it online said that it was a NASA lab for computer research, but that was probably bullshit.  I mean, do you see any NASA logos?  Sure, we got huge steel doors and 15-foot concrete walls, but not a logo in sight.  The building probably goes underground, right?  It's way too small to be a whole laboratory up here."),
}

ccb.content.define_dialogue_topic {
    id = { "TALK_ROBOFAC_MERC_1_GOING_ON", "TALK_ROBOFAC_MERC_1_GOING_ON_SLEEP" },
    line = ccb.content.text("Just trying to get some rest.  I don't have anywhere else to stay, so they let me sleep on the couch out here as long as I keep my gun handy."),
    replies = {
        {
            text = ccb.content.text("They don't let you in to sleep?"),
            next_topic = "TALK_ROBOFAC_MERC_1_GOING_ON_SLEEP",
        },
        { text = ccb.content.text("Fair enough."), next_topic = "TALK_ROBOFAC_MERC_1_MAIN" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_GOING_ON_SLEEP",
    line = ccb.content.text("Dude, I wish.  It sounds like there's different people on the mic at different times, but all of them give me the same spiel: nobody's allowed in right now.  I guess I shouldn't raise a fuss about it, honestly.  All being considered, this compound is pretty safe, and the couch ain't so bad."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_COINS",
    line = ccb.content.gendered_line("Yeah.  Have you noticed how they pay us in these tiny little gold coins?\"  Cranberry holds one up for emphasis.  \"It's bizarre.  You'd think they have a gold mine in there, but no, they don't, so they make me cross the damn world grabbing gold bars.  As far as scrip goes, it seems inconvenient as hell to make.", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("You sound frustrated about it."),
            next_topic = "TALK_ROBOFAC_MERC_1_GOLD_MISSION",
        },
        {
            text = ccb.content.text("Now that you mention it, it does seem rather strange."),
            next_topic = "TALK_ROBOFAC_MERC_1_MAIN",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_RANDOM_THOUGHTS",
    line = {
        choices = {
            ccb.content.text("Thinking I should go hunt something soon…"),
            ccb.content.text("Just wondering if things will get better someday."),
            ccb.content.text("Hmm?  Nothing, I guess I just like resting in this place.  I feel good today."),
            ccb.content.gendered_line("Have you ever noticed how… wait no, never mind.", { "speaker" }),
            ccb.content.text("Wondering if the whole world is like this now.  It has to be, right?  I was watching some foreign news channels when everything was going down, and it sounded like things were just as bad there…"),
            ccb.content.gendered_line("Hey, did you notice that there's working wi-fi here?  Not that anything else is online anymore, but still.", { "speaker" }),
            ccb.content.text("Just vibing."),
        },
    },
    replies = { { text = ccb.content.text("I see."), next_topic = "TALK_ROBOFAC_MERC_1_MAIN" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_HWP",
    line = ccb.content.text("*picks the gun up and shows it to you from a few different angles.  You've never seen anything like it; it has a steel body with composite blue furniture, and looks lightweight and cutting-edge.  It features a modern hybrid scope, built-in attachments, and a strange quick-release button on the side.  The magazine looks like something for an assault rifle, but the magazine well itself is strangely designed and seems to be fitted with an adapter to make the magazine actually fit.\n\n\"Whatcha think?\""),
    replies = {
        {
            text = ccb.content.text("Is that a custom Hub rifle?"),
            next_topic = "TALK_ROBOFAC_MERC_1_HWP_EXPLANATION",
        },
        {
            text = ccb.content.text("Where'd you find that thing?"),
            next_topic = "TALK_ROBOFAC_MERC_1_HWP_EXPLANATION",
        },
        {
            text = ccb.content.text("Sweet piece of salvage."),
            next_topic = "TALK_ROBOFAC_MERC_1_HWP_EXPLANATION",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_ROBOFAC_MERC_1_HWP_EXPLANATION", "TALK_ROBOFAC_MERC_1_HWP_EXPLANATION_WHERE" },
    line = ccb.content.text("It's from our employers.  Apparently, it's a custom platform they make for field agents.  It's got quick swap barrels for 9mm, the standard NATO cartridges, and shotgun shells too.  It's great for if you're on a long field mission and run out of ammo.  A lot of dudes bit the dust on their way home from the gun store with a box of nine-mil.  I guess it's better them than us; they don't need it now."),
    on_enter = {
        { once = "robofac_merc_1_HWP", actions = { actions.set_actor_value("speaker", "dialogue_robofac_merc_1_robofac_merc_1_HWP", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("Damn.  Where can I get one of those?"),
            next_topic = "TALK_ROBOFAC_MERC_1_HWP_EXPLANATION_WHERE",
        },
        {
            text = ccb.content.text("I've helped you out now.  Do you think you could vouch for me with our employers?"),
            next_topic = "TALK_ROBOFAC_MERC_1_HWP_YES",
            when = predicates.handler("dlg_p_dda_83478589bcf4"),
        },
        {
            text = ccb.content.text("I see."),
            next_topic = "TALK_ROBOFAC_MERC_1_MAIN",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_HWP_EXPLANATION_WHERE",
    line = ccb.content.text("You'll have to work that out with the intercom.  They seem stingy with them."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_HWP_YES",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_hub_merc_promised_u" } }),
        yes = ccb.content.text("As promised earlier, I'll let the Hub know that you're worth manufacturing some proper gear for.  Let 'em know that I sent you next time you talk with them and I'm sure they'll help you."),
        no = ccb.content.text("I do owe you one.  Tell you what: I'll let the Hub know that you're worth manufacturing some proper gear for.  Let 'em know that I sent you next time you talk with them and I'm sure they'll help you."),
    },
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "dialogue_hub_rnd_u_can_research_rifle", "yes") },
        },
    },
    replies = { { text = ccb.content.text("Thanks."), next_topic = "TALK_ROBOFAC_MERC_1_MAIN" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_HWP_NO",
    line = ccb.content.text("You'll have to work it out with the intercom.  I don't want to vouch for someone I don't really know."),
    replies = {
        {
            text = ccb.content.text("Anything I can do to change your mind?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.handler("dlg_p_dda_5518106cf401"),
        },
        {
            text = ccb.content.text("Anything I can do to change your mind?"),
            next_topic = "TALK_ROBOFAC_MERC_1_HWP_IF_I_OWE_YOU",
            when = predicates.handler("dlg_p_dda_6bb028d8c1c4"),
        },
        {
            text = ccb.content.text("Alright."),
            next_topic = "TALK_ROBOFAC_MERC_1_MAIN",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_HWP_IF_I_OWE_YOU",
    line = ccb.content.text("Once we finish up this job, I'll vouch for you.  Pinkie promise."),
    on_enter = { { actions = { actions.set_actor_value("speaker", "dialogue_hub_merc_promised_u", "yes") } } },
    replies = { { text = ccb.content.text("Alright."), next_topic = "TALK_ROBOFAC_MERC_1_MAIN" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_BACKGROUND",
    line = ccb.content.text("*goes quiet.  They chew their lip, looking off towards a point in space."),
    replies = {
        {
            text = ccb.content.text("I'm sorry.  Too personal?"),
            next_topic = "TALK_ROBOFAC_MERC_1_BACKGROUND_1",
        },
        {
            text = ccb.content.text("Hey, it can wait."),
            next_topic = "TALK_ROBOFAC_MERC_1_BACKGROUND_1",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_BACKGROUND_1",
    line = ccb.content.text("No, no!  It's fine, promise.  It's just been a hot minute, and I'm trying to remember it.  It's been a while.  You sure you want to hear it?"),
    replies = {
        { text = ccb.content.text("I'm sure."), next_topic = "TALK_ROBOFAC_MERC_1_BACKGROUND_2" },
        {
            text = ccb.content.text("I might not have the time.  Hold that thought for later."),
            next_topic = "TALK_ROBOFAC_MERC_1_MAIN",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_BACKGROUND_2",
    line = ccb.content.text("*stares at a point at the wall, thinking.  Their wedding ring glints on their left hand."),
    replies = { { text = ccb.content.text("[Wait.]"), next_topic = "TALK_ROBOFAC_MERC_1_BACKGROUND_3" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_BACKGROUND_3",
    line = ccb.content.text("…Alright.  Well.  For starters, I lived alone in an apartment, and I didn't have any family or relatives I really cared about, so things were a lot easier for me than they could have been."),
    replies = { { text = ccb.content.text("[Listen.]"), next_topic = "TALK_ROBOFAC_MERC_1_BACKGROUND_4" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_BACKGROUND_4",
    line = ccb.content.text("I've never really been a prepper, but I was into conspiracy theories.  Not as a participant, just as an observer.  I think information spread is interesting.\"  They pause.  \"I think it was in early March that I started thinking something was wrong.  Like, the riots were bad beforehand, right?  And that just seemed like normal unrest.  But then suddenly you're seeing it happening in other countries where the normal explanations don't work.  So I dug deeper, and once I did, I realized that this had been happening since January, and getting worse since then.  That was when I started to take it seriously."),
    replies = { { text = ccb.content.text("[Listen.]"), next_topic = "TALK_ROBOFAC_MERC_1_BACKGROUND_5" } },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_ROBOFAC_MERC_1_BACKGROUND_5", "TALK_ROBOFAC_MERC_1_BACKGROUND_5_1" },
    line = ccb.content.text("But like, I was a park ranger.  I wasn't exactly making six figures, and you know how bad rent was.  I couldn't buy a ton of canned food, but what I *could* do is can things myself.  Not in tin cans, but in jars; the old way.  So every paycheck, I'd use a little bit to buy one or two big glass jars, and on the weekends I'd spend a few hours filling them up with food and sealing them.  I started brushing up at the range too.  Proud gun owner, baby."),
    replies = {
        { text = ccb.content.text("[Listen.]"), next_topic = "TALK_ROBOFAC_MERC_1_BACKGROUND_6" },
        {
            text = ccb.content.text("What food were you canning?"),
            next_topic = "TALK_ROBOFAC_MERC_1_BACKGROUND_5_1",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_BACKGROUND_5_1",
    line = ccb.content.text("I bought fruit and veggies from the store for my greens, but I figured those didn't really have enough calories for the long-term, so I hunted.  To be more accurate, I poached in the park I worked at.  It was never anything huge; I had to be able to conceal this stuff, remember.  But we were on a shoestring budget as it is and we never had the people we needed, so it was trivial to bag an animal using a rifle from one of the ranger stations.  I'd dress the carcass, then leave it in a place that I could either bring with me in my truck that day or come back later to sneak it out.  I never got caught.  I'm not proud of it, but I'm not really ashamed of it, either.  Besides, venison is great."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_BACKGROUND_6",
    line = ccb.content.text("So I figured that this wasn't going to be a problem a few months down the line, right?  Just a flash in the pan.  I had my emergency stock of food in case things went bad for a little while.  Best case scenario, I never have to worry about it, things go back to normal after a bit, and I save some money on groceries for a while.  And I wanted to keep doing this for a few more weeks, but…"),
    replies = { { text = ccb.content.text("But what?"), next_topic = "TALK_ROBOFAC_MERC_1_BACKGROUND_7" } },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_ROBOFAC_MERC_1_BACKGROUND_7", "TALK_ROBOFAC_MERC_1_BACKGROUND_7_1" },
    line = ccb.content.text("March 30th happened.\"  Cranberry seems shaken, and talks a little louder for a second.  \"You remember that video, right?  That was what set off alarm bells in my head.  That shit was fucking scary.  And at that point I realized, okay, I think things are about to get bad and this is for real."),
    replies = {
        { text = ccb.content.text("[Listen.]"), next_topic = "TALK_ROBOFAC_MERC_1_BACKGROUND_8" },
        {
            text = ccb.content.text("I don't remember the video."),
            next_topic = "TALK_ROBOFAC_MERC_1_BACKGROUND_7_1",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_BACKGROUND_7_1",
    line = ccb.content.text("Whoo-ee, someone was living under a rock, huh?  It was all over the news.  Video on YouTube, it was a livestream of one of the riots in Minneapolis.  A mom was…\"  They hesitate.  \"I don't want to go into detail, but it was real bad.  Real bad.  That's what set off people panicking."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_BACKGROUND_8",
    line = ccb.content.text("People started freaking out.  I did, too.  I don't know how bad things got elsewhere, but shit was flying off the shelves where I lived.  Empty racks at grocery stores everywhere you looked.  I had enough food for a few weeks, so it wasn't a problem for me, but it still shook me up bad.  Every day some horrible new shit was happening somewhere in the world, and things got just worse and worse.  Then that insanity with Rhode Island happened, and once the national emergency came out, I knew that okay, this is happening, it's actually happening.\"\n\n\"Did you know that I was still going to work that entire time?  I don't know, it just felt meditative.  I lived in a pretty rural area, so there wasn't the kind of chaos in the cities and congestion on the roads.  I could just take a side road there and have a day of quiet.  Just the woods and whoever else actually bothered to show up that day.  The park closed for visitors closed a day or two before the state of emergency, and it was really peaceful, being there alone."),
    replies = { { text = ccb.content.text("[Listen.]"), next_topic = "TALK_ROBOFAC_MERC_1_BACKGROUND_9" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_BACKGROUND_9",
    line = ccb.content.text("Then the portals happened, and you know the rest from there.  Two days later, the world was over.  There was a lot of chaos in my complex.  I just nailed shut my front door, drew all the curtains, kept my shotgun loaded, and probably slept maybe ten hours total that week.  I don't know if there was someone up in the sky watching over me, but if there was, I sure as hell owe them big time."),
    replies = {
        {
            text = ccb.content.text("How did you get here?"),
            next_topic = "TALK_ROBOFAC_MERC_1_BACKGROUND_10",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_BACKGROUND_10",
    line = ccb.content.text("I kind of lost track of the days.  Every day was the same; eat, check the barricades, look on the Internet, play some games with the sound off to try and distract myself.  I filled up my bathtub, and once the water went out, I'd drink from there with a lifestraw when I needed to hydrate.  Meal planning got easier after I was down to just my canned stuff.  The Internet didn't stay on for long, though, which I guess was a blessing because of how many people were sharing their fear and awful experiences in real time.  I did that routine every day until that emergency broadcast came through that no help was coming, and then I knew it was over."),
    replies = { { text = ccb.content.text("[Listen.]"), next_topic = "TALK_ROBOFAC_MERC_1_BACKGROUND_11" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_BACKGROUND_11",
    line = ccb.content.text("It took a bit for me to muster the nerve to leave, but I wanted to.  Had to see, y'know?  It was… a shock, zombies just walking in the parking lot.  Like, sure, I could look out the window, but it feels different up close.  I had my knife handy, and I didn't want to make too much noise, so that's what I used.  I stabbed one of my dead neighbors in the neck that day.\"  They smile wistfully.  \"I threw up on my shoes after the first one, but it got easier."),
    replies = { { text = ccb.content.text("[Listen.]"), next_topic = "TALK_ROBOFAC_MERC_1_BACKGROUND_12" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_BACKGROUND_12",
    line = ccb.content.text("My truck was still there, and was on half a tank of gas.  I thought, okay, this isn't gonna be easy, but I can pack my food and the things I need to take with me into the truck, and then drive to that building I know about that was so reinforced.\"  They gesture around them.  \"This building.  The Hub.  So I got some stuff into a bugout bag in the cabin and filled up the truck bed, and off I went.  The roads were bad, but I'm not a bad driver.  Zombies are slow."),
    replies = {
        {
            text = ccb.content.text("And the rest is history."),
            next_topic = "TALK_ROBOFAC_MERC_1_BACKGROUND_13",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_BACKGROUND_13",
    line = ccb.content.text("If only, huh?  No, not quite.  About five miles away I hit a bad pothole and skidded off the road and got stuck.  That's not a problem on its own, but a few minutes into trying to get it unstuck, I saw a big furrow of dirt coming towards me and decided, you know what, maybe I should get off the side of the road.  So I grab my bugout bag from the cabin and a little food from the bed, and I book it onto the road.  Now, I don't know what this thing was, but it hit the truck from below and *flipped it over*.  That was enough to make me say 'Nope, I can go on foot.'"),
    replies = { { text = ccb.content.text("[Listen.]"), next_topic = "TALK_ROBOFAC_MERC_1_BACKGROUND_14" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_BACKGROUND_14",
    line = ccb.content.text("It took me a few days from there.  I had a heavy load, and it was slow going.  I slept on the road the first night because I was so freaked out by what I saw, but the day after I got the nerves to walk through the woods.  I had a tent, so it wasn't so bad.  Every now and then, I'd run into a zombie, or a wrecked car that still had some of them buckled in.  I left my shotgun behind in the truck, so I got better at using the knife.  It gets easier, y'know?"),
    replies = { { text = ccb.content.text("[Listen.]"), next_topic = "TALK_ROBOFAC_MERC_1_BACKGROUND_15" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_BACKGROUND_15",
    line = ccb.content.text("A while later, I made it here.  The gate was open, so I just walked right in.  I tried the intercom, but nobody answered, which I'm sure you had happen to you, too.  Then I realize: this building is super reinforced, unlocked, and seems abandoned now.  Why don't I just stay here?  So I set up my stuff in this here lobby and I spend the night there.  Then I try the intercom again."),
    replies = {
        {
            text = ccb.content.text("Did they answer that time?"),
            next_topic = "TALK_ROBOFAC_MERC_1_BACKGROUND_16",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_BACKGROUND_16",
    line = ccb.content.text("Hoo boy, yes they did, and let me tell you, they were not happy campers about me crashing on their couch.  Now, these people don't tell me who they are, but they tell me to get off the premises immediately.  I wasn't having that.  I had been through hell and come out the other end, and I don't remember what I said to them, but it was along the lines of 'I have nowhere to go, and your building is nice and cozy, so if you want me to leave, you can come out here and make me.'\"  They laugh.  \"They weren't expecting me to bite back.  So I turn off the intercom and I go eat lunch.  When I go back again, the first thing they ask is if I want a job."),
    replies = {
        {
            text = ccb.content.text("Just like that?"),
            next_topic = "TALK_ROBOFAC_MERC_1_BACKGROUND_17",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_BACKGROUND_17",
    line = ccb.content.text("Well, no.  It was obvious they just wanted to get rid of me, but I decided I wanted to show that I was useful.  They tell me to find a crashed drone somewhere in the surrounding area and bring it back here.  No directions, of course.  Y'know, go find this drone in the middle of the woods, it'll be easy.  But I had some tools in my bag, right?  And yours truly has repaired some drones in the park service.\"\n\n\"So it takes me a whole-ass afternoon, but I find their stupid drone stuck in a tree.  I can see the camera's still on, so I pick it up and I tell the lens: 'Hey, you want me to fix it too?'  And I do.  It was just a cracked frame and the wiring to the rotors was sliced up.  The propellers themselves were fine.  So I bring it out of the woods and turn it off.  Then I open up the casing, solder up the wires, and use superglue to hold the frame together, which wasn't perfect, but I figured it'd hold until it got back home.  Then I turned it back on, and wouldn't you know, it immediately starts up and sits there for a minute, like 'What the fuck?  Why am I working again?'  And then it flies away, and I walk my smug ass back home."),
    replies = {
        {
            text = ccb.content.text("And *now* the rest is history."),
            next_topic = "TALK_ROBOFAC_MERC_1_BACKGROUND_18",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_BACKGROUND_18",
    line = ccb.content.text("You got it.\"  Cranberry grins.  \"I ask them if their drone got home in one piece, and it did.  They said that my work wasn't bad at all and did a little impromptu interview asking where I learned my skills and how I got to the building.  I got the canned intro of 'we underestimated your usefulness', and like you say, the rest is history.  Now we're here."),
    replies = {
        {
            text = ccb.content.text("That's quite the story.  You seem to be feeling pretty good, in spite of the world ending."),
            next_topic = "TALK_ROBOFAC_MERC_1_BACKGROUND_19",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_BACKGROUND_19",
    line = ccb.content.text("I guess I am, yeah.  It feels nice to be putting all my skills to use instead of working an underpaid job to walk around the same woods flying a quadcopter around and being a glorified PR rep to cranky parents who are only at the park because they promised their kids they'd go.  Mind you, I'd still go back to it if I could.\"  Their expression falters a little.  \"We all had our struggles, but things are different now, you know?  We get to worry about the future in a whole new way; an existential way that we never had to consider before, not really.  Sure, there was the occasional nuke scare, but as a society, we had things pretty good.  Unless the dead stop getting back up, I… don't think things are going to ever go back to normal.\"\n\nCranberry pauses for a moment, then shakes it off.  \"But… right now, I'm feeling at peace with everything, despite it all.  Maybe I'm just in shock, and it'll all come crashing down one of these days.  Things might get worse, and they may never get better.  But I feel alright.  And I think that's enough for me."),
    replies = {
        {
            text = ccb.content.text("Thank you for telling me."),
            next_topic = "TALK_ROBOFAC_MERC_1_BACKGROUND_END",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_BACKGROUND_END",
    line = ccb.content.text("*smiles at you, genuine and warm.  \"It feels nice to tell it.  You're welcome.\""),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "general_robofac_merc_1_heard_backstory", "yes") },
            once = "robofac_merc_1_background_shared",
        },
    },
    replies = {
        { text = ccb.content.text("[Spend a while in silence.]"), next_topic = "TALK_DONE" },
        { text = ccb.content.text("[Leave.]"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_BACKGROUND_NO",
    line = ccb.content.text("I'm sorry, that's a bit personal.  Like, you seem alright, but that's kind of heavy stuff, y'know?  Maybe I can tell you another time."),
    replies = { { text = ccb.content.text("Alright."), next_topic = "TALK_ROBOFAC_MERC_1_MAIN" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_GOLD_MISSION",
    line = ccb.content.text("I guess I am, yeah.  Feels like a stupid fetch quest.\"  They suddenly pause.  \"Hey.  If you happen across any gold out in the world, I'll pay you to bring it back for me.  Right now my assignment stipulates eight scrip per kilo, and I'd be willing to give you all of that.  I just want something else to do.  Just maybe don't mention it to the intercom, alright?  This is supposed to be my job."),
    replies = {
        {
            text = ccb.content.text("You got it.  I'll let you know if I find any gold."),
            actions = { actions.set_actor_value("speaker", "general_robofac_merc_1_has_gold_deal", "yes") },
            next_topic = "TALK_ROBOFAC_MERC_1_GOLD_MISSION_ACCEPTED",
        },
        {
            text = ccb.content.text("Actually, I don't think I have time for that, sorry."),
            next_topic = "TALK_ROBOFAC_MERC_1_MAIN",
        },
    },
}

ccb.content.define_dialogue_topic { id = "TALK_ROBOFAC_MERC_1_GOLD_MISSION_ACCEPTED", line = ccb.content.text("Thanks a lot.") }

ccb.content.define_dialogue_topic {
    id = { "TALK_ROBOFAC_MERC_1_GOLD_MISSION_QUERY", "TALK_ROBOFAC_MERC_1_GOLD_MISSION_TRADE" },
    line = ccb.content.text("Got some gold for me?"),
    replies = {
        {
            text = ccb.content.text("[200 gold] Here's a batch for you."),
            next_topic = "TALK_ROBOFAC_MERC_1_GOLD_MISSION_TRADE",
            when = predicates.has_inventory("speaker", "gold_small", 200),
            actions = { actions.handler("dlg_a_dda_33259372cede") },
        },
        {
            text = ccb.content.text("I don't have 200 gold for you right now."),
            next_topic = "TALK_ROBOFAC_MERC_1_MAIN",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_GOLD_MISSION_TRADE",
    line = {
        choices = {
            ccb.content.text("I appreciate it.  Here's the scrip; don't spend it all in one place."),
            ccb.content.text("Honestly, sometimes I feel like an ATM."),
            ccb.content.text("Thanks.  I never thought I'd get exhausted of carrying pure gold around, but here we are."),
            ccb.content.text("Exchanging my money for goods and services.  Just as the founding fathers intended."),
        },
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "general_robofac_merc_1_gold_mission_complete", "yes"),
                actions.set_actor_value("speaker", "general_robofac_merc_1_helped_with_missions", "yes"),
            },
            once = "robofac_merc_1_first_gold_trade",
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_ROBOFAC_MERC_1_RADIO",
    name = ccb.content.text("Active Noise Control"),
    description = ccb.content.text("Investigate Hub 01's radio tower, discover the source of the interference, and fix the problem."),
    goal = "MGOAL_KILL_MONSTER",
    difficulty = 5,
    value = 0,
    start = {
        target = { terrain = "radio_tower_top", special = "hub_01", reveal_radius = 1 },
        map_updates = {
            { layout = { monster_placements = { { id = "mon_leech_radio", x = 11, y = 4, target = true } } } },
            { layout = { nested = { { x = 0, y = 0, z = -6, id = "robofac_radio_leech" } } } },
        },
        actions = {
            "follow_only",
            ccb.content.dialogue_actions.set_actor_value("interlocutor", "general_robofac_merc_1_temporal_follower", "yes"),
        },
    },
    finish = {
        actions = { ccb.content.dialogue_actions.offer_mission("MISSION_ROBOFAC_MERC_1_RETURN_TO_HUB") },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("…"),
        offer = ccb.content.text("Well… a little while ago, I set up a radio transmitter in the radio tower not far from here, but it stopped transmitting.  I went over there and encountered some crazy stuff you wouldn't believe if you didn't see it yourself:  Some 'plants' moving around, replicating, and attacking me with lightning bolts.  Luckily, the environmental suit I've got from our employers protected me from damage, but fried my electronics.  If you're willing to back me up to eradicate them, I'll owe you a favor.  However, I suggest you turn the mission down and come back when you think you've got sufficient gear."),
        accepted = ccb.content.text("Alright, let's be off, if you think you've got sufficient gear.  You don't mind taking point, right?"),
        rejected = ccb.content.text("Well, thanks for offering.  I hope you'll be able to come back when you've gotten hold of protective gear."),
        advice = ccb.content.text("Get hold of an environmental suit of your own, unless you've got some other protection against electric shocks.  Bring a good weapon and some ammo as well; no idea what insanity <the_cataclysm> has brought us this time, beyond what I saw during my brief encounter."),
        inquire = ccb.content.text("You think we fixed the problem?"),
        success = ccb.content.text("Sure seems like it.  What even was that…?  Eh, doesn't matter.  Let's go back to the Hub; hopefully the tower's working now."),
        success_lie = ccb.content.text("*frowns at you.  \"I've been with you this whole time, dude.  C'mon."),
        failure = ccb.content.text("…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_ROBOFAC_MERC_1_RETURN_TO_HUB",
    name = ccb.content.text("Return to Hub 01"),
    description = ccb.content.text("With the source of the radio tower's interference fixed, return to Hub 01 with Cranberry."),
    goal = "MGOAL_GO_TO_TYPE",
    destination = "robofachq_surface_entrance",
    difficulty = 0,
    value = 0,
    start = {
        target = { terrain = "robofachq_surface_entrance", special = "hub_01", reveal_radius = 1, z = 0 },
    },
    finish = {
        actions = {
            "stop_following",
            { handler = "advance_favor_owed_to_u_robofac_merc_1_favor_by_1" },
            ccb.content.dialogue_actions.clear_actor_value("interlocutor", "general_robofac_merc_1_temporal_follower"),
            ccb.content.dialogue_actions.set_actor_value("speaker", "general_robofac_merc_1_helped_with_missions", "yes"),
            { handler = "reward_robofac_merc_trust" },
            { handler = "reward_robofac_merc_value" },
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("…"),
        offer = ccb.content.text("Let's get back home."),
        accepted = ccb.content.text("Alright, let's be off.  You don't mind taking point, right?"),
        rejected = ccb.content.text("…"),
        advice = ccb.content.text("Hey, you have a map, don't you?  You can use mine, if you need."),
        inquire = ccb.content.text("Are we there yet?"),
        success = ccb.content.text("Thanks a lot for having my back.  Like I said, I owe you one."),
        success_lie = ccb.content.text("…"),
        failure = ccb.content.text("…"),
    },
}
