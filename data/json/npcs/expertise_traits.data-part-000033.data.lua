local ccb = require("ccb")

-- This trait group guarantees one of the associated traits - any trait, including fakes.
ccb.content.define_trait_group {
    id = "Exp_Psychology_Any",
    kind = "distribution",
    entries = {
        { trait = "Exp_Psychology1" },
        { trait = "Exp_Psychology1" },
        { trait = "Exp_Psychology0Fake1" },
        { trait = "Exp_Psychology2" },
        { trait = "Exp_Psychology2" },
        { trait = "Exp_Psychology1Fake2" },
        { trait = "Exp_Psychology1Fake2" },
        { trait = "Exp_Psychology0Fake2" },
    },
}

-- This trait group guarantees one of the associated traits - valid traits only, no fakes.
ccb.content.define_trait_group {
    id = "Exp_Psychology_Nofake",
    kind = "distribution",
    entries = { { trait = "Exp_Psychology1" }, { trait = "Exp_Psychology1" }, { trait = "Exp_Psychology2" } },
}

-- This trait group guarantees one of the associated traits, distributed in favor of real traits but with a chance of fakes.
ccb.content.define_trait_group {
    id = "Exp_Psychology_Group",
    kind = "distribution",
    entries = { { group = "Exp_Psychology_Nofake" }, { group = "Exp_Psychology_Any" } },
}
