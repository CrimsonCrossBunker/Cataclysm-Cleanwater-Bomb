local ccb = require("ccb")

ccb.content.define_npc_class {
    id = "NC_BANDIT_TRADER",
    name = ccb.content.text("Fenceman"),
    job_description = ccb.content.text("I sell illegal things."),
    common = false,
    traits = {
        { group = "BG_survival_story_CRIMINAL" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
        { trait = "IGNORE_SOUND" },
    },
    strength = { rng = { 2, 4 } },
    dexterity = { rng = { 0, 2 } },
    shop_groups = "bandit_merchant_sell",
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -4 } } } },
        { skill = "dodge", bonus = { rng = { 1, 3 } } },
        { skill = "melee", bonus = { rng = { 2, 4 } } },
        { skill = "unarmed", bonus = { rng = { 1, 3 } } },
        { skill = "bashing", bonus = { rng = { 1, 5 } } },
        { skill = "stabbing", bonus = { rng = { 1, 5 } } },
        { skill = "cutting", bonus = { rng = { 1, 5 } } },
    },
}

ccb.content.define_npc_class {
    id = "NC_BANDIT_QUARTERMASTER",
    name = ccb.content.text("Quartermaster"),
    job_description = ccb.content.text("I manage garrison supplies."),
    common = false,
    traits = {
        { group = "BG_survival_story_CRIMINAL" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
        { trait = "IGNORE_SOUND" },
    },
    strength = { rng = { 2, 4 } },
    dexterity = { rng = { 0, 2 } },
    shop_groups = "bandit_quartermaster_sell",
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -4 } } } },
        { skill = "dodge", bonus = { rng = { 1, 3 } } },
        { skill = "melee", bonus = { rng = { 2, 4 } } },
        { skill = "unarmed", bonus = { rng = { 1, 3 } } },
        { skill = "bashing", bonus = { rng = { 1, 5 } } },
        { skill = "stabbing", bonus = { rng = { 1, 5 } } },
        { skill = "cutting", bonus = { rng = { 1, 5 } } },
        { skill = "speech", bonus = { rng = { 1, 3 } } },
    },
}

ccb.content.define_npc_class {
    id = "NC_BANDIT_LEADER",
    name = ccb.content.text("Bandit Leader"),
    job_description = ccb.content.text("I lead a bandit clan."),
    common = false,
    traits = {
        { group = "BG_survival_story_CRIMINAL" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
        { trait = "IGNORE_SOUND" },
    },
    strength = { rng = { 3, 5 } },
    dexterity = { rng = { 1, 3 } },
    intelligence = { rng = { 0, 2 } },
    perception = { rng = { 0, 2 } },
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -4 } } } },
        { skill = "dodge", bonus = { rng = { 2, 4 } } },
        { skill = "melee", bonus = { rng = { 3, 5 } } },
        { skill = "unarmed", bonus = { rng = { 2, 4 } } },
        { skill = "bashing", bonus = { rng = { 2, 6 } } },
        { skill = "stabbing", bonus = { rng = { 2, 6 } } },
        { skill = "cutting", bonus = { rng = { 2, 6 } } },
    },
}
