local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- A member of the Gray Moose Militia, trying to safe in their isolated location
ccb.content.define_npc {
    id = "MILITIA_MERCHANT",
    unique_name = ccb.content.text("Darby Sutton"),
    class = "MILITIA_MERCHANT",
    attitude = 0,
    suffix = ccb.content.text("Survivor"),
    mission = "SHOPKEEP",
    chat = "TALK_MILITIA_MAIN",
    faction = "GM_militia_faction",
}

ccb.content.define_npc_class {
    id = "MILITIA_MERCHANT",
    name = ccb.content.text("Merchant"),
    job_description = ccb.content.text("I'm a local shopkeeper."),
    traits = { { group = "NPC_starting_traits" }, { group = "Appearance_demographics" } },
    common = false,
    intelligence = { one_in = 4 },
    perception = { one_in = 4 },
    shop_groups = "MILITIA_MERCHANT_misc",
    carry = "MILITIA_MERCHANT_misc",
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "mechanics", bonus = { one_in = 2 } },
        { skill = "electronics", bonus = { rng = { 0, 2 } } },
        { skill = "speech", bonus = { rng = { 3, 5 } } },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MILITIA_MAIN",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_MILITIAMAIN" } }),
        yes = ccb.content.text("Hello again."),
        no = ccb.content.text("Welcome to our camp.  Behave yourself while you are here.  What can I do for you?"),
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "dialogue_first_meeting_talked_to_MILITIAMAIN", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("What do you do here?"),
            next_topic = "TALK_MILITIA_INTRODUCTION",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_MILITIAMAIN" } })),
        },
        {
            text = ccb.content.text("What's the story behind this place?"),
            next_topic = "TALK_MILITIA_BACKGROUND",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_MILITIAMAIN" } }),
        },
        {
            text = ccb.content.text("Is there something I can do for you?"),
            next_topic = "TALK_MILITIA_HELP",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_MILITIAMAIN" } }),
        },
        {
            text = ccb.content.text("Do you have anything to trade?"),
            next_topic = "TALK_MILITIA_TRADE",
        },
        {
            text = ccb.content.text("Time for me to leave."),
            next_topic = "TALK_MILITIA_BYE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_MILITIAMAIN" } }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MILITIA_INTRODUCTION",
    line = ccb.content.text("I'm the most senior member at this point, so I'm what passes for the leader here now.  I'm just trying to make plans to keep us alive since everything fell apart."),
    replies = { { text = ccb.content.text("I see."), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MILITIA_BACKGROUND",
    line = ccb.content.text("Well, that's a long story.  We are what's left of the Grey Moose militia.  We had plans for when things went south cause of crazy politicians or war, but we didn't expect people to go crazy then turn zombie.  Only a handful of our members actually made it through all that madness.  What's worse is that we lost so much of our supplies and gear due to military checkpoints and trigger happy soldiers.  It didn't matter that half of us were former military, the checkpoint guards just saw weapons, panicked and then confiscated everything but the clothes on our back.  So here we are, at our planned escape location, with not even a fraction of our manpower or supplies."),
    replies = { { text = ccb.content.text("I see."), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MILITIA_HELP",
    line = ccb.content.text("I can't say I can think of anything at the moment.  Our remoteness is our defense.  We want to keep a low profile and try to keep out of any trouble in this isolated location.  We are willing to trade for weapons and ammo though.  Keeping the nearby area clear and hunting is always eating away at our supplies."),
    replies = { { text = ccb.content.text("Keeping a low profile is good."), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MILITIA_TRADE",
    line = ccb.content.text("Let's trade then."),
    replies = {
        {
            text = ccb.content.text("…"),
            native_actions = { "start_trade" },
            next_topic = "TALK_NONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MILITIA_BYE",
    line = ccb.content.text("Stay safe out there.  Not enough of us are around anymore."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}
