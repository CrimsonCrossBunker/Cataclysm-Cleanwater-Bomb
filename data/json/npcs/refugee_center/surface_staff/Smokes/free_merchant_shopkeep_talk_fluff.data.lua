local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_AboutGreeting",
    line = ccb.content.text("A lot of the time, yes.  Our address is on the info boards of most of the evac shelters around here, and people keep showing up that we have to turn away.  It gets easier when you have something you can read off a script."),
    replies = {
        {
            text = ccb.content.text("I'm sorry."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_AboutGreeting_End",
        },
        {
            text = ccb.content.text("That sounds a little cruel."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_AboutGreeting_Cruel",
        },
        {
            text = ccb.content.text("[Cannibal + Uncaring] Wait, I thought you were having food problems."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_AboutGreeting_Cannibal",
            when = predicates.all({ predicates.has_trait("speaker", "CANNIBAL"), predicates.has_flag("speaker", "PSYCHOPATH") }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_AboutGreeting_End",
    line = ccb.content.text("*shrugs.  \"Did you need something else?\""),
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_AboutGreeting_Cruel",
    line = ccb.content.text("*bristles.  \"I know, alright?  I do.  I hate it too.  But we are packed to the gills right now, and the only way we're going to stay alive is if we keep our gates closed fast.  I don't know what made the scavengers out there so ruthless, but some of us have had to kill our own kids.  Please show some consideration.\""),
    replies = {
        {
            text = ccb.content.text("I'm sorry."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_AboutGreeting_End",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_AboutGreeting_Cannibal",
    line = ccb.content.text("We are.  That's why we're turning people away."),
    replies = {
        {
            text = ccb.content.text("I'm saying you're giving up a potential source of meat."),
            success = {
                opinion = { trust = -5, fear = -2, value = -1, anger = 1 },
                next_topic = "TALK_FREE_MERCHANTS_MERCHANT_AboutGreeting_Cannibal2",
            },
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  Don't know where I was going with that."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_AboutGreeting_End",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_AboutGreeting_Cannibal2",
    line = ccb.content.text("I can't tell if you're joking or not, but that is seriously fucked up, and I don't want to hear another word about it.  Okay?"),
    replies = {
        {
            text = ccb.content.text("Alright, alright, I'm sorry.  Bad joke."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_AboutGreeting_End",
        },
        { text = ccb.content.text("Your loss."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = {
        "TALK_FREE_MERCHANTS_MERCHANT_AboutMe", "TALK_FREE_MERCHANTS_MERCHANT_AboutMe_Basic",
        "TALK_FREE_MERCHANTS_MERCHANT_AboutMe_Smokes2",
    },
    line = ccb.content.text("Not much to say.  What did you want to hear?"),
    replies = {
        {
            text = ccb.content.text("How'd you end up here?"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_AboutMe_Basic",
        },
        {
            text = ccb.content.text("Smokes?  That's quite a name."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_AboutMe_Smokes",
        },
        {
            text = ccb.content.text("That's fine for now."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Talk",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_AboutMe_Basic",
    line = ccb.content.text("Well, I'm Gavin, like I said.  I was a fireman before <the_cataclysm>, and I was also on duty when everything fell apart.  I'd rather not go into detail, but other than that, I wasn't really much to write home about.  My family was Irish, I never married, and I liked woodworking.  I volunteered to take inventory of what the center had when I got off the bus, one thing leads to another, and now I'm here."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_AboutMe_Smokes",
    line = ccb.content.text("*rolls his eyes.  \"Tell me about it.  My actual name is Gavin, which I think I told you.  I used to be a firefighter, and people started recognizing me because of the helmet.  Someone called me 'smokes' because of it, and it stuck.  I hate it.  I've never even touched a cigarette.\""),
    replies = {
        {
            text = ccb.content.text("[PER 8] If you hate it, then why are you smiling?"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_AboutMe_Smokes2",
            when = predicates.minimum_attribute("speaker", "perception", 8),
        },
        {
            text = ccb.content.text("Can't say I blame you."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_AboutMe",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_AboutMe_Smokes2",
    line = ccb.content.text("*laughs.  \"Well, I think it's ridiculous, but I guess I don't mind it that much.  I figure it's all in good fun, and people could really use the laugh these days, y'know?  I'm sure they'd stop if I asked.  The helmet is like… a badge of office, at this point.  You can call me Smokes if you really want.\""),
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_AboutMerch",
    line = ccb.content.text("Oh, merch.  They're just paper notes we've started using for local cash.  We started out paying each other with dollar bills, but there's so much paper money out there that it's just useless now.  For our internal use, we started certifying bills that represent food and labor in the center here.  We started trading them internally, and then they started circling around, and now other people have started adopting them, too."),
}

ccb.content.define_dialogue_topic {
    id = {
        "TALK_FREE_MERCHANTS_MERCHANT_AskJoin", "TALK_FREE_MERCHANTS_MERCHANT_AskJoin1",
        "TALK_FREE_MERCHANTS_MERCHANT_AskJoin2",
    },
    line = ccb.content.text("I'm sorry, but the last thing we need is another mouth to feed.  Most of us lack any real survival skills, so keeping our group small enough to survive on the food we trade for is the main thing keeping us alive."),
    replies = {
        {
            text = ccb.content.text("Another time, then."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("I can pull my own weight!"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_AskJoin1",
        },
        {
            text = ccb.content.text("Maybe I could change your mind…?~"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_AskJoin2",
            when = predicates.has_item("speaker", "condom"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_AskJoin1",
    line = ccb.content.text("Maybe out there alone, or with a small group, but enough to feed a few dozen other people that aren't helping you?  That just isn't a risk we're willing to take right now.  If you want to trade us supplies or donate something, you're more than welcome to, and it'd be a huge help, but right now, we're far past our comfort zone as it is."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_AskJoin2",
    line = ccb.content.text("No way in hell.  I'm not going to risk the safety of dozens of people just for some ass.  If you're that desperate, go talk to Alonso."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_Basement",
    line = ccb.content.text("The center has a pretty large lower floor, behind metal doors that were made to stand up to basically anything - bombs, radiation, you name it.  Place is basically a vault.  Most of our population is living in there; only people who we think are combat-capable stay up here.  Bear in mind, we started off with a few buses of office workers and soccer moms.  If worst comes to worst, they'll stand a chance if things go bad up here."),
    replies = {
        {
            text = ccb.content.text("Good to know."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("How do I get down there?"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Basement_NoAccess",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = {
        "TALK_FREE_MERCHANTS_MERCHANT_Basement_NoAccess",
        "TALK_FREE_MERCHANTS_MERCHANT_Basement_NoAccess2",
        "TALK_FREE_MERCHANTS_MERCHANT_Basement_NoAccess3",
    },
    line = ccb.content.text("I can't share that.  We're taking security extremely seriously right now.  The guards downstairs are well-armed, and they've got orders to immediately apprehend anyone they don't recognize.  We want to keep those people as safe we can until either we have more space up here or we've got some room inside the fence for them to live."),
    replies = {
        {
            text = ccb.content.text("I suppose that makes sense."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("Why spend so much effort keeping it locked down?  I thought you mentioned they weren't able to help."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Basement_NoAccess2",
        },
        {
            text = ccb.content.text("If I could go down there, I could help bring them supplies.  Food, medicine…"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Basement_NoAccess3",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_Basement_NoAccess2",
    line = ccb.content.text("Just because they're not boots on the ground doesn't mean they aren't helping.  In fact, I'd say that a lot of them are our most important people.  They keep the power running, for one thing.  And even if they weren't helping, look at it this way: all of us are scared, and almost all of us have lost someone from all this.  We aren't going to throw our own to the wolves."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_Basement_NoAccess3",
    line = ccb.content.text("I appreciate the offer, I really do, but I'm sorry.  The basement is off-limits to outsiders, and we're not in the market for new recruits right now.  Maybe once we're in a better spot there might be some room to think about it, but right now I can't justify just giving you free reign down there."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_OutsideWorld1",
    line = ccb.content.text("Yeah.  Someone came through this way a while back saying he had tried to drive into Syracuse after the outbreak.  Didn't even make it downtown before he ran into a wall of zombies that he said could stop a tank.  He hightailed it out, but he said there were several thousand at least.  I guess when you get a bunch of them together, they end up making enough noise to attract everyone in the neighborhood.  Thankfully, we haven't had a mob like that pass by here, because I'm not sure the fence would do much to keep them out."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_OutsideWorld2",
    line = ccb.content.text("Other than those people with the hard drive, none that I know of.  Scavengers share some odd things, but we can't exactly go check for ourselves.  The teamster in the back bay might have some pointers, though, if you really want to know."),
}

ccb.content.define_dialogue_topic {
    id = { "TALK_FREE_MERCHANTS_MERCHANT_Plans" },
    line = ccb.content.text("Things were rough at first, and our policy of taking everyone we could caused a lot of strife later on.  Right now, we just want to get enough trade going keep ourselves afloat.  We might have to turn people away, but we've found that they're usually willing to trade with us, which is our only real source of food right now.  We're trying to turn that into a business model.  Doesn't matter who you are, we'll trade with you as long as you don't bring trouble."),
    replies = {
        {
            text = ccb.content.text("What about when the goods dry up?  Won't that happen eventually?"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Plans2",
        },
        {
            text = ccb.content.text("Here's hoping it works out."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Talk",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_Plans2",
    line = ccb.content.text("Right now, it's the best way we have to make sure that everyone gets what they need.  Long-term viability of business models is what people in suits used to do back before all this, and we see where that got them.  Barter is the only thing keeping us from starving, so we're going to keep doing it as long as it works or until we can start producing our own food."),
    replies = {
        {
            text = ccb.content.text("Here's hoping it works out."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Talk",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_WhosInCharge",
    line = ccb.content.text("I don't think we have a figurehead right now, I think?  If we do, I don't know about it.  For the most part, we all have our own responsibilities and that works to keep us all fed as a group.  I'm the front man for outsiders, the broker keeps tabs on our food, so on and so forth.  We've had some town hall style talks in the cafeteria about setting up a democracy, but there's nothing solid on that right now."),
}
