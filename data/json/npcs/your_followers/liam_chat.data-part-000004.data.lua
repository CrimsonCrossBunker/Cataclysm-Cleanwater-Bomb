local ccb = require("ccb")

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
