local ccb = require("ccb")

-- This trait group guarantees one of the associated traits - any trait, including fakes.
ccb.content.define_trait_group {
    id = "Exp_Agriculture_Any",
    kind = "distribution",
    entries = {
        { trait = "Exp_Agriculture1" },
        { trait = "Exp_Agriculture1" },
        { trait = "Exp_Agriculture0Fake1" },
        { trait = "Exp_Agriculture2" },
        { trait = "Exp_Agriculture2" },
        { trait = "Exp_Agriculture1Fake2" },
        { trait = "Exp_Agriculture1Fake2" },
        { trait = "Exp_Agriculture0Fake2" },
    },
}

-- This trait group guarantees one of the associated traits - valid traits only, no fakes.
ccb.content.define_trait_group {
    id = "Exp_Agriculture_Nofake",
    kind = "distribution",
    entries = {
        { trait = "Exp_Agriculture1" },
        { trait = "Exp_Agriculture1" },
        { trait = "Exp_Agriculture2" },
    },
}

-- This trait group guarantees one of the associated traits, distributed in favor of real traits but with a chance of fakes.
ccb.content.define_trait_group {
    id = "Exp_Agriculture_Group",
    kind = "distribution",
    entries = { { group = "Exp_Agriculture_Nofake" }, { group = "Exp_Agriculture_Any" } },
}
