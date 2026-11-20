local ccb = require("ccb")

ccb.content.define_trait_migration {
    id = "EAGLEEYED_NIGHT",
    trait = "EAGLEEYED",
}

ccb.content.define_trait_migration {
    id = "PROF_ASSASSIN_CONVICT",
    remove = true,
}

ccb.content.define_trait_migration {
    id = "STYLISH",
    remove = true,
}

ccb.content.define_trait_migration {
    id = "KILLER",
    remove = true,
}
