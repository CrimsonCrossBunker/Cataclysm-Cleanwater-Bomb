local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

-- The Pirate of the Forge of Wonders.
ccb.content.define_npc {
    id = "forge_lord_reagents",
    unique_name = ccb.content.text("Helen Tavrel, Former Pirate"),
    suffix = ccb.content.text("Forge Lord"),
    class = "NC_FORGE_LORD_REAGENT",
    attitude = 0,
    mission = "SHOPKEEP",
    gender = "female",
    chat = "TALK_FORGE_LORD_REAGENT",
    faction = "forge_lords",
    on_death = "trigger_forge_lockdown_on_death",
}

-- This is a unique NPC who doesn't get randomly selected background traits
ccb.content.define_npc_class {
    id = "NC_FORGE_LORD_REAGENT",
    name = ccb.content.text("Pirate Queen"),
    job_description = ccb.content.text("My adventures would curdle your blood."),
    traits = {
        { trait = "VAULT_DEFENDER" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    common = false,
    intelligence = { one_in = 4 },
    perception = { one_in = 4 },
    shop_groups = {
        { id = "NC_FORGE_LORD_STORE_REAGENT_SHOP", rigid = true },
        {
            id = "forge_lord_pirate_treasure",
            strict = true,
            refusal = ccb.content.text("<npc_name> will never give you their treasures."),
            condition_handler = "forge_of_wonders_display_stock_is_sellable",
        },
    },
    price_rules = {
        { category = "guns", premium = 1 },
        { category = "ammo", premium = 1 },
        { group = "forge_lord_pirate_treasure", premium = 1.2 },
    },
    whitelist = "FORGE_REAGENT_WHITELIST",
    worn = "NC_FORGE_REAGENT_clothes",
    weapon = "NC_FORGE_REAGENT_wield",
    carry = "EMPTY_GROUP",
    sells_belongings = false,
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "mechanics", bonus = { one_in = 2 } },
        { skill = "computer", bonus = { one_in = 2 } },
        { skill = "electronics", bonus = { rng = { 0, 2 } } },
        { skill = "speech", bonus = { rng = { 1, 3 } } },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_REAGENT",
    line = {
        when = predicates.wears("speaker", "badge_marshal"),
        yes = {
            choices = {
                ccb.content.text("Would you try to capture me?"),
                ccb.content.text("I've killed many a government-sanctioned hunter in my life."),
                ccb.content.text("Aren't we all lucky that you are probably the last lawman alive in miles?"),
            },
        },
        no = {
            choices = {
                ccb.content.text("Welcome to the Forge of Wonders."),
                ccb.content.text("Reagents and blackpowders!"),
                ccb.content.text("Ahoy and other nautical terms!"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Let's trade."),
            native_actions = { "start_trade" },
            next_topic = "TALK_FORGE_LORD_REAGENT",
        },
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_FORGE_REAGENT_DOING",
        },
        {
            text = ccb.content.text("When are you getting new stuff?"),
            next_topic = "TALK_FORGE_REAGENT_ASK_INTERVAL",
        },
        {
            text = ccb.content.text("What goods are you looking for?"),
            next_topic = "TALK_FORGE_REAGENT_ASK_BUYING",
        },
        { text = ccb.content.text("Well, bye."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_REAGENT_DOING",
    line = {
        when = predicates.wears("speaker", "badge_marshal"),
        yes = ccb.content.text("I hope you're willing to overlook my past because otherwise you're not buying anything from me."),
        no = ccb.content.text("A lifetime of plunder has brought me many a strange item - that you can have for unbeatable prices!"),
    },
    replies = {
        {
            text = ccb.content.text("Well, shiver me timbers then."),
            next_topic = "TALK_FORGE_LORD_REAGENT",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_REAGENT_ASK_INTERVAL",
    line = {
        when = predicates.wears("speaker", "badge_marshal"),
        yes = {
            choices = {
                ccb.content.text("Do you think me a fool, to tell an officer of the law my current plans?"),
                ccb.content.text("Not even trying to ask me that undercover?  By the seventeen seas, officers of the law really ARE made worse these days."),
                ccb.content.text("The end of times is here and that's what you're worried about?  You should get your priorities straight."),
            },
        },
        no = ccb.content.text("Well you obviously aren't an officer so here's the deal.  There's a mighty fine galleon making land on <restock_time_point>, I'm certain to have something good by then."),
    },
    replies = {
        {
            text = ccb.content.text("May the seas be ever in your favor."),
            next_topic = "TALK_FORGE_LORD_REAGENT",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_REAGENT_ASK_BUYING",
    line = ccb.content.text("I am always on the lookout for weapons and ammo.  I am also happy to relieve you of your treasures."),
    replies = { { text = ccb.content.text("I'll keep an eye out."), next_topic = "TALK_FORGE_LORD_REAGENT" } },
}
