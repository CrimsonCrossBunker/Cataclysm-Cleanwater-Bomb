local ccb = require("ccb")

-- Should add a Mercurial version with stronger performance enhancing effects later on.  As a quest/alliance reward?
ccb.content.define_item {
    id = "afs_synth_blood",
    name = ccb.content.plural_text("synthetic blood", "synthetic blood"),
    mass = "262 g",
    color = "white",
    default_container = "bag_iv",
    symbol = "~",
    survival_price = "250 USD",
    price = "250 USD",
    description = ccb.content.text("A chalk white blood analogue for emergency medical use.  Far more efficient at oxygenation than natural blood, it can also be used as a general performance enhancer.  Once injected, it will be metabolized or otherwise expunged from the body in around 8 hours."),
    materials = { "blood" },
    volume = "250 ml",
    phase = "liquid",
    flags = { "NO_INGEST", "NPC_SAFE", "EDIBLE_FROZEN" },
    comestible = {
        kind = "MED",
        quench = 5,
        servings = 1,
        healthy = -1,
        fun = -10,
        vitamins = { { id = "meat_allergen", amount = 1 } },
    },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You inject the %s."),
            tools_needed = { syringe = -1 },
            effects = { { id = "synth_blood_perf", duration = 28800 } },
            vitamins = { { id = "blood", minimum = 2500 }, { id = "redcells", minimum = 2500 } },
        },
    },
}

ccb.content.define_item {
    id = "afs_painkiller",
    name = ccb.content.plural_text("serendipnol", "serendipnols"),
    description = ccb.content.text("A very strong, synthetic narcotic built from alien biochemistry and used to treat intense pain while in the field.  You'll need to inject it, and it's very addictive, so be careful."),
    mass = "1 g",
    volume = "1 ml",
    price = "122 cent",
    survival_price = "1 USD",
    symbol = "!",
    color = "yellow",
    default_container = "bag_iv",
    flags = { "NO_INGEST", "EDIBLE_FROZEN" },
    comestible = { kind = "MED", fun = 6, addiction_potential = 10, addiction = "opiate" },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You shoot up."),
            tools_needed = { syringe = -1 },
            effects = { { id = "pkill3", duration = "40 minutes" }, { id = "pkill2", duration = "2 hours" } },
        },
    },
}
