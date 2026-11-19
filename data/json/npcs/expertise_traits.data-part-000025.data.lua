local ccb = require("ccb")

-- This trait group guarantees one of the associated traits - any trait, including fakes.
ccb.content.define_trait_group {
    id = "Exp_Geology_Any",
    kind = "distribution",
    entries = {
        { trait = "Exp_Geology1" },
        { trait = "Exp_Geology1" },
        { trait = "Exp_Geology0Fake1" },
        { trait = "Exp_Geology2" },
        { trait = "Exp_Geology2" },
        { trait = "Exp_Geology1Fake2" },
        { trait = "Exp_Geology1Fake2" },
        { trait = "Exp_Geology0Fake2" },
    },
}

-- This trait group guarantees one of the associated traits - valid traits only, no fakes.
ccb.content.define_trait_group {
    id = "Exp_Geology_Nofake",
    kind = "distribution",
    entries = { { trait = "Exp_Geology1" }, { trait = "Exp_Geology1" }, { trait = "Exp_Geology2" } },
}

-- This trait group guarantees one of the associated traits, distributed in favor of real traits but with a chance of fakes.
ccb.content.define_trait_group {
    id = "Exp_Geology_Group",
    kind = "distribution",
    entries = { { group = "Exp_Geology_Nofake" }, { group = "Exp_Geology_Any" } },
}
