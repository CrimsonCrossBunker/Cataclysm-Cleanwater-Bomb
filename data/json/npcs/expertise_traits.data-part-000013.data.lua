local ccb = require("ccb")

-- This trait group guarantees one of the associated traits - any trait, including fakes.
ccb.content.define_trait_group {
    id = "Exp_Culinary_Any",
    kind = "distribution",
    entries = {
        { trait = "Exp_Culinary1" },
        { trait = "Exp_Culinary1" },
        { trait = "Exp_Culinary0Fake1" },
        { trait = "Exp_Culinary2" },
        { trait = "Exp_Culinary2" },
        { trait = "Exp_Culinary1Fake2" },
        { trait = "Exp_Culinary1Fake2" },
        { trait = "Exp_Culinary0Fake2" },
    },
}

-- This trait group guarantees one of the associated traits - valid traits only, no fakes.
ccb.content.define_trait_group {
    id = "Exp_Culinary_Nofake",
    kind = "distribution",
    entries = { { trait = "Exp_Culinary1" }, { trait = "Exp_Culinary1" }, { trait = "Exp_Culinary2" } },
}

-- This trait group guarantees one of the associated traits, distributed in favor of real traits but with a chance of fakes.
ccb.content.define_trait_group {
    id = "Exp_Culinary_Group",
    kind = "distribution",
    entries = { { group = "Exp_Culinary_Nofake" }, { group = "Exp_Culinary_Any" } },
}
