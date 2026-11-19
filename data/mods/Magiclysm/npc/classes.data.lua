local ccb = require("ccb")

ccb.content.define_npc_class {
    id = "NC_MAGE_TEST",
    name = ccb.content.text("Mage Test"),
    job_description = ccb.content.text("I'm a wandering debug tester for the arcane arts."),
    traits = {
        { trait = "STORMSHAPER" },
        { group = "BG_survival_story_EVACUEE" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    spells = { { id = "lightning_bolt", level = 6 }, { id = "windrun", level = 6 } },
}

ccb.content.define_npc_class {
    id = "NC_OLD_MAGUS",
    name = ccb.content.text("Master Magus"),
    job_description = ccb.content.text("I'm an old Magus.  Get off my lawn!"),
    worn = "NC_OLD_MAGUS_worn",
    traits = {
        { trait = "MAGUS" },
        { group = "BG_survival_story_RURAL" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    strength = { rng = { -4, -1 } },
    dexterity = { rng = { -2, 0 } },
    intelligence = { rng = { 2, 5 } },
    perception = { rng = { -2, -1 } },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -2 } } } } } },
        },
        { skill = "spellcraft", bonus = { rng = { 4, 6 } } },
    },
    spells = {
        { id = "magic_missile", level = 18 },
        { id = "gravity_well", level = 10 },
        { id = "foxs_cunning", level = 7 },
    },
}

ccb.content.define_npc_class {
    id = "NC_TECHNO_KID",
    name = ccb.content.text("Techno-student"),
    job_description = ccb.content.text("I'm searching for more power."),
    traits = {
        { trait = "TECHNOMANCER" },
        { group = "BG_survival_story_TEENAGER" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    strength = { rng = { -2, 1 } },
    dexterity = { rng = { -1, 1 } },
    intelligence = { rng = { 0, 3 } },
    perception = { rng = { -1, 1 } },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { -1, -4 } } } } } },
        },
        { skill = "spellcraft", bonus = { rng = { 0, 2 } } },
    },
    spells = { { id = "quantum_tunnel_lesser", level = 2 }, { id = "animated_blade", level = 2 } },
}

ccb.content.define_npc_class {
    id = "NC_BIO_PRIEST",
    name = ccb.content.text("Healer"),
    job_description = ccb.content.text("I will purge this land of its curse."),
    traits = {
        { trait = "BIOMANCER" },
        { group = "BG_survival_story_UNIVERSAL" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    strength = { rng = { -2, 2 } },
    dexterity = { rng = { -2, 2 } },
    intelligence = { rng = { 0, 4 } },
    perception = { rng = { 0, 3 } },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -3 } } } } } },
        },
        { skill = "spellcraft", bonus = { rng = { 1, 3 } } },
    },
    spells = { { id = "light_healing", level = 3 }, { id = "bio_bonespear", level = 6 } },
}

ccb.content.define_npc_class {
    id = "NC_NPC_MUTANT_MANATOUCHED",
    name = ccb.content.text("Manatouched Mutant"),
    job_description = ccb.content.text("I'm becoming something more than mortal.  I need to find a way off this plane."),
    skills = {
        { skill = "spellcraft", bonus = { rng = { 3, 6 } } },
        { skill = "chemistry", bonus = { rng = { 3, 6 } } },
        { skill = "gun", bonus = { rng = { 2, 4 } } },
    },
    intelligence = 4,
    perception = 2,
    traits = {
        { group = "trait_mutant_npc_common" },
        { group = "BG_survival_story_UNIVERSAL" },
        { group = "NPC_starting_traits" },
        { group = "trait_group_manatouched" },
        {
            distribution = {
                { group = "trait_group_manatouched_nonthres" },
                { group = "trait_group_manatouched_postthres" },
            },
        },
    },
}

ccb.content.define_npc_class {
    id = "NC_NPC_MUTANT_BDRAGON",
    name = ccb.content.text("Black Dragon Mutant"),
    job_description = ccb.content.text("I've got the blood of dragons in my veins.  I need more."),
    skills = {
        { skill = "melee", bonus = { rng = { 3, 6 } } },
        { skill = "unarmed", bonus = { rng = { 3, 6 } } },
    },
    traits = {
        { group = "trait_mutant_npc_common" },
        { group = "BG_survival_story_UNIVERSAL" },
        { group = "NPC_starting_traits" },
        { group = "trait_group_bdragon" },
        {
            distribution = {
                { group = "trait_group_bdragon_nonthres" },
                { group = "trait_group_bdragon_postthres" },
            },
        },
    },
}
