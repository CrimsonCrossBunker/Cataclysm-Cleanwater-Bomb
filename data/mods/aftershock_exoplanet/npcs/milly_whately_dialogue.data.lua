local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_Millyficent_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_millyficent" } }),
        yes = {
            choices = {
                ccb.content.text("What did you bring me?"),
                ccb.content.text("Hello."),
                ccb.content.text("How are you?"),
                ccb.content.text("Welcome!"),
                ccb.content.text("Do you smell something?"),
            },
        },
        no = ccb.content.text("New test subjects!  I'm so glad you showed up!"),
    },
    replies = {
        {
            text = ccb.content.text("Who are you?"),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_millyficent", "yes") },
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_millyficent" } })),
            next_topic = "TALK_millyficent_firstmeet",
        },
        {
            text = ccb.content.text("What is this place?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_millyficent" } }),
            next_topic = "TALK_millyficent_place",
        },
        {
            text = ccb.content.text("How did you get here?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_millyficent" } }),
            next_topic = "TALK_millyficent_ask_past",
        },
        {
            text = ccb.content.text("How are things here?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_millyficent" } }),
            next_topic = "TALK_millyficent_ask_mood",
        },
        {
            text = ccb.content.text("Can I do anything for you?  Do I want to?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_millyficent" } }),
            next_topic = "TALK_MISSION_LIST",
        },
        { text = ccb.content.text("I'm going on my way now."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_millyficent_firstmeet",
    line = ccb.content.text("Millyficent Whately.  I'm so glad you finally arrived.  It's been a while since I last received new lab partners."),
    replies = {
        {
            text = ccb.content.text("I'm so hungry, can you help me?"),
            next_topic = "TALK_millyficent_food",
        },
        {
            text = ccb.content.text("You are aware of the Cataclysm?"),
            next_topic = "TALK_millyficent_cataclysm",
        },
        { text = ccb.content.text("I am your new lab partner."), next_topic = "TALK_Millyficent_1" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_millyficent_place",
    line = ccb.content.text("Welcome to my lab!  Here we explore the boundaries of the possible beyond the reach of small minds."),
    replies = {
        {
            text = ccb.content.text("Can you give me something to eat then?"),
            next_topic = "TALK_millyficent_food",
        },
        { text = ccb.content.text("Oh, okay."), next_topic = "TALK_Millyficent_1" },
        { text = ccb.content.text("I think there's been a mistake."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_millyficent_food",
    line = ccb.content.text("No, no, no!  No food without successfully completed experiments.  We mustn't break the contract!"),
    replies = {
        { text = ccb.content.text("What do I have to do?"), next_topic = "TALK_MISSION_LIST" },
        { text = ccb.content.text("I don't think you are well."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_millyficent_ask_past",
    line = ccb.content.text("Well after I did my graduate thesis on theoretical xenobiology the government hired me to join the most interesting program.  Yes there were deaths but we learned so much."),
    replies = {
        {
            text = ccb.content.text("Let's talk about something else."),
            next_topic = "TALK_Millyficent_1",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_millyficent_cataclysm",
    line = ccb.content.text("What I know is that I pay well for test subjects and I deliver results and at this rate we will not be releasing on time!"),
    replies = {
        {
            text = ccb.content.text("Let's talk about something else."),
            next_topic = "TALK_Millyficent_1",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_millyficent_ask_mood",
    line = ccb.content.text("Ever since they moved me to my own lab my research has progressed so much faster."),
    replies = { { text = ccb.content.text("This is not reassuring."), next_topic = "TALK_Millyficent_1" } },
}

ccb.content.define_mission {
    id = "MISSION_migo_biology_1",
    name = ccb.content.text("Mi-go biology"),
    description = ccb.content.text("Find fetid goop."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 0,
    item = "fetid_goop",
    item_count = 14,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_migo_biology_2",
    dialogue = {
        describe = ccb.content.text("I need 14 fetid goops from mi-go locations."),
        offer = ccb.content.text("My experiments are at a critical point.  Could you find about… 14 fetid goops for me?"),
        accepted = ccb.content.text("Don't forget to tell me when you have them."),
        rejected = ccb.content.text("Then why are you even here?  Just let me know if you reconsider."),
        advice = ccb.content.text("Find a mi-go base, find a way inside, smash things until you find what I need."),
        inquire = ccb.content.text("Why aren't you done yet?"),
        success = ccb.content.text("Taste this."),
        success_lie = ccb.content.text("Thanks for trying… I guess."),
        failure = ccb.content.text("You are holding back the evolution of the human race."),
    },
    finish = { item_rewards = { { item = "mutagen_migo", count = 1, container = "flask_glass" } } },
}

ccb.content.define_mission {
    id = "MISSION_migo_biology_2",
    name = ccb.content.text("Mi-go Resin"),
    description = ccb.content.text("Find 50 chunks of mi-go resin."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 6,
    value = 0,
    item = "resin_chunk",
    item_count = 50,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_migo_biology_3",
    dialogue = {
        describe = ccb.content.text("I need 50 chunks of mi-go resin."),
        offer = ccb.content.text("I need to understand more about their environment and how they create it.  This research wasn't even possible previously.  Bring me fifty chunks of mi-go resin."),
        accepted = ccb.content.text("My notes suggest that their building materials are alive.  I need you to help me confirm that."),
        rejected = ccb.content.text("You can't just walk away from this.  We're changing the world!"),
        advice = ccb.content.text("Find their buildings, jackhammer them.  What did you do before the world changed for the better, cold call salesman?"),
        inquire = ccb.content.text("Have you found my resin?"),
        success = ccb.content.text("Drink this."),
        success_lie = ccb.content.text("Did you act on Broadway?  Because I bet that skill isn't useful anymore."),
        failure = ccb.content.text("I wonder if I could trade you to them for what I need?"),
    },
    finish = { item_rewards = { { item = "mutagen_migo", count = 1, container = "flask_glass" } } },
}

ccb.content.define_mission {
    id = "MISSION_migo_biology_3",
    name = ccb.content.text("Mutagen"),
    description = ccb.content.text("Bring me 3 mutagen."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 3,
    value = 0,
    item = "mutagen",
    item_count = 3,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_migo_biology_4",
    dialogue = {
        describe = ccb.content.text("I need three mutagen."),
        offer = ccb.content.text("I need some mutagen and I don't want to spend the time making it myself.  Bring me three doses, if you would be so kind."),
        accepted = ccb.content.text("Mutagen makes the world go round, it's definitely more valuable than love."),
        rejected = ccb.content.text("Are you scared of where I'm taking you?"),
        advice = ccb.content.text("If you can't make it yourself go hit up a government lab.  Be prepared for anything in there."),
        inquire = ccb.content.text("Mutagen?  Why are you in front of me if not?"),
        success = ccb.content.text("I've got something more potent for you this time."),
        success_lie = ccb.content.text("Lies and the lying liars who tell them."),
        failure = ccb.content.text("You are keeping me from my experiments.  Would you like to become one?"),
    },
    finish = { item_rewards = { { item = "iv_mutagen_migo", count = 1, container = "flask_glass" } } },
}

ccb.content.define_mission {
    id = "MISSION_migo_biology_4",
    name = ccb.content.text("Humming Hearts"),
    description = ccb.content.text("Find 2 humming hearts."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 8,
    value = 0,
    item = "humming_heart",
    item_count = 2,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_FIND_CYRUS",
    dialogue = {
        describe = ccb.content.text("Parts, parts, parts.  Bring me some hearts."),
        offer = ccb.content.text("The Whately's are known in these parts for gathering body parts.  Ha!  That's just rumors and hearsay.  But I do need two humming hearts."),
        accepted = ccb.content.text("I have some relatives you should meet, if you don't mind hard work for the advancement of science."),
        rejected = ccb.content.text("Even I understand this is dangerous."),
        advice = ccb.content.text("Brain blasters, that's what I call them.  Some kind of automated weapon system the mi-go use."),
        inquire = ccb.content.text("They speak sometimes.  I wonder if they still think."),
        success = ccb.content.text("Let's see what improvements we can divine from these beauties."),
        success_lie = ccb.content.text("Thanks for trying… I guess."),
        failure = ccb.content.text("I can't be Dr. Frankenstein unless you get me these."),
    },
    finish = { item_rewards = { { item = "mutagen_migo", count = 3, container = "bottle_glass" } } },
}

ccb.content.define_mission {
    id = "MISSION_FIND_CYRUS",
    name = ccb.content.text("Find my great uncle Cyrus Whately"),
    description = ccb.content.text("Cyrus and his family were poorly liked even for Whately's before the end of the world.  They went so far off grid that they may not even know anything has changed.  I need to know he's alive and where his research has taken him."),
    goal = "MGOAL_TALK_TO_NPC",
    difficulty = 2,
    value = 150000,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("My great uncle Cyrus had an unconventional relationship with both his neighbors and the mi-go before the Cataclysm.  I'd like to know where he has gotten with his research since I haven't heard from him in years."),
        offer = ccb.content.text("Can you go find my uncle and let him know where I am?"),
        accepted = ccb.content.text("Of course you said yes, you want to know what he's found just as much as I do!"),
        rejected = ccb.content.text("Oh well.  I was hoping to teach you some new things, so you could start your own experiments."),
        advice = ccb.content.text("I've given you directions to that branch of the family's bunker.  Yes I said bunker did you think he'd be in a tower?"),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Thanks, now that he knows I'm here he's sent some of my cousins.  Now that I have more disposable help, take a copy of my early research."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("I hope he didn't meet Leandrus' fate…"),
    },
    start = {
        target = {
            terrain = "whately_lmoe_under_first_floor",
            special = "Strange LMOE Shelter",
            z = 0,
            reveal_radius = 3,
            must_see = false,
            random = true,
            search_range = 180,
        },
        map_updates = {
            { layout = { npc_placements = { { id = "cyrus_whately", x = 11, y = 10, target = true } } } },
        },
    },
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = { item_rewards = { { item = "millyficents_diary", count = 1 } } },
}
