local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- The hunter that hunted regular animals as part of the cover-up.  She is now responsible to hunt animals for food.
ccb.content.define_npc {
    id = "vampire_hunter_mundane",
    suffix = ccb.content.text("regular hunter"),
    class = "NC_vampire_hunter_mundane",
    unique_name = ccb.content.text("Elsa Nielsen"),
    gender = "female",
    attitude = 0,
    mission = "NULL",
    chat = "TALK_HUNTER_MUNDANE",
    personality = { aggression = 2, bravery = 6, collector = 5, altruism = 2 },
    faction = "vampire_hunters",
}

-- Was recruited as part of the cover-up that hid the vampire-hunting group as a bunch of regular crossbow hunters.
-- She's great at hunting animals but has little combat training and barely knows anything about vampires except the necessity to kill them all, thus the low deduction, low combat and high shooting skills.
-- She also teaches the new recruits and explains to wanderers how they're just an exclusive hunting club, thus high social and being willing to teach how to use crossbows.
ccb.content.define_npc_class {
    id = "NC_vampire_hunter_mundane",
    name = ccb.content.text("regular hunter"),
    job_description = ccb.content.text("I hunt, but I don't hunt vampires."),
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_Irish" },
        { trait = "IGNORE_SOUND" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    common = false,
    strength = { rng = { 2, 3 } },
    dexterity = { rng = { 1, 3 } },
    intelligence = { rng = { 1, 2 } },
    perception = { rng = { 3, 5 } },
    sells_belongings = false,
    shop_groups = "hunter_mundane_sold_items",
    consumption_rates = "basic_shop_rates",
    worn = "VAMPIRE_HUNTER_DEFAULT_worn",
    weapon = "VAMPIRE_HUNTER_DEFAULT_CROSSBOW_wield",
    skills = {
        { skill = "ALL", level = { mul = { { sum = { { dice = { 1, 2 } } } } } } },
        { skill = "rifle", bonus = { rng = { 6, 8 } } },
        { skill = "gun", bonus = { rng = { 6, 8 } } },
        { skill = "survival", bonus = { rng = { 5, 6 } } },
        { skill = "dodge", bonus = { rng = { 1, 2 } } },
        { skill = "deduction", bonus = { rng = { -3, -2 } } },
        { skill = "speech", bonus = { rng = { 3, 4 } } },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_HUNTER_MUNDANE",
    line = {
        choices = {
            {
                when = predicates.has_trait("speaker", "VAMPIRE"),
                yes = ccb.content.text("Go see Blaine or Phyliss about your infection, or else Leonard won't calm down about it."),
                no = {
                    choices = {
                        ccb.content.text("Welcome."),
                        ccb.content.text("Hello."),
                        ccb.content.text("Hi."),
                    },
                },
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Do you have something to trade?"),
            next_topic = "TALK_HUNTER_MUNDANE_TRADE",
        },
        {
            text = ccb.content.text("Could you teach me something?"),
            next_topic = "TALK_HUNTER_MUNDANE_TRAIN",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_HUNTER_MUNDANE_TRADE",
    line = {
        choices = {
            {
            when = predicates.handler("dlg_p_xedra_evolved_0a508fa5baff"),
            yes = ccb.content.text("I have plenty of leather and bone to sell but nothing edible to spare.  We must maintain our food stockpile for when it will be scarce."),
            no = ccb.content.text("I have plenty of leather and bone to sell and I can give you some jerky if you want."),
        },
        },
    },
    replies = {
        {
            text = ccb.content.text("I'll buy."),
            next_topic = "TALK_HUNTER_MUNDANE",
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("I'd take some jerky."),
            next_topic = "TALK_HUNTER_MUNDANE_GIVE_JERKY",
            when = predicates.handler("dlg_p_xedra_evolved_fa2c90835cf0"),
            actions = { actions.handler("dlg_a_xedra_evolved_d4fff8570f2a") },
        },
        {
            text = ccb.content.text("Let's talk about something else."),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Maybe later.  Bye!"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_HUNTER_MUNDANE_TRAIN",
    line = {
        choices = {
            {
            when = predicates.handler("dlg_p_xedra_evolved_0a508fa5baff"),
            yes = ccb.content.text("You helped us, so I'll give you a good discount for your training."),
            no = ccb.content.text("If you want that, you'll have to pay for it.  I won't stop gathering food just to train a stranger."),
        },
        },
    },
    replies = {
        {
            text = ccb.content.text("I can pay."),
            next_topic = "TALK_TRAIN",
            when = predicates.handler("dlg_p_xedra_evolved_5c3b94c5290a"),
        },
        {
            text = ccb.content.text("Thanks!  Let's start the training."),
            next_topic = "TALK_TRAIN",
            when = predicates.handler("dlg_p_xedra_evolved_fa2c90835cf0"),
            actions = { actions.handler("dlg_a_xedra_evolved_26f5e04b6fdb") },
        },
        {
            text = ccb.content.text("Let's talk about something else."),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Maybe later.  Bye!"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_HUNTER_MUNDANE_GIVE_JERKY",
    line = {
        choices = {
            ccb.content.text("Here's some jerky.  It's not something we sell, but you brought some badly-needed help so you can have it."),
        },
    },
    replies = {
        {
            text = ccb.content.text("I'd take more jerky."),
            next_topic = "TALK_HUNTER_MUNDANE_GIVE_JERKY",
            when = predicates.handler("dlg_p_xedra_evolved_fa2c90835cf0"),
            actions = { actions.handler("dlg_a_xedra_evolved_d4fff8570f2a") },
        },
        {
            text = ccb.content.text("Let's trade."),
            next_topic = "TALK_HUNTER_MUNDANE",
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Let's talk about something else."),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Maybe later.  Bye!"),
            next_topic = "TALK_DONE",
        },
    },
}
