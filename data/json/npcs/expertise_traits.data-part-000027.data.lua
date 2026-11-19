local ccb = require("ccb")

-- This trait group guarantees one of the associated traits - any trait, including fakes.
ccb.content.define_trait_group {
    id = "Exp_Medicine_Any",
    kind = "distribution",
    entries = {
        { trait = "Exp_Medicine1" },
        { trait = "Exp_Medicine1" },
        { trait = "Exp_Medicine0Fake1" },
        { trait = "Exp_Medicine2" },
        { trait = "Exp_Medicine2" },
        { trait = "Exp_Medicine1Fake2" },
        { trait = "Exp_Medicine1Fake2" },
        { trait = "Exp_Medicine0Fake2" },
    },
}

-- This trait group guarantees one of the associated traits - valid traits only, no fakes.
ccb.content.define_trait_group {
    id = "Exp_Medicine_Nofake",
    kind = "distribution",
    entries = { { trait = "Exp_Medicine1" }, { trait = "Exp_Medicine1" }, { trait = "Exp_Medicine2" } },
}

-- This trait group guarantees one of the associated traits, distributed in favor of real traits but with a chance of fakes.
ccb.content.define_trait_group {
    id = "Exp_Medicine_Group",
    kind = "distribution",
    entries = { { group = "Exp_Medicine_Nofake" }, { group = "Exp_Medicine_Any" } },
}
