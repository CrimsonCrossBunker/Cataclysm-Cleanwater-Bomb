local ccb = require("ccb")

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
