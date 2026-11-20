local ccb = require("ccb")

return ccb.ModDefinition {
    id = "mom_knacks_only",
    name = ccb.content.text("Mind Over Matter: Psychic Scream"),
    authors = { "Standing-Storm" },
    description = ccb.content.text("Changes Mind Over Matter so that only psychic knacks exist, meaning only those born with them have psychic powers.  Removes higher-level feral psions and psionic awakenings, leaves crafting and locations.\n\nTriffids and mi-go still get powerful psychics, so watch out."),
    category = "rebalance",
    dependencies = { "ccb", "mindovermatter" },
    ordered_data_files = true,
}
