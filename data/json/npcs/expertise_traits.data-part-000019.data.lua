local ccb = require("ccb")

-- This trait group guarantees one of the associated traits - any trait, including fakes.
ccb.content.define_trait_group {
    id = "Exp_Eng_Software_Any",
    kind = "distribution",
    entries = {
        { trait = "Exp_Eng_Software1" },
        { trait = "Exp_Eng_Software1" },
        { trait = "Exp_Eng_Software0Fake1" },
        { trait = "Exp_Eng_Software2" },
        { trait = "Exp_Eng_Software2" },
        { trait = "Exp_Eng_Software1Fake2" },
        { trait = "Exp_Eng_Software1Fake2" },
        { trait = "Exp_Eng_Software0Fake2" },
    },
}

-- This trait group guarantees one of the associated traits - valid traits only, no fakes.
ccb.content.define_trait_group {
    id = "Exp_Eng_Software_Nofake",
    kind = "distribution",
    entries = {
        { trait = "Exp_Eng_Software1" },
        { trait = "Exp_Eng_Software1" },
        { trait = "Exp_Eng_Software2" },
    },
}

-- This trait group guarantees one of the associated traits, distributed in favor of real traits but with a chance of fakes.
ccb.content.define_trait_group {
    id = "Exp_Eng_Software_Group",
    kind = "distribution",
    entries = { { group = "Exp_Eng_Software_Nofake" }, { group = "Exp_Eng_Software_Any" } },
}
