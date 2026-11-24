local ccb = require("ccb")

ccb.content.define_mutation_type {
    id = "Equipment",
}

ccb.content.define_mutation {
    id = "well_distributed",
    name = ccb.content.text("Well Distributed Gear"),
    points = 0,
    description = ccb.content.text("You are wearing equipment that helps to distribute weight allowing you to carry more."),
    valid = false,
    purifiable = false,
    types = { "Equipment" },
    enchantments = { "INLINE_ENCH_well_distributed_0" },
}
