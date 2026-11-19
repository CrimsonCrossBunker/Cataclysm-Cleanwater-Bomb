local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_Liam_CHAT",
    line = {
        choices = {
            ccb.content.text("Sure.  Can I tell you about this idea I had for a comic I'm never gonna make?"),
            ccb.content.text("Lately I've been thinking about my Steam library and all those games I was putting off for a bad time.  Now it's a bad time and I can't play 'em.  Tragedy of our era, right?"),
            ccb.content.text("You remember that girl from high school I had that huge crush on?  Emily?  I wonder if she's still alive.  I shoulda asked her out."),
            ccb.content.text("Aw dude.  I was just remembering about this crowdfunded board game I backed right before things went to hell.  It'd be fulfilling right about now, I bet."),
            ccb.content.text("Does it ever seem to you like the stars are in different places from where they used to be?  I can find all the old constellations, but they look different now."),
            ccb.content.text("Since everything went down, I keep having this recurring dream where I'm at Foodplace again, and Luke Skywalker is there, demanding an EB2 combo with extra Beverage, and he's being a real Karen about it.  Do you think it means something?"),
            ccb.content.text("Maybe it's weird but this whole thing sorta feels like an extended camping trip.  With zombies."),
            ccb.content.text("I slept weird last night.  Got this awful crick in my neck."),
            ccb.content.text("Do you think the internet is still out there somewhere, floating around in some still-functional servers somehow?  It's weird to think about what happened to all that data."),
            ccb.content.text("Remember that guy Daren in elementary who used to tell all those weird-ass creepy stories?  Chris hated him but I thought he was interesting.  I wonder if he's alive, he'd have loved this."),
            ccb.content.text("You know what I could really use right now?  A hot bath."),
            ccb.content.text("Next time we hit a library, I'm gonna see if they've got a copy of Gideon the Ninth.  I read that book a while ago, but I was super high and I don't remember much of it."),
            ccb.content.text("Do you remember what day of the week it is?"),
            ccb.content.text("Next time I get a chance, I'm gonna make a nice big bowl of mac and cheese."),
            ccb.content.text("Y'know, these shoes are surprisingly comfy.  You wouldn't think it to look at 'em."),
            ccb.content.text("Do you think zombies know what's going on?  Like, are the original people still in there watching all this happen?  I sure hope not."),
            ccb.content.text("It's funny how fast all this weird shit starts to feel normal, don't you think?"),
        },
    },
    on_enter = {
        {
            actions = {
                "morale_chat_activity",
                actions.add_effect("interlocutor", "asked_to_socialize", { turns = 7000 }),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("We're always gonna be friends, right?  Even with the apocalypse… changing us?"),
            next_topic = "TALK_FRIEND_Liam_CHAT_Friends4ever",
        },
        {
            text = ccb.content.text("What do you miss most about the internet?"),
            next_topic = "TALK_FRIEND_Liam_CHAT_Internet",
        },
        {
            text = ccb.content.text("Now that we've got no responsibilities, is there anything you'd like to see or do?"),
            next_topic = "TALK_FRIEND_Liam_CHAT_Goals",
        },
        {
            text = ccb.content.text("What do you think the rest of the world is like these days?"),
            next_topic = "TALK_FRIEND_Liam_CHAT_World",
        },
        {
            text = ccb.content.text("Do you miss any food from the old days?"),
            next_topic = "TALK_FRIEND_Liam_CHAT_Food",
        },
    },
}
