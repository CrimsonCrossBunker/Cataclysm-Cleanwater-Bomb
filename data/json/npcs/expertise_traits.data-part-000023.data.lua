local ccb = require("ccb")

-- This trait group guarantees one of the associated traits - any trait, including fakes.
ccb.content.define_trait_group {
    id = "Exp_Entomology_Any",
    kind = "distribution",
    entries = {
        { trait = "Exp_Entomology1" },
        { trait = "Exp_Entomology1" },
        { trait = "Exp_Entomology0Fake1" },
        { trait = "Exp_Entomology2" },
        { trait = "Exp_Entomology2" },
        { trait = "Exp_Entomology1Fake2" },
        { trait = "Exp_Entomology1Fake2" },
        { trait = "Exp_Entomology0Fake2" },
    },
}

-- This trait group guarantees one of the associated traits - valid traits only, no fakes.
ccb.content.define_trait_group {
    id = "Exp_Entomology_Nofake",
    kind = "distribution",
    entries = { { trait = "Exp_Entomology1" }, { trait = "Exp_Entomology1" }, { trait = "Exp_Entomology2" } },
}

-- This trait group guarantees one of the associated traits, distributed in favor of real traits but with a chance of fakes.
ccb.content.define_trait_group {
    id = "Exp_Entomology_Group",
    kind = "distribution",
    entries = { { group = "Exp_Entomology_Nofake" }, { group = "Exp_Entomology_Any" } },
}
