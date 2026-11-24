local ccb = require("ccb")

-- Appears in the Great Library as essentially a shopkeeper.  Faction critical.
ccb.content.define_npc {
    id = "great_library_librarian",
    unique_name = ccb.content.text("Elvira Fish"),
    gender = "female",
    suffix = ccb.content.text("Circulations"),
    class = "NC_GREAT_LIBRARY_LIBRARIAN",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_GREAT_LIBRARY_LIBRARIAN",
    faction = "the_great_library",
}

-- Elvira is a young librarian, one of the few surviving librarians from before.  She is also heir to the fabulous Fish fortune, but she threw that all away to pursue her passion for library science.
-- Elvira has a formal, professional tone but breaks into stutters when asked anything personal or uncomfortable.  She will not lie.
-- Most of her dialogue goes in 'great_library_librarian_dialogue.json'. Dialogue that just does worldbuilding goes into 'great_library_librarian_dialogue_fluff.json'.
ccb.content.define_npc_class {
    id = "NC_GREAT_LIBRARY_LIBRARIAN",
    name = ccb.content.text("Circulations"),
    job_description = ccb.content.text("I'm a librarian."),
    common = false,
    sells_belongings = false,
    intelligence = 4,
    shop_groups = { { id = "GREAT_LIBRARY_Shop", rigid = true } },
    consumption_rates = "elvira_shop_rates",
    worn = "NC_GREAT_LIBRARY_LIBRARIAN_worn",
    weapon = "NC_GREAT_LIBRARY_LIBRARIAN_carried",
    traits = {
        { group = "Appearance_demographics" },
        { trait = "LOVES_BOOKS" },
        { trait = "TRUTHTELLER" },
        { trait = "OPTIMISTIC" },
        { trait = "STRONGBACK" },
        { trait = "CLUMSY" },
        { trait = "IGNORE_SOUND" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    skills = { { skill = "firstaid", bonus = 1 }, { skill = "speech", bonus = 3 } },
}
