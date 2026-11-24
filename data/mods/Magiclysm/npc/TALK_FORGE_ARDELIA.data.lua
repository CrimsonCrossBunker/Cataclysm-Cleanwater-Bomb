local ccb = require("ccb")

-- The Librarian of the Forge of Wonders.
ccb.content.define_npc {
    id = "forge_lord_librarian",
    unique_name = ccb.content.text("Librarian, A"),
    suffix = ccb.content.text("Forge Lord"),
    class = "NC_FORGE_LORD_LIBRARIAN",
    attitude = 0,
    mission = "SHOPKEEP",
    gender = "female",
    chat = "TALK_FORGE_LORD_LIBRARIAN",
    faction = "forge_lords",
    on_death = "trigger_forge_lockdown_on_death",
}

-- This is a unique NPC who doesn't get randomly selected background traits
-- Regular books are not really interesting to extradimensional beings. Will pay a lot for beechnuts, though.
ccb.content.define_npc_class {
    id = "NC_FORGE_LORD_LIBRARIAN",
    name = ccb.content.text("Forge Librarian"),
    job_description = ccb.content.text("I take care of the books and scrolls."),
    traits = {
        { trait = "VAULT_DEFENDER" },
        { trait = "LIBRARY_DEFENDER" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    common = false,
    intelligence = { one_in = 4 },
    perception = { one_in = 4 },
    shop_groups = {
        { id = "NC_FORGE_LORD_STORE_LIBRARY_SHOP", rigid = true },
        {
            id = "forge_lord_ardelia_loved_items",
            strict = true,
            refusal = ccb.content.text("<npc_name> will never give you their beech nuts."),
            condition_handler = "forge_of_wonders_display_stock_is_sellable",
        },
    },
    whitelist = "FORGE_LIBRARIAN_WHITELIST",
    price_rules = {
        { item = "denarius", price = 2500, fixed_adjustment = 0 },
        { group = "book_military", premium = 0.2, markup = 5 },
        { group = "book_gunref", premium = 0.2, markup = 5 },
        { group = "boxing_books", premium = 0.2, markup = 5 },
        { group = "book_survival", premium = 0.2, markup = 5 },
        { group = "book_school", premium = 0.2, markup = 5 },
        { group = "hardware_books", premium = 0.2, markup = 5 },
        { group = "ranch_homebooks", premium = 0.2, markup = 5 },
        { group = "manuals", premium = 0.2, markup = 5 },
        { group = "textbooks", premium = 0.2, markup = 5 },
        { group = "lab_bookshelves", premium = 0.2, markup = 5 },
        { group = "exotic_books", premium = 0.2, markup = 5 },
        { group = "esoteric_books", premium = 0.2, markup = 5 },
        { group = "dojo_manuals", premium = 0.2, markup = 5 },
        { group = "doctors_books", premium = 0.2, markup = 5 },
        { group = "fireman_doc", premium = 0.2, markup = 5 },
        { group = "tailorbooks", premium = 0.2, markup = 5 },
        { group = "carpentrybooks", premium = 0.2, markup = 5 },
        { group = "magazines", premium = 0.2, markup = 5 },
        { group = "forge_lord_ardelia_loved_items", premium = 5, markup = 100 },
    },
    worn = "NC_FORGE_LIBRARIAN_clothes",
    carry = "EMPTY_GROUP",
    sells_belongings = false,
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "unarmed", bonus = { one_in = 2 } },
        { skill = "melee", bonus = { one_in = 2 } },
        { skill = "gun", bonus = { rng = { 0, 2 } } },
        { skill = "speech", bonus = { rng = { 1, 3 } } },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_LIBRARIAN",
    line = ccb.content.text("I keep Valzain's books.  There are many floors of bookshelves among his pocket dimensions, with more magic than a mortal mind like yours could comprehend.  These happen to be the ones I think it most likely he'll read soon.  I can sell some that we have extra copies of."),
    replies = {
        {
            text = ccb.content.text("Let's trade."),
            native_actions = { "start_trade" },
            next_topic = "TALK_FORGE_LORD_LIBRARIAN",
        },
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_FORGE_LIBRARIAN_DOING",
        },
        {
            text = ccb.content.text("Do you have any more books in the back?"),
            next_topic = "TALK_FORGE_LIBRARIAN_ASK_INTERVAL",
        },
        { text = ccb.content.text("Well, bye."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LIBRARIAN_DOING",
    line = ccb.content.text("I organize the books, I sell extra books, back when we still lent books I would hunt down those with late books to return.  I have done this for aeons past and I will continue to do this for aeons to come."),
    replies = {
        {
            text = ccb.content.text("Let's talk business then."),
            next_topic = "TALK_FORGE_LORD_LIBRARIAN",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LIBRARIAN_ASK_INTERVAL",
    line = ccb.content.text("It shouldn't take Valzain too long to read what he desires from what I have out.  Check back on <restock_time_point> and I should have some new books set out."),
    replies = { { text = ccb.content.text("Safe readings."), next_topic = "TALK_FORGE_LORD_LIBRARIAN" } },
}
