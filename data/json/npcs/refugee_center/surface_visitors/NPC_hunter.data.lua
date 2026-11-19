local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_HUNTER_SMELL",
    line = ccb.content.gendered_line("Oh, I didn't mean that in a bad way.  Been out in the wilderness so long, I find myself noticing things by scent before sight.", { "interlocutor" }),
    replies = { { text = ccb.content.text("O…kay…?"), next_topic = "TALK_EVAC_HUNTER" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_HUNTER_DO",
    line = ccb.content.text("I trade food here in exchange for a place to crash and general supplies.  Well, more specifically I trade food that isn't stale chips and flat cola."),
    replies = {
        { text = ccb.content.text("Interesting."), next_topic = "TALK_EVAC_HUNTER_LIFE" },
        { text = ccb.content.text("Oh, so you hunt?"), next_topic = "TALK_EVAC_HUNTER_HUNT" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_HUNTER_LIFE",
    line = ccb.content.text("Not really, just trying to lead my life."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_EVAC_HUNTER" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_HUNTER_HUNT",
    line = ccb.content.text("Yep.  Whatever game I spot, I bag and sell the meat and other parts here.  Got the occasional fish and basket full of wild fruit, but nothing comes close to a freshly-cooked moose steak for supper!"),
    replies = {
        {
            text = ccb.content.text("Great, now my mouth is watering…"),
            next_topic = "TALK_EVAC_HUNTER",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_HUNTER_SALE",
    line = ccb.content.text("Sure, just bagged a fresh batch of meat.  You may want to grill it up before it gets too, uh… 'tender'."),
    replies = {
        {
            text = ccb.content.text("…"),
            native_actions = { "start_trade" },
            next_topic = "TALK_EVAC_HUNTER",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_HUNTER_ADVICE",
    line = {
        choices = {
            ccb.content.text("Feed a man a fish, he's full for a day.  Feed a man a bullet, he's full for the rest of his life."),
            ccb.content.text("Spot your prey before something nastier spots you."),
            ccb.content.gendered_line("I've heard that cougars sometimes leap.  Maybe it's just a myth.", { "interlocutor" }),
            ccb.content.text("The Jabberwock is real, don't listen to what anybody else says.  If you see it, RUN."),
            ccb.content.text("Zombified animals aren't good for eating, but sometimes you might find usable fur on 'em."),
            ccb.content.text("A steady diet of cooked meat and clean water will keep you alive forever, but your taste buds and your colon may start to get angry at you.  Eat a piece of fruit every once in a while."),
            ccb.content.text("Smoke crack to get more shit done."),
        },
    },
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_EVAC_HUNTER" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_HUNTER_BYE",
    line = ccb.content.text("Watch your back out there."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}
