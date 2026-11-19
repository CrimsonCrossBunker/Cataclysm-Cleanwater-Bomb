local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

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
