local ccb = require("ccb")

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
