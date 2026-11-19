local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Kostas_Tea",
    line = ccb.content.text("Sure.  Bring me a dozen pine boughs and I'll boil you some."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("I'll be back soon."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Kostas_Tea_2",
    line = ccb.content.text("This recipe is a gemstone of my family heritage.  Lucky for us that the most common evergreen tree in the U.S. is non-toxic.  Start by rinsing the needles, and separating any woody parts from them.  Then, cut the pine needles in half.  Add one bough's worth of chopped needles to a cup or mug and fill it with boiling water.  Let the needles steep for ten minutes, until they turn brownish and sink down to the bottom.  As a final step, you can strain the needles, but then you'd be wasting precious calories.  A drink like this is perfect for mid-winter colds."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("Thank you.  See you around, Kostas."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Kostas_Jeremiah",
    line = ccb.content.text("Yeah, yeah…  I don't think he'd be a good fit for an herbalist.  He has a bad habit of wandering off someplace, could get him killed one of these days."),
    replies = {
        {
            text = ccb.content.text("Jeremiah's a bright kid.  I'll just tell him to not wander as a stipulation."),
            trial = {
                kind = "persuade",
                difficulty = 10,
                modifiers = {
                    { score = "trust", scale = 2 },
                    { score = "value", scale = 2 },
                    { score = "anger", scale = -1 },
                },
            },
            success = {
                next_topic = "TALK_GODCO_Kostas_Jeremiah_Persuade",
                opinion = { trust = 1, value = 1 },
            },
            failure = {
                next_topic = "TALK_GODCO_Kostas_Jeremiah_FailPersuade",
                opinion = { trust = 0, fear = 0 },
            },
        },
        {
            text = ccb.content.text("I know him pretty well, I'm sure he'll learn as he goes along."),
            trial = {
                kind = "persuade",
                difficulty = 10,
                modifiers = { { score = "value", scale = 3 }, { score = "anger", scale = -2 } },
            },
            success = {
                next_topic = "TALK_GODCO_Kostas_Jeremiah_Persuade",
                opinion = { trust = 1, value = 1 },
            },
            failure = {
                next_topic = "TALK_GODCO_Kostas_Jeremiah_FailPersuade",
                opinion = { trust = 0, fear = 0 },
            },
        },
        {
            text = ccb.content.text("If you don't take him under your wings, I'll rip them off for you.  Capiche?"),
            trial = {
                kind = "intimidate",
                difficulty = -5,
                modifiers = {
                    { score = "fear", scale = 2 },
                    { score = "trust", scale = -2 },
                    { score = "value", scale = -2 },
                    { score = "anger", scale = -1 },
                },
            },
            success = {
                next_topic = "TALK_GODCO_Kostas_Jeremiah_Persuade",
                opinion = { trust = -5, value = -5, anger = 5, fear = 10 },
            },
            failure = {
                next_topic = "TALK_GODCO_Kostas_Jeremiah_FailPersuade_Violent",
                opinion = { trust = -10, value = -10, anger = 10 },
            },
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("Thank you.  See you around, Kostas."), next_topic = "TALK_DONE" },
    },
}
