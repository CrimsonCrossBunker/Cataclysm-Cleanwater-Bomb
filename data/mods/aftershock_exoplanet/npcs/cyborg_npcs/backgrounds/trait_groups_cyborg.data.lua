local ccb = require("ccb")

-- This group picks out background traits that could apply to specific Aftershock cyborg survivor.
ccb.content.define_trait_group {
    id = "BG_survival_story_GANGER",
    kind = "distribution",
    entries = { { trait = "BGSS_GANGER_1" }, { trait = "BGSS_GANGER_2" }, { trait = "BGSS_GANGER_3" } },
}

-- This group picks out background traits that could apply to specific Aftershock cyborg survivor.
ccb.content.define_trait_group {
    id = "BG_survival_story_CYBERNINJA",
    kind = "distribution",
    entries = { { trait = "BGSS_CYBERNINJA" } },
}
