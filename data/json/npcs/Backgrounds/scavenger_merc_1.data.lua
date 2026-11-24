local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- This guy is very unlikely to respond to nice words, unless you're a really smooth operator and have earned it.
-- This guy is more likely to respond to a show of strength.
ccb.content.define_dialogue_topic {
    id = "BGSS_SCAVENGER_MERC_1_STORY1",
    line = {
        when = predicates.has_effect("interlocutor", "player_BGSS_SAIDYES"),
        yes = ccb.content.gendered_line("Like I said, you want me to tell you a story, you gotta pony up the whisky.  A full bottle, mind you.", { "interlocutor" }),
        no = ccb.content.text("Listen.  I'm gonna cut this off short.  I work for you, okay?  I'm not interested in getting attached.  You didn't pay me to be your friend."),
    },
    replies = {
        {
            text = ccb.content.text("I'm not looking for a friend, but I've paid my dues and earned my way.  You gotta pony up too.  We're stuck with each other for a bit."),
            when = predicates.negate(predicates.any({ predicates.has_effect("interlocutor", "player_BGSS_SAIDNO"), predicates.has_effect("interlocutor", "player_BGSS_SAIDYES") })),
            trial = {
                kind = "persuade",
                difficulty = 80,
                modifiers = { { score = "VALUE", scale = -2 }, { score = "TRUST", scale = -2 } },
            },
            success = { next_topic = "BGSS_SCAVENGER_MERC_1_STORY2_BADGERME" },
            failure = { next_topic = "BGSS_SCAVENGER_MERC_1_FUCKOFF" },
        },
        {
            text = ccb.content.text("Don't mouth off to me.  I know where everyone else working for me comes from.  If I'm going to let you stand behind me with a loaded gun, you're going to toe the <freaking> line too."),
            when = predicates.negate(predicates.any({ predicates.has_effect("interlocutor", "player_BGSS_SAIDNO"), predicates.has_effect("interlocutor", "player_BGSS_SAIDYES") })),
            trial = {
                kind = "intimidate",
                difficulty = 50,
                modifiers = { { score = "TRUST", scale = -1 }, { score = "FEAR", scale = -1 } },
            },
            success = { next_topic = "BGSS_SCAVENGER_MERC_1_STORY2_OKAY" },
            failure = { next_topic = "BGSS_SCAVENGER_MERC_1_NICETRY" },
        },
        {
            text = ccb.content.text("Is this enough whisky for you?"),
            when = predicates.all({ predicates.has_item("speaker", "single_malt_whiskey"), predicates.has_effect("interlocutor", "player_BGSS_SAIDYES") }),
            next_topic = "BGSS_SCAVENGER_MERC_1_STORY2",
        },
        { text = ccb.content.text("Fine.  Let's talk business, then."), next_topic = "TALK_NONE" },
        { text = ccb.content.text("Fine, have it your way."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_SCAVENGER_MERC_1_FUCKOFF",
    line = ccb.content.gendered_line("No dice.  You asked me to come along.  This is what you get.  If you don't like it, I'll take my fee and go back to the center.  Ain't hard to find contracts.", { "speaker" }),
    on_enter = {
        { opinion = { fear = -1 } },
    },
    replies = {
        {
            text = ccb.content.text("Fine, then.  <done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDNO", { turns = 20000 }) },
        },
        {
            text = ccb.content.text("Have it your way."),
            next_topic = "TALK_DONE",
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDNO", { turns = 20000 }) },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_SCAVENGER_MERC_1_NICETRY",
    line = ccb.content.text("I respect where you're coming from, but no.  Not interested.  If you don't like it, I can find another boss easy enough."),
    replies = {
        {
            text = ccb.content.text("Fine, then.  <done_conversation_section>"),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDNO", { turns = 20000 }) },
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        {
            text = ccb.content.text("Have it your way."),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDNO", { turns = 20000 }) },
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_SCAVENGER_MERC_1_STORY2_BADGERME",
    line = ccb.content.text("<swear!>  You're just gonna keep badgering me about this forever, aintcha.  Fine.  Bring me a bottle of single malt, we share a drink, I tell you the story."),
    replies = {
        {
            text = ccb.content.text("I'll get looking for that.  <done_conversation_section>"),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDYES", { permanent = true }) },
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        {
            text = ccb.content.text("I'll get back to you on that."),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDYES", { permanent = true }) },
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_SCAVENGER_MERC_1_STORY2_OKAY",
    line = ccb.content.text("Yeah, okay.  I can respect that.  How about this: bring me a bottle of single malt, we share a drink, I tell you the story."),
    replies = {
        {
            text = ccb.content.text("I'll get looking for that.  <done_conversation_section>"),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDYES", { permanent = true }) },
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        {
            text = ccb.content.text("I'll get back to you on that."),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDYES", { permanent = true }) },
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_SCAVENGER_MERC_1_STORY2",
    line = ccb.content.text("Oh, yeah, this is a good choice.  Hold on to it for me, let's have a drink later.  Right now we're practically swimming in good whisky, but some day the last bottle will get drunk.  It's gonna be a long time before any of us is brewing nice scotch, and we ain't never gettin' peat from Islay ever again.  Makes me shed a tear just thinking about it."),
    on_enter = {
        { opinion = { trust = 1, value = 1 } },
    },
    replies = {
        {
            text = ccb.content.text("You owe me a story."),
            next_topic = "BGSS_SCAVENGER_MERC_1_STORY3",
            actions = { actions.add_effect("interlocutor", "BGSS_Merc_haswhisky", { permanent = true }) },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_SCAVENGER_MERC_1_STORY3",
    line = ccb.content.gendered_line("Mostly I just wanted to get some scotch out of you.  There really ain't much of a story.  I was in the marines, years ago.  After that, did security contract work.  I was out guarding some dump of a warehouse when the apocalypse rolled through town.  I was out on the edge of town, armed, and know when to not pick a fight, so I didn't get killed.  Wound up recruited by the Free Merchants early on, and then the Old Guard for a bit, but I was getting itchy feet when you came by with an offer.  Here I am.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Why was a guy with your skillset guarding a warehouse?  Must've been some warehouse."),
            when = predicates.all({ predicates.minimum_attribute("speaker", "intelligence", 7), predicates.minimum_attribute("speaker", "perception", 8) }),
            next_topic = "BGSS_SCAVENGER_MERC_1_STORY4",
        },
        {
            text = ccb.content.text("What was working for the Free Merchants like?"),
            next_topic = "BGSS_SCAVENGER_MERC_1_FREE_MERCHANTS",
        },
        {
            text = ccb.content.text("What was working for the Old Guard like?"),
            next_topic = "BGSS_SCAVENGER_MERC_1_OLD_GUARD",
        },
        { text = ccb.content.text("Thanks for that."), next_topic = "TALK_FRIEND_CONVERSATION" },
        { text = ccb.content.text("Thanks for that.  <lets_go>"), next_topic = "TALK_DONE" },
    },
}

-- UPCOMING: this merc will offer a mission for you to explore the warehouse in question.
ccb.content.define_dialogue_topic {
    id = "BGSS_SCAVENGER_MERC_1_STORY4",
    line = ccb.content.gendered_line("Huh.  Hadn't thought about it in ages, but now that you mention it, that was a weird job.  It was just a boarded up warehouse in the middle of nowhere, and I was not a cheap contractor in those days.  Coulda got any fat rent-a-cop to watch it.  I had only just started working there when the shit hit the fan, and I kinda forgot about that to be honest.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("Thanks for that."), next_topic = "TALK_FRIEND_CONVERSATION" },
        { text = ccb.content.text("Thanks for that.  <lets_go>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_SCAVENGER_MERC_1_FREE_MERCHANTS",
    line = ccb.content.text("Fucking dull.  Caravan patrols were a bit more fun, for a while, but a guy can only eat so much road dust.  Guarding that pile of bricks full of sad-sack pussies who can't even justify surviving <the_cataclysm>?  Well, I dunno.  They're not a bad bunch but I'm fine not working for them now."),
    replies = {
        {
            text = ccb.content.text("Why was someone with your skillset guarding a warehouse?  Must've been some warehouse."),
            when = predicates.all({ predicates.minimum_attribute("speaker", "intelligence", 7), predicates.minimum_attribute("speaker", "perception", 8) }),
            next_topic = "BGSS_SCAVENGER_MERC_1_STORY4",
        },
        {
            text = ccb.content.text("What was working for the Old Guard like?"),
            next_topic = "BGSS_SCAVENGER_MERC_1_OLD_GUARD",
        },
        { text = ccb.content.text("Thanks for that."), next_topic = "TALK_FRIEND_CONVERSATION" },
        { text = ccb.content.text("Thanks for that.  <lets_go>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_SCAVENGER_MERC_1_OLD_GUARD",
    line = ccb.content.gendered_line("Good work, and some fun stuff, but risky.  Without a few hands at my side that I trust, I wouldn't take more of their work.  If I had a solid team, though, I'd happily work for Uncle Sam again.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Why was a guy with your skillset guarding a warehouse?  Must've been some warehouse."),
            when = predicates.all({ predicates.minimum_attribute("speaker", "intelligence", 7), predicates.minimum_attribute("speaker", "perception", 8) }),
            next_topic = "BGSS_SCAVENGER_MERC_1_STORY4",
        },
        {
            text = ccb.content.text("What was working for the Free Merchants like?"),
            next_topic = "BGSS_SCAVENGER_MERC_1_FREE_MERCHANTS",
        },
        { text = ccb.content.text("Thanks for that."), next_topic = "TALK_FRIEND_CONVERSATION" },
        { text = ccb.content.text("Thanks for that.  <lets_go>"), next_topic = "TALK_DONE" },
    },
}
