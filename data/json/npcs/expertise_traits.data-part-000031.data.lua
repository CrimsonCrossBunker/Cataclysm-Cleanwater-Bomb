local ccb = require("ccb")

-- This trait group guarantees one of the associated traits - any trait, including fakes.
ccb.content.define_trait_group {
    id = "Exp_Physics_Any",
    kind = "distribution",
    entries = {
        { trait = "Exp_Physics1" },
        { trait = "Exp_Physics1" },
        { trait = "Exp_Physics0Fake1" },
        { trait = "Exp_Physics2" },
        { trait = "Exp_Physics2" },
        { trait = "Exp_Physics1Fake2" },
        { trait = "Exp_Physics1Fake2" },
        { trait = "Exp_Physics0Fake2" },
    },
}

-- This trait group guarantees one of the associated traits - valid traits only, no fakes.
ccb.content.define_trait_group {
    id = "Exp_Physics_Nofake",
    kind = "distribution",
    entries = { { trait = "Exp_Physics1" }, { trait = "Exp_Physics1" }, { trait = "Exp_Physics2" } },
}

-- This trait group guarantees one of the associated traits, distributed in favor of real traits but with a chance of fakes.
ccb.content.define_trait_group {
    id = "Exp_Physics_Group",
    kind = "distribution",
    entries = { { group = "Exp_Physics_Nofake" }, { group = "Exp_Physics_Any" } },
}
