local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_Liam_SOCIAL" },
    line = ccb.content.text("Any time, what's on your mind?"),
    replies = {
        {
            text = ccb.content.text("I'd like your opinion on a job we're doing."),
            next_topic = "TALK_Liam_Opinions",
        },
        {
            text = ccb.content.text("[Raise your hand for a high-five.]"),
            next_topic = "TALK_Liam_HighFive",
        },
        {
            text = ccb.content.text("Can I ask you a bit about yourself?"),
            next_topic = "BGSS_Liam1",
        },
        {
            text = ccb.content.text("You picked up a lot of useful skills over the years, hey."),
            next_topic = "BGSS_Liam_Expertise",
        },
        {
            text = ccb.content.text("I just wanted to chat, you know.  To relax."),
            next_topic = "TALK_FRIEND_Liam_CHAT",
            when = predicates.negate(predicates.has_effect("interlocutor", "asked_to_socialize")),
        },
        {
            text = ccb.content.text("The way you said something earlier made me realize… you have a crush on Jenny Forcette, don't you."),
            next_topic = "TALK_Liam_Jenny_CrushAccuse",
            when = predicates.all({ predicates.any_equal({ "crush_suspected", { scope = "speaker", key = "u_liam_jenny_feelings" } }), predicates.negate(predicates.any_equal({ "crushing_hard", { scope = "speaker", key = "u_liam_jenny_feelings" } })) }),
        },
        {
            text = ccb.content.text("I changed my mind, wanted to ask you something else."),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<lets_go>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_HighFive",
    line = {
        choices = {
            ccb.content.text("*high fives you back enthusiastically."),
            ccb.content.text("*returns the high five with a flourish"),
            ccb.content.text("*leaps into the air and gives you a spinning high five."),
            ccb.content.text("*smacks your hand with a resounding clap."),
            ccb.content.text("*pretends to fake you out for a moment, then grins and returns the high five"),
        },
    },
    replies = {
        { text = ccb.content.text("[Nod and continue talking.]"), next_topic = "TALK_NONE" },
        { text = ccb.content.text("[Nod and head on out.]"), next_topic = "TALK_DONE" },
    },
}

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

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_Liam_CHAT_Friends4ever",
    line = {
        when = predicates.any_equal({ "ddotd", { scope = "speaker", key = "flag_modded" } }),
        yes = ccb.content.text_without_extraction("<talk_snippet_modded_liam_Friends4ever>"),
        no = ccb.content.text("Aww, of course.  No matter what happens, you're always you and I'm always me, right?  We've been through worse than this.\"  He pauses, his brow furrowed.  \"Well, okay, maybe we haven't.  But we've stuck through it all for so many years, what's a little apocalypse gonna change?  Or a little mutation, or grievous bodily harm, or zombies, or interdimensional monster attacks and serious life-altering PTSD, or whatever.  Who cares.  You're my family, more than my birth family ever was."),
    },
    replies = { { text = ccb.content.text("[Continue chatting.]"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_Liam_CHAT_Internet",
    line = {
        choices = {
            ccb.content.text("OK, I know you're leading me up to say something dirty, and yeah I miss that, but you know what?  Really the thing I miss most is social media.  No seriously!  Stop looking at me like that!  I liked being able to just talk to people no matter where they were, any time.  I had friends in Sweden, and Brazil, and the West Coast.  I'm never gonna know what happened to them, and that busts me up bad.  They mattered to me, you know?\"  His voice catches a bit, and he coughs.  \"You're here though, and that helps a lot.  Can't imagine trying to do this lone-wolf.  How about you, what were you thinking of when you asked?"),
            ccb.content.text("Well, I mean, there's the obvious stuff like, uh, video streaming,\" he winks at you, \"but I think lately I'm missing Wikipedia.  I have all these random questions about things, and I can't answer them.  I feel like I'm living in a box.  How did we survive for thousands of years like this?"),
            ccb.content.text("Online restaurant reviews.\"  He stares at you without a shred of irony.  \"I'm serious, I used to love browsing looking for the funniest or weirdest reviews.  I guess I could broaden it, I miss pointless doom scrolling.  It's harder to find things to keep my mind off things now, and I've got more I wish I could keep my mind off.  What about you?"),
        },
    },
    replies = { { text = ccb.content.text("[Continue chatting.]"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_Liam_CHAT_Goals",
    line = {
        choices = {
            ccb.content.text("*laughs.  \"You know me, I was never high on the ambition front.  Honestly, if you weren't around I'd probably clean up my dad's old cabin, try to learn how to set up a power supply, and scavenge for parts until I'd built the best damn gaming rig the world will ever see.  Then I'd load up whatever games I could find.\"  He pauses.  \"Or maybe it'd be easier to set up a console, I dunno.  Most consoles aren't gonna like the no-internet thing right?  There's probably a way to crack 'em but without the internet where would we even check?\"  He rubs his chin.  \"Still.  I'd have maybe found a way.  How about you, what's the big overarching plan for all this?\""),
            ccb.content.text("Oh, well.  I don't really think of life that way, you know?  I guess I'm pretty happy to just hang out with you, doing the shit we're doing, seeing what life brings.  Still, I guess I could see settling down somewhere nice, somewhere quiet, somewhere zombie-free.  I bet it wouldn't take long to get enough food and supplies to live on forever, and then I'd just let myself turn into some kinda wild bush man, with a big crazy long beard.  I'd smell like weed and B.O. and I'd have this giant stack of books to read.  Other survivors would come find me, like a guru on a mountaintop, to ask me questions about Batman.  In time, as the old world was forgotten, I'd convince them that he was a real person.\"  He grins.  \"How 'bout you?"),
        },
    },
    replies = { { text = ccb.content.text("[Continue chatting.]"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_Liam_CHAT_World",
    line = {
        choices = {
            ccb.content.text("Oh dude, good question.  The news reports made it sound like this is everywhere, you know?  Still, somewhere out there's gotta be better than this, right?  Maybe like, up in the Yukon or Siberia or something it's all kinda normal?  I think most places are like this though, just one big fucked up mess.  Maybe they've got different monsters though, like, carnivorous rocks or some shit.  How 'bout you, what do you think is out there?"),
            ccb.content.text("See, I like that about you.  Here we are just trying to keep alive and you're thinking all these big thoughts about the rest of the world.  I got no clue how they're doing out there, so I'm just gonna imagine that things are kinda like here, but maybe a bit better.  There's a few places where folks have settled in and they're figuring stuff out.  Those folks are gonna last a long time, maybe they're how we start rebuilding."),
        },
    },
    replies = { { text = ccb.content.text("[Continue chatting.]"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_Liam_CHAT_Food",
    line = {
        choices = {
            ccb.content.text("I never thought I'd hear myself say this, but I kinda miss the Ediburger3 from Foodplace.  I worked there so long, I hated everything, but as soon as you tell me I'm *never* gonna have a fresh, greasy EB3 again, suddenly it's all my stomach wants.  Don't try to track one down or anything though.  I'm pretty sure I miss the *idea* more than the actual *thing*.  And I don't think we could cook up a copy, it'd be pretty hard to get the right blend of animal product and sawdust for the Meatcylinder.\"  He stares wistfully into space for a moment.  \"How about you, what were you thinking of when you asked?"),
            ccb.content.text("Delivery pizza.  It's not the quality of the pizza I miss, it's the delivery.  Having someone just show up at the door with a god damn pizza, ready for you to eat.  We lived in paradise and we knew it not.  How about you?"),
            ccb.content.text("You know, my friend, I could really go for an egg salad sandwich right now.  Nice, fresh eggs, some cheap-ass white bread, bit of pickle on there, hint of mustard.  Egg salad gets a bad rap because it sucks if you get it from the store, but you make a good homemade one?  That's something else, I tell you.  What's your poison?"),
            ccb.content.text("You know, I'm kinda in the mood for some pub nachos right now.  The whole pub ambience would be good too, but I like how they'd put 'em on wax paper that'd be so soaked with cheese grease you could see right through it.  Those little black olive wheels that tasted like rubber, they were only ever good with pub nachos, you know?  Any other time, garbage.  I'd love to have a big tray of pub nachos, go to a karaoke night, and just sing fuckin' Abba songs until my throat hurt.  You in?"),
        },
    },
    replies = { { text = ccb.content.text("[Continue chatting.]"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_Liam1",
    line = ccb.content.text("Well, sure.  I dunno what more there is to tell, we've known each other for ages."),
    replies = {
        {
            text = ccb.content.text("We hadn't caught up in a while before <the_cataclysm>.  What've you been doing?"),
            next_topic = "BGSS_Liam2",
        },
        {
            text = ccb.content.text("You picked up a lot of useful skills over the years, hey."),
            next_topic = "BGSS_Liam_Expertise",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_Liam_SOCIAL",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_Liam2",
    line = ccb.content.text("*shrugs.  \"Same as I was when we used to hang out more, mostly.  I quit my job at Foodplace a while back, got tired of the stupid outfits.  Worked doing labor in construction for a bit, but I didn't like my boss so I ditched it.  Got a job doing deliveries for Amazon, which was absolutely shitty, but I managed to jump from that to a bit of a better delivery job for a smaller company.  It was actually going pretty good before everything happened.\""),
    replies = {
        {
            text = ccb.content.text("How did you make it through the Cataclysm?"),
            next_topic = "BGSS_Liam3",
        },
        {
            text = ccb.content.text("You picked up a lot of useful skills over the years, hey."),
            next_topic = "BGSS_Liam_Expertise",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_Liam_SOCIAL",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_Liam3",
    line = ccb.content.text("I wanna say it was a hell of a story, but really, I was on the way back to Boston from a delivery and a thing about the riots came on the radio.  I was close to the cabin so I just thought, 'this is starting to sound really fuckin' bad.'  I called in sick and took a few days to hunker down out of civilization.  By the time I had to think about going back to work, we were into that wild time when half the people were trying to keep things running and the other half were trying to burn everything down.  I shut the blinds and stayed in, until Chris showed up acting like a freak."),
    replies = {
        {
            text = ccb.content.text("You picked up a lot of useful skills over the years, hey."),
            next_topic = "BGSS_Liam_Expertise",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_Liam_SOCIAL",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_Liam_Expertise",
    line = ccb.content.text("It doesn't feel that way, but I guess so.  I don't know if I ever told you, but my dad was quite the weirdo prepper.  He built the cabin and when I was a kid we'd head out and do drills for the end of the world.  It's part of why I was kinda whacked out on apocalypse stuff when you and I first met, back when we made the plan for where to meet up and all.  He taught me archery and some survival skills but I never really took to it, partly because my ol' man was a real piece of work.\"  He stares off for a minute.  \"To be honest, though, now that we're in the middle of a real-ass apocalypse, I can see a lot of what he taught me was just crap anyway."),
    replies = {
        {
            text = ccb.content.text("What happened to your father?  You never talked about him much."),
            next_topic = "BGSS_Liam_Father",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_Liam_SOCIAL",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_Liam_Father",
    line = ccb.content.text("*snorts.  \"I was pretty low-contact with him the last couple years.  He got me that job in construction and when I left it, he tried to hit me, found out I'm not so much of a pushover as when I was fifteen.  Asshole.  I was still texting my mom a bit, apparently when things went to shit, he tried to join the riots.  I hope he got gunned down.\""),
    replies = {
        {
            text = ccb.content.text("I remember your mom as kind of a quiet lady, she seemed all right.  Should we be trying to find her?"),
            next_topic = "BGSS_Liam_Mother",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_Liam_SOCIAL",
        },
        {
            text = ccb.content.text("Harsh, but I hear you.  <end_talking>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_Liam_Mother",
    line = ccb.content.text("Well, things with her weren't as bad as with my dad, but I don't know if I'd go trying to hunt for her in a zombified city or anything.  Like, sure she didn't beat me up, but she didn't ever lift a finger to help me either.  She was still with him right up until the end, even when it was obvious that she was choosing him over me.  I don't wanna judge her for the life she led, but - \" he trails off for a moment, then twitches his shoulders and resumes.  \"Well, it's like I said.  I hope she's okay but I'm not gonna go risk my neck trying to find her.  You and Chris were my real family, you got me through those years."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_Liam_SOCIAL",
        },
        {
            text = ccb.content.text("Harsh, but I hear you.  <end_talking>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Jenny_CrushAccuse",
    line = ccb.content.text("*stares at you wide-eyed for a beat, then breaks into a shy grin.  \"Aw man, busted.  You *know* I dig those distracted nerdy chicks who don't react to my presence in any way.  It's all good though, you know?  Don't tell her.  I barely know her and it's not like she's in a place to be dating some stranger.\""),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "u_liam_jenny_feelings", "crushing_hard") },
        },
    },
    replies = {
        {
            text = ccb.content.text("Your secret's safe with me.  <done_conversation_section>"),
            next_topic = "TALK_Liam_SOCIAL",
        },
        {
            text = ccb.content.text("Your secret's safe with me.  <lets_go>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions",
    line = ccb.content.text("My opinion?  Sure, my friend, hit me up, what's eating you?"),
    replies = {
        {
            text = ccb.content.text("Check this out, I found an address of some kind of central refugee management facility.  Should we check it out?  Maybe they'll have answers?"),
            next_topic = "TALK_Liam_Opinions_MISSION_REACH_REFUGEE_CENTER",
            when = predicates.has_mission("MISSION_REACH_REFUGEE_CENTER"),
        },
        {
            text = ccb.content.text("You thinking what I'm thinking about this mystery dropoff for Smokes?"),
            next_topic = "TALK_Liam_Opinions_MISSION_FREE_MERCHANTS_HUB_DELIVERY_1",
            when = predicates.has_mission("MISSION_FREE_MERCHANTS_HUB_DELIVERY_1"),
        },
        {
            text = ccb.content.text("Any ideas about this job to clear out the back bay for Smokes?"),
            next_topic = "TALK_Liam_Opinions_MISSION_FREE_MERCHANTS_EVAC_1",
            when = predicates.has_mission("MISSION_FREE_MERCHANTS_EVAC_1"),
        },
        {
            text = ccb.content.text("What do you think about taking down this bandit camp?"),
            next_topic = "TALK_Liam_Opinions_MISSION_FREE_MERCHANTS_EVAC_2",
            when = predicates.has_mission("MISSION_FREE_MERCHANTS_EVAC_2"),
        },
        {
            text = ccb.content.text("Any thoughts about bringing this prospectus out to the ranch?"),
            next_topic = "TALK_Liam_Opinions_MISSION_FREE_MERCHANTS_EVAC_3",
            when = predicates.has_mission("MISSION_FREE_MERCHANTS_EVAC_3"),
        },
        {
            text = ccb.content.text("What's the fastest way to find these guys some solar panels?"),
            next_topic = "TALK_Liam_Opinions_MISSION_FREE_MERCHANTS_EVAC_4",
            when = predicates.has_mission("MISSION_FREE_MERCHANTS_EVAC_4"),
        },
        {
            text = ccb.content.text("Liam, I need a lot of jars.  A shocking amount of jars."),
            next_topic = "TALK_Liam_Opinions_MISSION_FREE_MERCHANTS_EVAC_5",
            when = predicates.has_mission("MISSION_FREE_MERCHANTS_EVAC_5"),
        },
        {
            text = ccb.content.text("Liam, we need bigger jars."),
            next_topic = "TALK_Liam_Opinions_MISSION_BROKER_1",
            when = predicates.has_mission("MISSION_BROKER_1"),
        },
        {
            text = ccb.content.text("How about finding this guy some cigarettes?"),
            next_topic = "TALK_Liam_Opinions_MISSION_EVAC_SMOKER_GET_CIGARETTES",
            when = predicates.has_mission("MISSION_EVAC_SMOKER_GET_CIGARETTES"),
        },
        {
            text = ccb.content.text("Should we go check out those farmers the teamster mentioned?"),
            next_topic = "TALK_Liam_Opinions_directions_isherwood",
            when = predicates.has_mission("directions_isherwood"),
        },
        {
            text = ccb.content.text("A secret lab in the wilds, with survivors in it, Liam.  You heard the teamster."),
            next_topic = "TALK_Liam_Opinions_directions_hub01",
            when = predicates.has_mission("directions_hub01"),
        },
        {
            text = ccb.content.text("This 'scrap metal castle' sounds far-fetched to me."),
            next_topic = "TALK_Liam_Opinions_directions_exodii",
            when = predicates.has_mission("directions_exodii"),
        },
        {
            text = ccb.content.text("What sounds better to you, a 'bullet bank' or a woman who feeds visitors?"),
            next_topic = "TALK_Liam_Opinions_directions_artisans",
            when = predicates.has_mission("directions_artisans"),
        },
        {
            text = ccb.content.text("What do you think about helping out this Dave guy?"),
            next_topic = "TALK_Liam_Opinions_MISSION_BEGGAR_2_BOX_SMALL",
            when = predicates.has_mission("MISSION_BEGGAR_2_BOX_SMALL"),
        },
        {
            text = ccb.content.text("At least Dave has some practicality, and isn't just asking for more trash, right?"),
            next_topic = "TALK_Liam_Opinions_MISSION_BEGGAR_2_DUCT_TAPE",
            when = predicates.has_mission("MISSION_BEGGAR_2_DUCT_TAPE"),
        },
        {
            text = ccb.content.text("Any thoughts on Dave's cardboard needs?"),
            next_topic = "TALK_Liam_Opinions_MISSION_BEGGAR_2_BOX_MEDIUM",
            when = predicates.has_mission("MISSION_BEGGAR_2_BOX_MEDIUM"),
        },
        {
            text = ccb.content.text("Looks like we might be done with cardboard for Dave, it's plastic now."),
            next_topic = "TALK_Liam_Opinions_MISSION_BEGGAR_2_PLASTIC_SHEET",
            when = predicates.has_mission("MISSION_BEGGAR_2_PLASTIC_SHEET"),
        },
        {
            text = ccb.content.text("I have a feeling this is the last of the cardboard for Dave."),
            next_topic = "TALK_Liam_Opinions_MISSION_BEGGAR_2_BOX_LARGE",
            when = predicates.has_mission("MISSION_BEGGAR_2_BOX_LARGE"),
        },
        {
            text = ccb.content.text("Hey, this is a different direction for Dave, don't you think?"),
            next_topic = "TALK_Liam_Opinions_MISSION_BEGGAR_2_PERMISSION",
            when = predicates.has_mission("MISSION_BEGGAR_2_PERMISSION"),
        },
        {
            text = ccb.content.text("Do you think it's dangerous to get zombie blood, besides the obvious?"),
            next_topic = "TALK_Liam_Opinions_MISSION_SCIENCE_REP_1",
            when = predicates.has_mission("MISSION_SCIENCE_REP_1"),
        },
        {
            text = ccb.content.text("Sneaking into a lab to run some data analysis can't be bad, right?"),
            next_topic = "TALK_Liam_Opinions_MISSION_SCIENCE_REP_2",
            when = predicates.has_mission("MISSION_SCIENCE_REP_2"),
        },
        {
            text = ccb.content.text("Who could have guessed there'd be some further complications to our stolen data analysis?"),
            next_topic = "TALK_Liam_Opinions_MISSION_SCIENCE_REP_3",
            when = predicates.has_mission("MISSION_SCIENCE_REP_3"),
        },
        {
            text = ccb.content.text("What do you think about checking out this freezing portal lab?"),
            next_topic = "TALK_Liam_Opinions_MISSION_SCIENCE_REP_4",
            when = predicates.has_mission("MISSION_SCIENCE_REP_4"),
        },
        {
            text = ccb.content.text("If you were tired of underground labs, now we're gonna check out secret underground lab tunnels!"),
            next_topic = "TALK_Liam_Opinions_MISSION_SCIENCE_REP_5",
            when = predicates.has_mission("MISSION_SCIENCE_REP_5"),
        },
        {
            text = ccb.content.text("Do you know how to build a still?"),
            next_topic = "TALK_Liam_Opinions_MISSION_RANCH_BARTENDER_1",
            when = predicates.has_mission("MISSION_RANCH_BARTENDER_1"),
        },
        {
            text = ccb.content.text("How long does brewer's yeast last in the package?  Can we just find it at a supermarket?"),
            next_topic = "TALK_Liam_Opinions_MISSION_RANCH_BARTENDER_2",
            when = predicates.has_mission("MISSION_RANCH_BARTENDER_2"),
        },
        {
            text = ccb.content.text("Any idea where we could find sugar beet seeds for the bartender?"),
            next_topic = "TALK_Liam_Opinions_MISSION_RANCH_BARTENDER_3",
            when = predicates.has_mission("MISSION_RANCH_BARTENDER_3"),
        },
        {
            text = ccb.content.text("Do you like big jugs, Liam?"),
            next_topic = "TALK_Liam_Opinions_MISSION_RANCH_BARTENDER_4",
            when = predicates.has_mission("MISSION_RANCH_BARTENDER_4"),
        },
        {
            text = ccb.content.text("How are we gonna transport two giant drums?"),
            next_topic = "TALK_Liam_Opinions_MISSION_RANCH_BARTENDER_5",
            when = predicates.has_mission("MISSION_RANCH_BARTENDER_5"),
        },
        {
            text = ccb.content.text("Bringing a professional arsonist some commercial fertilizer seems like a normal thing to do."),
            next_topic = "TALK_Liam_Opinions_MISSION_ARSONIST_1_AMMONIUM_NITRATE",
            when = predicates.has_mission("MISSION_ARSONIST_1_AMMONIUM_NITRATE"),
        },
        {
            text = ccb.content.text("So, uh.  Alonso's pants, hey."),
            next_topic = "TALK_Liam_Opinions_MISSION_REFUGEE_Alonso_pants",
            when = predicates.has_mission("MISSION_REFUGEE_Alonso_pants"),
        },
        {
            text = ccb.content.text("What do you think about helping these guys clean up all that dead zombie mess?"),
            next_topic = "TALK_Liam_Opinions_MISSION_REFUGEE_Boris_CLEANUP",
            when = predicates.has_mission("MISSION_REFUGEE_Boris_CLEANUP"),
        },
        {
            text = ccb.content.text("Any thoughts on finding Boris a power saw?"),
            next_topic = "TALK_Liam_Opinions_MISSION_REFUGEE_Boris_WORKSPACE",
            when = predicates.has_mission("MISSION_REFUGEE_Boris_WORKSPACE"),
        },
        {
            text = ccb.content.text("We're looking for Boris' kid's old laptop.  Thoughts?"),
            next_topic = "TALK_Liam_Opinions_MISSION_REFUGEE_Boris_LAPTOP",
            when = predicates.has_mission("MISSION_REFUGEE_Boris_LAPTOP"),
        },
        {
            text = ccb.content.text("You ever used a sourdough starter?"),
            next_topic = "TALK_Liam_Opinions_MISSION_REFUGEE_Dana_Sourdough",
            when = predicates.has_mission("MISSION_REFUGEE_Dana_Sourdough"),
        },
        {
            text = ccb.content.text("Draco seems like a kindred spirit for you."),
            next_topic = "TALK_Liam_Opinions_MISSION_REFUGEE_Draco_GET_GUITAR",
            when = predicates.has_mission("MISSION_REFUGEE_Draco_GET_GUITAR"),
        },
        {
            text = ccb.content.text("Are you okay with tracking down a copy of the Quran?"),
            next_topic = "TALK_Liam_Opinions_MISSION_REFUGEE_Fatima_1",
            when = predicates.has_mission("MISSION_REFUGEE_Fatima_1"),
        },
        {
            text = ccb.content.text("Any idea where to find a really specific reference book about pneumatic guns?"),
            next_topic = "TALK_Liam_Opinions_MISSION_REFUGEE_Jenny_GET_PNEUMATICS",
            when = predicates.has_mission("MISSION_REFUGEE_Jenny_GET_PNEUMATICS"),
        },
        {
            text = ccb.content.text("What do you think, where should we look for a motor for Jenny?"),
            next_topic = "TALK_Liam_Opinions_MISSION_REFUGEE_Jenny_GET_MOTOR",
            when = predicates.has_mission("MISSION_REFUGEE_Jenny_GET_MOTOR"),
        },
        {
            text = ccb.content.text("It shouldn't be too hard to find Jenny a big metal tank, right?"),
            next_topic = "TALK_Liam_Opinions_MISSION_REFUGEE_Jenny_GET_TANK",
            when = predicates.has_mission("MISSION_REFUGEE_Jenny_GET_TANK"),
        },
        {
            text = ccb.content.text("You ever seen gunsmithing books just lying around?"),
            next_topic = "TALK_Liam_Opinions_MISSION_REFUGEE_Jenny_GET_TEXT",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "crushing_hard", { scope = "speaker", key = "u_liam_jenny_feelings" } })), predicates.has_mission("MISSION_REFUGEE_Jenny_GET_TEXT") }),
        },
        {
            text = ccb.content.text("So, we're finding a book about guns for your sweet nerd-girl."),
            next_topic = "TALK_Liam_Opinions_MISSION_REFUGEE_Jenny_GET_TEXTcrushmode",
            when = predicates.all({ predicates.any_equal({ "crushing_hard", { scope = "speaker", key = "u_liam_jenny_feelings" } }), predicates.has_mission("MISSION_REFUGEE_Jenny_GET_TEXT") }),
        },
        {
            text = ccb.content.text("Do you think it's the right thing, trying to help the Nunez family move to Tacoma?"),
            next_topic = "TALK_Liam_Opinions_MISSION_TACOMA_Nunez",
            when = predicates.has_mission("MISSION_TACOMA_Nunez"),
        },
        {
            text = ccb.content.text("Any thoughts on helping Uyen out with her antiseptic?"),
            next_topic = "TALK_Liam_Opinions_MISSION_REFUGEE_Uyen_1",
            when = predicates.has_mission("MISSION_REFUGEE_Uyen_1"),
        },
        {
            text = ccb.content.text("Any thoughts on helping Uyen out with her bandages?"),
            next_topic = "TALK_Liam_Opinions_MISSION_REFUGEE_Uyen_2",
            when = predicates.has_mission("MISSION_REFUGEE_Uyen_2"),
        },
        {
            text = ccb.content.text("Any thoughts on helping Uyen out with her antidepressants?"),
            next_topic = "TALK_Liam_Opinions_MISSION_REFUGEE_Uyen_3",
            when = predicates.has_mission("MISSION_REFUGEE_Uyen_3"),
        },
        {
            text = ccb.content.text("You and me: hairdressing supply vendors now."),
            next_topic = "TALK_Liam_Opinions_MISSION_REFUGEE_Vanessa_1",
            when = predicates.has_mission("MISSION_REFUGEE_Vanessa_1"),
        },
        {
            text = ccb.content.text("What're your thoughts on this mission to kill bandits for the old guard?"),
            next_topic = "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_1",
            when = predicates.has_mission("MISSION_OLD_GUARD_REP_1"),
        },
        {
            text = ccb.content.text("How do you think we should track down this enemy informant?"),
            next_topic = "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_2",
            when = predicates.has_mission("MISSION_OLD_GUARD_REP_2"),
        },
        {
            text = ccb.content.text("What do you think about these robots?  Crazy stuff, hey?"),
            next_topic = "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_3-NotMet",
            when = predicates.all({ predicates.has_mission("MISSION_OLD_GUARD_REP_3"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Rubik" } })) }),
        },
        {
            text = ccb.content.text("What do you think about these robots?  Crazy stuff, hey?"),
            next_topic = "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_3-HasMet",
            when = predicates.all({ predicates.has_mission("MISSION_OLD_GUARD_REP_3"), predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Rubik" } }) }),
        },
        {
            text = ccb.content.text("Do you think it's really a monster hitting those trade caravans?  Any ideas how we should deal with it?"),
            next_topic = "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_4",
            when = predicates.has_mission("MISSION_OLD_GUARD_REP_4"),
        },
        {
            text = ccb.content.text("So, we're officially assassins for hire now.  How do you feel about that?"),
            next_topic = "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_5",
            when = predicates.has_mission("MISSION_OLD_GUARD_REP_5"),
        },
        {
            text = ccb.content.text("Well, now we're radio technicians.  Sounds fun, don't you think?"),
            next_topic = "TALK_Liam_Opinions_MISSION_OLD_GUARD_REPEATER_BEGIN",
            when = predicates.has_mission("MISSION_OLD_GUARD_REPEATER_BEGIN"),
        },
        {
            text = ccb.content.text("What do you make of these weird pictographs?  I think they're directions somewhere."),
            next_topic = "TALK_Liam_Opinions_directions_exodii_signpost",
            when = predicates.has_mission("directions_exodii_signpost"),
        },
        {
            text = ccb.content.text("Where do you think we can get some anesthetic for that robot guy?"),
            next_topic = "TALK_Liam_Opinions_RUBIK_ANUS_FETICK",
            when = predicates.has_mission("RUBIK_ANUS_FETICK"),
        },
        {
            text = ccb.content.text("Any thoughts on this scouting mission, checking out this bunker thing?"),
            next_topic = "TALK_Liam_Opinions_EXODII_MISSION_CONTACT_HUB",
            when = predicates.has_mission("EXODII_MISSION_CONTACT_HUB"),
        },
        {
            text = ccb.content.text("How do you think we should start looking for this lost interdimensional building?"),
            next_topic = "TALK_Liam_Opinions_EXODII_MISSION_WAREHOUSE",
            when = predicates.has_mission("EXODII_MISSION_WAREHOUSE"),
        },
        {
            text = ccb.content.text("You ready to go burn some shit down?"),
            next_topic = "TALK_Liam_Opinions_MISSION_pizzaiolo_1",
            when = predicates.has_mission("MISSION_pizzaiolo_1"),
        },
        {
            text = ccb.content.text("It's not gonna be a problem that we're hunting down Foodperson, is it?"),
            next_topic = "TALK_Liam_Opinions_MISSION_pizzaiolo_2",
            when = predicates.has_mission("MISSION_pizzaiolo_2"),
        },
        {
            text = ccb.content.text("What do you think about clearing out these pizzeria squatters?"),
            next_topic = "TALK_Liam_Opinions_MISSION_pizzaiolo_3",
            when = predicates.has_mission("MISSION_pizzaiolo_3"),
        },
        {
            text = ccb.content.text("So, cake and a party.  Think it was all worth it?"),
            next_topic = "TALK_Liam_Opinions_MISSION_pizzaiolo_4",
            when = predicates.has_mission("MISSION_pizzaiolo_4"),
        },
        {
            text = ccb.content.text("What do you think, you in the mood to hunt some slimes?"),
            next_topic = "TALK_Liam_Opinions_MISSION_KILL_SLIMES",
            when = predicates.has_mission("MISSION_KILL_SLIMES"),
        },
        {
            text = ccb.content.text("Hey Liam!  Liam!  Bughunt!"),
            next_topic = "TALK_Liam_Opinions_MISSION_HUNT_ANTS",
            when = predicates.has_mission("MISSION_HUNT_ANTS"),
        },
        {
            text = ccb.content.text("Looks like I've got you doing deliveries again.  Where should we look for all this lumber?"),
            next_topic = "TALK_Liam_Opinions_MISSION_BUILD_CAMP_1",
            when = predicates.has_mission("MISSION_BUILD_CAMP_1"),
        },
        {
            text = ccb.content.text("I dunno if you heard, but guess what we're gonna deliver now?  More lumber!"),
            next_topic = "TALK_Liam_Opinions_MISSION_BUILD_CAMP_2",
            when = predicates.has_mission("MISSION_BUILD_CAMP_2"),
        },
        {
            text = ccb.content.text("Any idea where we can find some ropes?"),
            next_topic = "TALK_Liam_Opinions_MISSION_BUILD_CAMP_3",
            when = predicates.has_mission("MISSION_BUILD_CAMP_3"),
        },
        {
            text = ccb.content.text("These guys need a wood saw.  You carrying one?"),
            next_topic = "TALK_Liam_Opinions_MISSION_BUILD_CAMP_4",
            when = predicates.has_mission("MISSION_BUILD_CAMP_4"),
        },
        {
            text = ccb.content.text("Where could we find a shovel?"),
            next_topic = "TALK_Liam_Opinions_MISSION_BUILD_CAMP_5",
            when = predicates.has_mission("MISSION_BUILD_CAMP_5"),
        },
        {
            text = ccb.content.text("We're looking for a charcoal smoker now.  You seen one?"),
            next_topic = "TALK_Liam_Opinions_MISSION_BUILD_CAMP_6",
            when = predicates.has_mission("MISSION_BUILD_CAMP_6"),
        },
        {
            text = ccb.content.text("This guy wants us to find a Remington 870 Express for a client.  You know a bit about that stuff, don't you?"),
            next_topic = "TALK_Liam_Opinions_MISSION_COWBOYT_SHOTGUN",
            when = predicates.has_mission("MISSION_COWBOYT_SHOTGUN"),
        },
        {
            text = ccb.content.text("Nothing ever went wrong tracking down a nice old guy in a cabin in the woods, right?"),
            next_topic = "TALK_Liam_Opinions_directions_lapin",
            when = predicates.has_mission("directions_lapin"),
        },
        {
            text = ccb.content.text("You fine with helping this guy and his rabbits?"),
            next_topic = "TALK_Liam_Opinions_MISSION_Warrener_LOG_1",
            when = predicates.has_mission("MISSION_Warrener_LOG_1"),
        },
        {
            text = ccb.content.text("Does blackberry hunting sound nice?"),
            next_topic = "TALK_Liam_Opinions_MISSION_Warrener_FOOD_2",
            when = predicates.has_mission("MISSION_Warrener_FOOD_2"),
        },
        {
            text = ccb.content.text("Mind helping Mr. Lapin get in touch with his friends?"),
            next_topic = "TALK_Liam_Opinions_MISSION_Warrener_ISHERWOOD",
            when = predicates.has_mission("MISSION_Warrener_ISHERWOOD"),
        },
        {
            text = ccb.content.text("Seen an anvil around recently?"),
            next_topic = "TALK_Liam_Opinions_MISSION_ISHERWOOD_CARLOS_1",
            when = predicates.has_mission("MISSION_ISHERWOOD_CARLOS_1"),
        },
        {
            text = ccb.content.text("Anything we should consider before trying to find Chris Isherwood?"),
            next_topic = "TALK_Liam_Opinions_MISSION_ISHERWOOD_CARLOS_2",
            when = predicates.has_mission("MISSION_ISHERWOOD_CARLOS_2"),
        },
        {
            text = ccb.content.text("Looks like Barry Isherwood's got himself into some trouble."),
            next_topic = "TALK_Liam_Opinions_MISSION_ISHERWOOD_CHRIS_1",
            when = predicates.has_mission("MISSION_ISHERWOOD_CHRIS_1"),
        },
        {
            text = ccb.content.text("Want to help me collect some dandelions?"),
            next_topic = "TALK_Liam_Opinions_MISSION_ISHERWOOD_CLAIRE_1",
            when = predicates.has_mission("MISSION_ISHERWOOD_CLAIRE_1"),
        },
        {
            text = ccb.content.text("Hey Liam.  Bee balm?"),
            next_topic = "TALK_Liam_Opinions_MISSION_ISHERWOOD_CLAIRE_2",
            when = predicates.has_mission("MISSION_ISHERWOOD_CLAIRE_2"),
        },
        {
            text = ccb.content.text("Tonight, on 'to catch a predator'…"),
            next_topic = "TALK_Liam_Opinions_MISSION_ISHERWOOD_CLAIRE_3",
            when = predicates.has_mission("MISSION_ISHERWOOD_CLAIRE_3"),
        },
        {
            text = ccb.content.text("Eddie wants a *lot* of rocks."),
            next_topic = "TALK_Liam_Opinions_MISSION_ISHERWOOD_EDDIE_1",
            when = predicates.has_mission("MISSION_ISHERWOOD_EDDIE_1"),
        },
        {
            text = ccb.content.text("So, Liam, you ready to gather sand?"),
            next_topic = "TALK_Liam_Opinions_MISSION_ISHERWOOD_EDDIE_2",
            when = predicates.has_mission("MISSION_ISHERWOOD_EDDIE_2"),
        },
        {
            text = ccb.content.text("I told Eddie we'd help him gather some clay."),
            next_topic = "TALK_Liam_Opinions_MISSION_ISHERWOOD_EDDIE_3",
            when = predicates.has_mission("MISSION_ISHERWOOD_EDDIE_3"),
        },
        {
            text = ccb.content.text("Where should we look for jars for the Isherwoods?"),
            next_topic = "TALK_Liam_Opinions_MISSION_ISHERWOOD_JACK_1",
            when = predicates.has_mission("MISSION_ISHERWOOD_JACK_1"),
        },
        {
            text = ccb.content.text("Any thoughts about looking for wheat seeds?"),
            next_topic = "TALK_Liam_Opinions_MISSION_ISHERWOOD_JACK_2",
            when = predicates.has_mission("MISSION_ISHERWOOD_JACK_2"),
        },
        {
            text = ccb.content.text("Liam, you're not afraid of the big bad wolf, are you?"),
            next_topic = "TALK_Liam_Opinions_MISSION_ISHERWOOD_JESSE_1",
            when = predicates.has_mission("MISSION_ISHERWOOD_JESSE_1"),
        },
        {
            text = ccb.content.text("What do you think about hunting some mystery monsters for Jesse?"),
            next_topic = "TALK_Liam_Opinions_MISSION_ISHERWOOD_JESSE_2",
            when = predicates.has_mission("MISSION_ISHERWOOD_JESSE_2"),
        },
        {
            text = ccb.content.text("Hey, you ever seen a book about glassblowing?"),
            next_topic = "TALK_Liam_Opinions_MISSION_ISHERWOOD_LUKE_1",
            when = predicates.has_mission("MISSION_ISHERWOOD_LUKE_1"),
        },
        {
            text = ccb.content.text("Luke Isherwood wants a copy of the DIY Compendium."),
            next_topic = "TALK_Liam_Opinions_MISSION_ISHERWOOD_LUKE_2",
            when = predicates.has_mission("MISSION_ISHERWOOD_LUKE_2"),
        },
        {
            text = ccb.content.text("You think Barry's gonna be okay?"),
            next_topic = "TALK_Liam_Opinions_MISSION_ISHERWOOD_BARRY_1",
            when = predicates.has_mission("MISSION_ISHERWOOD_BARRY_1"),
        },
        {
            text = ccb.content.text("You know anything about how to troubleshoot a radio tower, Liam?"),
            next_topic = "TALK_Liam_Opinions_MISSION_ROBOFAC_MERC_1_RADIO",
            when = predicates.has_mission("MISSION_ROBOFAC_MERC_1_RADIO"),
        },
        {
            text = ccb.content.text("How do we explain what we saw out at the radio tower to the guys back at the Hub?"),
            next_topic = "TALK_Liam_Opinions_MISSION_ROBOFAC_MERC_1_RETURN_TO_HUB",
            when = predicates.has_mission("MISSION_ROBOFAC_MERC_1_RETURN_TO_HUB"),
        },
        {
            text = ccb.content.text("These guys seriously want us to try to take down a robot with EMP grenades.  How you feeling?"),
            next_topic = "TALK_Liam_Opinions_MISSION_ROBOFAC_INTERCOM_1",
            when = predicates.has_mission("MISSION_ROBOFAC_INTERCOM_1"),
        },
        {
            text = ccb.content.text("Think this will be an easy find and retrieve job, looking for the hard case?"),
            next_topic = "TALK_Liam_Opinions_MISSION_ROBOFAC_INTERCOM_2",
            when = predicates.has_mission("MISSION_ROBOFAC_INTERCOM_2"),
        },
        {
            text = ccb.content.text("This collapsed tower business sounds pretty risky.  Are you still in?"),
            next_topic = "TALK_Liam_Opinions_MISSION_ROBOFAC_INTERCOM_3",
            when = predicates.has_mission("MISSION_ROBOFAC_INTERCOM_3"),
        },
        {
            text = ccb.content.text("This robot interception stuff sounds pretty heavy, don't you think?"),
            next_topic = "TALK_Liam_Opinions_MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1",
            when = predicates.has_mission("MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1"),
        },
        {
            text = ccb.content.text("What are your thoughts on standing outside during a portal storm?  Seems like a good way to spend an evening right?"),
            next_topic = "TALK_Liam_Opinions_MISSION_ROBOFAC_INTERCOM_PORTAL_SM_1",
            when = predicates.has_mission("MISSION_ROBOFAC_INTERCOM_PORTAL_SM_1"),
        },
        {
            text = ccb.content.text("Liam, the guys in the secret lab want us to break into a secret lab."),
            next_topic = "TALK_Liam_Opinions_MISSION_ROBOFAC_INTERCOM_LIXA_SM_1",
            when = predicates.has_mission("MISSION_ROBOFAC_INTERCOM_LIXA_SM_1"),
        },
        {
            text = ccb.content.text("Looks like we're on a monster hunt, my friend."),
            next_topic = "TALK_Liam_Opinions_BEM_jabberwock_mission",
            when = predicates.has_mission("BEM_jabberwock_mission"),
        },
        {
            text = ccb.content.text("Does this 'human sample' business seem a little off to you?"),
            next_topic = "TALK_Liam_Opinions_BEM_human_sample_mission",
            when = predicates.has_mission("BEM_human_sample_mission"),
        },
        {
            text = ccb.content.text("Where should we look for one of those chemistry sets?"),
            next_topic = "TALK_Liam_Opinions_MISSION_CABIN_CHEMIST_GET_analytical_set_basic",
            when = predicates.has_mission("MISSION_CABIN_CHEMIST_GET_analytical_set_basic"),
        },
        {
            text = ccb.content.text("Fifteen liters of hydrochloric acid seems like a lot to me, don't you think?"),
            next_topic = "TALK_Liam_Opinions_MISSION_CABIN_CHEMIST_GET_60_chem_muriatic_acid",
            when = predicates.has_mission("MISSION_CABIN_CHEMIST_GET_60_chem_muriatic_acid"),
        },
        {
            text = ccb.content.text("What do you think is the best way to get a hundred liters of gas for this guy's generator?"),
            next_topic = "TALK_Liam_Opinions_MISSION_CABIN_CHEMIST_GET_500_GAS",
            when = predicates.has_mission("MISSION_CABIN_CHEMIST_GET_500_GAS"),
        },
        {
            text = ccb.content.text("Any thoughts about tracking down that refugee center?"),
            next_topic = "TALK_Liam_Opinions_MISSION_CABIN_CHEMIST_SET_TRADE_ROUTE_not_met_smokes",
            when = predicates.all({ predicates.has_mission("MISSION_CABIN_CHEMIST_SET_TRADE_ROUTE"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Gavin" } })) }),
        },
        {
            text = ccb.content.text("What do you think about connecting that chemist to the Free Merchants?"),
            next_topic = "TALK_Liam_Opinions_MISSION_CABIN_CHEMIST_SET_TRADE_ROUTE_has_met_smokes",
            when = predicates.all({ predicates.has_mission("MISSION_CABIN_CHEMIST_SET_TRADE_ROUTE"), predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Gavin" } }) }),
        },
        {
            text = ccb.content.text("Liam!  There's a chef, trapped in a restaurant!  Want to help save them?"),
            next_topic = "TALK_Liam_Opinions_directions_chef",
            when = predicates.has_mission("directions_chef"),
        },
        {
            text = ccb.content.text("What do you think about tracking down these survivors camping out on a farm?"),
            next_topic = "TALK_Liam_Opinions_directions_farmer",
            when = predicates.has_mission("directions_farmer"),
        },
        {
            text = ccb.content.text("Should we go track down this mystery cabin?"),
            next_topic = "TALK_Liam_Opinions_directions_hospital_2_CABIN",
            when = predicates.has_mission("directions_hospital_2_CABIN"),
        },
        {
            text = ccb.content.text("Liam, I've got the location of a prepper bunker.  Should we check this out?"),
            next_topic = "TALK_Liam_Opinions_directions_prepper_1_SHELTER",
            when = predicates.has_mission("directions_prepper_1_SHELTER"),
        },
        {
            text = ccb.content.text("How do you feel about checking out a zombie-infested farm?"),
            next_topic = "TALK_Liam_Opinions_directions_rural_1_FARM",
            when = predicates.has_mission("directions_rural_1_FARM"),
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_Liam",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_REACH_REFUGEE_CENTER",
    line = ccb.content.text("Sweet, road trip!  That sounds like as good a plan as any, my friend.  Gives me some first season Walking Dead vibes, you know?  Maybe the place will be run by sinister G-men, or a lone crazy scientist who thinks he can cure zombies if he can just get his hands on one super-rare ingredient.  Road trip!"),
    replies = {
        {
            text = ccb.content.text("Road trip!  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_FREE_MERCHANTS_HUB_DELIVERY_1",
    line = {
        when = predicates.handler("dlg_p_dda_9183061634b4"),
        yes = ccb.content.text("I'm thinking this kinda sounds like that intercom and their vague-yet-menacing government agency.\"  He pauses.  \"That might be a deep cut, if you never listened to Night Vale.  Anyway, I bet that's where we're going."),
        no = ccb.content.text("I'm thinking this sounds *awesome*, and also possibly we're gonna die.  At least we'll die investigating a vague-yet-menacing government agency.\"  He pauses.  \"That might be a deep cut, if you never listened to Night Vale."),
    },
    replies = {
        {
            text = ccb.content.text("Yep, same page.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_FREE_MERCHANTS_EVAC_1",
    line = ccb.content.text("*rubs his chin thoughtfully.  \"Maybe we can set up a bottleneck in the hallway?  First we drag a few lockers or something to funnel them, then one of us hangs close to the barricade and the other stands back and fires arrows or something?\"  He shrugs.  \"I'm not great at tactics, and I'm a bit nervous about what's back there.\""),
    replies = {
        {
            text = ccb.content.text("Thanks man.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_FREE_MERCHANTS_EVAC_2",
    line = ccb.content.text("You sure we haven't bit off more than we can chew here?\"  He stares at you for a moment.  \"This isn't DOTA2, this is real life.  These guys are gonna have guns and shit.  I know we've been through a lot together but if they're ready for us they could take us out before we're even close enough to see them.  I mean, I'm with you if you think we can do it, but be careful, okay?"),
    replies = {
        {
            text = ccb.content.text("Thanks man, I'll keep that in mind.  We gotta do this though.  Any suggestions for how to do it safely?"),
            next_topic = "TALK_Liam_Opinions_MISSION_FREE_MERCHANTS_EVAC_2-1",
        },
        {
            text = ccb.content.text("Thanks man, I'll keep that in mind.  We'll do this carefully.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_FREE_MERCHANTS_EVAC_2-1",
    line = ccb.content.text("If you're gonna insist on it then I say we drive up quick in the dark, take cover behind the car, and make a ton of noise.  Then we take cover and when they come to check things out, we pick them off.  Or maybe we come in silent, from a distance, and take out their sentries.  A bow is great for that, if we can make the shots.  This whole thing still seems ridiculous though."),
    replies = {
        {
            text = ccb.content.text("Thanks man, I'll keep that in mind.  We'll do this carefully.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_FREE_MERCHANTS_EVAC_3",
    line = ccb.content.text("I'm kinda looking forward to it.  It's good to see people already building up something to last, after everything that's gone down.  Wonder what we'll find out there."),
    replies = {
        {
            text = ccb.content.text("That's optimistic, thanks man.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_FREE_MERCHANTS_EVAC_4",
    line = ccb.content.text("You know, I read an article about how those stupid FEMA evac shelters all had solar power for emergencies.  I bet nobody's looting those, let's track some down and unbolt 'em."),
    replies = {
        {
            text = ccb.content.text("Not a bad thought.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_FREE_MERCHANTS_EVAC_5",
    line = ccb.content.text("Look, you're the one that agreed to this.  I don't know why you keep agreeing to this stuff.  Maybe we can check hardware stores?  Or just eat a lot of jarred food, and keep the empties?  A hundred jars.  That's a lot, my friend.\"  He shakes his head.  \"You don't have to agree to do *everything* people ask you to do, you know?"),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "u_liam_opinion_liam_MISSION_FREE_MERCHANTS_EVAC_5", "yes"),
            },
            once = "liam_opinion_liam_MISSION_FREE_MERCHANTS_EVAC_5",
        },
    },
    replies = {
        {
            text = ccb.content.text("Your objection is noted.  I'd like your opinion on something else, though."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_BROKER_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_liam_opinion_liam_MISSION_FREE_MERCHANTS_EVAC_5" } }),
        yes = ccb.content.text("*shakes his head at you.  \"Look, you asked last time, and I told you you didn't have to keep taking jobs like this.  Now you're asking again?  *I dunno, stop offering to bring a billion jars to people if you don't know where to find them.*\"  He laughs.  \"I'm just messing with you.\"  His eyes narrow.  \"Or am I?\""),
        no = ccb.content.text("Look, you're the one that agreed to this.  I don't know why you keep agreeing to this stuff.  Maybe we can check hardware stores?  Or just eat a lot of jarred food, and keep the empties?  A hundred jars.  That's a lot, my friend.\"  He shakes his head.  \"You don't have to agree to do *everything* people ask you to do, you know?"),
    },
    replies = {
        {
            text = ccb.content.text("Your objection is noted.  I'd like your opinion on something else, though."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_EVAC_SMOKER_GET_CIGARETTES",
    line = ccb.content.text("How about it?  Seems like a nice enough thing to do I guess.  I bet plenty of zombies are carrying smokes, and there's probably tons in people's abandoned cars."),
    replies = {
        {
            text = ccb.content.text("Yeah.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_directions_isherwood",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_met_an_isherwood" } }),
        yes = ccb.content.text("Isn't he just directing us out to that Isherwood farm?"),
        no = ccb.content.text("Sounds good.  I'm a bit nervous about what we might find, though.  Who knows what the apocalypse would do to a bunch of gun-toting back country folks?  On the other hand, maybe they're sweet, salt-of-the-earth types.  Only one way to find out!"),
    },
    replies = {
        {
            text = ccb.content.text("Right.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_directions_hub01",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_u_discovered_robofac_intercom" } }),
        yes = {
            when = predicates.handler("dlg_p_dda_9183061634b4"),
            yes = ccb.content.text("Is that just that Hub place, with the intercom?  Not that it's not cool, but it's nothing new to us.  Woah… we've really seen some shit, haven't we."),
            no = ccb.content.text("It sounds to me like this might be that intercom we found out in that weird building?  I'm just guessing.  We should go confirm."),
        },
        no = ccb.content.text("Hell yeah, this sounds so badass!  Let's be careful though, 'secret lab' sounds like a place that's gonna have some defenses."),
    },
    replies = {
        {
            text = ccb.content.text("You bet.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_directions_exodii",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Rubik" } }),
        yes = ccb.content.text("We've been there, remember?  It's got those cyborg guys, the cockney ones."),
        no = ccb.content.text("Far-fetched and awesome!  Let's go see.  Maybe it's an abandoned theme park or something."),
    },
    replies = {
        {
            text = ccb.content.text("I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_directions_artisans",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_met_isolated_road_artisans" } }),
        yes = {
            joined = {
                ccb.content.text("We've been there, remember"),
                {
                    when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_met_isolated_road_cody" } }),
                    yes = ccb.content.text("?  Cody, the blacksmith, she's the food lady"),
                    no = ccb.content.text("?  I'm guessing the blacksmith we didn't talk to is the one who would have fed us"),
                },
                {
                    when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_met_isolated_road_jay" } }),
                    yes = ccb.content.text(", and Jay is the one with the weird bullet bank."),
                    no = ccb.content.text(", and the other guy there must be the one with the bullet bank."),
                },
            },
        },
        no = ccb.content.text("I'm open to anything if it means getting fed.  Ugh, unless it's unidentified meat.  I guess we have to be more careful of strangers than we used to.  Still, let's find out."),
    },
    replies = {
        {
            text = ccb.content.text("I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_BEGGAR_2_BOX_SMALL",
    line = ccb.content.text("Well, I like his fashion choices, but he, um.  Well, you know.  You met him.  I don't mind helping him out, in theory, but I don't know if bringing him piles of trash is really going to do anyone any good.  The Merchants might think it's a fire hazard."),
    replies = {
        {
            text = ccb.content.text("Let's try it out anyway.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_BEGGAR_2_DUCT_TAPE",
    line = ccb.content.text("Right, I guess.  I don't quite get why you're doing this stuff for him, he's probably just going to keep piling up the stuff and not doing anything with it.\"  He shrugs.  \"On the other hand, maybe he'll make a kick-ass box fort, I'd be all about that."),
    replies = {
        {
            text = ccb.content.text("That's my hope.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_BEGGAR_2_BOX_MEDIUM",
    line = ccb.content.text("I'm telling you, this is just going to go on and on forever.\"  He looks sad.  \"I'd really love to see him get a cool box fort and feel better, but I think we're just enabling his delusions, my friend."),
    replies = {
        {
            text = ccb.content.text("Let's see this through a bit longer.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_BEGGAR_2_PLASTIC_SHEET",
    line = ccb.content.text("I gotta admit, this one surprised me.  I take back some of what I said earlier, I'm just confused now.  Let's see where it goes."),
    replies = {
        {
            text = ccb.content.text("Right?  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_BEGGAR_2_BOX_LARGE",
    line = ccb.content.text("It had better be!  I'm not sure why you're doing this, but I do think it's good you're trying to help him.  Maybe we should stop eventually though?\"  He sighs.  \"I don't know what to make of Dave.  I worked with a guy with schizophrenia back at Foodplace, and Dave is nothing like that.  I don't know if he's actually got some kind of mental illness or if it's a stress reaction or something.  He doesn't act like any real person I've ever met, and we got all kinds of strung-out types there."),
    replies = {
        {
            text = ccb.content.text("That's good insight.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_BEGGAR_2_PERMISSION",
    line = ccb.content.text("Well, I'm definitely interested to see where it goes.  I hope it helps Dave somehow.  I don't know what's going on with him except that it's nothing like any schizophrenia or anything like that I've ever seen, and I've seen practically anything you can imagine, working service."),
    replies = {
        {
            text = ccb.content.text("I have a good feeling.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_SCIENCE_REP_1",
    line = ccb.content.text("Well, it probably isn't going to come back alive.  They ooze blood everywhere, when we fight 'em.  It's kinda thicker and goopier than human blood, but I guess not so bad it'd be hard to draw?"),
    replies = {
        {
            text = ccb.content.text("Thanks.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_SCIENCE_REP_2",
    line = ccb.content.text("This sounds *nuts* man.  How are we going to get in and out alive?  A place like that is going to be crawling with zombies and who knows what else.\"  He shudders.  \"Let's be careful, right?"),
    replies = {
        {
            text = ccb.content.text("Okay.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_SCIENCE_REP_3",
    line = ccb.content.text("This was a total surprise to everyone,\" he grumbles.  \"Still, this can't be any worse than getting the first analysis done, right?"),
    replies = {
        {
            text = ccb.content.text("Let's hope not.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_SCIENCE_REP_4",
    line = {
        joined = {
            ccb.content.text("&He grins.  \"I'm gonna level with you, this sounds incredibly *cool*.\"  He laughs at his own joke.  \"Seriously though, it's probably going to be a really tricky one"),
            {
                when = predicates.has_trait("speaker", "CBM_Interface"),
                yes = ccb.content.text(".  It'd be good to maybe try cybernetics to help us with the cold, they won't be as bulky and confining to fight in as winter gear.\""),
                no = ccb.content.text(".  We'll need to bundle up extra toasty, that'll make fighting tough.\""),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Good thoughts.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_SCIENCE_REP_5",
    line = ccb.content.text("Compared to what we've done, this doesn't sound so bad.  Creepy as heck though.  We should tell ghost stories on the way."),
    replies = {
        {
            text = ccb.content.text("I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_RANCH_BARTENDER_1",
    line = ccb.content.text("I mean, I have a basic understanding of the principles.  We could also see if we could just find a couple stills though, we're not far from the mountains.  I bet every second farm's gonna have a moonshine still set up in one of the sheds."),
    replies = {
        {
            text = ccb.content.text("Good point, although really, how hard can it be to make one?  I'd like your opinion on something else, too."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_RANCH_BARTENDER_2",
    line = ccb.content.text("I think a supermarket might be the *yeast* likely place to find it!\"  He watches your expression for a moment, then shrugs.  \"Worth a shot.  Anyway, as far as I know, dry yeast lasts practically forever.  Should be able to find some of it anywhere people did baking or brewing."),
    replies = {
        {
            text = ccb.content.text("Thanks man.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_RANCH_BARTENDER_3",
    line = ccb.content.text("Those Tacoma folks really think about sustainability, hey?  I like that.  Buy local, you know?  I got no idea where to find sugar beet seeds though.  I don't remember having any stocked at the cabin.  Maybe a farm or farm supply store would have them?"),
    replies = {
        {
            text = ccb.content.text("Thanks man.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_RANCH_BARTENDER_4",
    line = ccb.content.text("*laughs.  \"If we track these things down for the bartender, I hope we get a nice, sincere 'tanks' at the end.\""),
    replies = {
        {
            text = ccb.content.text("Me too.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_RANCH_BARTENDER_5",
    line = ccb.content.text("There's only one way for two folks like us to transport two huge liquid storage drums.  We bundle ourselves in them and roll them down the hill.  First one to the bar buys the other one a drink."),
    replies = {
        {
            text = ccb.content.text("You know it'd be me.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_REFUGEE_Alonso_pants",
    line = ccb.content.text("Of all the jobs we've agreed to do, this is certainly one of them."),
    replies = {
        {
            text = ccb.content.text("You can say that again.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_REFUGEE_Boris_CLEANUP",
    line = ccb.content.text("I guess I get why the one Boris guy can't do it but I don't quite see why we have to go around asking everyone for him.  He lives here!  Anyway, you know I'm okay with getting my hands dirty, if you want to go offer to help him out I'll get busy with a scrubby.  I've cleaned worse things out of the Foodplace washroom.  Hell, I've cleaned worse things out of the back of my van when I was running for Amazon.\"  He gets a thousand-yard-stare for a moment.  \"Let's not discuss this any more."),
    on_enter = {
        { actions = { actions.set_actor_value("interlocutor", "mission_Boris_mission_1_cleanup_asked", "yes"), actions.handler("dlg_a_dda_ec2c95793aea") } },
    },
    replies = {
        {
            text = ccb.content.text("Thanks Liam, I knew I could count on you."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_REFUGEE_Boris_WORKSPACE",
    line = ccb.content.text("It's just a fetch job, right?  I'd say our best first bet would be to see if Smokes up at the Free Merchant desk has one, and just shell out to get it covered.  These guys are broke as heck, but we can easily make the cash back by doing some good old fashioned scavenging."),
    replies = {
        {
            text = ccb.content.text("Worth checking.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_REFUGEE_Boris_LAPTOP",
    line = ccb.content.text("&His voice comes out a bit softer and lower than usual.  \"This is just a sad one, my friend.  I don't think we'll have any troubles with the delivery, but it's so goddamn sad.\""),
    replies = {
        {
            text = ccb.content.text("You can say that again.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_REFUGEE_Dana_Sourdough",
    line = ccb.content.text("Nah, not me.  I hear they're hard to keep alive or something, and that makes me nervous.  I was never really that much of a baker to be honest.  I love the bread though, pretty excited to see what she makes.\"  He looks thoughtful for a moment.  \"Depending on where the bakery is though, this could be a heck of a job.  We should make sure we're ready to sneak past a lot of zed to get to it."),
    replies = {
        {
            text = ccb.content.text("Or we could clear the area some other way.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_REFUGEE_Draco_GET_GUITAR",
    line = ccb.content.text("*grins.  \"Yeah, he sure is.  I never got the hang of the guitar, myself, but I respect the journey.  It shouldn't be too hard to find one, right?  Lots of people have them in their houses, or we could maybe loot a music store if we want to get fancy.\""),
    replies = {
        {
            text = ccb.content.text("With your singing voice, I'm glad you never learned.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_REFUGEE_Fatima_1",
    line = ccb.content.text("Of course!  People need what comfort they can get, right?  I've always been kinda spiritual, but I'm not the sort to put a label on it or anything.  I don't have a clue where to find one though, I'm not sure I'd even recognize a mosque if I saw one.  Do they stock books like that in normal stores?\"  He frowns.  \"I feel like I should know this, but… well, no Wikipedia, right?"),
    replies = {
        {
            text = ccb.content.text("Cell phones were something else.  I'd like your opinion on a different thing though."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_REFUGEE_Jenny_GET_PNEUMATICS",
    line = ccb.content.text("&He scratches his head.  \"No.  I guess a library or a bookstore.  I have a feeling this is going to be a tough one though.  Maybe we could try like, hardware stores?  Or school libraries?\"  He thinks a bit more.  \"Those seem like our best bets to me, but I'm just guessing.\""),
    replies = {
        {
            text = ccb.content.text("Thanks, man.  I'd like your opinion on a different thing though."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_REFUGEE_Jenny_GET_MOTOR",
    line = ccb.content.text("This one sounds easy to me.  Let's just take apart some old machinery until we find a good one."),
    replies = {
        {
            text = ccb.content.text("Thanks, man.  I'd like your opinion on a different thing though."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_REFUGEE_Jenny_GET_TANK",
    line = ccb.content.text("Kinda wonder why she didn't just get us to get her a compressor, but she probably has her reasons.\"  You notice a bit of an odd tone to his voice.  \"Maybe we could take apart a big compressor for her, the tank would probably be perfect."),
    on_enter = {
        {
            once = "liam_crush1",
            actions = { actions.set_actor_value("speaker", "u_liam_jenny_feelings", "crush_suspected") },
        },
    },
    replies = {
        {
            text = ccb.content.text("Dude.  You have a crush on Jenny."),
            next_topic = "TALK_Liam_Jenny_CrushAccuse",
            when = predicates.negate(predicates.any_equal({ "crushing_hard", { scope = "speaker", key = "u_liam_jenny_feelings" } })),
        },
        {
            text = ccb.content.text("Thanks, man.  I'd like your opinion on a different thing though."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_REFUGEE_Jenny_GET_TEXT",
    line = ccb.content.text("*blushes, for some reason.  \"Uh, yeah.  Gun books, hey?  I guess we should look in um, gun stores or libraries?  Or high school lockers, haha.  Oh, that made me sad.\""),
    on_enter = {
        {
            once = "liam_crush1",
            actions = { actions.set_actor_value("speaker", "u_liam_jenny_feelings", "crush_suspected") },
        },
    },
    replies = {
        {
            text = ccb.content.text("Dude.  You have a crush on Jenny."),
            next_topic = "TALK_Liam_Jenny_CrushAccuse",
            when = predicates.negate(predicates.any_equal({ "crushing_hard", { scope = "speaker", key = "u_liam_jenny_feelings" } })),
        },
        {
            text = ccb.content.text("Thanks, man.  I'd like your opinion on a different thing though."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_REFUGEE_Jenny_GET_TEXTcrushmode",
    line = ccb.content.text("*blushes.  \"Yeah we are.\"  He smiles dopily, apparently forgetting that you'd asked for his thoughts."),
    replies = {
        {
            text = ccb.content.text("Any opinions on the job itself?"),
            next_topic = "TALK_Liam_Opinions_MISSION_REFUGEE_Jenny_GET_TEXTcrushmode2",
        },
        {
            text = ccb.content.text("Just wanted to point that out.  I'd like your opinion on a different thing though."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_REFUGEE_Jenny_GET_TEXTcrushmode2",
    line = ccb.content.text("Uh, right.  Maybe a gun store?  Or a library?  Or we could check high school lockers, haha.  Oh, that made me sad."),
    replies = {
        {
            text = ccb.content.text("You've got it *bad*, dude.  I'd like your opinion on a different thing though."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_TACOMA_Nunez",
    line = ccb.content.text("&He looks at you, a bit surprised.  \"Yeah, of course.  I mean, that situation they're in now is miserable, no matter how much we've helped folks out there.  Can you imagine trying to be a young couple in that cramped space?\"  He waggles his eyebrows suggestively.  \"They're tryin' to have a *baby*, you know.  Gonna be hard in a bunkhouse.  Let's get them out to a nice farm, some fresh air, and, *you* know.\"  He winks, to drive the point far, far further home than necessary.  \"Let the magic happen, right?\""),
    replies = {
        {
            text = ccb.content.text("That was unnecessarily clear.  Still, I'd like your opinion on a different thing, somehow."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_REFUGEE_Uyen_1",
    line = ccb.content.text("Seems pretty cut and dry to me.  Let's raid a few first aid kits.  I'm pretty sure you can find that stuff in the basement of those government evac shelters, for example."),
    replies = {
        {
            text = ccb.content.text("Thanks.  I'd like your opinion on a different thing, though."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_REFUGEE_Uyen_2",
    line = ccb.content.text("Kinda don't think she needs our help on this one, but she's in a bind I guess.\"  He pauses.  \"No pun intended this time,\" he chuckles.  \"Anyway, let's just find some spare fabric, choppy-choppy, and Bob's your uncle.\"  He thinks for a moment.  \"Actually she'll probably want them disinfected, and we should find her some tape too just to be on the safe side."),
    replies = {
        {
            text = ccb.content.text("Fair enough.  I'd like your opinion on a different thing, though."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_REFUGEE_Uyen_3",
    line = ccb.content.text("I admit, I haven't been paying attention to it, but I'm sure those things must be around in half the medicine cabinets in the area, right?  Seems like an easy looting job to me."),
    replies = {
        {
            text = ccb.content.text("Good point.  I'd like your opinion on a different thing, though."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_REFUGEE_Vanessa_1",
    line = ccb.content.text("Worse things we could do for people than help them get haircuts,\" he shrugs.  \"No job too small, right?  Vanessa seems a bit cranky to me, but I'm not judging.  Those folks are in a tough spot.  Maybe she'll turn suddenly nice if we bring her the hair stuff she wants.\"  He grins.  \"I'm one hundred percent sure that's what'll happen."),
    replies = {
        {
            text = ccb.content.text("That's my optimistic Liam.  I'd like your opinion on a different thing, though."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ARSONIST_1_AMMONIUM_NITRATE",
    line = ccb.content.text("*laughs.  \"Look, Makayla is a trained professional, she knows what she's doing with several kilograms of improvised explosives, doesn't she?\"  He shrugs.  \"If not, let's just stay far away when she tests it.\""),
    replies = {
        {
            text = ccb.content.text("That's my optimistic Liam.  I'd like your opinion on a different thing, though."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_1",
    line = ccb.content.text("*blows out a long breath.  \"Well, my friend, I do think it's good to help clean out some of the mess that's going on.  I'll be with you for it.  I'm just not sure why you figure I'm the right guy for this job.  Shouldn't you have, like, a cop or a soldier or something?  I'm a delivery driver.\""),
    replies = {
        {
            text = ccb.content.text("Don't sell yourself short, Liam.  You've got my back."),
            next_topic = "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_1-Reassure",
        },
        {
            text = ccb.content.text("I'll handle the tough parts, Liam.  You're there to cover my back, that's all."),
            next_topic = "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_1-Bravado",
        },
        {
            text = ccb.content.text("In troubled times, we learn what sort of people we really are."),
            next_topic = "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_1-Fortunecookie",
        },
        {
            text = ccb.content.text("Meh.  What's a few bandits?  We'll flatten 'em."),
            next_topic = "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_1-Psycho",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_1-Reassure",
    line = ccb.content.text("Thanks.  You're right.  Okay, I can do this.\"  He shakes his shoulders and limbers up, like a boxer preparing for a match.  \"Let's go."),
    replies = {
        {
            text = ccb.content.text("Hold up Balboa, I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_1-Bravado",
    line = ccb.content.text("Oh, oh yeah that makes sense.  Okay, well, that's something I can do.  I'll cover your back like it's never been covered before.  You and me like Calvin and Hobbes, baby."),
    replies = {
        {
            text = ccb.content.text("Thanks, Hooch.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_1-Fortunecookie",
    line = ccb.content.text("*sniffs the air around your head.  \"You been getting in the ganja?  No judgment if so, but maybe you shouldn't be taking mercenary jobs while you're high, y'know?\""),
    replies = {
        {
            text = ccb.content.text("Shut up, you're not my dad!  Anyway, I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_1-Psycho",
    line = ccb.content.text("*gives you some serious side-eye.  \"You okay?  This is serious shit, you're making me kinda worried getting so gung-ho about it.\""),
    replies = {
        {
            text = ccb.content.text("Don't worry, man.  Trust me, it'll be great.  Anyway, I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

-- I really need to touch up the informant quest :(
ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_2",
    line = ccb.content.text("You know, this sounds like it's gonna be some big exciting mystery whodunnit, but I have this feeling if we just look around for someone who is acting obviously and extremely suspicious it'll all fall apart at once."),
    replies = {
        {
            text = ccb.content.text("That's optimistic, thanks man.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_3-NotMet",
    line = ccb.content.text("I dunno, but compared to the last two missions for that guy, I gotta admit I'm kinda stoked.  Robots?  This sounds *wicked*.  Do you think we're talking more Terminator, or Wall-E?  Doesn't matter.  Robots!"),
    replies = {
        {
            text = ccb.content.text("Thanks man.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_3-HasMet",
    line = ccb.content.text("Uh, well, we *did* meet that weird cyborg guy in the castle full of giant robot dogs matching this exact description, right?  Tell me you remember that.  Damn, it's worse saying it out loud.  I still can't really believe all this stuff has really happened."),
    replies = {
        {
            text = ccb.content.text("Oh, right, I remember that.  I'd like your opinion on something else, though."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_4",
    line = ccb.content.text("You know me my friend,\" he shrugs and grins at you.  \"I'd have said it was some kinda cryptid or something *before* the world got flooded with monsters and mutants.  Nowadays, I think I'd be more surprised if it was bandits again.  As for how to deal with it, well, I guess we're getting pretty good at dealing with this kind of thing now.  Let's handle it how we usually do: with style."),
    replies = {
        {
            text = ccb.content.text("Damn straight.  I'd like your opinion on something else, though."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_5",
    line = ccb.content.text("I dunno,\" he points to your Marshal badge.  \"I guess if they give you a shiny bit of metal you're not really an assassin for hire anymore, you're the law.  Judge, jury, and executioner.\"  He scratches his neck and looks away for a moment.  \"You know how I feel about all these high risk missions, but we've gotten this far.  It's different now than when we started out.  I don't think you need my advice, you know I'll have your back whatever happens."),
    replies = {
        {
            text = ccb.content.text("I might not need it, but I still like to hear it.  I'd like your opinion on something else, anyway."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_OLD_GUARD_REPEATER_BEGIN",
    line = ccb.content.text("Honestly my friend, this is the kinda stuff I hoped we'd be doing when we offered to help these guys out.  Fresh air, great views, climbing on things we'd have gotten in trouble for in the old days, maybe pushing a zombie off the edge of a maintenance platform to see how big a splat it leaves at the bottom.  Sounds wicked.  Let's bring a couple cold ones up to the top and crack a brew while we survey the wasteland, hey?"),
    replies = {
        {
            text = ccb.content.text("Sounds like a great idea.  I'd like your opinion on something else, though."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_directions_exodii_signpost",
    line = ccb.content.text("Yeah, I'm with you there, it's some kind of weird map.  The smart thing to do is probably avoid it, this is some really weird shit.  I've never been one to do the smart thing though, myself.  Probably gonna have troubles sleeping until I know what that thing is trying to lead us to."),
    replies = {
        {
            text = ccb.content.text("I know what you mean.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_RUBIK_ANUS_FETICK",
    line = ccb.content.text("I just like, wanna back up a second.  We're trying to score drugs for a cyborg so it can do surgery on you?  That's really where life's taking us, now?"),
    replies = {
        { text = ccb.content.text("…Yes."), next_topic = "TALK_Liam_Opinions_RUBIK_ANUS_FETICK-1" },
        { text = ccb.content.text("Yes?"), next_topic = "TALK_Liam_Opinions_RUBIK_ANUS_FETICK-1" },
        { text = ccb.content.text("Yes!"), next_topic = "TALK_Liam_Opinions_RUBIK_ANUS_FETICK-1" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_RUBIK_ANUS_FETICK-1",
    line = ccb.content.text("*grins.  \"Okay, just wanted to clear that up.  I thought maybe I was having some kind of psychotic break, glad it's at least mutual.  Anyway, first place that comes to mind for that kinda stuff would be a hospital, but that's suicide.  Maybe a pharmacy?  Would they have the right stuff?  Seems like a stretch.  Maybe like, a vet clinic or a private surgery clinic might be safer?  I'll level with you, I never got into anything harder than Mary Jane, this is past my pay grade.\""),
    replies = {
        {
            text = ccb.content.text("Thanks man.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_EXODII_MISSION_CONTACT_HUB",
    line = ccb.content.text("Something about this kinda rubs me the wrong way, my friend.  I don't know what it is.  That Rubik guy seems nice enough but I feel like we're not getting the whole story.  Just tread carefully, okay?"),
    replies = {
        {
            text = ccb.content.text("Thanks man.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_EXODII_MISSION_WAREHOUSE",
    line = ccb.content.text("Seems to me we could be wandering the area forever just looking for this thing, to be honest.  I guess we could go up somewhere high like a radio tower, maybe with some binoculars, and see if we can spot it?  Our best bet might be to ask a few folks that have been around though, pool our resources."),
    replies = {
        {
            text = ccb.content.text("Thanks man.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_pizzaiolo_1",
    line = ccb.content.text("*leans in close, speaking softly, clearly trying to avoid notice from the pizzaiolo.  \"Are you sure we should be hanging with this guy?  He's not exactly all there, is he?  He reminds me a bit of Chris before things went all chompy-chompy.\""),
    replies = {
        {
            text = ccb.content.text("Chill, man.  It's just a little light arson, it'll be fine."),
            next_topic = "TALK_Liam_Opinions_MISSION_pizzaiolo_1-chill",
        },
        {
            text = ccb.content.text("I hear you, but he's following us now and I don't know how else to get rid of him."),
            next_topic = "TALK_Liam_Opinions_MISSION_pizzaiolo_1-yeah",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_pizzaiolo_1-chill",
    line = ccb.content.text("I guess everything else is wrecked already anyway, what's one more burning building?  And like, it *does* sound fun.  Let's just keep an eye on this guy, he's a slice short of a full pie, if you catch my drift."),
    replies = {
        {
            text = ccb.content.text("I knew you'd come around.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_pizzaiolo_1-yeah",
    line = ccb.content.text("True enough, and I don't wanna like, just *kill* him.  Well, I don't have anything against a bonfire this season I suppose.  Let's just make sure neither of us ends up lying face-down in a wood-fired oven, y'know?"),
    replies = {
        {
            text = ccb.content.text("We're on the same page.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

-- Be nice to have some different reply if the player is true foodperson here
ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_pizzaiolo_2",
    line = ccb.content.text("No.\"  He stares at you, his eyes wild.  For a moment, you barely know the man in front of you.  \"The things I've seen when I wore that mask… it changes you.  It's a burden you can't truly understand unless you've borne it.\"  He shudders, and becomes again the Liam you know.  \"Anyone who chooses to keep wearing it after the end of the world… putting them down would be a kindness, believe me."),
    replies = {
        {
            text = ccb.content.text("Uh… okay.  I'd like your opinion on something else, anyway."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_pizzaiolo_3",
    line = ccb.content.text("*shrugs.  \"My thoughts on Murder Mario haven't changed much, but he hasn't killed us yet.  I don't love the idea of just killing some other survivors for him.  Foodperson doesn't count.\"  He shudders and takes a quick breath.  \"I have a funny feeling they won't let us talk them out of there, though.\""),
    replies = {
        {
            text = ccb.content.text("Thanks man.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_pizzaiolo_4",
    line = ccb.content.text("What if the cake is a lie?  Also do you really want to follow this guy back to his house?  We both know that's not tomato sauce on his apron.  Don't eat anything he cooks.\"  He shrugs, giving a nonplussed look.  \"Still, we've committed actual murder for him multiple times now, so I guess I'm being a bit of a hypocrite.  Let's party."),
    replies = {
        {
            text = ccb.content.text("You didn't have fun?  I think this whole adventure has been a…"),
            next_topic = "TALK_Liam_Opinions_MISSION_pizzaiolo_4-slice",
        },
        {
            text = ccb.content.text("I think it's worth it all, for the cake.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_pizzaiolo_4-slice",
    line = ccb.content.text("…SLICE!\"  Liam shouts along with you, then gives you a leaping high five before dissolving into belly laughter.  \"OK fine, that makes all the murder and arson worth it, you mad bastard."),
    replies = {
        {
            text = ccb.content.text("That, and the cake.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_KILL_SLIMES",
    line = ccb.content.text("I feel like at some point we must have switched to playing Stardew Valley, and I'm not quite sure when that happened.\"  He scratches his head.  \"Oh well, let's just be sure to wear gumboots."),
    replies = {
        {
            text = ccb.content.text("And aprons.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_HUNT_ANTS",
    line = ccb.content.text("BUGHUNT!\"  Liam raises his arms over his head and grins.  \"BUUUG HUUUNT!\"  He mimes stomping on ants.  \"I'm doing my part!"),
    replies = {
        {
            text = ccb.content.text("I did actually want your opinion on something though."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_BUILD_CAMP_1",
    line = ccb.content.text("It's all good, I never minded doing deliveries, especially with a friend for company.  I guess we could try to find lumber in a lumberyard, right?  Probably not a lot of zombies hanging out in lumber yards.  Or maybe we could find an old barn and knock it down and take all the pieces.\"  He laughs.  \"Or saw it ourselves from scratch, if you're feeling like a mad lad.  Make sure we've got a vehicle that can fit it though, that much lumber ain't gonna fit in a hatchback."),
    replies = {
        {
            text = ccb.content.text("I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_BUILD_CAMP_2",
    line = ccb.content.text("Something, something, wood pun, something something.  This is starting to feel like Settlers of Catan, think they'll give us some sheep in return?"),
    replies = {
        {
            text = ccb.content.text("I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_BUILD_CAMP_3",
    line = ccb.content.text("Six ropes?  I find it hard to believe these guys can't just get 'em themselves, but, uh, OK I guess.  Maybe we could take some old seatbelts and tie them together, or something.  It shouldn't be hard to find a few ropes laying around."),
    replies = {
        {
            text = ccb.content.text("I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_BUILD_CAMP_4",
    line = ccb.content.text("Okay, wait, what?  One wood saw?  Why are you agreeing to this?  I like deliveries as much as the next guy, but it's a *single wood saw*.  It's starting to feel like you'll just agree to do anything anyone asks.\"  He sighs.  \"No worries though I guess.  One time I delivered a single cold soda to a guy living way out in the back woods.  Cost him seventy bucks.  People are weird."),
    replies = {
        {
            text = ccb.content.text("I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_BUILD_CAMP_5",
    line = ccb.content.text("A shovel?"),
    replies = {
        {
            text = ccb.content.text("Yeah, a shovel."),
            next_topic = "TALK_Liam_Opinions_MISSION_BUILD_CAMP_5-1",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_BUILD_CAMP_5-1",
    line = ccb.content.text("A shovel."),
    replies = {
        {
            text = ccb.content.text("That's right."),
            next_topic = "TALK_Liam_Opinions_MISSION_BUILD_CAMP_5-2",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_BUILD_CAMP_5-2",
    line = ccb.content.text("You're not joking."),
    replies = { { text = ccb.content.text("No."), next_topic = "TALK_Liam_Opinions_MISSION_BUILD_CAMP_5-3" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_BUILD_CAMP_5-3",
    line = ccb.content.text("*stares at you for a few seconds.  \"At the shovel store, I guess.\""),
    replies = { { text = ccb.content.text("Thanks."), next_topic = "TALK_Liam_Opinions" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_BUILD_CAMP_6",
    line = ccb.content.text("What now, a vegetable peele… oh, a smoker?  That's actually kinda legit I guess.  Maybe we should hunt through peoples' backyards.  We could jump over fences like in Shaun of the Dead!"),
    replies = {
        {
            text = ccb.content.text("I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_COWBOYT_SHOTGUN",
    line = ccb.content.text("I'm not a great expert on guns, to be honest.  I know how to shoot a bit, but my focus was always on archery when I was a kid.  That sounds like a pretty rare gun though, I think maybe we should see if we can find some old collector rather than trying to raid a gun store?  Just a guess."),
    replies = {
        {
            text = ccb.content.text("Thanks man.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_directions_lapin",
    line = ccb.content.text("Nah, you got it.  This is the sort of job that never, ever went wrong, certainly not in any one of a thousand TV tropes.  Let's go find an unknown old man in a secluded cabin."),
    replies = {
        {
            text = ccb.content.text("Glad we're on the same page.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_Warrener_LOG_1",
    line = ccb.content.text("Hell yeah I am.  This guy seems nice.  Bunnies are cute.  This is the sort of job I like, let's find him some logs.  We should be able to just hunt around the woods for 'em, right?  Might need a hatchet or a saw."),
    replies = {
        {
            text = ccb.content.text("I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_Warrener_FOOD_2",
    line = ccb.content.text("It sure does!  Is it blackberry season though?  I guess if they're not ripe, we could check around abandoned kitchens and fridges, see if we can find some that are still intact."),
    replies = {
        {
            text = ccb.content.text("Thanks man.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_Warrener_ISHERWOOD",
    line = ccb.content.text("Nah.  Lapin's sweet.  I wanna smoke a joint with the bunny man.  If you ever turn into a zombie I'm gonna come back here and settle down as an assistant bunny tamer.  Hope you don't mind."),
    replies = {
        {
            text = ccb.content.text("No hard feelings.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ISHERWOOD_CARLOS_1",
    line = ccb.content.text("An anvil?  Where do you come up with this stuff?  Yeah, I met this guy, Wile-E Coyote, he had a bunch of 'em."),
    replies = {
        {
            text = ccb.content.text("I'll track him down.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ISHERWOOD_CARLOS_2",
    line = ccb.content.text("I'm worried for these guys.  My gut tells me they're dealing with something really dangerous.  Let's make sure we're packing heat, you know?"),
    replies = {
        {
            text = ccb.content.text("Roger that.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ISHERWOOD_CHRIS_1",
    line = ccb.content.text("You can say that again.  This is some serious shit, my friend.  I know we've been through a lot, but this might be the big one.  We need to make sure we're ready for anything before we even consider going in there."),
    replies = {
        {
            text = ccb.content.text("Roger that.  I'd like your opinion on something else, first."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ISHERWOOD_CLAIRE_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_saved_barry_isherwood" } }),
        yes = ccb.content.text("After the shit these poor bastards have gone through, picking some dandelions for them seems kind of anticlimactic.  Still, I am a big fan of dandelion wine."),
        no = ccb.content.text("Picking flowers in a field seems okay to me.  I don't mind helping Claire out, she's a nice enough person.  Gotta say though, I get a bit of a weird vibe off these guys.  They're so… I don't know.  It's like we walked into a Norman Rockwell painting in the middle of the end of the world."),
    },
    replies = {
        {
            text = ccb.content.text("I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ISHERWOOD_CLAIRE_2",
    line = ccb.content.text("Bee bombs!  Kaboom!\"  He mimes an explosion with his hands.  \"Seriously though it's a very versatile plant, we should get some seeds for ourselves."),
    replies = {
        {
            text = ccb.content.text("I'll see what I can do.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ISHERWOOD_CLAIRE_3",
    line = ccb.content.text("*laughs.  \"I was going to make a joke about herding cats, but yours is better.  I was always more of a dog man myself, I don't know anything about catching a feral cat.  Maybe we open a can of tuna?  Or is that a cliché?\""),
    replies = {
        {
            text = ccb.content.text("I'm still… 'feline' it out myself.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ISHERWOOD_EDDIE_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_saved_barry_isherwood" } }),
        yes = ccb.content.text("Even if we work together it's gonna take a while to just find enough good rocks lying around.  We'll probably want to get a shovel and dig around a bit maybe?  Or break up bigger ones with a sledge.  I'm impressed at these guys, keeping going after everything that's happened."),
        no = ccb.content.text("Even if we work together it's gonna take a while to just find enough good rocks lying around.  We'll probably want to get a shovel and dig around a bit maybe?  Or break up bigger ones with a sledge.  Something about this stuff feels weird to me though.  Too pastoral for the apocalypse."),
    },
    replies = {
        {
            text = ccb.content.text("Yeah, I hear you.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ISHERWOOD_EDDIE_2",
    line = ccb.content.text("Gathering sand sounds, honestly, sort of pleasant.  Like, meditative, you know?  Maybe we find some batteries and get a bit of music going, smoke a joint if you're so inclined, then fill some buckets of sand for Eddie to do whatever the hell he's doing with it.  No zombies, no gunfire, just sand."),
    replies = {
        {
            text = ccb.content.text("I believe he's making bricks.  I'd like your opinion on something else, though."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ISHERWOOD_EDDIE_3",
    line = ccb.content.text("I like a good, well defined physical job.  Let's go to the riverside!  I feel like the odds of getting badly injured while gathering clay are sort of low.  Make sure to get some music going though, right?  Maybe bring some refreshments?  And shovels."),
    replies = {
        {
            text = ccb.content.text("You do make it sound good.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ISHERWOOD_JACK_1",
    line = ccb.content.text("Big jars aren't really that uncommon.  Lots of people got super into canning in the last few months before shit really hit the fan, like they did with toilet paper a few years back.  Maybe a bit more reasonable, I guess, though learning how to pickle meat probably didn't save anyone from zombies.  I bet we can track down a few just by raiding houses, and if they're not empty we'll just have to eat what's inside or something."),
    replies = {
        {
            text = ccb.content.text("Do you need a snack, man?  Never mind.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ISHERWOOD_JACK_2",
    line = ccb.content.text("I'm sort of surprised they don't have plenty of wheat seeds of their own,\" Liam shrugs.  \"What the hell do I know about farming though?  Nothing, that's what.  Including having no idea about where to find wheat seeds, sorry man.  I would have said 'on a farm' but we're on one and they're asking us, so I just don't know what to think anymore.  My life is a shambles."),
    replies = {
        {
            text = ccb.content.text("Fair enough.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ISHERWOOD_JESSE_1",
    line = ccb.content.text("You know, it's a harmful stereotype that wolves are dangerous to humans.  Of course I'm not afraid.\"  He smirks at you, then grins.  \"Except let's be honest, this is probably going to be a giant monster zombie wolf or something, right?  Let's go take the bastard down."),
    replies = {
        {
            text = ccb.content.text("That's the spirit.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ISHERWOOD_JESSE_2",
    line = ccb.content.text("Fast, unidentified monsters are killing the local wildlife, and we're going to get 'em.\"  He looks thoughtful.  \"I'm pretty sure this was an episode of the X-Files.  Or like, several episodes?  As long as we're Scully and Mulder we'll be fine, but if we're the local cops coming in to investigate, we're *toast*.  Just in case, let's make sure we've got our good gear."),
    replies = {
        {
            text = ccb.content.text("Will do, Scully.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ISHERWOOD_LUKE_1",
    line = ccb.content.text("Funny you should ask, yeah I have.  My dad borrowed it from the library once and I leafed through it.  So I guess we could try looking at a library?  I got no better ideas, I was like thirteen, I don't remember what was in the thing, and he got all pissy at me for checking it out anyway."),
    replies = {
        {
            text = ccb.content.text("Fair enough.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ISHERWOOD_LUKE_2",
    line = ccb.content.text("Well, yeah he does, because he's a man of discerning tastes.\"  Liam nods approvingly.  \"Or because he wants something to prop his car up while he changes the tire.  It's a big book, is what I'm saying.  We should make sure we've got a copy for ourselves though, it's one of the prepper bibles."),
    replies = {
        {
            text = ccb.content.text("Great info, thanks.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ISHERWOOD_BARRY_1",
    line = ccb.content.text("*leans in close, speaking softly.  \"I do not say this lightly: this motherfucker has *seen some shit*.  Look at that thousand-yard-stare.  We did a good thing getting him out, but I don't know if he's ever really gonna be *out*, you know?\""),
    replies = {
        {
            text = ccb.content.text("Do you think we can do anything for him?"),
            next_topic = "TALK_Liam_Opinions_MISSION_ISHERWOOD_BARRY_1-help1",
        },
        {
            text = ccb.content.text("He'll suck it up.  We've all been through shit."),
            next_topic = "TALK_Liam_Opinions_MISSION_ISHERWOOD_BARRY_1-toughlove",
        },
        {
            text = ccb.content.text("Scary stuff.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ISHERWOOD_BARRY_1-help1",
    line = ccb.content.text("We can get him home in one piece.  Get him back to his people.  I'd offer him a drink or a toke, but I think they're like, Amish or something.  After that, our best bet is to make ourselves scarce, to him we're always gonna be the people he met in the tower.  He won't wanna be reminded of that."),
    replies = {
        {
            text = ccb.content.text("How do you know so much about this?"),
            next_topic = "TALK_Liam_Opinions_MISSION_ISHERWOOD_BARRY_1-help2",
        },
        {
            text = ccb.content.text("Scary stuff.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ISHERWOOD_BARRY_1-help2",
    line = ccb.content.text("*looks abruptly uncomfortable.  \"You know a bit about me and my dad, right?  I went to counseling for a few years after I got out.  Since what went down with Chris, I've been thinking about it more too.\"  He shakes his head.  \"We could all use a decent counsellor, honestly.  Even before the world ended.\""),
    replies = {
        {
            text = ccb.content.text("Thanks, man.  You have layers.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ISHERWOOD_BARRY_1-toughlove",
    line = ccb.content.text("Yeah, I guess we have.\"  Liam looks off into the distance for a moment.  \"We sure fuckin' have."),
    replies = {
        {
            text = ccb.content.text("Damn straight.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ROBOFAC_MERC_1_RADIO",
    line = ccb.content.text("&He laughs.  \"Heck yeah, my friend, I picked that up here and there running deliveries for Amazon, during my famously long breaks.\"  He grins.  \"Seriously though, I hope it's something obvious, like a big disconnected dish.  Even if we can't figure it out, I'm looking forward to climbing up there, I love that shit.  Seems like a nice fun one.\""),
    replies = {
        {
            text = ccb.content.text("Cool.  I'd like your opinion on something else, though."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ROBOFAC_MERC_1_RETURN_TO_HUB",
    line = ccb.content.text("*stares at you.  \"I'm leaving that one to you.  I can't believe I was excited for that mission, that critter was *weird*.  I guess it did make it easy to figure out what was going on though, so that's cool right?\""),
    replies = {
        {
            text = ccb.content.text("Yeah, 'cool'.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ROBOFAC_INTERCOM_1",
    line = ccb.content.text("How do you think I'm feeling?  *Amazing* of course.  Can I hold the EMP grenades?  Please?\"  He lightens up his grin, just a little.  \"Hope Dr. Prado is OK though."),
    replies = {
        {
            text = ccb.content.text("We'll see about the grenades, but I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ROBOFAC_INTERCOM_2",
    line = ccb.content.text("I want to say… yes?\"  He rubs his chin.  \"Yes.  This is going to be an easy find-and-fetch job and nothing could possibly go wrong.\"  He grins.  \"There, now you have it from the source."),
    replies = {
        {
            text = ccb.content.text("Great, thanks for predicting that.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ROBOFAC_INTERCOM_3",
    line = ccb.content.text("&He cocks his head at you.  \"My friend, I'm in.  It sounds risky as hell, I'm not letting you go in there alone!  Let's get as geared up as possible though.  Hazard suits.  Heavy armor.  Big guns.  Can I have some EMP grenades?  Please?\""),
    replies = {
        {
            text = ccb.content.text("What is it with you and EMP grenades?  Anyway, I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1",
    line = ccb.content.text("Yeah.  It sounds like we're gonna need some serious mechanical or electrical know-how if we're gonna take it down.  Big responsibility.  If we can pull it off, though, it'll be *so cool*."),
    replies = {
        {
            text = ccb.content.text("Do you think you know enough to handle the technical side?"),
            next_topic = "TALK_Liam_Opinions_MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1_Skills_hasskills",
            when = predicates.handler("dlg_p_dda_68153d1aa270"),
        },
        {
            text = ccb.content.text("Do you think you know enough to handle the technical side?"),
            next_topic = "TALK_Liam_Opinions_MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1_Skills_noskills",
            when = predicates.handler("dlg_p_dda_a8b242afed9f"),
        },
        {
            text = ccb.content.text("Yeah.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1_Skills_hasskills",
    line = ccb.content.text("Maybe?  It's hard to say without seeing the machine, but I know my way around enough to at least try."),
    replies = {
        {
            text = ccb.content.text("Gotcha.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1_Skills_noskills",
    line = ccb.content.text("What?  Me?  Dismantle a *robot*?  I love that you've got this kind of faith in me, my friend, but my contribution here is going to be a lot more smashy-smashy, less thinky-thinky."),
    replies = {
        {
            text = ccb.content.text("Gotcha.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ROBOFAC_INTERCOM_PORTAL_SM_1",
    line = ccb.content.text("*stares at you for a moment.  \"Remember when we were kids, and that huge storm hit?  I thought it was a hurricane, and we ran outside, and that tree fell down like just down the road, and smashed that guy's car?\"  He grins.  \"That was awesome.  Let's do that again!\""),
    replies = {
        {
            text = ccb.content.text("Let's hope it's not *our* car getting smashed this time.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ROBOFAC_INTERCOM_LIXA_SM_1",
    line = ccb.content.text("Yo dawg, we heard you like science labs.\"  He grins.  \"My guess is there's gonna be some serious defenses in there.  We should stick together, and make sure we've got our best gear."),
    replies = {
        {
            text = ccb.content.text("Agreed.  Don't go running around a corner and eating turret fire.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_BEM_jabberwock_mission",
    line = ccb.content.text("I'm always a fan of a good monster hunt.  Anything that could shake up a merc like that is gonna be pretty serious business, though.  We better pack some heat.  Probably something we can use to take it on at range, I'm not keen to go toe-to-toe with something like that."),
    replies = {
        {
            text = ccb.content.text("That's your advice for everything.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_BEM_human_sample_mission",
    line = ccb.content.text("Yes, it does,\" he admits.  \"I'm not the one that took the job though.  Let's maybe get it from a feral though, right?  Not some hapless dork?"),
    replies = {
        {
            text = ccb.content.text("Right… Right.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_CABIN_CHEMIST_GET_analytical_set_basic",
    line = ccb.content.text("There were a lot of private research centers in this part of the world.  I bet we could raid one of them.  It seems like the kind of thing that might be in a hospital, too."),
    replies = {
        {
            text = ccb.content.text("I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_CABIN_CHEMIST_GET_60_chem_muriatic_acid",
    line = ccb.content.text("I guess, but the chemisty seemed to know about it.  Maybe it's easier to find it big bottles in some place they keep chemistry supplies.  Come to think of it, were there some back where we got the chemisty set?"),
    replies = {
        {
            text = ccb.content.text("I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_CABIN_CHEMIST_GET_500_GAS",
    line = ccb.content.text("I think the biggest trick is just storing it.  That's 25 gallons, right?  I'm pretty sure we can get that much by siphoning from a bunch of cars, no big problem there, but it's a lot to carry around.  Maybe we could clean out a couple dozen milk jugs?"),
    replies = {
        {
            text = ccb.content.text("We'll think of something.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_CABIN_CHEMIST_SET_TRADE_ROUTE_not_met_smokes",
    line = ccb.content.text("It sounds like a hell of a road trip, getting to a place like that, but I think it's a great idea to check it out.  If all the evac shelters point to it, there could be some more survivors there."),
    replies = {
        {
            text = ccb.content.text("We'll see soon enough.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_CABIN_CHEMIST_SET_TRADE_ROUTE_has_met_smokes",
    line = ccb.content.text("Well, you know what Smokes is gonna say.  'No room at the refugee center, not even for a skilled chemist.'  I bet they'll be willing to set up a trade route or something, though."),
    replies = {
        {
            text = ccb.content.text("We'll see soon enough.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_directions_chef",
    line = ccb.content.text("*rubs his chin.  \"Mmmaaaybe?  What kind of chef?  I worked as a dishwasher in a fancy place for a couple months.  If they're a line chef, then yes.  Sous-chef or above?  Leave 'em for the zombies.\"  He pauses, staring into space for a moment.  \"I hated that job.\""),
    replies = {
        {
            text = ccb.content.text("Duly noted.  I'd like your opinion on something else, though."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_directions_farmer",
    line = ccb.content.text("Seems like a good idea to me.  If they're alive, then we meet some new people, that's always fun.\"  He hesitates.  \"Well, it used to always be fun.  New people are a bit scarier these days.  But still, as a general rule, I'm a fan.  Anyway, if they're not alive, then we clear 'em out and we have a farm of our very own.  It's win-win, as long as none of us gets devoured by an undead menace."),
    replies = {
        {
            text = ccb.content.text("Well summarized.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_directions_hospital_2_CABIN",
    line = ccb.content.text("We could if you want.  I got complex feelings about prepper cabins in the woods, obviously.  As far as loot goes though, they're pretty top tier, and low-risk.  Maybe we'll find a nice bow.  Or like, guns or whatever.  Or a bow!"),
    replies = {
        {
            text = ccb.content.text("You and your death springs.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_directions_prepper_1_SHELTER",
    line = ccb.content.text("Fuck yeah we should.  Usually I'd be all, 'be careful my friend, preppers leave traps 'n shit', but in this case we have said prepper's word on the matter.  We could be running our operation from a cozy, well protected bunker!  What are we waiting for?"),
    replies = {
        {
            text = ccb.content.text("Thanks for the enthusiasm.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_directions_rural_1_FARM",
    line = ccb.content.text("Normally I'd say something about needing to be careful, blah blah, and that's all true, but we're doing this for a friend, so I'm way more keen.  Let's help out our new pal.  The three of us can handle this, right?"),
    replies = {
        {
            text = ccb.content.text("Right on.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = {
        "TALK_Liam_Opinions_MISSION_REACH_REFUGEE_CENTER",
        "TALK_Liam_Opinions_MISSION_FREE_MERCHANTS_HUB_DELIVERY_1",
        "TALK_Liam_Opinions_MISSION_FREE_MERCHANTS_EVAC_1",
        "TALK_Liam_Opinions_MISSION_FREE_MERCHANTS_EVAC_2",
        "TALK_Liam_Opinions_MISSION_FREE_MERCHANTS_EVAC_2-1",
        "TALK_Liam_Opinions_MISSION_FREE_MERCHANTS_EVAC_3",
        "TALK_Liam_Opinions_MISSION_FREE_MERCHANTS_EVAC_4",
        "TALK_Liam_Opinions_MISSION_FREE_MERCHANTS_EVAC_5", "TALK_Liam_Opinions_MISSION_BROKER_1",
        "TALK_Liam_Opinions_MISSION_EVAC_SMOKER_GET_CIGARETTES",
        "TALK_Liam_Opinions_directions_isherwood", "TALK_Liam_Opinions_directions_hub01",
        "TALK_Liam_Opinions_directions_exodii", "TALK_Liam_Opinions_directions_artisans",
        "TALK_Liam_Opinions_MISSION_BEGGAR_2_BOX_SMALL", "TALK_Liam_Opinions_MISSION_BEGGAR_2_DUCT_TAPE",
        "TALK_Liam_Opinions_MISSION_BEGGAR_2_BOX_MEDIUM",
        "TALK_Liam_Opinions_MISSION_BEGGAR_2_PLASTIC_SHEET",
        "TALK_Liam_Opinions_MISSION_BEGGAR_2_BOX_LARGE",
        "TALK_Liam_Opinions_MISSION_BEGGAR_2_PERMISSION", "TALK_Liam_Opinions_MISSION_SCIENCE_REP_1",
        "TALK_Liam_Opinions_MISSION_SCIENCE_REP_2", "TALK_Liam_Opinions_MISSION_SCIENCE_REP_3",
        "TALK_Liam_Opinions_MISSION_SCIENCE_REP_4", "TALK_Liam_Opinions_MISSION_SCIENCE_REP_5",
        "TALK_Liam_Opinions_MISSION_RANCH_BARTENDER_1", "TALK_Liam_Opinions_MISSION_RANCH_BARTENDER_2",
        "TALK_Liam_Opinions_MISSION_RANCH_BARTENDER_3", "TALK_Liam_Opinions_MISSION_RANCH_BARTENDER_4",
        "TALK_Liam_Opinions_MISSION_RANCH_BARTENDER_5",
        "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_1-Reassure",
        "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_1-Bravado",
        "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_1-Fortunecookie",
        "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_1-Psycho",
        "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_2",
        "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_3-NotMet",
        "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_3-HasMet",
        "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_4", "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_5",
        "TALK_Liam_Opinions_MISSION_OLD_GUARD_REPEATER_BEGIN",
        "TALK_Liam_Opinions_MISSION_ARSONIST_1_AMMONIUM_NITRATE",
        "TALK_Liam_Opinions_MISSION_REFUGEE_Alonso_pants",
        "TALK_Liam_Opinions_MISSION_REFUGEE_Boris_CLEANUP",
        "TALK_Liam_Opinions_MISSION_REFUGEE_Boris_WORKSPACE",
        "TALK_Liam_Opinions_MISSION_REFUGEE_Boris_LAPTOP",
        "TALK_Liam_Opinions_MISSION_REFUGEE_Dana_Sourdough",
        "TALK_Liam_Opinions_MISSION_REFUGEE_Draco_GET_GUITAR",
        "TALK_Liam_Opinions_MISSION_REFUGEE_Fatima_1",
        "TALK_Liam_Opinions_MISSION_REFUGEE_Jenny_GET_PNEUMATICS",
        "TALK_Liam_Opinions_MISSION_REFUGEE_Jenny_GET_MOTOR",
        "TALK_Liam_Opinions_MISSION_REFUGEE_Jenny_GET_TANK",
        "TALK_Liam_Opinions_MISSION_REFUGEE_Jenny_GET_TEXT",
        "TALK_Liam_Opinions_MISSION_REFUGEE_Jenny_GET_TEXTcrushmode",
        "TALK_Liam_Opinions_MISSION_REFUGEE_Jenny_GET_TEXTcrushmode2",
        "TALK_Liam_Opinions_MISSION_REFUGEE_Uyen_1", "TALK_Liam_Opinions_MISSION_REFUGEE_Uyen_2",
        "TALK_Liam_Opinions_MISSION_REFUGEE_Uyen_3", "TALK_Liam_Opinions_MISSION_REFUGEE_Vanessa_1",
        "TALK_Liam_Opinions_MISSION_TACOMA_Nunez", "TALK_Liam_Opinions_directions_exodii_signpost",
        "TALK_Liam_Opinions_RUBIK_ANUS_FETICK-1", "TALK_Liam_Opinions_EXODII_MISSION_CONTACT_HUB",
        "TALK_Liam_Opinions_EXODII_MISSION_WAREHOUSE", "TALK_Liam_Opinions_MISSION_pizzaiolo_1-chill",
        "TALK_Liam_Opinions_MISSION_pizzaiolo_1-yeah", "TALK_Liam_Opinions_MISSION_pizzaiolo_2",
        "TALK_Liam_Opinions_MISSION_pizzaiolo_3", "TALK_Liam_Opinions_MISSION_pizzaiolo_4",
        "TALK_Liam_Opinions_MISSION_pizzaiolo_4-slice", "TALK_Liam_Opinions_MISSION_KILL_SLIMES",
        "TALK_Liam_Opinions_MISSION_HUNT_ANTS", "TALK_Liam_Opinions_MISSION_BUILD_CAMP_1",
        "TALK_Liam_Opinions_MISSION_BUILD_CAMP_2", "TALK_Liam_Opinions_MISSION_BUILD_CAMP_3",
        "TALK_Liam_Opinions_MISSION_BUILD_CAMP_4", "TALK_Liam_Opinions_MISSION_BUILD_CAMP_5-3",
        "TALK_Liam_Opinions_MISSION_BUILD_CAMP_6", "TALK_Liam_Opinions_MISSION_COWBOYT_SHOTGUN",
        "TALK_Liam_Opinions_directions_lapin", "TALK_Liam_Opinions_MISSION_Warrener_LOG_1",
        "TALK_Liam_Opinions_MISSION_Warrener_FOOD_2", "TALK_Liam_Opinions_MISSION_Warrener_ISHERWOOD",
        "TALK_Liam_Opinions_MISSION_ISHERWOOD_CARLOS_1", "TALK_Liam_Opinions_MISSION_ISHERWOOD_CARLOS_2",
        "TALK_Liam_Opinions_MISSION_ISHERWOOD_CHRIS_1", "TALK_Liam_Opinions_MISSION_ISHERWOOD_CLAIRE_1",
        "TALK_Liam_Opinions_MISSION_ISHERWOOD_CLAIRE_2", "TALK_Liam_Opinions_MISSION_ISHERWOOD_CLAIRE_3",
        "TALK_Liam_Opinions_MISSION_ISHERWOOD_EDDIE_1", "TALK_Liam_Opinions_MISSION_ISHERWOOD_EDDIE_2",
        "TALK_Liam_Opinions_MISSION_ISHERWOOD_EDDIE_3", "TALK_Liam_Opinions_MISSION_ISHERWOOD_JACK_1",
        "TALK_Liam_Opinions_MISSION_ISHERWOOD_JACK_2", "TALK_Liam_Opinions_MISSION_ISHERWOOD_JESSE_1",
        "TALK_Liam_Opinions_MISSION_ISHERWOOD_JESSE_2", "TALK_Liam_Opinions_MISSION_ISHERWOOD_LUKE_1",
        "TALK_Liam_Opinions_MISSION_ISHERWOOD_LUKE_2", "TALK_Liam_Opinions_MISSION_ISHERWOOD_BARRY_1",
        "TALK_Liam_Opinions_MISSION_ISHERWOOD_BARRY_1-help1",
        "TALK_Liam_Opinions_MISSION_ISHERWOOD_BARRY_1-help2",
        "TALK_Liam_Opinions_MISSION_ISHERWOOD_BARRY_1-toughlove",
        "TALK_Liam_Opinions_MISSION_ROBOFAC_MERC_1_RADIO",
        "TALK_Liam_Opinions_MISSION_ROBOFAC_MERC_1_RETURN_TO_HUB",
        "TALK_Liam_Opinions_MISSION_ROBOFAC_INTERCOM_1", "TALK_Liam_Opinions_MISSION_ROBOFAC_INTERCOM_2",
        "TALK_Liam_Opinions_MISSION_ROBOFAC_INTERCOM_3",
        "TALK_Liam_Opinions_MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1",
        "TALK_Liam_Opinions_MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1_Skills",
        "TALK_Liam_Opinions_MISSION_ROBOFAC_INTERCOM_PORTAL_SM_1",
        "TALK_Liam_Opinions_MISSION_ROBOFAC_INTERCOM_LIXA_SM_1",
        "TALK_Liam_Opinions_BEM_jabberwock_mission", "TALK_Liam_Opinions_BEM_human_sample_mission",
        "TALK_Liam_Opinions_MISSION_CABIN_CHEMIST_GET_analytical_set_basic",
        "TALK_Liam_Opinions_MISSION_CABIN_CHEMIST_GET_60_chem_muriatic_acid",
        "TALK_Liam_Opinions_MISSION_CABIN_CHEMIST_GET_500_GAS",
        "TALK_Liam_Opinions_MISSION_CABIN_CHEMIST_SET_TRADE_ROUTE_not_met_smokes",
        "TALK_Liam_Opinions_MISSION_CABIN_CHEMIST_SET_TRADE_ROUTE_has_met_smokes",
        "TALK_Liam_Opinions_directions_chef", "TALK_Liam_Opinions_directions_farmer",
        "TALK_Liam_Opinions_directions_hospital_2_CABIN",
        "TALK_Liam_Opinions_directions_prepper_1_SHELTER", "TALK_Liam_Opinions_directions_rural_1_FARM",
    },
    replies = {
        {
            text = ccb.content.text("I want to talk about something a bit more fundamental now."),
            next_topic = "TALK_FRIEND_Liam",
        },
        {
            text = ccb.content.text("Can we chat about something else?"),
            next_topic = "TALK_Liam_SOCIAL",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
