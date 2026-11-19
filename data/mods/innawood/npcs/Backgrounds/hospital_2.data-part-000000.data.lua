local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "BGSS_HOSPITAL_2_STORY1",
    line = {
        when = predicates.has_effect("interlocutor", "player_BGSS_SAIDNO"),
        yes = ccb.content.text("I just can't talk about that right now.  I can't."),
        no = {
            when = predicates.has_effect("interlocutor", "player_BGSS_SAIDYES"),
            yes = ccb.content.text("I was at work trying to heal the sick, when it all went down.  It's a bit of a blur.  For a while there were weird rumors, stuff that sounded unbelievable about people getting back up after dying, but mostly things normal.  Then, towards the end, stuff just skyrocketed.  We thought it was some kind of attack, and that's what we were being told.  People coming in crazed, covered in wounds.  About halfway through my shift I… well, I broke."),
            no = ccb.content.text("I was at work trying to heal the sick, when it all went down.  It's a bit of a blur.  For a while there were weird rumors, stuff that sounded unbelievable about people getting back up after dying, but mostly things normal.  Then, towards the end, stuff just skyrocketed.  We thought it was some kind of attack, and that's what we were being told.  People coming in crazed, covered in wounds.  About halfway through my shift I… well, I broke.  I'd seen such horrible injuries, and then I… <swear!>, I can't even talk about it."),
        },
    },
    replies = {
        {
            text = ccb.content.text("It might help to get it off your chest."),
            when = predicates.all({ predicates.negate(predicates.has_effect("interlocutor", "player_BGSS_SAIDNO")), predicates.negate(predicates.has_effect("interlocutor", "player_BGSS_SAIDYES")) }),
            trial = {
                kind = "persuade",
                difficulty = 40,
                modifiers = { { score = "TRUST", scale = 2 }, { score = "VALUE", scale = 3 } },
            },
            success = { next_topic = "BGSS_HOSPITAL_2_STORY2" },
            failure = { next_topic = "BGSS_HOSPITAL_2_NOTYET" },
        },
        {
            text = ccb.content.text("Suck it up buttercup.  If we're going to work together I need to know you."),
            when = predicates.all({ predicates.negate(predicates.has_effect("interlocutor", "player_BGSS_SAIDNO")), predicates.negate(predicates.has_effect("interlocutor", "player_BGSS_SAIDYES")) }),
            trial = {
                kind = "intimidate",
                difficulty = 40,
                modifiers = {
                    { score = "BRAVERY", scale = 2 },
                    { score = "TRUST", scale = 1 },
                    { score = "ANGER", scale = -2 },
                },
            },
            success = { next_topic = "BGSS_HOSPITAL_2_STORY2" },
            failure = { next_topic = "BGSS_HOSPITAL_2_NOTYET" },
        },
        {
            text = ccb.content.text("What was it that 'broke' you?"),
            when = predicates.has_effect("interlocutor", "player_BGSS_SAIDYES"),
            next_topic = "BGSS_HOSPITAL_2_STORY2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
