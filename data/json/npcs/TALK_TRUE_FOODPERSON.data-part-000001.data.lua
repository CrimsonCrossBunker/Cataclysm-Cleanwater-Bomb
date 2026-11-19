local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_FOODPERSON_INTRODUCTION",
    line = ccb.content.gendered_line("Indeed it is I!  The one and only FOODPERSON!", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Wow!  Such an honor to meet you in person!"),
            next_topic = "TALK_FOODPERSON_MAIN",
            opinion = { trust = 1, value = 1 },
        },
        {
            text = ccb.content.text("Are you joking?  Foodperson is not real, it's a restaurant mascot!"),
            opinion = { trust = -1, value = -1 },
            next_topic = "TALK_FOODPERSON_DOUBTED",
        },
        {
            text = ccb.content.text("The great Foodperson in the flesh!  Such an honor to finally meet you in person!"),
            trial = {
                kind = "lie",
                difficulty = 60,
                modifiers = { { score = "TRUST", scale = 2 }, { score = "VALUE", scale = 2 } },
            },
            success = { next_topic = "TALK_FOODPERSON_MAIN", opinion = { trust = 2, value = 2 } },
            failure = { next_topic = "TALK_FOODPERSON_VEXED", opinion = { trust = -5, value = -5 } },
        },
        {
            text = ccb.content.text("Ah… well, nice to meet you Foodperson."),
            next_topic = "TALK_FOODPERSON_MAIN",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FOODPERSON_VEXED",
    line = ccb.content.text("Do not mock me, for my strength is quite real!  Get out of here now!"),
    replies = {
        { text = ccb.content.text("Sheesh, ok, calm down, I'm leaving!"), next_topic = "TALK_DONE" },
        {
            text = ccb.content.text("Forgive me, I didn't mean to disrespect you."),
            next_topic = "TALK_FOODPERSON_MAIN",
        },
        {
            text = ccb.content.text("Oh yeah?  Show me what you can do!"),
            next_topic = "TALK_DONE",
            native_actions = { "hostile" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FOODPERSON_DOUBTED",
    line = ccb.content.text("A common mistake, but I can assure you that I'm very real!"),
    replies = {
        { text = ccb.content.text("Sure, whatever."), next_topic = "TALK_DONE" },
        { text = ccb.content.text("Ok… I believe you."), next_topic = "TALK_FOODPERSON_MAIN" },
    },
}
