local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ALLY_TUTORIAL_ACTIVITIES",
    line = ccb.content.text("I can help with some tasks if you show me where to work.\n  Use the zone manager (keybind 'Y') to set up sorting zones for your loot, or to draw blueprints for a building, or to define where you want to plant some crops, or where you'd like some trees cut down, or where you want a vehicle dismantled or repaired, or a good fishing spot.  Then talk to me about my current activity and tell me to sort stuff, or build stuff, or cut down trees, or repair or dismantle a vehicle, or do farmwork, or catch some fish, and I'll go off and do my best to get what you want done.\n  If I need tools, you should leave them in a loot zone near where you want me to work - axes for logging, shovels and seeds and fertilizer for farming, wrenches and hacksaws or a toolbox to take apart a vehicle.  I promise to put stuff back in an unsorted loot zone when I'm finished.\n  I can pretty much sort out our stuff without needing tools, but keep the piles of unsorted and sorted stuff kind of close together because I don't want to walk back and forth carrying junk too much."),
    replies = {
        {
            text = ccb.content.text("Good to know.  Can you perform first aid?"),
            next_topic = "TALK_ALLY_TUTORIAL_MEDIC",
        },
        {
            text = ccb.content.text("What about carrying stuff in general?"),
            next_topic = "TALK_ALLY_TUTORIAL_MULE",
        },
        {
            text = ccb.content.text("What if I want you to build an organized camp?"),
            next_topic = "TALK_CAMP_TUTORIAL_INTRO",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ALLY_TUTORIAL_MOVEMENT",
    line = ccb.content.text("If you call me by radio, you can tell me to come to you.  If you've got some basecamps set up, you can tell me to go to one of them.  I'll start walking, and when I get to where I'm going, I'll guard it.\n  Now depending on where I am and where I'm going, it may take me a while to get there.  I'll dodge any dangers on the way, don't worry about that, but if you're way the heck away from me and tell me to come, it may be a while until I get to you.\n  I'll move faster if I'm horseback."),
    replies = {
        {
            text = ccb.content.text("We can talk with radios?"),
            next_topic = "TALK_ALLY_TUTORIAL_RADIO",
        },
        {
            text = ccb.content.text("What do you do as a guard?"),
            next_topic = "TALK_ALLY_TUTORIAL_GUARD",
        },
        {
            text = ccb.content.text("Tell me about faction camps."),
            next_topic = "TALK_CAMP_TUTORIAL_INTRO",
        },
        {
            text = ccb.content.text("You can ride a horse?"),
            next_topic = "TALK_ALLY_TUTORIAL_HORSES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ALLY_TUTORIAL_HORSES",
    line = ccb.content.text("If there's a friendly horse with a saddle nearby, you tell me to mount up, I'll go over and get on it.  You may need to feed a feral horse some cattle fodder to get it act tame and friendly, and e'x'amine it while you have a saddle in your inventory in order to put the saddle on.  You can also ride yourself, if you know how.\n  You want me to get off a horse, you just tell me.  You can get off a horse with the vehicle control key (keybind '^').\n  While we're on horses, we'll just move normally, but a lot faster.  It's a good way to get places more quickly than we could on our own two feet."),
    replies = {
        {
            text = ccb.content.text("You said something about being able to go places."),
            next_topic = "TALK_ALLY_TUTORIAL_MOVEMENT",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ALLY_TUTORIAL_GUARD",
    line = ccb.content.text("You tell me to guard, I'll stay where I am and guard it - unless I'm in a vehicle, in which case I'll stick with the vehicle.  I might not be able to stop a horde of zombies, but I can keep people other people from stealing our stuff.  Well, unless they try to kill me.\n  Also, I'm not a potted plant, so if I hear something dangerous happening, I'm going to go see what it is instead of getting jumped in the dark.  If you want me to stay put, tell me not to investigate noises - but if I get shot by some bandit because I can't see where he is and you don't want me to go looking, I won't be happy.\n  You can also use the zone manager (keybind 'Y') to set up no-investigate zone, so if there's some monsters behind a door that you know about, I can ignore them.  You can also set up an investigate-only zone, and I won't investigate noises coming from outside the zone.  The no-investigate zone takes precedence over the investigate-only, if there's a noise coming from some place in both zones.  And if you've got an investigate-only zone set anywhere, even if it's far away, I won't investigate noises coming from outside of it, so be careful with those zones.  Like I said, I don't want to get sniped by some bandit because you told me not to go looking for him - but I also don't want to go investigate something pounding at door only to find out it's some horrible monster you forgot to warn me about."),
    replies = {
        {
            text = ccb.content.text("Just in case - how else can I tell you to stay put?"),
            next_topic = "TALK_ALLY_TUTORIAL_MISC",
        },
        {
            text = ccb.content.text("Hang on, other people can steal our stuff?"),
            next_topic = "TALK_ALLY_TUTORIAL_OTHER_FACTIONS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ALLY_TUTORIAL_CBMS",
    line = ccb.content.text("Bionics are augmentation packages, right?  They come in these installable Compact Bionic Modules or CBMs, and I can use some CBMs - if you examine a CBM, it will tell you if I can use it.\n  Find a programmable surgical installer or Autodoc, position me on the couch, and activate it, and you can install a suitable CBM to me - or if I think I'll do a better job, I'll do.  I'll take over installing CBMs into you if I'm better at it.\n  I can use almost all passive bionics and some active bionics.  If I have any active bionics, I'll try to use them sensibly, but if we're in danger, I'm going to activate anything that might give me an edge.  I'll use any weapon bionics if they're better than the weapons you gave me, but if you think I should reserve my bionic energy for my defensive and healing bionics, you can tell me how much to reserve.  I'll try to keep my bionic energy topped off, but if we're running low on supplies, you can tell me to stop recharging when I'm not full.\n  I'll tell you if I'm low on bionic energy and can't recharge, and what fuel I need."),
    replies = {
        {
            text = ccb.content.text("Tell me how I give you fuel for your bionics."),
            next_topic = "TALK_ALLY_TUTORIAL_MULE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ALLY_TUTORIAL_SOCIAL",
    line = ccb.content.text("We can chit-chat, if you want.  People are social animals, right?  A little light conversation can do wonders for your mood.  But I don't want to be yapping all the time, so if we've chatted recently, I probably am not going to want to talk for a bit.\n  You can also ask me about my background.  I may not want to talk about it, though.\n  You can also ask me for advice - I've heard things here and there that may help us survive, but I don't usually give advice relevant to the situation.\n  I can also train you, and you can read books to me in order to train me."),
    replies = {
        {
            text = ccb.content.text("What's that about training?"),
            next_topic = "TALK_ALLY_TUTORIAL_TRAINING",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ALLY_TUTORIAL_MISC",
    line = ccb.content.text("You can give me a bunch of instructions.  Talk to me about the miscellaneous rules, and I'll tell you what I'm doing and you can give a new instruction.  Sometimes you'll have shouted a command that overrides your other instructions, and I'll tell you which instructions are overridden.\n  I'm not a chatterbox, but I'll tell you when I see or hear danger or if I'm hurt or hungry or something.  You don't want me doing that, you just tell me.\n  Also, I'll pulp zombies if you'd like - I would prefer that.\n  If I hear something suspicious and can't see it, I'll go take a look, but you can tell me not to do that.\n  I'll open and close doors, or open them and leave them ajar, or not going through closed doors.  You just tell me what you want.\n  I can pick stuff up if want me to, and you can tell me what to pick up.  If I've got a bow or crossbow, please tell me to pick up the ammo - it's less fuss for both of us.\n  If you've got a vehicle, you can e'x'amine it and use the cre'w' command to assign me a seat.  That saves arguments about who needs to sit where."),
    replies = {
        {
            text = ccb.content.text("How do shouted commands work?"),
            next_topic = "TALK_ALLY_TUTORIAL_SHOUTS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ALLY_TUTORIAL_COMMANDS",
    line = ccb.content.text("Here's the list of shouted commands I'll respond to:\n  - Order me to guard, and I'll stay where I am and watch out for danger.  I'll investigate suspicious noises unless you told me not to.\n  - Order me to follow, and I'll stop guarding and go back to following you.\n  - Order me to stay awake, and I'll stay awake until I'm too tired to keep my eyes open.\n  - Order me to sleep when tired, and I'll nap when I get tired.  I'll try to tell you when I'm off to bed unless you don't want to hear it.\n  - Order me to flee, and I'll stick close to you when you run from danger.  I won't go running off on my own - though if things really bad, I might be running away already!\n  - Order me to stop running, and I'll evaluate the danger myself and might go off and fight something while you're doing other things.\n  - Ordering me to prepare for danger is special: it's an override command.  That means I'm going to follow certain instructions, even if you've given me other instructions earlier.  Specifically, I'm going to flee with you, I'm not going to open or close doors, I'm not going to sleep until I'm exhausted, and I'm going to try to hold any chokepoints that you're fighting at.\n  - Ordering me to relax from danger is another special command, and it will clear any overrides I currently have and I'll go back to whatever instructions I had before you told me to prepare for danger."),
    replies = {
        {
            text = ccb.content.text("Thanks.  How can I give you instructions normally?"),
            next_topic = "TALK_ALLY_TUTORIAL_TALK",
        },
        {
            text = ccb.content.text("Can I give you instructions about fighting?"),
            next_topic = "TALK_ALLY_TUTORIAL_COMBAT",
        },
        {
            text = ccb.content.text("Can I tell you to open and close doors or avoid sleep without shouting?"),
            next_topic = "TALK_ALLY_TUTORIAL_MISC",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ALLY_TUTORIAL_OTHER_FACTIONS",
    line = ccb.content.text("Just about everyone is dead, but some people survived, right?  But just like you go around breaking into houses and taking whatever you think you need or want, well, other survivors do the same thing.  And that stack of loot you've been accumulating looks just like some random dead person's loot when it's left alone.  If some other scavenger comes around and sees that loot, and you or I or another ally isn't around to claim it, that other survivor is just going to take it.  So try to detail someone to watch your stuff - whether its at a base or in a vehicle.\n  Also, we've teamed up to better our chances of survival.  Other people are going to do the same, forming little factions just like we did.  If you open the faction manager (keybind '#'), you can see a list of all your allies, as well as all the other factions you've met so far.  Some factions are really just some guy trying to survive on his own, but other factions have dozens of members and fortified bases and such.  You might want to find some of them and try to make friends with them."),
    replies = {
        {
            text = ccb.content.text("Anything else I can do in the faction manager?"),
            next_topic = "TALK_ALLY_TUTORIAL_RADIO",
        },
        {
            text = ccb.content.text("Is there any way we can build base for our faction?"),
            next_topic = "TALK_CAMP_TUTORIAL_INTRO",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ALLY_TUTORIAL_CHANGES",
    line = ccb.content.text("Well, this conversation is pretty new!  But there's been some other changes.\n  I've been able to install CBMs on you, and have passive bionics installed in me, for a while.  But now I can use some active bionics, and I can explain some details on how I use bionics.\n  I can also ride horses, and you can give me orders to do things like farmwork, cutting trees, or even building houses from a blueprint.\n  I can even read books to improve my skills, so you don't have to spend time reading to me.\n  If you've got a faction camp, and we're near it, I'll eat from the camp's food reserves when I'm hungry.  And if the camp has a well, I'll drink from the well when thirsty.  Be careful, though - if other people are out on missions, I may eat the food they expected to eat when they got done!"),
    replies = {
        {
            text = ccb.content.text("You can use bionics?  How does that work?"),
            next_topic = "TALK_ALLY_TUTORIAL_CBMS",
        },
        {
            text = ccb.content.text("You can ride horses?  Can I ride horses?"),
            next_topic = "TALK_ALLY_TUTORIAL_HORSES",
        },
        {
            text = ccb.content.text("Tell me more about the activities you can do now."),
            next_topic = "TALK_ALLY_TUTORIAL_ACTIVITIES",
        },
        {
            text = ccb.content.text("Hey, you can teach yourself from a book.  How does that work?"),
            next_topic = "TALK_ALLY_TUTORIAL_TRAINING",
        },
        {
            text = ccb.content.text("Tell me about faction camps."),
            next_topic = "TALK_CAMP_TUTORIAL_INTRO",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = {
        "TALK_ALLY_TUTORIAL_TALK", "TALK_ALLY_TUTORIAL_RADIO", "TALK_ALLY_TUTORIAL_SHOUTS",
        "TALK_ALLY_TUTORIAL_COMBAT", "TALK_ALLY_TUTORIAL_TRAINING", "TALK_ALLY_TUTORIAL_MULE",
        "TALK_ALLY_TUTORIAL_ACTIVITIES", "TALK_ALLY_TUTORIAL_HORSES", "TALK_ALLY_TUTORIAL_MEDIC",
        "TALK_ALLY_TUTORIAL_MOVEMENT", "TALK_ALLY_TUTORIAL_MUTINY", "TALK_ALLY_TUTORIAL_OTHER_FACTIONS",
        "TALK_ALLY_TUTORIAL_GUARD", "TALK_ALLY_TUTORIAL_CBMS", "TALK_ALLY_TUTORIAL_SOCIAL",
        "TALK_ALLY_TUTORIAL_MISC", "TALK_ALLY_TUTORIAL_COMMANDS", "TALK_ALLY_TUTORIAL_CHANGES",
    },
    replies = {
        {
            text = ccb.content.text("Thanks for the explanation.  I wanted to know more about something else."),
            next_topic = "TALK_ALLY_TUTORIAL",
        },
        {
            text = ccb.content.text("Thanks.  I have some things for you to do."),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text("Skip it.  <lets_go>"), next_topic = "TALK_DONE" },
    },
}
