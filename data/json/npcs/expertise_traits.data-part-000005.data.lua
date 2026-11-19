local ccb = require("ccb")

-- This trait group guarantees one of the associated traits - any trait, including fakes.
ccb.content.define_trait_group {
    id = "Exp_Biology_Any",
    kind = "distribution",
    entries = {
        { trait = "Exp_Biology1" },
        { trait = "Exp_Biology1" },
        { trait = "Exp_Biology0Fake1" },
        { trait = "Exp_Biology2" },
        { trait = "Exp_Biology2" },
        { trait = "Exp_Biology1Fake2" },
        { trait = "Exp_Biology1Fake2" },
        { trait = "Exp_Biology0Fake2" },
    },
}

-- This trait group guarantees one of the associated traits - valid traits only, no fakes.
ccb.content.define_trait_group {
    id = "Exp_Biology_Nofake",
    kind = "distribution",
    entries = { { trait = "Exp_Biology1" }, { trait = "Exp_Biology1" }, { trait = "Exp_Biology2" } },
}

-- This trait group guarantees one of the associated traits, distributed in favor of real traits but with a chance of fakes.
ccb.content.define_trait_group {
    id = "Exp_Biology_Group",
    kind = "distribution",
    entries = { { group = "Exp_Biology_Nofake" }, { group = "Exp_Biology_Any" } },
}
