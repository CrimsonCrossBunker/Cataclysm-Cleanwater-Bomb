local ccb = require("ccb")

ccb.content.define_npc_class {
    id = "NC_TRADER_PREDATORY",
    name = ccb.content.text("Trader"),
    job_description = ccb.content.text("I'm collecting gear and selling it at a high interest."),
    traits = {
        { group = "BG_survival_story_EVACUEE" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    common = false,
    shop_groups = { { id = "NC_EVAC_SHOPKEEP_misc", rigid = true } },
    price_rules = {
        { item = "icon", price = 100 },
        { group = "NC_EVAC_SHOPKEEP_misc", markup = 3, condition_handler = "godco_representative_unpaid" },
    },
    intelligence = { one_in = 4 },
    perception = { one_in = 4 },
}
