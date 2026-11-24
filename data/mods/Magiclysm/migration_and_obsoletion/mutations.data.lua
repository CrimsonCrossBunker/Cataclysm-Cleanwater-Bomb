local ccb = require("ccb")

ccb.content.define_mutation {
    id = "FOREST_STEALTH",
    name = ccb.content.text("Cloak of Elvenkind: Forest Stealth"),
    description = ccb.content.text("You have a much easier time hiding in the forest."),
    points = 2,
}

ccb.content.define_trait_migration {
    id = "BIOMANCER_EAT_TONS_OF_FOOD_01",
    remove = true,
}

ccb.content.define_trait_migration {
    id = "BIOMANCER_EAT_TONS_OF_FOOD_02",
    remove = true,
}

ccb.content.define_trait_migration {
    id = "BIOMANCER_EAT_TONS_OF_FOOD_03",
    remove = true,
}

ccb.content.define_trait_migration {
    id = "BIOMANCER_EAT_TONS_OF_FOOD_04",
    remove = true,
}

ccb.content.define_trait_migration {
    id = "BIOMANCER_EAT_TONS_OF_FOOD_05",
    remove = true,
}

-- remove after 0.J
ccb.content.define_trait_migration {
    id = "COLD_AURA_OFF",
    trait = "BOREAL_MAGE_COLD_AURA",
}

-- remove after 0.J
ccb.content.define_trait_migration {
    id = "COLD_AURA_ON",
    trait = "BOREAL_MAGE_COLD_AURA",
}
