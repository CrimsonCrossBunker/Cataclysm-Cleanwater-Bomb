local ccb = require("ccb")

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
