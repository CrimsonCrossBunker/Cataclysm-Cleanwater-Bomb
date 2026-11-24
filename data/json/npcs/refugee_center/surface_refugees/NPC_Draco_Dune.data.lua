local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- Draco is a middle-aged musician, and generally a pretty nice guy.  He's always been a wanderer and this isn't his first time living basically homeless.
ccb.content.define_npc_class {
    id = "NC_REFUGEE_Draco",
    name = ccb.content.text("Refugee"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    strength = { rng = { -2, 2 } },
    dexterity = { rng = { -1, 2 } },
    intelligence = { rng = { -1, 3 } },
    perception = { rng = { -1, 3 } },
    worn = "REFUGEE_Draco_worn",
    carry = "REFUGEE_Draco_carried",
    weapon = "REFUGEE_Draco_wield",
    traits = {
        { trait = "PRETTY" },
        { trait = "OPTIMISTIC" },
        { trait = "BADBACK" },
        { group = "Appearance_African" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -4 } } } } } },
        },
        { skill = "speech", bonus = { rng = { 2, 3 } } },
        { skill = "swimming", bonus = { rng = { 1, 2 } } },
    },
}

ccb.content.define_npc {
    id = "refugee_DracoDune",
    unique_name = ccb.content.text("Draco Dune"),
    gender = "male",
    suffix = ccb.content.text("Refugee"),
    class = "NC_REFUGEE_Draco",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_REFUGEE_Draco_1",
    faction = "free_merchants",
    missions_offered = "MISSION_REFUGEE_Draco_GET_GUITAR",
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Draco_Dune" } }),
        yes = ccb.content.gendered_line("Always good to see you, friend.", { "speaker" }),
        no = ccb.content.text("Well now, good to see another new face!  Welcome to the center, friend, I'm Draco."),
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "general_meeting_u_met_Draco_Dune", "yes"),
                actions.set_first_topic("TALK_REFUGEE_Draco_1a"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you, Draco."),
            next_topic = "TALK_REFUGEE_Draco_1_firstmeet",
        },
        {
            text = ccb.content.text("Hi Draco, nice to meet you.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_1a",
    line = ccb.content.gendered_line("Always good to see you, friend.", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("Hi, Draco, how are you doing?"),
            next_topic = "TALK_REFUGEE_Draco_2",
            when = predicates.handler("dlg_p_dda_6f5900f35a2a"),
        },
        {
            text = ccb.content.text("Hi again, Draco, nice to see you too."),
            next_topic = "TALK_REFUGEE_Draco_5a",
            when = predicates.handler("dlg_p_dda_dd80a02d9880"),
        },
        {
            text = ccb.content.text("Hi again, Draco, nice to see you too."),
            next_topic = "TALK_REFUGEE_Draco_7",
            when = predicates.handler("dlg_p_dda_0b77d9b346c2"),
        },
        {
            text = ccb.content.text("Hi Draco, nice to see you too.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_1_firstmeet",
    line = ccb.content.text("Nice to meet you too.  What brings you to these parts?  Got any stories to share?  Happy ones, hopefully… we've had our fill of sadness around here."),
    replies = {
        {
            text = ccb.content.text("What about you, how're you doing?"),
            next_topic = "TALK_REFUGEE_Draco_2",
        },
        {
            text = ccb.content.text("Yeah, it's tough everywhere.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_2",
    line = ccb.content.text("Well, look at you.  Asking after random folks like some sort of shepherd!  No, don't take offense now… I mean it well.  We could use more folks askin' after other folks.  I figure it makes the world go round, now, more than ever.  I'm well, friend, considering I have both of my legs and much of my health left to me.  A bit of pain in the back, but can't really complain much if that's the worst of it, right?  You look like you've had a story of your own to tell, just getting here.  I'm writing it in my imagination right now.  Fought through countless hordes, run ragged, chased at every turn, yeah, no thank-you any more of that for me!"),
    replies = {
        {
            text = ccb.content.text("What about you, what's your story?"),
            next_topic = "TALK_REFUGEE_Draco_3",
            actions = { actions.handler("dlg_a_dda_4776232023da") },
        },
        {
            text = ccb.content.text("No more indeed."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_3",
    line = ccb.content.text("Oh you don't have time for all that, do you?  Well, I'll give you the short version.  I've gotten kinda tired of it in the telling.  Frankly, it's not as heroic, not as inspiring, not as tragic, and certainly not as funny as some of the tales around here.  But it's mine, ya know?  I'm a musician.  Guitar's my baby.  You like folk and the blues, friend?  Well, that was my bag and I sure could please my own ear with em, anyway.  Folks who's bein' generous might also say it pleased theirs.  Problem is, I seem to be between guitars right now, you know?  Temporarily guitar-light, if you get my saying.  Problem is, in the run for my life, I had to use old Jasmine as a bit of a billy club.  Had to curb some rowdy dudes on my way here.  It was her or me, you understand?  You wouldn't begrudge a man breakin' his instrument to save his life, would ya?"),
    replies = {
        {
            text = ccb.content.text("I think I would've done the same.  Nobody around here has a guitar?"),
            next_topic = "TALK_REFUGEE_Draco_4",
        },
        { text = ccb.content.text("Yes, yes I would… you monster."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_4",
    line = ccb.content.text("Would you believe that they don't!  Not a one in the whole place.  Well, maybe downstairs, but that's a different matter, isn't it?  Say, you're not planning on sticking around, right?  You're a free-roller, not a settler, seems like to me.  Don't know if I could beg or cajole you into maybe keepin' an ear out for a new guitar for me?  There gotta still be plenty out there not gettin' any love these days.  Whattya say?  Help an old man play some blues?  Would be good to have some real music around this place.  Be good for PEOPLE, you know what I'm sayin'?"),
    replies = {
        {
            text = ccb.content.text("Where would we be without music?"),
            next_topic = "TALK_REFUGEE_Draco_5a",
        },
        {
            text = ccb.content.text("You're aware that the world has ended, right?  I've got real problems to deal with.  You're on your own."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_5a",
    line = ccb.content.text("Let me ask you something.  What type are you?"),
    replies = {
        { text = ccb.content.text("Uhh, what do you mean?"), next_topic = "TALK_REFUGEE_Draco_5b" },
        {
            text = ccb.content.text("I'll tell you what type I am."),
            next_topic = "TALK_REFUGEE_Draco_5c",
        },
        { text = ccb.content.text("No, not playing this game."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_5b",
    line = ccb.content.text("You know, what kinda person are you?  What motivates you?"),
    replies = {
        {
            text = ccb.content.text("I'll tell you what type I am."),
            next_topic = "TALK_REFUGEE_Draco_5c",
        },
        { text = ccb.content.text("Leaving."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_5c",
    line = ccb.content.text("So then, what type are you?"),
    replies = {
        {
            text = ccb.content.text("The 'just getting by' type."),
            next_topic = "TALK_REFUGEE_Draco_6a",
        },
        { text = ccb.content.text("The serious type."), next_topic = "TALK_REFUGEE_Draco_6b" },
        { text = ccb.content.text("The zany type."), next_topic = "TALK_REFUGEE_Draco_6c" },
        { text = ccb.content.text("I fight stuff."), next_topic = "TALK_REFUGEE_Draco_6d" },
        { text = ccb.content.text("I want to see it all."), next_topic = "TALK_REFUGEE_Draco_6e" },
        {
            text = ccb.content.text("The 'doesn't have time for this' type."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_6a",
    line = ccb.content.text("Me too!  You can understand how folks be wantin' some liveliness in these times.  Some music sure would help with that.  Damn, I miss it.  All I hear is those MP3 players with their tin-can drum machines and whiny vocals.  Help me find a guitar and we'll really get this place smokin'!"),
    replies = {
        { text = ccb.content.text("I could be persuaded."), next_topic = "TALK_REFUGEE_Draco_7" },
        {
            text = ccb.content.text("It's called dub-step and I like it.  Goodbye, old man."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_6b",
    line = ccb.content.text("Me too!  Times are hard for folks and that's no laughing matter.  People need some normality in these times.  Some reminders of how things used to be.  I think a sing-along or two could do folks good."),
    replies = {
        { text = ccb.content.text("Couldn't hurt."), next_topic = "TALK_REFUGEE_Draco_7" },
        {
            text = ccb.content.text("I don't need to hear amateur-hour karaoke around here.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_6c",
    line = ccb.content.text("Me too!  I did stand-up comedy at a club once.  Well, outside a club anyway.  You know what'd be funny?  Next time one of those stupid ferals starts running around chasing after a squirrel or something, if I had me a guitar I could play the Benny Hill tune and get everybody crackin' up.  Places needs some laughter badly."),
    replies = {
        { text = ccb.content.text("That'd be awesome."), next_topic = "TALK_REFUGEE_Draco_7" },
        {
            text = ccb.content.text("Yeah, wouldn't be so funny when Zed heard all the sound and broke in.  Be responsible."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_6d",
    line = ccb.content.text("Me too.  It's fight a stay afloat in these times.  Some music would lift all spirits, though, don't you think?"),
    replies = {
        {
            text = ccb.content.text("Can you play heavy metal on an acoustic guitar?"),
            next_topic = "TALK_REFUGEE_Draco_7",
        },
        {
            text = ccb.content.text("Boring.  I'm going to go destroy something."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_6e",
    line = ccb.content.text("Me too!  For now, anyway, that's not really possible for me.  I mean, I guess you know better than me about that.  Man, I used to travel all around.  Saw halfa the States with my guitar on my back.  Now, though, well, I think I'll stay inside til this all flies over."),
    replies = {
        {
            text = ccb.content.text("Maybe I could help with something?"),
            next_topic = "TALK_REFUGEE_Draco_7",
        },
        {
            text = ccb.content.text("Well then, I'll leave you here where it's safe."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_7",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_mission_NC_REFUGEE_Draco_has_guitar" } }),
        yes = ccb.content.gendered_line("My savior!  My patron of the arts!  You're always welcome here, friend.", { "speaker" }),
        no = ccb.content.text("Man, just imagine what I could do with a new guitar."),
    },
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_e06c65c8caa1") } },
    },
    replies = {
        {
            text = ccb.content.text("Let's talk about getting you that guitar."),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_mission_NC_REFUGEE_Draco_has_guitar" } })),
        },
        {
            text = ccb.content.text("I've been thinking about that deal you mentioned."),
            next_topic = "TALK_REFUGEE_Draco_10_approve",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_barter_NC_REFUGEE_Draco_offered_weed_deal" } }),
        },
        {
            text = ccb.content.text("Anything you buying or selling, by chance?"),
            next_topic = "TALK_REFUGEE_Draco_8",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_barter_NC_REFUGEE_Draco_offered_weed_deal" } })),
            actions = { actions.set_actor_value("speaker", "general_barter_NC_REFUGEE_Draco_offered_weed_deal", "yes") },
        },
        {
            text = ccb.content.text("Do you know any tunes good to dance to?"),
            next_topic = "TALK_REFUGEE_Draco_Dance",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_mission_NC_REFUGEE_Draco_has_guitar" } }),
        },
        {
            text = ccb.content.text("See you around, Draco."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_8",
    line = ccb.content.text("Well now, my friend-o!  You just asked a mighty fine question.  Folks have been missing the little things in life.  New shoes, new cellphones, can't exactly go shopping, or, well, I guess you sorta can, if you mind the broken glass.  I left my wallet in an outdoorsman's store when I 'bought' this warmer coat.  Figured that's kinda it, you know?  It didn't matter anymore.  I don't think my insurance's going to pay out for any health care I get now.  I did what you see in the movies though, I rolled a joint with a hundred dollar bill.  Ended up coughing and rerolling it in regular paper though.  Was too harsh.  Just letting you know in case you get the smart idea of trying it."),
    replies = { { text = ccb.content.text("Go on."), next_topic = "TALK_REFUGEE_Draco_9" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_9",
    line = ccb.content.text("Say, I don't mean to get you in any trouble or nothing, if any folks still care about that, but you haven't seen any green around town, have ya?"),
    replies = {
        {
            text = ccb.content.text("What?"),
            next_topic = "TALK_REFUGEE_Draco_10_question",
        },
        {
            text = ccb.content.text("WHAT."),
            next_topic = "TALK_REFUGEE_Draco_10_disapprove",
        },
        {
            text = ccb.content.text("Oh yeah, some people've been growing it in their basements."),
            next_topic = "TALK_REFUGEE_Draco_10_approve",
            actions = { actions.handler("dlg_a_dda_4776232023da") },
        },
        {
            text = ccb.content.text("I'm not comfortable with where this is going."),
            next_topic = "TALK_REFUGEE_Draco_10_disapprove",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_10_question",
    line = ccb.content.gendered_line("Where you say you're from again?  You're not as worldly as you look.  I'm talking about weed.  Marijuana.  Wondered if you've happened upon any.", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("Oh.  Uh, sure."),
            next_topic = "TALK_REFUGEE_Draco_10_approve",
        },
        {
            text = ccb.content.text("Right, of course I knew that!  There's tons of the stuff out there for the taking."),
            next_topic = "TALK_REFUGEE_Draco_10_approve",
            actions = { actions.handler("dlg_a_dda_4776232023da") },
        },
        {
            text = ccb.content.text("Nope, sorry."),
            next_topic = "TALK_REFUGEE_Draco_10_hasnt_found_weed",
        },
        {
            text = ccb.content.text("I'm not doing this."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_10_disapprove",
    line = ccb.content.text("Hey, don't get all serious on me all of a sudden.  It helps me relax.  Lubricates my joints.  Eases the pain, ya know?  Makes every day a bit more bearable."),
    replies = {
        {
            text = ccb.content.text("I can help."),
            next_topic = "TALK_REFUGEE_Draco_10_approve",
            actions = { actions.handler("dlg_a_dda_4776232023da") },
        },
        {
            text = ccb.content.text("Find somebody else, dude."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_10_approve",
    line = {
        when = predicates.has_effect("interlocutor", "u_sold_to_Draco"),
        yes = ccb.content.text("Yeah, no worries, though.  I'm good at the moment.  Ask me again later and maybe I'll have scrounged up some more cash for you."),
        no = ccb.content.text("Amazing!  My lucky day.  Let's see here.  What can I offer… I can scrounge up some merch bucks for, say, five joints or joints-worth of the good stuff."),
    },
    replies = {
        {
            text = ccb.content.text("You have yourself a deal.  Here's the marijuana."),
            next_topic = "TALK_REFUGEE_Draco_10_sold",
            when = predicates.all({ predicates.has_inventory("speaker", "weed", 5), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_mission_NC_REFUGEE_Draco_has_guitar" } })), predicates.negate(predicates.has_effect("interlocutor", "u_sold_to_Draco")) }),
            actions = { actions.transfer_items("weed", 5), actions.handler("dlg_a_dda_9fa754efa91b"), actions.add_effect("interlocutor", "u_sold_to_Draco", { turns = 240000 }) },
        },
        {
            text = ccb.content.text("You have yourself a deal.  Here's the marijuana."),
            next_topic = "TALK_REFUGEE_Draco_10_sold",
            when = predicates.all({ predicates.has_inventory("speaker", "weed", 5), predicates.any_equal({ "yes", { scope = "speaker", key = "general_mission_NC_REFUGEE_Draco_has_guitar" } }), predicates.negate(predicates.has_effect("interlocutor", "u_sold_to_Draco")) }),
            actions = { actions.transfer_items("weed", 5), actions.handler("dlg_a_dda_16fda14fd72a"), actions.add_effect("interlocutor", "u_sold_to_Draco", { turns = 200000 }) },
        },
        {
            text = ccb.content.text("You have yourself a deal.  Here's some joints."),
            next_topic = "TALK_REFUGEE_Draco_10_sold",
            when = predicates.all({ predicates.has_inventory("speaker", "joint", 5), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_mission_NC_REFUGEE_Draco_has_guitar" } })), predicates.negate(predicates.has_effect("interlocutor", "u_sold_to_Draco")) }),
            actions = { actions.transfer_items("joint", 5), actions.handler("dlg_a_dda_9fa754efa91b"), actions.add_effect("interlocutor", "u_sold_to_Draco", { turns = 240000 }) },
        },
        {
            text = ccb.content.text("You have yourself a deal.  Here's some joints."),
            next_topic = "TALK_REFUGEE_Draco_10_sold",
            when = predicates.all({ predicates.has_inventory("speaker", "joint", 5), predicates.any_equal({ "yes", { scope = "speaker", key = "general_mission_NC_REFUGEE_Draco_has_guitar" } }), predicates.negate(predicates.has_effect("interlocutor", "u_sold_to_Draco")) }),
            actions = { actions.transfer_items("joint", 5), actions.handler("dlg_a_dda_16fda14fd72a"), actions.add_effect("interlocutor", "u_sold_to_Draco", { turns = 200000 }) },
        },
        {
            text = ccb.content.text("Oh, alright.  I'll be back later with the goods."),
            next_topic = "TALK_REFUGEE_Draco_7",
        },
        {
            text = ccb.content.text("On second thought, maybe later."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_10_hasnt_found_weed",
    line = ccb.content.text("Well, let me know when you have.  I'm not going anywhere."),
    replies = {
        { text = ccb.content.text("Sure."), next_topic = "TALK_REFUGEE_Draco_10_approve" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_REFUGEE_Draco_7",
        },
        { text = ccb.content.text("I'm not your drug dealer, buddy."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_10_sold",
    line = ccb.content.gendered_line("Sold!  Thanks for helping me out, friend.", { "speaker" }),
    replies = {
        { text = ccb.content.text("No problem, Draco."), next_topic = "TALK_REFUGEE_Draco_7" },
        { text = ccb.content.text("You're welcome.  <end_talking_bye>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_Dance",
    line = ccb.content.gendered_line("Sure thing, friend!  Let's see how you can move to this one.", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("Just a sec, got something I need to do first."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("[Shuffle back and forth a little.]"),
            next_topic = "TALK_REFUGEE_Draco_Dance_1",
            when = predicates.handler("dlg_p_dda_a34118e38e05"),
            switch = true,
        },
        {
            text = ccb.content.text("[Do a little dance.]"),
            next_topic = "TALK_REFUGEE_Draco_Dance_2",
            when = predicates.handler("dlg_p_dda_9623c8d7a546"),
            switch = true,
        },
        {
            text = ccb.content.text("[Perform a decent dance.]"),
            next_topic = "TALK_REFUGEE_Draco_Dance_3",
            when = predicates.handler("dlg_p_dda_f008b74ca526"),
            switch = true,
        },
        {
            text = ccb.content.text("[Perform an impressive dance.]"),
            next_topic = "TALK_REFUGEE_Draco_Dance_4",
            when = predicates.handler("dlg_p_dda_507a9328c34f"),
            switch = true,
        },
        {
            text = ccb.content.text("[Perform a masterful dance.]"),
            next_topic = "TALK_REFUGEE_Draco_Dance_5",
            when = predicates.handler("dlg_p_dda_228162772555"),
            switch = true,
        },
        {
            text = ccb.content.text("[Perform a legendary dance.]"),
            next_topic = "TALK_REFUGEE_Draco_Dance_6",
            when = predicates.handler("dlg_p_dda_e3c0424690ab"),
            switch = true,
            default = true,
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_Dance_1",
    line = ccb.content.text("Not in the mood to dance, huh?  Or perhaps you should try wearing something less encumbering.  You know, if you want to."),
    replies = {
        {
            text = ccb.content.text("I'll consider it.  Thanks for the tunes."),
            next_topic = "TALK_REFUGEE_Draco_7",
        },
        { text = ccb.content.text("Thanks, later."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_Dance_2",
    line = ccb.content.text("Ah yes, that's the spirit!  This place could sure use more dancing."),
    replies = {
        { text = ccb.content.text("Cheers!"), next_topic = "TALK_REFUGEE_Draco_7" },
        { text = ccb.content.text("Cheers!  <end_talking_bye>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_Dance_3",
    line = ccb.content.gendered_line("Oh my, am I dealing with a professional dancer here?  Sweet moves, friend.", { "speaker" }),
    replies = {
        { text = ccb.content.text("Thanks!"), next_topic = "TALK_REFUGEE_Draco_7" },
        { text = ccb.content.text("Cheers!  <end_talking_bye>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_Dance_4",
    line = ccb.content.text("Oh my oh my.  That was impressive!  Sweet moves!"),
    replies = {
        { text = ccb.content.text("Thanks!"), next_topic = "TALK_REFUGEE_Draco_7" },
        { text = ccb.content.text("Cheers!  <end_talking_bye>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_Dance_5",
    line = ccb.content.gendered_line("Daym.  You're probably the best dancer I've ever had the honor of meeting.  Well done.  Well done indeed.", { "speaker" }),
    replies = {
        { text = ccb.content.text("Thanks!"), next_topic = "TALK_REFUGEE_Draco_7" },
        { text = ccb.content.text("Cheers!  <end_talking_bye>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_Dance_6",
    line = ccb.content.text("Oh wow.  I didn't even know the human body could move like that.  I don't know what to say.  That was amazing!"),
    replies = {
        { text = ccb.content.text("Thanks!"), next_topic = "TALK_REFUGEE_Draco_7" },
        { text = ccb.content.text("Cheers!  <end_talking_bye>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_mission {
    id = "MISSION_REFUGEE_Draco_GET_GUITAR",
    name = ccb.content.text("Bring an acoustic guitar"),
    difficulty = 1,
    value = 0,
    goal = "MGOAL_FIND_ITEM",
    item = "acoustic_guitar",
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    finish = {
        handler = {
            "mark_general_mission_NC_REFUGEE_Draco_has_guitar",
            "advance_counter_refugee_center_refugee_happiness_by_2",
        },
    },
    dialogue = {
        describe = ccb.content.text("Yeah, sure, imagine how things would be if we had some live music around here?  I don't know how much I could thank you, though, if you're looking for payment.  You'd sure be improving the mood, though."),
        offer = ccb.content.text("I just want a functional acoustic guitar.  Preferably one that hasn't been used to cave in any zombie skulls."),
        accepted = ccb.content.text("Great!  We'll be makin' music in no time!"),
        rejected = ccb.content.text("Oh well.  I understand your reluctance… I guess."),
        advice = ccb.content.text("Well, I'll let you in on a little secret.  Guitars COULD be found at a music store.  Let that one sink in a bit."),
        inquire = ccb.content.text("How's my guitar comin', friend?"),
        success = ccb.content.text("Hell yeah, bud!  You just made a lot of people really happy!  In thanks, I'll have enough cash to offer you more recompense for our little dealings."),
        success_lie = ccb.content.text("Huh.  This… is something, isn't it."),
        failure = ccb.content.text("No worries.  They don't grow from trees, but we have time."),
    },
}
