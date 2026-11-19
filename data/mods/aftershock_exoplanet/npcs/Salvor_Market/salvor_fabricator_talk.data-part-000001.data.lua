local ccb = require("ccb")

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
