local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_FOUND_LMOE2_BENICE",
    line = {
        choices = {
            {
            when = predicates.handler("dlg_p_dda_baba7b359c8f"),
            yes = ccb.content.gendered_line("The door was open?  Was there anyone inside?  Why would you assume I was dead?", { "interlocutor", "speaker" }),
            no = ccb.content.gendered_line("That's pretty presumptive of you, considering it hasn't been that long since shit went down.  What made you assume I was dead?", { "interlocutor", "speaker" }),
        },
        },
    },
    replies = {
        {
            text = ccb.content.text("There was a dead guy inside.  It didn't take much to make that connection."),
            trial = { kind = "lie", difficulty = 40, modifiers = { { score = "TRUST", scale = 3 } } },
            success = { next_topic = "BGSS_PREPPER_1_FOUND_LMOE4" },
            failure = { next_topic = "BGSS_PREPPER_1_FOUND_LMOE4_FAILLIE", opinion = { trust = -1 } },
        },
        {
            text = ccb.content.text("The whole front door had been blown off and everything had been looted.  Nothing left.  It seemed like something major had happened, that's all."),
            trial = { kind = "lie", difficulty = -10, modifiers = { { score = "TRUST", scale = 2 } } },
            success = { next_topic = "BGSS_PREPPER_1_FOUND_LMOE4" },
            failure = { next_topic = "BGSS_PREPPER_1_FOUND_LMOE4_FAILLIE", opinion = { trust = -1 } },
        },
        {
            text = ccb.content.text("I had no idea.  It's <the_cataclysm>.  I was just trying to survive."),
            next_topic = "BGSS_PREPPER_1_FOUND_LMOE4_BEHONEST",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_FOUND_LMOE2_BEMEAN",
    line = {
        choices = {
            {
            when = predicates.handler("dlg_p_dda_baba7b359c8f"),
            yes = ccb.content.gendered_line("Well, that's one way to say 'fuck you'!  I know it's been a while since shit went down, but I didn't lock that door and put up that sign for no reason!  How would you feel if I came and stole all the stuff that YOU locked away for safe keeping?!", { "interlocutor" }),
            no = ccb.content.gendered_line("Well, that's one way to say 'fuck you'!  How…  Why…  I was still trying to get back there, surviving and struggling just like you!  How would you feel if I came and stole all YOUR stuff right when you needed it most?!", { "interlocutor" }),
        },
        },
    },
    replies = {
        {
            text = ccb.content.text("Finders, keepers."),
            next_topic = "BGSS_PREPPER_1_FOUND_LMOE3_BEMEAN",
            opinion = { trust = -2, value = -5, anger = 4 },
        },
        {
            text = ccb.content.text("C'mon, you would do the same!  It's life or death out here!"),
            next_topic = "BGSS_PREPPER_1_FOUND_LMOE3_BENICE",
            opinion = { trust = 1, value = -1, anger = 1 },
        },
    },
}
