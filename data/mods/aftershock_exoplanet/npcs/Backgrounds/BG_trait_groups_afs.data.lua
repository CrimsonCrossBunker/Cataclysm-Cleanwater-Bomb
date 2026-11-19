local ccb = require("ccb")

-- This group picks out background traits that could apply to any mutant survivor.
ccb.content.define_trait_group {
    id = "BG_survival_story_MUTANTS",
    kind = "distribution",
    entries = {
        { trait = "BGSS_RECENT_MUTATION_1" },
        { trait = "BGSS_UPLIFTED_ANIMAL_1" },
        { trait = "BGSS_UPLIFTED_ANIMAL_2" },
        { trait = "BGSS_UPLIFTED_ANIMAL_3" },
        { trait = "BGSS_UPLIFTED_ANIMAL_4" },
        { trait = "BGSS_UPLIFTED_ANIMAL_5" },
        { trait = "BGSS_RADIATION_1" },
        { trait = "BGSS_RADIATION_2" },
        { trait = "BGSS_SELFTEST" },
        { trait = "BGSS_VATGROWN_1" },
        { trait = "BGSS_CRIMINAL_EXPERIMENT" },
    },
}

-- This group picks out background traits that could apply to any Frankenstein revivee.
ccb.content.define_trait_group {
    id = "BG_revival_story_FRANKENSTEIN",
    kind = "distribution",
    entries = {
        { trait = "BGRS_AFTERLIFE_1" },
        { trait = "BGRS_MIGO_1" },
        { trait = "BGRS_MIGO_2" },
        { trait = "BGRS_MIGO_3" },
        { trait = "BGRS_SCHIZO_1" },
        { trait = "BGRS_SCHIZO_2" },
        { trait = "BGRS_Dreamer" },
        { trait = "BGRS_Bonesinger_1" },
    },
}
