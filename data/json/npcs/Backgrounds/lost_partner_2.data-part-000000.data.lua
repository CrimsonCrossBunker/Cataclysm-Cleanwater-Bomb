local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "BGSS_LOST_PARTNER_2_STORY1",
    line = {
        when = predicates.has_effect("interlocutor", "player_BGSS_SAIDNO"),
        yes = ccb.content.gendered_line("I said, I don't wanna talk about it.  How are you not understanding this?", { "interlocutor" }),
        no = {
            when = predicates.has_effect("interlocutor", "player_BGSS_SAIDYES"),
            yes = ccb.content.gendered_line("Like I said, it's a lame story, but I guess it won't kill me to tell it one more time.", { "interlocutor" }),
            no = ccb.content.text("Just another fucked-up tale of love and loss.  Not one I like to tell."),
        },
    },
    replies = {
        {
            text = ccb.content.text("It might help to get it off your chest."),
            when = predicates.all({ predicates.negate(predicates.has_effect("interlocutor", "player_BGSS_SAIDNO")), predicates.negate(predicates.has_effect("interlocutor", "player_BGSS_SAIDYES")) }),
            trial = {
                kind = "persuade",
                difficulty = 50,
                modifiers = { { score = "TRUST", scale = 2 }, { score = "VALUE", scale = 3 } },
            },
            success = { next_topic = "BGSS_LOST_PARTNER_2_STORY2" },
            failure = { next_topic = "BGSS_LOST_PARTNER_2_NOTYET" },
        },
        {
            text = ccb.content.text("Suck it up.  If we're going to work together I need to know you."),
            when = predicates.all({ predicates.negate(predicates.has_effect("interlocutor", "player_BGSS_SAIDNO")), predicates.negate(predicates.has_effect("interlocutor", "player_BGSS_SAIDYES")) }),
            trial = {
                kind = "intimidate",
                difficulty = 50,
                modifiers = {
                    { score = "BRAVERY", scale = 2 },
                    { score = "TRUST", scale = 1 },
                    { score = "ANGER", scale = -2 },
                },
            },
            success = { next_topic = "BGSS_LOST_PARTNER_2_STORY2" },
            failure = { next_topic = "BGSS_LOST_PARTNER_2_FUCKOFF" },
        },
        {
            text = ccb.content.text("You said you lost someone."),
            when = predicates.has_effect("interlocutor", "player_BGSS_SAIDYES"),
            next_topic = "BGSS_LOST_PARTNER_2_STORY3",
        },
        {
            text = ccb.content.text("Never mind.  Sorry I brought it up."),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
    },
}
