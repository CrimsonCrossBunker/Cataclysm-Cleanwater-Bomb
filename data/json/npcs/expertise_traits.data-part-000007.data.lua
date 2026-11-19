local ccb = require("ccb")

-- This trait group guarantees one of the associated traits - any trait, including fakes.
ccb.content.define_trait_group {
    id = "Exp_Bookkeeping_Any",
    kind = "distribution",
    entries = {
        { trait = "Exp_Bookkeeping1" },
        { trait = "Exp_Bookkeeping1" },
        { trait = "Exp_Bookkeeping0Fake1" },
        { trait = "Exp_Bookkeeping2" },
        { trait = "Exp_Bookkeeping2" },
        { trait = "Exp_Bookkeeping1Fake2" },
        { trait = "Exp_Bookkeeping1Fake2" },
        { trait = "Exp_Bookkeeping0Fake2" },
    },
}

-- This trait group guarantees one of the associated traits - valid traits only, no fakes.
ccb.content.define_trait_group {
    id = "Exp_Bookkeeping_Nofake",
    kind = "distribution",
    entries = {
        { trait = "Exp_Bookkeeping1" },
        { trait = "Exp_Bookkeeping1" },
        { trait = "Exp_Bookkeeping2" },
    },
}

-- This trait group guarantees one of the associated traits, distributed in favor of real traits but with a chance of fakes.
ccb.content.define_trait_group {
    id = "Exp_Bookkeeping_Group",
    kind = "distribution",
    entries = { { group = "Exp_Bookkeeping_Nofake" }, { group = "Exp_Bookkeeping_Any" } },
}
