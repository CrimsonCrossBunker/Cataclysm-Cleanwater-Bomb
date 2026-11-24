local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- The Lord of the Forge of Wonders.
ccb.content.define_npc {
    id = "forge_lord_merchant",
    unique_name = ccb.content.text("Valzain of Psiom"),
    suffix = ccb.content.text("Forge Lord"),
    class = "NC_FORGE_LORD",
    attitude = 0,
    mission = "SHOPKEEP",
    gender = "male",
    chat = "TALK_FORGE_LORD",
    faction = "forge_lords",
    on_death = "trigger_forge_lockdown_on_death",
}

-- This is a unique NPC who doesn't get randomly selected background traits
ccb.content.define_npc_class {
    id = "NC_FORGE_LORD",
    name = ccb.content.text("Wondrous Dreamer"),
    job_description = ccb.content.text("I created this place from dreams and magic."),
    traits = {
        { trait = "VAULT_DEFENDER" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    common = false,
    intelligence = { rng = { 20, 25 } },
    perception = { rng = { 20, 25 } },
    shop_groups = {
        { id = "NC_FORGE_LORD_SHOP", rigid = true },
        {
            id = "NC_FORGE_LORD_ACCEPTED_BOOKS",
            strict = true,
            refusal = ccb.content.text("<npc_name> will never give you their stories."),
            condition_handler = "forge_of_wonders_display_stock_is_sellable",
        },
    },
    price_rules = { { group = "NC_FORGE_LORD_ACCEPTED_BOOKS", price = 2500, fixed_adjustment = 0 } },
    whitelist = "NC_FORGE_LORD_WHITELIST",
    worn = "NC_FORGE_LORD_clothes",
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
        { skill = "speech", bonus = { rng = { 10, 20 } } },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD",
    line = {
        when = predicates.wears("speaker", "badge_marshal"),
        yes = {
            choices = {
                ccb.content.text("The government doesn't subsidize your purchases here anymore."),
                ccb.content.text("Do you have any tales of adventure I could write down?"),
                ccb.content.text("In case you were wondering, we no longer respect any pre-existing weapon laws."),
            },
        },
        no = {
            choices = {
                ccb.content.text("Welcome to the Forge of Wonders."),
                ccb.content.text("Here to trade, I hope?"),
                ccb.content.text("Bring me tales and we can trade."),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Let's trade."),
            native_actions = { "start_trade" },
            next_topic = "TALK_FORGE_LORD",
        },
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_FORGE_LORD_DOING",
        },
        {
            text = ccb.content.text("I have some stories for you."),
            next_topic = "TALK_FORGE_LORD_BOOKS_DELIVER",
        },
        {
            text = ccb.content.text("Anything interesting being worked on?"),
            next_topic = "TALK_FORGE_LORD_ASK_INTERVAL",
        },
        { text = ccb.content.text("Well, bye."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_BOOKS_DELIVER",
    line = ccb.content.text("Excellent.  What new stories have you brought me?"),
    replies = {
        {
            text = ccb.content.text("Well, let's see."),
            native_actions = { "start_trade" },
            next_topic = "TALK_FORGE_LORD",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DOING",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_FORGE_LORD" } }),
        yes = ccb.content.text("Once I was lost in the throes of love, now I've built an empire of material goods.  I've found these two things are equally as powerful, and dangerous."),
        no = ccb.content.text("Well here and now I am the law, and the law here is that people purchase my goods, they take them out into the world and they die; or they return to buy more of my goods.  Either way, I write poetry about them."),
    },
    replies = {
        {
            text = ccb.content.text("Good day, sir."),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_FORGE_LORD", "yes") },
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_FORGE_LORD" } })),
            next_topic = "TALK_FORGE_LORD",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_ASK_INTERVAL",
    line = ccb.content.text("My minions are busy putting the final touches on a few exciting projects, check back on <restock_time_point> and see what's new."),
    replies = { { text = ccb.content.text("May your hammers be accurate."), next_topic = "TALK_FORGE_LORD" } },
}
