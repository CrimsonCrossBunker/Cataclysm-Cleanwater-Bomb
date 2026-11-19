local ccb = require("ccb")

ccb.content.define_npc_class {
    id = "NC_NPC_MUTANT_STEGO",
    name = ccb.content.text("Stego Mutant"),
    job_description = ccb.content.text("I'm looking for stego mutagen… I'm going to become a thunder lizard."),
    skills = {
        { skill = "bashing", bonus = { rng = { 3, 6 } } },
        { skill = "melee", bonus = { rng = { 3, 6 } } },
        { skill = "unarmed", bonus = { rng = { 3, 6 } } },
    },
    strength = 2,
    perception = 2,
    traits = {
        { group = "trait_mutant_npc_common" },
        { group = "BG_survival_story_UNIVERSAL" },
        { group = "NPC_starting_traits" },
        { group = "trait_group_dino" },
        {
            distribution = {
                { group = "trait_group_stego_nonthres" },
                { group = "trait_group_stego_postthres" },
            },
        },
    },
}

ccb.content.define_npc_class {
    id = "NC_NPC_MUTANT_TYRANT",
    name = ccb.content.text("Tyrant Mutant"),
    job_description = ccb.content.text("I'm looking for tyrant mutagen… I'm going to be a king."),
    skills = {
        { skill = "dodge", bonus = { rng = { 3, 6 } } },
        { skill = "melee", bonus = { rng = { 3, 6 } } },
        { skill = "unarmed", bonus = { rng = { 3, 6 } } },
    },
    strength = 2,
    dexterity = 2,
    traits = {
        { group = "trait_mutant_npc_common" },
        { group = "BG_survival_story_UNIVERSAL" },
        { group = "NPC_starting_traits" },
        { group = "trait_group_dino" },
        {
            distribution = {
                { group = "trait_group_tyrant_nonthres" },
                { group = "trait_group_tyrant_postthres" },
            },
        },
    },
}
