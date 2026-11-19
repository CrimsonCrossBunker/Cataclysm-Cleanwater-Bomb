local ccb = require("ccb")

ccb.content.define_npc_class {
    id = "NC_NPC_MUTANT_LIZARD",
    name = ccb.content.text("Lizard Mutant"),
    job_description = ccb.content.text("I'm looking for lizard mutagen… this world is no place for humans anymore, and I don't plan to keep being one."),
    skills = {
        { skill = "dodge", bonus = { rng = { 3, 6 } } },
        { skill = "melee", bonus = { rng = { 3, 6 } } },
        { skill = "unarmed", bonus = { rng = { 3, 6 } } },
    },
    strength = 4,
    dexterity = 2,
    traits = {
        { group = "trait_mutant_npc_common" },
        { group = "BG_survival_story_MUTANTS" },
        { group = "trait_group_lizard" },
        {
            distribution = {
                { group = "trait_group_lizard_nonthres" },
                { group = "trait_group_lizard_postthres" },
            },
        },
    },
}

ccb.content.define_npc_class {
    id = "NC_NPC_MUTANT_RABBIT",
    name = ccb.content.text("Rabbit Mutant"),
    job_description = ccb.content.text("I'm looking for rabbit mutagen… this world is no place for humans anymore, and I don't plan to keep being one."),
    skills = {
        { skill = "dodge", bonus = { rng = { 3, 6 } } },
        { skill = "swimming", bonus = { rng = { 3, 6 } } },
        { skill = "speech", bonus = { rng = { 3, 6 } } },
    },
    perception = 2,
    dexterity = 4,
    traits = {
        { group = "trait_mutant_npc_common" },
        { group = "BG_survival_story_MUTANTS" },
        { group = "trait_group_rabbit" },
        {
            distribution = {
                { group = "trait_group_rabbit_nonthres" },
                { group = "trait_group_rabbit_postthres" },
            },
        },
    },
}

ccb.content.define_npc_class {
    id = "NC_NPC_MUTANT_SNAIL",
    name = ccb.content.text("Shell Cultist"),
    job_description = ccb.content.text("A religious cult of post human snail people that live in a volcanic cave under the ice."),
    skills = {
        { skill = "fabrication", bonus = { rng = { 3, 6 } } },
        { skill = "firstaid", bonus = { rng = { 3, 6 } } },
        { skill = "gun", bonus = { rng = { 3, 6 } } },
    },
    perception = 2,
    strength = 2,
    intelligence = 2,
    common = false,
    traits = {
        { group = "trait_mutant_npc_common" },
        { group = "BG_survival_story_MUTANTS" },
        { group = "trait_group_snail" },
        {
            distribution = {
                { group = "trait_group_snail_nonthres" },
                { group = "trait_group_snail_postthres" },
            },
        },
    },
}

ccb.content.define_npc_class {
    id = "NC_NPC_MUTANT_FROG",
    name = ccb.content.text("Frog Mutant"),
    job_description = ccb.content.text("I'm looking for frog mutagen… this world is no place for humans anymore, and I don't plan to keep being one."),
    skills = {
        { skill = "dodge", bonus = { rng = { 3, 6 } } },
        { skill = "swimming", bonus = { rng = { 3, 6 } } },
        { skill = "unarmed", bonus = { rng = { 3, 6 } } },
    },
    perception = 2,
    dexterity = 4,
    traits = {
        { group = "trait_mutant_npc_common" },
        { group = "BG_survival_story_MUTANTS" },
        { group = "trait_group_frog" },
        {
            distribution = {
                { group = "trait_group_frog_nonthres" },
                { group = "trait_group_frog_postthres" },
            },
        },
    },
}

ccb.content.define_npc_class {
    id = "NC_NPC_MUTANT_MEDICAL",
    name = ccb.content.text("Medical Mutant"),
    job_description = ccb.content.text("I'm looking for medical mutagen… this world is no place for humans anymore, and I don't plan to keep being one."),
    skills = {
        { skill = "dodge", bonus = { rng = { 3, 6 } } },
        { skill = "melee", bonus = { rng = { 3, 6 } } },
        { skill = "unarmed", bonus = { rng = { 3, 6 } } },
    },
    traits = {
        { group = "trait_mutant_npc_common" },
        { group = "BG_survival_story_MUTANTS" },
        { group = "trait_group_medical" },
        {
            distribution = {
                { group = "trait_group_medical_nonthres" },
                { group = "trait_group_medical_postthres" },
            },
        },
    },
}

ccb.content.define_npc_class {
    id = "NC_NPC_MUTANT_BIRD",
    name = ccb.content.text("Bird Mutant"),
    job_description = ccb.content.text("I'm looking for bird mutagen… this world is no place for humans anymore, and I don't plan to keep being one."),
    skills = {
        { skill = "dodge", bonus = { rng = { 4, 8 } } },
        { skill = "melee", bonus = { rng = { 3, 6 } } },
        { skill = "unarmed", bonus = { rng = { 3, 6 } } },
    },
    dexterity = 4,
    perception = 7,
    traits = {
        { group = "trait_mutant_npc_common" },
        { group = "BG_survival_story_MUTANTS" },
        { group = "trait_group_bird" },
        {
            distribution = {
                { group = "trait_group_bird_nonthres" },
                { group = "trait_group_bird_postthres" },
            },
        },
    },
}

ccb.content.define_npc_class {
    id = "NC_NPC_MUTANT_FISH",
    name = ccb.content.text("Fish Mutant"),
    job_description = ccb.content.text("I'm looking for fish mutagen… this world is no place for humans anymore, and I don't plan to keep being one."),
    skills = {
        { skill = "dodge", bonus = { rng = { 4, 8 } } },
        { skill = "melee", bonus = { rng = { 3, 6 } } },
        { skill = "unarmed", bonus = { rng = { 3, 6 } } },
        { skill = "swimming", bonus = { rng = { 5, 15 } } },
    },
    dexterity = 7,
    traits = {
        { group = "trait_mutant_npc_common" },
        { group = "BG_survival_story_MUTANTS" },
        { group = "trait_group_fish" },
        {
            distribution = {
                { group = "trait_group_fish_nonthres" },
                { group = "trait_group_fish_postthres" },
            },
        },
    },
}

ccb.content.define_npc_class {
    id = "NC_NPC_MUTANT_BEAST",
    name = ccb.content.text("Beast Mutant"),
    job_description = ccb.content.text("I'm looking for beast mutagen… this world is no place for humans anymore, and I don't plan to keep being one."),
    skills = {
        { skill = "dodge", bonus = { rng = { 4, 8 } } },
        { skill = "melee", bonus = { rng = { 4, 8 } } },
        { skill = "unarmed", bonus = { rng = { 4, 8 } } },
    },
    strength = 7,
    traits = {
        { group = "trait_mutant_npc_common" },
        { group = "BG_survival_story_MUTANTS" },
        { group = "trait_group_beast" },
        {
            distribution = {
                { group = "trait_group_beast_nonthres" },
                { group = "trait_group_beast_postthres" },
            },
        },
    },
}

ccb.content.define_npc_class {
    id = "NC_NPC_MUTANT_URSINE",
    name = ccb.content.text("Ursine Mutant"),
    job_description = ccb.content.text("I'm looking for ursine mutagen… this world is no place for humans anymore, and I don't plan to keep being one."),
    skills = {
        { skill = "dodge", bonus = { rng = { 2, 4 } } },
        { skill = "melee", bonus = { rng = { 3, 6 } } },
        { skill = "unarmed", bonus = { rng = { 3, 6 } } },
    },
    strength = 11,
    traits = {
        { group = "trait_mutant_npc_common" },
        { group = "BG_survival_story_MUTANTS" },
        { group = "trait_group_ursine" },
        {
            distribution = {
                { group = "trait_group_ursine_nonthres" },
                { group = "trait_group_ursine_postthres" },
            },
        },
    },
}

ccb.content.define_npc_class {
    id = "NC_NPC_MUTANT_FELINE",
    name = ccb.content.text("Feline Mutant"),
    job_description = ccb.content.text("I'm looking for feline mutagen… this world is no place for humans anymore, and I don't plan to keep being one."),
    skills = {
        { skill = "dodge", bonus = { rng = { 3, 6 } } },
        { skill = "melee", bonus = { rng = { 3, 6 } } },
        { skill = "unarmed", bonus = { rng = { 3, 6 } } },
    },
    dexterity = 4,
    traits = {
        { group = "trait_mutant_npc_common" },
        { group = "BG_survival_story_MUTANTS" },
        { group = "trait_group_feline" },
        {
            distribution = {
                { group = "trait_group_feline_nonthres" },
                { group = "trait_group_feline_postthres" },
            },
        },
    },
}

ccb.content.define_npc_class {
    id = "NC_NPC_MUTANT_LUPINE",
    name = ccb.content.text("Lupine Mutant"),
    job_description = ccb.content.text("I'm looking for lupine mutagen… this world is no place for humans anymore, and I don't plan to keep being one."),
    skills = {
        { skill = "dodge", bonus = { rng = { 3, 6 } } },
        { skill = "melee", bonus = { rng = { 3, 6 } } },
        { skill = "unarmed", bonus = { rng = { 3, 6 } } },
    },
    strength = 4,
    traits = {
        { group = "trait_mutant_npc_common" },
        { group = "trait_group_lupine" },
        { group = "BG_survival_story_MUTANTS" },
        {
            distribution = {
                { group = "trait_group_lupine_nonthres" },
                { group = "trait_group_lupine_postthres" },
            },
        },
    },
}

ccb.content.define_npc_class {
    id = "NC_NPC_MUTANT_CATTLE",
    name = ccb.content.text("Cattle Mutant"),
    job_description = ccb.content.text("I'm looking for cattle mutagen… this world is no place for humans anymore, and I don't plan to keep being one."),
    skills = {
        { skill = "dodge", bonus = { rng = { 2, 4 } } },
        { skill = "melee", bonus = { rng = { 3, 6 } } },
        { skill = "unarmed", bonus = { rng = { 3, 6 } } },
    },
    strength = 6,
    traits = {
        { group = "trait_mutant_npc_common" },
        { group = "BG_survival_story_MUTANTS" },
        { group = "trait_group_cattle" },
        {
            distribution = {
                { group = "trait_group_cattle_nonthres" },
                { group = "trait_group_cattle_postthres" },
            },
        },
    },
}

ccb.content.define_npc_class {
    id = "NC_NPC_MUTANT_INSECT",
    name = ccb.content.text("Insect Mutant"),
    job_description = ccb.content.text("I'm looking for insect mutagen… this world is no place for humans anymore, and I don't plan to keep being one."),
    skills = {
        { skill = "dodge", bonus = { rng = { 3, 6 } } },
        { skill = "melee", bonus = { rng = { 3, 6 } } },
        { skill = "unarmed", bonus = { rng = { 3, 6 } } },
    },
    strength = 1,
    dexterity = 1,
    traits = {
        { group = "trait_mutant_npc_common" },
        { group = "BG_survival_story_MUTANTS" },
        { group = "trait_group_insect" },
        {
            distribution = {
                { group = "trait_group_insect_nonthres" },
                { group = "trait_group_insect_postthres" },
            },
        },
    },
}

ccb.content.define_npc_class {
    id = "NC_NPC_MUTANT_PLANT",
    name = ccb.content.text("Plant Mutant"),
    job_description = ccb.content.text("I'm looking for plant mutagen… this world is no place for humans anymore, and I don't plan to keep being one."),
    skills = {
        { skill = "dodge", bonus = { rng = { 2, 4 } } },
        { skill = "melee", bonus = { rng = { 3, 6 } } },
        { skill = "unarmed", bonus = { rng = { 3, 6 } } },
    },
    strength = 2,
    traits = {
        { group = "trait_mutant_npc_common" },
        { group = "BG_survival_story_MUTANTS" },
        { group = "trait_group_plant" },
        {
            distribution = {
                { group = "trait_group_plant_nonthres" },
                { group = "trait_group_plant_postthres" },
            },
        },
    },
}

ccb.content.define_npc_class {
    id = "NC_NPC_MUTANT_SLIME",
    name = ccb.content.text("Slime Mutant"),
    job_description = ccb.content.text("I'm looking for slime mutagen… this world is no place for humans anymore, and I don't plan to keep being one."),
    skills = {
        { skill = "dodge", bonus = { rng = { 2, 4 } } },
        { skill = "melee", bonus = { rng = { 2, 4 } } },
        { skill = "unarmed", bonus = { rng = { 2, 4 } } },
    },
    strength = -4,
    dexterity = 5,
    intelligence = 10,
    perception = 5,
    traits = {
        { group = "trait_mutant_npc_common" },
        { group = "BG_survival_story_MUTANTS" },
        { group = "trait_group_slime" },
        {
            distribution = {
                { group = "trait_group_slime_nonthres" },
                { group = "trait_group_slime_postthres" },
            },
        },
    },
}

ccb.content.define_npc_class {
    id = "NC_NPC_MUTANT_TROGLOBITE",
    name = ccb.content.text("Troglobite Mutant"),
    job_description = ccb.content.text("I'm looking for troglobite mutagen… this world is no place for humans anymore, and I don't plan to keep being one."),
    skills = {
        { skill = "dodge", bonus = { rng = { 2, 4 } } },
        { skill = "melee", bonus = { rng = { 4, 8 } } },
        { skill = "unarmed", bonus = { rng = { 4, 8 } } },
    },
    strength = 6,
    dexterity = -2,
    traits = {
        { group = "trait_mutant_npc_common" },
        { group = "BG_survival_story_MUTANTS" },
        { group = "trait_group_troglobite" },
        {
            distribution = {
                { group = "trait_group_troglobite_nonthres" },
                { group = "trait_group_troglobite_postthres" },
            },
        },
    },
}

ccb.content.define_npc_class {
    id = "NC_NPC_MUTANT_CEPHALOPOD",
    name = ccb.content.text("Cephalopod Mutant"),
    job_description = ccb.content.text("I'm looking for cephalopod mutagen… this world is no place for humans anymore, and I don't plan to keep being one."),
    skills = {
        { skill = "dodge", bonus = { rng = { 3, 6 } } },
        { skill = "melee", bonus = { rng = { 2, 4 } } },
        { skill = "unarmed", bonus = { rng = { 2, 4 } } },
        { skill = "swimming", bonus = { rng = { 3, 6 } } },
    },
    dexterity = 7,
    intelligence = 7,
    traits = {
        { group = "trait_mutant_npc_common" },
        { group = "BG_survival_story_MUTANTS" },
        { group = "trait_group_cephalopod" },
        {
            distribution = {
                { group = "trait_group_cephalopod_nonthres" },
                { group = "trait_group_cephalopod_postthres" },
            },
        },
    },
}

ccb.content.define_npc_class {
    id = "NC_NPC_MUTANT_SPIDER",
    name = ccb.content.text("Spider Mutant"),
    job_description = ccb.content.text("I'm looking for spider mutagen… this world is no place for humans anymore, and I don't plan to keep being one."),
    skills = {
        { skill = "dodge", bonus = { rng = { 3, 6 } } },
        { skill = "melee", bonus = { rng = { 3, 6 } } },
        { skill = "unarmed", bonus = { rng = { 3, 6 } } },
    },
    dexterity = 2,
    traits = {
        { group = "trait_mutant_npc_common" },
        { group = "BG_survival_story_MUTANTS" },
        { group = "trait_group_spider" },
        {
            distribution = {
                { group = "trait_group_spider_nonthres" },
                { group = "trait_group_spider_postthres" },
            },
        },
    },
}

ccb.content.define_npc_class {
    id = "NC_NPC_MUTANT_RAT",
    name = ccb.content.text("Rat Mutant"),
    job_description = ccb.content.text("I'm looking for rat mutagen… this world is no place for humans anymore, and I don't plan to keep being one."),
    skills = {
        { skill = "dodge", bonus = { rng = { 3, 6 } } },
        { skill = "melee", bonus = { rng = { 3, 6 } } },
        { skill = "unarmed", bonus = { rng = { 3, 6 } } },
    },
    traits = {
        { group = "trait_mutant_npc_common" },
        { group = "BG_survival_story_MUTANTS" },
        { group = "trait_group_rat" },
        { distribution = { { group = "trait_group_rat_nonthres" }, { group = "trait_group_rat_postthres" } } },
    },
}

ccb.content.define_npc_class {
    id = "NC_NPC_MUTANT_MOUSE",
    name = ccb.content.text("Mouse Mutant"),
    job_description = ccb.content.text("I'm looking for mouse mutagen… this world is no place for humans anymore, and I don't plan to keep being one."),
    skills = {
        { skill = "dodge", bonus = { rng = { 4, 7 } } },
        { skill = "melee", bonus = { rng = { 2, 5 } } },
        { skill = "unarmed", bonus = { rng = { 2, 5 } } },
    },
    dexterity = 6,
    traits = {
        { group = "trait_mutant_npc_common" },
        { group = "BG_survival_story_MUTANTS" },
        { group = "trait_group_mouse" },
        {
            distribution = {
                { group = "trait_group_mouse_nonthres" },
                { group = "trait_group_mouse_postthres" },
            },
        },
    },
}

ccb.content.define_npc_class {
    id = "NC_NPC_MUTANT_ALPHA",
    name = ccb.content.text("Alpha Mutant"),
    job_description = ccb.content.text("I'm looking for alpha mutagen… this world is no place for humans anymore, and I don't plan to keep being one."),
    skills = {
        { skill = "dodge", bonus = { rng = { 3, 6 } } },
        { skill = "melee", bonus = { rng = { 3, 6 } } },
        { skill = "unarmed", bonus = { rng = { 3, 6 } } },
    },
    strength = 5,
    dexterity = 5,
    intelligence = 5,
    perception = 5,
    traits = {
        { group = "trait_mutant_npc_common" },
        { group = "BG_survival_story_MUTANTS" },
        { group = "trait_group_alpha" },
        {
            distribution = {
                { group = "trait_group_alpha_nonthres" },
                { group = "trait_group_alpha_postthres" },
            },
        },
    },
}

ccb.content.define_npc_class {
    id = "NC_NPC_MUTANT_ELFA",
    name = ccb.content.text("Elf-A Mutant"),
    job_description = ccb.content.text("I'm looking for Elf-A mutagen… this world is no place for humans anymore, and I don't plan to keep being one."),
    skills = {
        { skill = "dodge", bonus = { rng = { 4, 8 } } },
        { skill = "melee", bonus = { rng = { 2, 4 } } },
        { skill = "unarmed", bonus = { rng = { 2, 4 } } },
    },
    strength = 1,
    dexterity = 5,
    intelligence = 4,
    perception = 4,
    traits = {
        { group = "trait_mutant_npc_common" },
        { group = "BG_survival_story_MUTANTS" },
        { group = "trait_group_elfa" },
        {
            distribution = {
                { group = "trait_group_elfa_nonthres" },
                { group = "trait_group_elfa_postthres" },
            },
        },
    },
}

ccb.content.define_npc_class {
    id = "NC_NPC_MUTANT_CHIMERA",
    name = ccb.content.text("Chimera Mutant"),
    job_description = ccb.content.text("I'm looking for chimera mutagen… this world is no place for humans anymore, and I don't plan to keep being one."),
    skills = {
        { skill = "dodge", bonus = { rng = { 4, 8 } } },
        { skill = "melee", bonus = { rng = { 4, 8 } } },
        { skill = "unarmed", bonus = { rng = { 4, 8 } } },
    },
    strength = 4,
    dexterity = 2,
    perception = 2,
    traits = {
        { group = "trait_mutant_npc_common" },
        { group = "BG_survival_story_MUTANTS" },
        { group = "trait_group_chimera" },
        {
            distribution = {
                { group = "trait_group_chimera_nonthres" },
                { group = "trait_group_chimera_postthres" },
            },
        },
    },
}

ccb.content.define_npc_class {
    id = "NC_NPC_MUTANT_RAPTOR",
    name = ccb.content.text("Raptor Mutant"),
    job_description = ccb.content.text("I'm looking for raptor mutagen… this world is no place for humans anymore, and I don't plan to keep being one."),
    skills = {
        { skill = "dodge", bonus = { rng = { 6, 10 } } },
        { skill = "melee", bonus = { rng = { 6, 10 } } },
        { skill = "unarmed", bonus = { rng = { 6, 10 } } },
    },
    strength = 1,
    dexterity = 2,
    perception = 4,
    traits = {
        { group = "trait_mutant_npc_common" },
        { group = "BG_survival_story_MUTANTS" },
        { group = "trait_group_raptor" },
        {
            distribution = {
                { group = "trait_group_raptor_nonthres" },
                { group = "trait_group_raptor_postthres" },
            },
        },
        { group = "trait_group_raptor" },
        {
            distribution = {
                { group = "trait_group_raptor_nonthres" },
                { group = "trait_group_raptor_postthres" },
            },
        },
    },
}

ccb.content.define_npc_class {
    id = "NC_NPC_MUTANT_MASTODON",
    name = ccb.content.text("Mastodon Uplift"),
    job_description = ccb.content.text("Humans created me.  Let's see what I can be on my own."),
    skills = {
        { skill = "survival", bonus = { rng = { 2, 4 } } },
        { skill = "melee", bonus = { rng = { 6, 10 } } },
        { skill = "unarmed", bonus = { rng = { 6, 10 } } },
    },
    strength = 3,
    traits = {
        { group = "trait_mutant_npc_common" },
        { group = "trait_group_mastodon" },
        {
            distribution = {
                { group = "trait_group_mastodon_nonthres" },
                { group = "trait_group_mastodon_postthres" },
            },
        },
    },
}
