local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- If you have met her already, skip the introduction and go to the normal menu.
-- If you haven't met her, go to her non-earthborn introduction.
-- If you haven't met her and your Earthborn she chastizes you harder. Her exerpiences with Artemis makes her assume you're a panzy.
ccb.content.define_dialogue_topic {
    id = { "TALK_SALVOR_FABRICATOR" },
    line = ccb.content.text("&As you approach the counter, you can't help but notice the chaotic scene before you: Juxtaposed to the makeshift structure, an awkward marriage of ship hulls and foamcrete walls, stands neatly arranged shelving, and near-pristine furniture.  The tools and parts lining the shelves have each been meticulously arranged.  A Salvor sits behind the counter with her arm perched on the surface, supporting her head in her hand.  In her other hand, she idly waves a cigarette, making small circles in the air.  Gray hairs peek out from the edges of her Cryo suit, and her wrinkle-creased face wears a permanent scowl."),
    replies = {
        {
            text = ccb.content.text("[Approach the counter]"),
            next_topic = "TALK_SALVOR_FABRICATOR_MAIN",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "player_has_met" } }),
        },
        {
            text = ccb.content.text("[Approach the counter]"),
            next_topic = "TALK_SALVOR_FABRICATOR_INTRODUCTION",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "player_has_met" } })), predicates.negate(predicates.has_trait("speaker", "BKGR_EARTH")) }),
        },
        {
            text = ccb.content.text("[Approach the counter]"),
            next_topic = "TALK_SALVOR_FABRICATOR_INTRODUCTION_EARTH",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "player_has_met" } })), predicates.has_trait("speaker", "BKGR_EARTH") }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_SALVOR_FABRICATOR_INTRODUCTION_EARTH" },
    line = ccb.content.text("Great, another Earther descends from the heavens.  Did you come all the way here to grace us with your presence?  If you've any brains in that thick skull: you take whatever money you have left and get your sorry ass off this rock.  Salus ain't for you."),
    replies = {
        {
            text = ccb.content.text("I can't do that."),
            next_topic = "TALK_SALVOR_FABRICATOR_INTRODUCTION_2",
        },
        {
            text = ccb.content.text("You got some kind of problem with Earthers?"),
            next_topic = "TALK_SALVOR_FABRICATOR_INTRODUCTION_EARTH_BIAS_EXPLAIN",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_SALVOR_FABRICATOR_INTRODUCTION_EARTH_BIAS_EXPLAIN" },
    line = ccb.content.text("Your kind are all the same.  Born on the ol' celestial throne Sol, silver spoon in your mouth.  Everywhere you go, you're walk'n and talk'n like you own the place.  Bumbling through the stars without a clue.  Spit'n out the Corpo bullshit they been feeding you till you die for the glory of ol' Earth.  I've seen enough Earth kids come through here to know you type.  Here to bite it just like they did?"),
    replies = {
        {
            text = ccb.content.text("I didn't come here to die."),
            next_topic = "TALK_SALVOR_FABRICATOR_INTRODUCTION_EARTH_BIAS_EXPLAIN_2",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_SALVOR_FABRICATOR_INTRODUCTION_EARTH_BIAS_EXPLAIN_2" },
    line = ccb.content.text("Course you didn't.  But death's all you'll find here.  You step into those icy wastes and you ain't wandering back.  A bot'll blow your brains out or a Wraith splatter you into some many pieces that even the med bots can't put your carcass back together.  And if you ain't lucky the moxies'll mob you.  Now the way they tear a person apart, it ain't a sight that ever leaves you."),
    replies = {
        {
            text = ccb.content.text("Leaving isn't an option for me."),
            next_topic = "TALK_SALVOR_FABRICATOR_INTRODUCTION_2",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_SALVOR_FABRICATOR_INTRODUCTION" },
    line = ccb.content.text("Another new face.  So what'll it be this time?  Corpo Business?  Treasure Hunting?  Bounty Hunt?  Or maybe you heard about the lovely weather here and just had to experience it yourself?  Save yourself the trouble, there ain't nothing for you on Salus.  Want my advice?  Get off world 'fore some bot plasters your brains all over the snow."),
    replies = {
        {
            text = ccb.content.text("I can't do that."),
            next_topic = "TALK_SALVOR_FABRICATOR_INTRODUCTION_2",
        },
    },
}

-- All introductions point to here eventually. I have set up so the last line the player has said to explain their sitation doesn't allow them to leave Salus IV right now.
ccb.content.define_dialogue_topic {
    id = { "TALK_SALVOR_FABRICATOR_INTRODUCTION_2" },
    line = ccb.content.text("Whatever you think your reasons are they ain't worth it.  Salus'll chew you up and spit you back out.  A quick death here is a mercy.  Get off world no matter what it costs you: That's how you survive."),
    replies = {
        {
            text = ccb.content.text("I'm not backing down."),
            trial = { kind = "intimidate", difficulty = 60 },
            success = {
                next_topic = "TALK_SALVOR_FABRICATOR_INTRODUCTION_INTIMIDATE_SUCCESS",
                opinion = { trust = 1 },
            },
            failure = { next_topic = "TALK_SALVOR_FABRICATOR_INTRODUCTION_INTIMIDATE_FAILURE" },
        },
        {
            text = ccb.content.text("Do you talk to all your customers like this?"),
            next_topic = "TALK_SALVOR_FABRICATOR_INTRODUCTION_REDIRECT",
        },
    },
}

-- Not a super hard check to pass, it's more about standing up for yourself rather than backing down or redirecting the conversation.
ccb.content.define_dialogue_topic {
    id = { "TALK_SALVOR_FABRICATOR_INTRODUCTION_INTIMIDATE_SUCCESS" },
    line = ccb.content.text("&Veronica looks you up and down discerningly and a small smile creases her lips.\n\"So you got some spine, good.  Some of the kids that come through here fold the minute the pressure's on.  They don't have a damn clue what's waiting for them out there.  You, well come back alive and you can call me impressed.\""),
    replies = {
        {
            text = ccb.content.text("So, what do you actually do here?"),
            next_topic = "TALK_SALVOR_FABRICATOR_INTRODUCTION_3",
        },
    },
}

-- Veronica is not impressed by your attempt to puff out your chest and look tough. But she still wants you to buy from her because she genuinely wants you to survive.
ccb.content.define_dialogue_topic {
    id = { "TALK_SALVOR_FABRICATOR_INTRODUCTION_INTIMIDATE_FAILURE" },
    line = ccb.content.text("&Veronica looks you up and down discerningly and scoffs.\n\"You don't have what it takes kid.  But I won't beat a dead horse.  If you're set on this: best you get geared up before you head out there.  Got some good stuff here that might save your life.\""),
    replies = {
        {
            text = ccb.content.text("So, what do you actually do here?"),
            next_topic = "TALK_SALVOR_FABRICATOR_INTRODUCTION_3",
        },
    },
}

-- Veronica respects your sass. But you didn't impress her so you aren't going to get the trust boost.
ccb.content.define_dialogue_topic {
    id = { "TALK_SALVOR_FABRICATOR_INTRODUCTION_REDIRECT" },
    line = ccb.content.text("&A small smile tugs at the edge of Veronica's lips.\n\"Tch.  No, just the ones I like.  If you ain't changing your mind then at least take a look around.  Best not to go into those frigid wastes unprepared.\""),
    replies = {
        {
            text = ccb.content.text("So, what do you actually do here?"),
            next_topic = "TALK_SALVOR_FABRICATOR_INTRODUCTION_3",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_SALVOR_FABRICATOR_INTRODUCTION_3" },
    line = ccb.content.text("Right then, this here's my shop, and round the back there's my workroom.  I've enough tech here to whip up whatever you need, 'cept for that real fancy glittertech shit.  I sell the sorts of tools folk like you need to do your work.  Stuff that'll get you into places you ain't supposed to be and break apart anything interesting you find.  I'll buy any scraps you get out there and I'll shoot you straight on the prices.  So if you find anything interesting you bring it here first ya hear?"),
    replies = {
        {
            text = ccb.content.text("Good to know.  Can I take a look at your stock?"),
            next_topic = "TALK_DONE",
            actions = { "start_trade", actions.set_actor_value("interlocutor", "player_has_met", "yes") },
        },
        {
            text = ccb.content.text("Good to know.  I don't need anything right now though."),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("interlocutor", "player_has_met", "yes") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_SALVOR_FABRICATOR_MAIN" },
    line = ccb.content.text("Welcome back.  Planning on buying something or did you just come here to gawk?"),
    replies = {
        {
            text = ccb.content.text("Show me what you have in stock."),
            next_topic = "TALK_DONE",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text("What brought you to Salus?"),
            next_topic = "TALK_SALVOR_FABRICATOR_BACKSTORY_START",
        },
        { text = ccb.content.text("Nevermind."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_SALVOR_FABRICATOR_BACKSTORY_START" },
    line = ccb.content.text("Came in with a crew trying to cozy up 'ere on the DL.  It was a shit plan from the start, told 'em as much.  But those scrap-for brains couldn't see the forest for the trees.  Figured they pull a fortune of ship parts from the graveyards and skip planet fat and happy."),
    replies = {
        {
            text = ccb.content.text("What happened to your crew?"),
            next_topic = "TALK_SALVOR_FABRICATOR_BACKSTORY_CREW",
        },
        {
            text = ccb.content.text("Did you ever find anything interesting?"),
            next_topic = "TALK_SALVOR_FABRICATOR_BACKSTORY_INTERESTING_STUFF",
        },
        { text = ccb.content.text("Nevermind"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_SALVOR_FABRICATOR_BACKSTORY_CREW" },
    line = ccb.content.text("They're pushing daisies in the great beyond.  Not a single one of them made it off this hell.  Not like I didn't warn them.  They just kept fooling around in places one of us had any business being."),
    replies = { { text = ccb.content.text("I'm sorry for your loss."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_SALVOR_FABRICATOR_BACKSTORY_INTERESTING_STUFF" },
    line = ccb.content.text("Tch, sure.  Plenty.  But we never got our hands on any of it.  Not a single thing worth taking comes as easily as you like, and you'd do well to remember that."),
    replies = {
        {
            text = ccb.content.text("What happened to your crew?"),
            next_topic = "TALK_SALVOR_FABRICATOR_BACKSTORY_CREW",
        },
        {
            text = ccb.content.text("What was the coolest thing you ever found?"),
            next_topic = "TALK_SALVOR_FABRICATOR_BACKSTORY_INTERESTING_COOL_STUFF",
        },
        { text = ccb.content.text("Noted."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_SALVOR_FABRICATOR_BACKSTORY_INTERESTING_COOL_STUFF" },
    line = ccb.content.text("Drive Core, Cruiser class, mostly intact.  We picked it up on scanners in the stern section of a Titan II class.  It was partially buried at the bottom of a ravine, old gal must a split in the atmo.  Only ever managed a glimpse of the damn thing though."),
    replies = {
        {
            text = ccb.content.text("What happened?"),
            next_topic = "TALK_SALVOR_FABRICATOR_BACKSTORY_INTERESTING_COOL_STUFF_WHAT_HAPPENED",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_SALVOR_FABRICATOR_BACKSTORY_INTERESTING_COOL_STUFF_WHAT_HAPPENED" },
    line = ccb.content.text("Net Breacher woke up the Ship's AI.  The bastard fried her brain from the inside out.  Rail from a Wraith turned another two to paste while everyone was still losing their shit.  Rest is a haze of bloody screams and a hail of bullets and plasma.  Few that got out died later of blood loss or froze from suits full o' holes.\"\nVeronica removes her glove revealing a metallic hand that glints brightly in the dim light of the structure.\n\"Woulda been dead myself but the plasma burst that took my arm cauterized the wound.  Patched the suit up with foamcrete on my way out.  The Doc had a lot of fun with that one."),
    replies = {
        {
            text = ccb.content.text("I'm sorry for your loss."),
            next_topic = "TALK_SALVOR_FABRICATOR_BACKSTORY_INTERESTING_COOL_STUFF_WARNING",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_SALVOR_FABRICATOR_BACKSTORY_INTERESTING_COOL_STUFF_WARNING" },
    line = ccb.content.text("&Veronica slowly slides her glove back over her hand and meets your eyes with a scornful gaze.\n\"Those kids were hopeful idiots but they knew what they were doing.  This place 'ill take everything from you no matter how prepared you think you are.  Leave as soon as you can.  And stay the hell away from the graveyards.\""),
    replies = {
        {
            text = ccb.content.text("What happened afterwards, how did you end up here?"),
            next_topic = "TALK_SALVOR_FABRICATOR_BACKSTORY_CURRENT_DAY",
        },
        { text = ccb.content.text("I'll keep that in mind."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_SALVOR_FABRICATOR_BACKSTORY_CURRENT_DAY" },
    line = ccb.content.text("I pulled myself together and set up this little abode.  Been selling tools and gear to the folk that come through 'ere for a time now.  Buncha upstarts followed suit and set up their own little places.  And now we got our own neighborhood.  If it weren't for the nosey UICA pricks and especially that little shit Atermis I'd almost call it livable."),
    replies = {
        {
            text = ccb.content.text("Why stay?  You must have enough to leave the planet by now?"),
            next_topic = "TALK_SALVOR_FABRICATOR_BACKSTORY_CURRENT_DAY_WHY_STAY",
        },
    },
}

-- In the future if the player demonstrates capability. Veronica will ask you to go to the ship her crew died at and blow up the Ship AI Core. Optionally she will reward you extra for recovering keepsakes from her crew.
ccb.content.define_dialogue_topic {
    id = { "TALK_SALVOR_FABRICATOR_BACKSTORY_CURRENT_DAY_WHY_STAY" },
    line = ccb.content.text("Well, it ain't like I got someplace to be.  And, well, I can't rightly explain it, but, I feel like I still got business here.  There's a score that needs to be settled, and it just wouldn't sit right leaving things at that.  Salus ain't through with me yet."),
    replies = { { text = ccb.content.text("I understand."), next_topic = "TALK_DONE" } },
}
