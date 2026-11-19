local ccb = require("ccb")

-- This group picks out background traits that could apply to any survivor. Eventually these should be implemented as the catch-all for NPCs of an unknown class, e.g. those introduced by mods.
ccb.content.define_trait_group {
    id = "BG_survival_story_UNIVERSAL",
    kind = "distribution",
    entries = {
        { trait = "BGSS_Confused_1" },
        { trait = "BGSS_No_Past_1" },
        { trait = "BGSS_No_Past_2" },
        { trait = "BGSS_No_Past_3" },
        { trait = "BGSS_No_Past_4" },
        { trait = "BGSS_No_Past_5" },
        { trait = "BGSS_Religious_1" },
        { trait = "BGSS_Religious_2" },
        { trait = "BGSS_Dreamer" },
        { trait = "BGSS_Wedding_1" },
    },
}

-- This group picks out background traits for evacuees, and also includes survivors that should have evacuated but didn't. These backgrounds are not appropriate to rural survivors nor to emergency personnel who would not have been evacuated. Most other survivors should fit.
ccb.content.define_trait_group {
    id = "BG_survival_story_EVACUEE",
    kind = "distribution",
    entries = {
        { group = "BG_survival_story_UNIVERSAL" },
        { group = "BG_survival_story_STUCK_IN_TOWN" },
        { trait = "BGSS_Evacuee_1" },
        { trait = "BGSS_Evacuee_2" },
        { trait = "BGSS_Evacuee_3" },
        { trait = "BGSS_Evacuee_4" },
        { trait = "BGSS_Evacuee_5" },
        { trait = "BGSS_Evacuee_6" },
        { trait = "BGSS_FEMA_Evacuee_1" },
        { trait = "BGSS_Out_of_Town_1" },
        { trait = "BGSS_Out_of_Town_2" },
        { trait = "BGSS_Lost_Partner_1" },
        { trait = "BGSS_Lost_Partner_2" },
        { trait = "BGSS_Codger" },
    },
}

-- This group picks out background traits for survivors who are specifically left in town; those who didn't evacuate intentionally or not.
ccb.content.define_trait_group {
    id = "BG_survival_story_STUCK_IN_TOWN",
    kind = "distribution",
    entries = {
        { trait = "BGSS_Left_for_Dead_1" },
        { trait = "BGSS_Left_for_Dead_2" },
        { trait = "BGSS_Left_for_Dead_3" },
        { trait = "BGSS_Gung_Ho_1" },
        { trait = "BGSS_Gung_Ho_2" },
        { trait = "BGSS_Gung_Ho_3" },
        { trait = "BGSS_Prepper_1" },
        { trait = "BGSS_Prepper_2" },
    },
}

-- This group is for NPCs that would have been out of town when the Cataclysm hit.
ccb.content.define_trait_group {
    id = "BG_survival_story_RURAL",
    kind = "distribution",
    entries = {
        { group = "BG_survival_story_UNIVERSAL" },
        { trait = "BGSS_Gung_Ho_1" },
        { trait = "BGSS_Gung_Ho_2" },
        { trait = "BGSS_Gung_Ho_3" },
        { trait = "BGSS_Out_of_Town_1" },
        { trait = "BGSS_Out_of_Town_2" },
        { trait = "BGSS_Lost_Partner_1" },
        { trait = "BGSS_Hunter_1" },
        { trait = "BGSS_Hunter_2" },
        { trait = "BGSS_Rural_1" },
        { trait = "BGSS_Rural_2" },
        { trait = "BGSS_Codger" },
    },
}

-- This group is specifically for NPCs working at the lumbermills.
ccb.content.define_trait_group {
    id = "BG_survival_story_LUMBERMILL",
    kind = "distribution",
    entries = {
        { trait = "BGSS_Confused_1" },
        { trait = "BGSS_No_Past_1" },
        { trait = "BGSS_No_Past_2" },
        { trait = "BGSS_No_Past_3" },
        { trait = "BGSS_No_Past_4" },
        { trait = "BGSS_No_Past_5" },
        { trait = "BGSS_Religious_1" },
        { trait = "BGSS_Religious_2" },
        { trait = "BGSS_Dreamer" },
        { trait = "BGSS_Gung_Ho_1" },
        { trait = "BGSS_Gung_Ho_2" },
        { trait = "BGSS_Out_of_Town_1" },
        { trait = "BGSS_Lost_Partner_2" },
        { trait = "BGSS_Rural_2" },
    },
}

-- This group is for NPCs that might need to explain why they didn't die working at the hospital.
ccb.content.define_trait_group {
    id = "BG_survival_story_MEDICAL",
    kind = "distribution",
    entries = {
        { group = "BG_survival_story_UNIVERSAL" },
        { trait = "BGSS_Left_for_Dead_3" },
        { trait = "BGSS_Hospital_1" },
        { trait = "BGSS_Hospital_2" },
        { trait = "BGSS_Hospital_3" },
    },
}

-- This group is for NPCs that would have been more likely to loot and riot than join the evacuation.
ccb.content.define_trait_group {
    id = "BG_survival_story_CRIMINAL",
    kind = "distribution",
    entries = {
        { group = "BG_survival_story_UNIVERSAL" },
        { trait = "BGSS_Left_for_Dead_3" },
        { trait = "BGSS_Gung_Ho_1" },
        { trait = "BGSS_Gung_Ho_2" },
        { trait = "BGSS_Gung_Ho_3" },
        { trait = "BGSS_Prepper_1" },
        { trait = "BGSS_Prepper_2" },
        { trait = "BGSS_Criminal_1" },
        { trait = "BGSS_Criminal_2" },
        { trait = "BGSS_Prisoner_1" },
    },
}

-- This group is for NPCs that might have been working the front lines during the Cataclysm.
ccb.content.define_trait_group {
    id = "BG_survival_story_SOLDIER",
    kind = "distribution",
    entries = {
        { group = "BG_survival_story_UNIVERSAL" },
        { trait = "BGSS_Soldier_1" },
        { trait = "BGSS_Soldier_2" },
    },
}

-- This group is for NPCs that would have been attempting to maintain order during the Cataclysm.
ccb.content.define_trait_group {
    id = "BG_survival_story_POLICE",
    kind = "distribution",
    entries = {
        { group = "BG_survival_story_UNIVERSAL" },
        { trait = "BGSS_Cop_1" },
        { trait = "BGSS_Cop_2" },
        { trait = "BGSS_Cop_3" },
    },
}

-- This group is for NPCs that should be doing their homework instead of hunting zombies.
ccb.content.define_trait_group {
    id = "BG_survival_story_TEENAGER",
    kind = "distribution",
    entries = {
        { group = "BG_survival_story_UNIVERSAL" },
        { trait = "BGSS_Evacuee_1" },
        { trait = "BGSS_Evacuee_2" },
        { trait = "BGSS_Evacuee_3" },
        { trait = "BGSS_Evacuee_4" },
        { trait = "BGSS_Evacuee_5" },
        { trait = "BGSS_Evacuee_6" },
        { trait = "BGSS_Left_for_Dead_3" },
        { trait = "BGSS_High_School_1" },
        { trait = "BGSS_Burger_Flipper_1" },
        { trait = "BGSS_Nerd_1" },
    },
}

-- This group is for NPCs that worked in science, maybe in a lab, or maybe in a Lab. They don't necessarily know any more about the Cataclysm than the rest of us.
ccb.content.define_trait_group {
    id = "BG_survival_story_LAB",
    kind = "distribution",
    entries = {
        { group = "BG_survival_story_UNIVERSAL" },
        { trait = "BGSS_Scientist_1" },
        { trait = "BGSS_Scientist_2" },
        { trait = "BGSS_Professor_1" },
        { trait = "BGSS_Grad_Student_1" },
        { trait = "BGSS_Lab_1" },
    },
}

-- This group is for NPCs were former experimental lab mutants.  This includes prisoners who were conscripted into the program and people who volunteered for something seemingly innocuous without knowing what they'd gotten themselves into.
ccb.content.define_trait_group {
    id = "BG_survival_story_LAB_MUTANT",
    kind = "distribution",
    entries = { { trait = "BGSS_Lab_Mutant_1" } },
}

-- This group is for NPCs that were left unusually emotionally or physically defenseless after the Cataclysm.
ccb.content.define_trait_group {
    id = "BG_survival_story_VULNERABLE",
    kind = "distribution",
    entries = { { trait = "BGSS_Confused_1" }, { trait = "BGSS_No_Past_2" }, { trait = "BGSS_No_Past_3" } },
}

-- This group is for NPCs that were exploring a city.
ccb.content.define_trait_group {
    id = "BG_survival_story_TOURIST",
    kind = "distribution",
    entries = { { group = "BG_survival_story_UNIVERSAL" }, { group = "BG_survival_story_STUCK_IN_TOWN" } },
}

-- This group is for NPCs that retired prior to the Cataclysm.
ccb.content.define_trait_group {
    id = "BG_survival_story_RETIRED",
    kind = "distribution",
    entries = {
        { group = "BG_survival_story_UNIVERSAL" },
        { trait = "BGSS_Confused_1" },
        { trait = "BGSS_Codger" },
    },
}

-- This group is for NPCs that are ambiguously unemployed and weirder than usual.
ccb.content.define_trait_group {
    id = "BG_survival_story_ECCENTRIC",
    kind = "distribution",
    entries = { { group = "BG_survival_story_EVACUEE" } },
}

-- This group is for NPCs that prepared in advance and hunkered down after the Cataclysm.
ccb.content.define_trait_group {
    id = "BG_survival_story_PREPPER",
    kind = "distribution",
    entries = { { trait = "BGSS_Prepper_1" }, { trait = "BGSS_Prepper_2" } },
}

-- This group is for NPCs that are young and roam the streets.
ccb.content.define_trait_group {
    id = "BG_survival_story_TEENAGER_TOUGH",
    kind = "distribution",
    entries = { { group = "BG_survival_story_TEENAGER" } },
}

-- This group is for NPCs that are particularly focused on a spiritual belief.
ccb.content.define_trait_group {
    id = "BG_survival_story_SPIRITUAL",
    kind = "distribution",
    entries = { { trait = "BGSS_Religious_1" }, { trait = "BGSS_Religious_2" }, { trait = "BGSS_Dreamer" } },
}

-- This group is for NPCs that are particularly sporty.
ccb.content.define_trait_group {
    id = "BG_survival_story_SPORTS",
    kind = "distribution",
    entries = { { group = "BG_survival_story_EVACUEE" } },
}

-- This group is for NPCs that were commercial workers before the Cataclysm.
ccb.content.define_trait_group {
    id = "BG_survival_story_WORKER_COMMERCIAL",
    kind = "distribution",
    entries = { { group = "BG_survival_story_EVACUEE" } },
}

-- This group is for NPCs that were self-employed before the Cataclysm.
ccb.content.define_trait_group {
    id = "BG_survival_story_WORKER_SELFEMP",
    kind = "distribution",
    entries = { { group = "BG_survival_story_EVACUEE" } },
}

-- This group is for NPCs that were public workers before the Cataclysm.
ccb.content.define_trait_group {
    id = "BG_survival_story_WORKER_PUBLIC",
    kind = "distribution",
    entries = { { group = "BG_survival_story_EVACUEE" } },
}

-- This group is for NPCs that were firefighters before the Cataclysm.
ccb.content.define_trait_group {
    id = "BG_survival_story_WORKER_FIREFIGHTER",
    kind = "distribution",
    entries = { { group = "BG_survival_story_UNIVERSAL" } },
}

-- This group is for NPCs that were prisoners before the Cataclysm.
ccb.content.define_trait_group {
    id = "BG_survival_story_PRISONER",
    kind = "distribution",
    entries = { { trait = "BGSS_Prisoner_1" } },
}

-- This group is for Cyborgs rescued down in the Lab.
ccb.content.define_trait_group {
    id = "BG_survival_story_CYBORG",
    kind = "distribution",
    entries = { { group = "BG_survival_story_UNIVERSAL" }, { trait = "BGSS_Cyborg_1" } },
}

-- This assigns a possible story about knowing where to find other survivors - 'background: other survivor stories'.
ccb.content.define_trait_group {
    id = "BG_other_survivor_stories",
    kind = "distribution",
    entries = {
        { trait = "BOSS_No_Others_01", weight = 25 },
        { trait = "BOSS_No_Others_02", weight = 25 },
        { trait = "BOSS_Lapin_01", weight = 3 },
        { trait = "BOSS_NC_FARMER_01", weight = 3 },
        { trait = "BOSS_NC_SURVIVOR_CHEF_01", weight = 3 },
        { trait = "BOSS_Brigitte_LaCroix_01", weight = 3 },
        { trait = "BOSS_Evac_Shelter_01", weight = 5 },
        { trait = "BOSS_Evac_Shelter_01b", weight = 5 },
        { trait = "BOSS_Evac_Shelter_02", weight = 5 },
        { trait = "BOSS_Evac_Shelter_02b", weight = 5 },
        { trait = "BOSS_Evac_Shelter_03", weight = 5 },
        { trait = "BOSS_Evac_Shelter_03b", weight = 5 },
        { trait = "BOSS_Free_Merchants_01", weight = 5 },
        { trait = "BOSS_Free_Merchants_02", weight = 5 },
        { trait = "BOSS_Hub01_01", weight = 2 },
        { trait = "BOSS_Isherwood_01", weight = 4 },
    },
}
