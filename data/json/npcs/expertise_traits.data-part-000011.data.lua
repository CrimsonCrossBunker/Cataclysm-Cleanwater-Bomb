local ccb = require("ccb")

-- This trait group guarantees one of the associated traits - any trait, including fakes.
ccb.content.define_trait_group {
    id = "Exp_Chemistry_Any",
    kind = "distribution",
    entries = {
        { trait = "Exp_Chemistry1" },
        { trait = "Exp_Chemistry1" },
        { trait = "Exp_Chemistry0Fake1" },
        { trait = "Exp_Chemistry2" },
        { trait = "Exp_Chemistry2" },
        { trait = "Exp_Chemistry1Fake2" },
        { trait = "Exp_Chemistry1Fake2" },
        { trait = "Exp_Chemistry0Fake2" },
    },
}

-- This trait group guarantees one of the associated traits - valid traits only, no fakes.
ccb.content.define_trait_group {
    id = "Exp_Chemistry_Nofake",
    kind = "distribution",
    entries = { { trait = "Exp_Chemistry1" }, { trait = "Exp_Chemistry1" }, { trait = "Exp_Chemistry2" } },
}

-- This trait group guarantees one of the associated traits, distributed in favor of real traits but with a chance of fakes.
ccb.content.define_trait_group {
    id = "Exp_Chemistry_Group",
    kind = "distribution",
    entries = { { group = "Exp_Chemistry_Nofake" }, { group = "Exp_Chemistry_Any" } },
}
