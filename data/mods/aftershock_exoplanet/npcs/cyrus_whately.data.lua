local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_CYRUS_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_cyrus" } }),
        yes = {
            choices = {
                ccb.content.text("What brings you here today?"),
                ccb.content.text("Hello."),
                ccb.content.text("How are you?"),
                ccb.content.text("Welcome!"),
                ccb.content.text("Are you ready to leave this marble?"),
            },
        },
        no = ccb.content.text("You look like one of my niece's lab assistants."),
    },
    replies = {
        {
            text = ccb.content.text("Who are you?"),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_cyrus", "yes") },
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_cyrus" } })),
            next_topic = "TALK_CYRUS_firstmeet",
        },
        {
            text = ccb.content.text("What is this place?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_cyrus" } }),
            next_topic = "TALK_CYRUS_place",
        },
        {
            text = ccb.content.text("How did you get here?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_cyrus" } }),
            next_topic = "TALK_CYRUS_ask_past",
        },
        {
            text = ccb.content.text("How are things here?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_cyrus" } }),
            next_topic = "TALK_CYRUS_ask_mood",
        },
        {
            text = ccb.content.text("Can I do anything for you?  Are you as crazy as your niece?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_cyrus" } }),
            next_topic = "TALK_MISSION_LIST",
        },
        { text = ccb.content.text("I'm going on my way now."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CYRUS_firstmeet",
    line = ccb.content.text("Are you here because you are morally flexible and willing to take questionable directions from obviously insane people."),
    replies = {
        {
            text = ccb.content.text("Your niece is looking for you."),
            next_topic = "TALK_CYRUS_millyficent",
        },
        {
            text = ccb.content.text("How did you survive the Cataclysm?"),
            next_topic = "TALK_CYRUS_cataclysm",
        },
        { text = ccb.content.text("Quite the setup you have here."), next_topic = "TALK_CYRUS_1" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CYRUS_place",
    line = ccb.content.text("This is a Whately family property.  And you are an intruder."),
    replies = {
        { text = ccb.content.text("I've met your niece."), next_topic = "TALK_CYRUS_millyficent" },
        { text = ccb.content.text("I didn't mean to intrude."), next_topic = "TALK_CYRUS_1" },
        { text = ccb.content.text("I think there's been a mistake."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CYRUS_millyficent",
    line = ccb.content.text("She's always been so precocious!  I knew that she was going places and we'd see great things from her."),
    replies = {
        {
            text = ccb.content.text("She needed a lab assistant, do you?"),
            next_topic = "TALK_MISSION_LIST",
        },
        { text = ccb.content.text("This whole family is deranged."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CYRUS_ask_past",
    line = ccb.content.text("The Whately family has been part of the fabric of New England since before the Revolutionary War.  And I have been growing our interests for the last few decades."),
    replies = { { text = ccb.content.text("Let's talk about something else."), next_topic = "TALK_CYRUS_1" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CYRUS_cataclysm",
    line = ccb.content.text("*muttering.  \"They whispered of a prison.  Ragnarok engine humming.  Wrapped they in darkness dreaming.\"  He shakes himself.  \"Anyway it looks like something woke up, for at least a little bit.\""),
    replies = { { text = ccb.content.text("Let's talk about something else."), next_topic = "TALK_CYRUS_1" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CYRUS_ask_mood",
    line = ccb.content.text("This is a time of great danger and great opportunity and it must not be squandered."),
    replies = { { text = ccb.content.text("This is not reassuring."), next_topic = "TALK_CYRUS_1" } },
}

ccb.content.define_mission {
    id = "MISSION_FRANKENSTEIN_1",
    name = ccb.content.text("In the absence of life"),
    description = ccb.content.text("Find self healing polymers."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 0,
    item = "afs_biomaterial_4",
    item_count = 4,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_FRANKENSTEIN_2",
    dialogue = {
        describe = ccb.content.text("I need 4 self healing polymers from wherever you can find them."),
        offer = ccb.content.text("My experiments are at a critical point.  Could you find about… 4 self healing polymers for me?"),
        accepted = ccb.content.text("Don't forget to tell me when you have them."),
        rejected = ccb.content.text("Then why are you even here?  Just let me know if you reconsider."),
        advice = ccb.content.text("Hospitals, DIY geneticists."),
        inquire = ccb.content.text("Why aren't you done yet?"),
        success = ccb.content.text("My niece shared her research, show me if it works."),
        success_lie = ccb.content.text("Thanks for trying… I guess."),
        failure = ccb.content.text("Put a stopper in death?  No you never will."),
    },
    finish = { item_rewards = { { item = "mutagen_migo", count = 3, container = "bottle_glass" } } },
}

ccb.content.define_mission {
    id = "MISSION_FRANKENSTEIN_2",
    name = ccb.content.text("Making Connections"),
    description = ccb.content.text("I need a neurosynaptic interface matrix."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 6,
    value = 0,
    item = "afs_neural_io_5",
    item_count = 1,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_FRANKENSTEIN_3",
    dialogue = {
        describe = ccb.content.text("I need one neurosynaptic interface matrix."),
        offer = ccb.content.text("I want to test something and I need a viable version to reverse engineer.  Bring me one neurosynaptic interface matrix."),
        accepted = ccb.content.text("Without this all that's possible is 'Ye liveliest awfulness'."),
        rejected = ccb.content.text("You'd give up a new world just to bring back Foodplace!"),
        advice = ccb.content.text("You're going to have to hunt this down."),
        inquire = ccb.content.text("Have you found my matrix?"),
        success = ccb.content.text("Have this."),
        success_lie = ccb.content.text("How could you possibly lie to me about an object you have not put in my hands."),
        failure = ccb.content.text("Do you have any head cybernetics?  I could possibly salvage one out of your skull."),
    },
    finish = { item_rewards = { { item = "afs_energy_storage_4", count = 4 } } },
}

ccb.content.define_mission {
    id = "MISSION_FRANKENSTEIN_3",
    name = ccb.content.text("Alpha Mutagen"),
    description = ccb.content.text("Bring me 3 alpha mutagen."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 4,
    value = 0,
    item = "mutagen_alpha",
    item_count = 3,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_FRANKENSTEIN_4",
    dialogue = {
        describe = ccb.content.text("I need three alpha mutagen."),
        offer = ccb.content.text("I know that one of the corporations were creating a so called Alpha mutagen.  I need three doses to prepare the body."),
        accepted = ccb.content.text("Better living through chemistry."),
        rejected = ccb.content.text("Would you take it yourself?"),
        advice = ccb.content.text("If you can't make it yourself go hit up a lab.  Be prepared for anything in there."),
        inquire = ccb.content.text("Did you get taller since the last time I saw you?"),
        success = ccb.content.text("I've got something more potent for you this time."),
        success_lie = ccb.content.text("Lies and the lying liars who tell them."),
        failure = ccb.content.text("You are keeping me from my experiments.  Would you like to become one?"),
    },
    finish = { item_rewards = { { item = "iv_mutagen_migo", count = 3, container = "bottle_glass" } } },
}

ccb.content.define_mission {
    id = "MISSION_FRANKENSTEIN_4",
    name = ccb.content.text("Broken Cyborg"),
    description = ccb.content.text("We need a strong base for our experiment."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 6,
    value = 0,
    item = "bot_broken_cyborg",
    item_count = 1,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_FRANKENSTEIN_5",
    dialogue = {
        describe = ccb.content.text("I need an unconscious broken cyborg.  They are already brain dead so it won't be murder."),
        offer = ccb.content.text("If you go to labs you should find some broken cyborg experiments.  Bring an inactive one to me."),
        accepted = ccb.content.text("Are you ready for a little necromancy?"),
        rejected = ccb.content.text("I'm telling you they're already brain dead."),
        advice = ccb.content.text("Look for surgical centers inside the labs."),
        inquire = ccb.content.text("So where are my fresh parts?"),
        success = ccb.content.text("I've got something more potent for you this time."),
        success_lie = ccb.content.text("Lies and the lying liars who tell them."),
        failure = ccb.content.text("What kinds of body modifications do you have?"),
    },
    finish = { item_rewards = { { item = "iv_mutagen_migo", count = 3, container = "bottle_glass" } } },
}

-- Sometime consider changing the end effect of this item and making the test site its own quest.
ccb.content.define_mission {
    id = "MISSION_FRANKENSTEIN_5",
    name = ccb.content.text("A-Mi-go, You-go find me some brains"),
    description = ccb.content.text("Find 6 living brains in jars."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 8,
    value = 0,
    item = "living_brain_jar",
    item_count = 2,
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("I need some brains, but brains that are still living.  We've got our own brain blasters, but I won't risk them in experiments."),
        offer = ccb.content.text("If this works I may be able to give some of these poor souls bodies again.  Six should do."),
        accepted = ccb.content.text("I knew I could count on your generosity."),
        rejected = ccb.content.text("I would have given you the title of Whately family Igor."),
        advice = ccb.content.text("Brain blasters, that's what I call them.  Some kind of automated weapon system the mi-go use."),
        inquire = ccb.content.text("They speak sometimes.  I wonder if they still think."),
        success = ccb.content.text("Go somewhere, far away, and then connect the power system.  Come back and tell me how things went."),
        success_lie = ccb.content.text("Thanks for trying… I guess."),
        failure = ccb.content.text("I can't be Dr. Frankenstein unless you get me these."),
    },
    finish = { item_rewards = { { item = "inactive_frankenstein", count = 1 } } },
}
