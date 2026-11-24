local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- A rural holdout survivor willing to trade items
ccb.content.define_npc {
    id = "RURAL_HOLDOUT_TRADER",
    class = "NC_COWBOY",
    attitude = 0,
    suffix = ccb.content.text("Survivor cowboy"),
    mission = "GUARD",
    chat = "TALK_COWBOYT_MAIN",
    missions_offered = "MISSION_COWBOYT_SHOTGUN",
    faction = "no_faction",
}

ccb.content.define_dialogue_topic {
    id = "TALK_COWBOYT_MAIN",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cowboyt" } }),
        yes = ccb.content.text("Hey there."),
        no = ccb.content.text("Hey!  Who goes there?"),
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "dialogue_first_meeting_talked_to_cowboyt", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Just another survivor.  What are you doing here?"),
            next_topic = "TALK_COWBOYT_INTRODUCTION",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cowboyt" } })),
        },
        {
            text = ccb.content.text("I'm you, from the future.  I've come to warn you."),
            next_topic = "TALK_COWBOYT_JOKE",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cowboyt" } })),
        },
        {
            text = ccb.content.text("I am a ghost.  I died here 37 years ago, yet I cannot depart this mortal realm."),
            next_topic = "TALK_COWBOYT_JOKE",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cowboyt" } })),
        },
        {
            text = ccb.content.text("What did you before all this?"),
            next_topic = "TALK_COWBOYT_BACKGROUND",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cowboyt" } }),
        },
        {
            text = ccb.content.text("Is there something I can help you with?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cowboyt" } }),
        },
        {
            text = ccb.content.text("How about we travel together?"),
            next_topic = "TALK_COWBOYT_FOLLOW",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cowboyt" } }),
        },
        {
            text = ccb.content.text("See you around."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cowboyt" } }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COWBOYT_BACKGROUND",
    line = ccb.content.text("Worked as a salesman - high end farming equipment.  Now I know, it may not sound that fancy, but you'd be shocked at how pricy those machines can get.  I was lucky enough to be on a fairly remote farm when everything went to shit.  In a way, being a salesman saved me and the experience from the job might allow me to make a living in the apocalypse, bartering for gear and trinkets, so I got that going for me, I suppose."),
    replies = {
        {
            text = ccb.content.text("Speaking of which, I'd like to see your wares."),
            next_topic = "TALK_NONE",
            native_actions = { "start_trade" },
        },
        { text = ccb.content.text("Not a bad way to live."), next_topic = "TALK_NONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COWBOYT_JOKE",
    line = ccb.content.text("Hah, real cute.  Seem the End times didn't take your sense of humor, eh, stranger?"),
    replies = {
        {
            text = ccb.content.text("I have my moments.  So what are you doing here?"),
            next_topic = "TALK_COWBOYT_INTRODUCTION",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COWBOYT_INTRODUCTION",
    line = ccb.content.text("Ah, not much really.  Passing through, trying to make a living by trading with folk.  If you're interested, I got a lot of good things on sale, stranger."),
    replies = {
        {
            text = ccb.content.text("You do?  Let me take a look."),
            next_topic = "TALK_DONE",
            native_actions = { "start_trade" },
        },
        { text = ccb.content.text("I see."), next_topic = "TALK_COWBOYT_MAIN" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COWBOYT_FOLLOW",
    line = ccb.content.text("You seem like a decent sort, but I'm not really looking for company right now.  Think I'm better off on my own."),
    replies = {
        { text = ccb.content.text("If you think so."), next_topic = "TALK_NONE" },
        { text = ccb.content.text("Fair enough.  <end_talking_bye>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_mission {
    id = "MISSION_COWBOYT_SHOTGUN",
    name = ccb.content.text("Obtain a Remington 870 Express shotgun"),
    goal = "MGOAL_FIND_ITEM",
    item = "remington_870_express",
    difficulty = 2,
    value = 40000,
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("Well, now that you mention it…"),
        offer = ccb.content.text("You see, some time ago, I ran into this guy who offered me a substantial payment in exchange for a Remington 870 Express.  I asked if he'd like another weapon, since nowadays, any gun will do, but for some reason, he's dead set on that particular model.  If you could obtain one for me, well, I'd be quite grateful."),
        accepted = ccb.content.text("Great!  Let me know when you get it, and I'll try to get in touch with him."),
        rejected = ccb.content.text("Suit yourself.  Ain't a rush."),
        advice = ccb.content.text("Well, a gun store is a solid bet, but the model is common enough.  Maybe you can find one in a police station, or a store with hunting gear."),
        inquire = ccb.content.text("Any news on that Remington?"),
        success = ccb.content.text("Fantastic!  I'll try and get it to the buyer, if he's still alive.  If not, well, still a good gun to sell.  Now, how would you like to be compensated?"),
        success_lie = ccb.content.text("How did you even get this option to display the hell."),
        failure = ccb.content.text("Then where is it?"),
    },
}
