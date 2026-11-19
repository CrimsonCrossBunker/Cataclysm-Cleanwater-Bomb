local ccb = require("ccb")

ccb.content.define_npc_class {
    id = "NC_NONE",
    name = ccb.content.text("No class"),
    job_description = ccb.content.text("I'm just wandering."),
    traits = {
        { group = "BG_survival_story_EVACUEE" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 4, 2 } }, { rng = { -4, -1 } } } } } },
        },
    },
}

ccb.content.define_npc_class {
    id = "NC_NONE_HARDENED",
    name = ccb.content.text("No class"),
    job_description = ccb.content.text("I'm a dummy class for better NPC items later into the Cataclysm."),
}

ccb.content.define_npc_class {
    id = "NC_TEST_CLASS",
    name = ccb.content.text("Debug Dude"),
    job_description = ccb.content.text("I'm helping you test the game."),
    common = false,
    strength = 100,
    dexterity = { dice = { 10, 10 } },
    intelligence = { one_in = 2 },
    perception = { sum = { { constant = 100 }, { dice = { 10, 10 } } } },
    worn = "NC_DEBUG_worn",
    carry = "NC_DEBUG_carried",
    weapon = "NC_DEBUG_weapon",
    traits = { { "DEBUG_NODMG", 100 } },
}

-- This is a unique NPC who doesn't get randomly selected background traits
ccb.content.define_npc_class {
    id = "NC_SHOPKEEP",
    name = ccb.content.text("Shopkeep"),
    job_description = ccb.content.text("I'm a local shopkeeper."),
    traits = { { group = "NPC_starting_traits" }, { group = "Appearance_demographics" } },
    common = false,
}

ccb.content.define_npc_class {
    id = "NC_DOCTOR",
    name = ccb.content.text("Doctor"),
    job_description = ccb.content.text("I'm looking for wounded to help."),
    traits = {
        { group = "BG_survival_story_MEDICAL" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    strength = { rng = { -2, 0 } },
    intelligence = { rng = { 0, 2 } },
    perception = { rng = { 0, 2 } },
    aggression = { rng = { -4, 0 } },
    shop_groups = "NC_DOCTOR_misc",
    proficiencies = {
        "prof_intro_chemistry",
        "prof_intro_biology",
        "prof_wound_care",
        "prof_wound_care_expert",
        "prof_burn_care",
        "prof_dissect_humans",
        "prof_physiology",
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 3, 2 } }, { rng = { -1, -3 } } } } } },
        },
        { skill = "chemistry", bonus = { rng = { 1, 3 } } },
        { skill = "dodge", bonus = 1 },
        { skill = "firstaid", bonus = { rng = { 2, 6 } } },
        { skill = "speech", bonus = { sum = { { dice = { 3, 2 } }, { constant = -2 } } } },
    },
}

-- Reasonably, this class should receive animal-specific medical proficiencies if they're ever added.
ccb.content.define_npc_class {
    id = "NC_VETERINARIAN",
    name = ccb.content.text("Veterinarian"),
    job_description = ccb.content.text("I'm looking for wounded to help."),
    traits = {
        { group = "BG_survival_story_STUCK_IN_TOWN" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    strength = { rng = { -2, 0 } },
    intelligence = { rng = { 0, 2 } },
    perception = { rng = { 0, 2 } },
    aggression = { rng = { -4, 0 } },
    shop_groups = "NC_DOCTOR_misc",
    proficiencies = {
        "prof_intro_chemistry",
        "prof_intro_biology",
        "prof_wound_care",
        "prof_wound_care_expert",
        "prof_burn_care",
        "prof_dissect_humans",
        "prof_physiology",
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 3, 2 } }, { rng = { -1, -3 } } } } } },
        },
        { skill = "chemistry", bonus = { rng = { 1, 3 } } },
        { skill = "dodge", bonus = 1 },
        { skill = "firstaid", bonus = { rng = { 2, 6 } } },
        { skill = "speech", bonus = { sum = { { dice = { 3, 2 } }, { constant = -2 } } } },
    },
}

ccb.content.define_npc_class {
    id = "NC_COWBOY",
    name = ccb.content.text("Cowboy"),
    job_description = ccb.content.text("I'm looking to make an honest living using the skills I gained in the country."),
    traits = {
        { group = "BG_survival_story_RURAL" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    strength = { rng = { 0, 1 } },
    intelligence = { rng = { -2, 0 } },
    perception = { rng = { 0, 2 } },
    aggression = { rng = { 0, 2 } },
    bravery = { rng = { 1, 5 } },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -4 } } } } } },
        },
        { skill = "gun", bonus = { rng = { 1, 3 } } },
        { skill = "pistol", bonus = { rng = { 1, 3 } } },
        { skill = "rifle", bonus = { rng = { 0, 2 } } },
        { skill = "survival", bonus = { rng = { 0, 2 } } },
    },
}

ccb.content.define_npc_class {
    id = "NC_MARLOSS_VOICE",
    name = ccb.content.text("Marloss Voice"),
    job_description = ccb.content.text("I spread the Hymns so that peace and unity return to our world."),
    traits = {
        { group = "BG_survival_story_RURAL" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { "MARLOSS", 100 },
        { "MARLOSS_BLUE", 40 },
        { "MYCUS_FRIEND", 100 },
        { "FLIMSY2", 100 },
    },
    common = false,
    worn = "NC_VOICE_worn",
    carry = "NC_VOICE_carry",
    weapon = "NC_VOICE_weapon",
    strength = { rng = { 0, 1 } },
    intelligence = { rng = { -2, 0 } },
    perception = { rng = { 0, 2 } },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -4 } } } } } },
        },
        { skill = "dodge", bonus = { rng = { 1, 3 } } },
        { skill = "melee", bonus = { rng = { 2, 4 } } },
        { skill = "unarmed", bonus = { rng = { 1, 3 } } },
    },
}

ccb.content.define_npc_class {
    id = "NC_FARMER",
    name = ccb.content.text("Farmer"),
    job_description = ccb.content.text("I made things grow before, I bet I can do it again once things calm down."),
    traits = {
        { group = "BG_survival_story_RURAL" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    strength = { rng = { 0, 1 } },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { rng = { 0, -4 } } } } } },
        },
        { skill = "survival", bonus = { rng = { 0, 2 } } },
        { skill = "rifle", bonus = { rng = { 0, 2 } } },
    },
}

ccb.content.define_npc_class {
    id = "NC_BOUNTY_HUNTER",
    name = ccb.content.text("Bounty Hunter"),
    job_description = ccb.content.text("I'm a killer for hire."),
    traits = {
        { group = "BG_survival_story_POLICE" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    aggression = { rng = { 1, 6 } },
    bravery = { rng = { 0, 5 } },
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -3 } } } },
        { skill = "gun", bonus = { rng = { 2, 4 } } },
        { skill = "pistol", bonus = { rng = { 2, 4 } } },
        { skill = "rifle", bonus = { rng = { 2, 4 } } },
    },
}

ccb.content.define_npc_class {
    id = "NC_THUG",
    name = ccb.content.text("Thug"),
    job_description = ccb.content.text("I'm just here for the paycheck."),
    traits = {
        { group = "BG_survival_story_CRIMINAL" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    strength = { rng = { 2, 4 } },
    dexterity = { rng = { 0, 2 } },
    aggression = { rng = { 1, 6 } },
    bravery = { rng = { 0, 5 } },
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
    id = "NC_LAB_MUTANT",
    name = ccb.content.text("Mutant"),
    job_description = ccb.content.text("I'm a survivor trying to come to terms with my strange new self in this strange new world."),
    traits = {
        { group = "BG_survival_story_LAB_MUTANT" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { group = "BG_LAB_MUTANT_Tree_Choice" },
    },
    proficiencies = { "prof_gross_anatomy", "prof_unarmed_familiar" },
    strength = { rng = { 2, 4 } },
    dexterity = { rng = { 0, 2 } },
    aggression = { rng = { 0, 1 } },
    bravery = { rng = { 0, 5 } },
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -4 } } } },
        { skill = "dodge", bonus = { rng = { 1, 5 } } },
        { skill = "melee", bonus = { rng = { 2, 6 } } },
        { skill = "unarmed", bonus = { rng = { 1, 5 } } },
        { skill = "bashing", bonus = { rng = { 1, 5 } } },
        { skill = "stabbing", bonus = { rng = { 1, 5 } } },
        { skill = "cutting", bonus = { rng = { 1, 5 } } },
    },
}

ccb.content.define_npc_class {
    id = "NC_SCAVENGER",
    name = ccb.content.text("Scavenger"),
    job_description = ccb.content.text("I'm just trying to survive."),
    traits = {
        { group = "BG_survival_story_EVACUEE" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    aggression = { rng = { 1, 3 } },
    bravery = { rng = { 1, 4 } },
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -3 } } } },
        { skill = "gun", bonus = { rng = { 2, 4 } } },
        { skill = "pistol", bonus = { rng = { 2, 5 } } },
        { skill = "rifle", bonus = { rng = { 0, 3 } } },
        { skill = "archery", bonus = { rng = { 0, 3 } } },
    },
}

ccb.content.define_npc_class {
    id = "NC_SCAVENGER_PREPPER",
    name = ccb.content.text("Scavenger"),
    job_description = ccb.content.text("I'm just trying to survive."),
    traits = {
        { group = "BG_survival_story_EVACUEE" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "GETS_RANDOM_MISSION_NOMOVE" },
    },
    shop_groups = {
        { id = "homeguns", rigid = true },
        { id = "lmoe_guns", rigid = true },
        { id = "ammo_common_boxed", rigid = true },
        { id = "magazines", rigid = true },
        { id = "gear_survival", rigid = true },
    },
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -3 } } } },
        { skill = "gun", bonus = { rng = { 2, 4 } } },
        { skill = "pistol", bonus = { rng = { 2, 5 } } },
        { skill = "rifle", bonus = { rng = { 0, 3 } } },
        { skill = "archery", bonus = { rng = { 0, 3 } } },
    },
}

ccb.content.define_npc_class {
    id = "NC_SCAVENGER_MOONSHINER",
    name = ccb.content.text("Scavenger"),
    job_description = ccb.content.text("I'm just trying to survive."),
    traits = {
        { group = "BG_survival_story_EVACUEE" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "GETS_RANDOM_MISSION_NOMOVE" },
    },
    shop_groups = { { id = "still_alcohol", rigid = true }, { id = "keg_wine_intact", rigid = true } },
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -3 } } } },
        { skill = "gun", bonus = { rng = { 2, 4 } } },
        { skill = "pistol", bonus = { rng = { 2, 5 } } },
        { skill = "rifle", bonus = { rng = { 0, 3 } } },
        { skill = "archery", bonus = { rng = { 0, 3 } } },
    },
}

ccb.content.define_npc_class {
    id = "NC_SCAVENGER_EX_PILOT",
    name = ccb.content.text("Former Pilot"),
    job_description = ccb.content.text("I just want to fly away to somewhere better."),
    spawn_weight = 0.3,
    traits = {
        { trait = "BGSS_Lost_Pilot_1" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    perception = { rng = { 2, 4 } },
    proficiencies = { "prof_helicopter_pilot" },
    skills = { { skill = "driving", bonus = { rng = { 3, 5 } } } },
}

ccb.content.define_npc_class {
    id = "NC_HUNTER",
    name = ccb.content.text("Hunter"),
    job_description = ccb.content.text("I'm tracking game."),
    traits = {
        { group = "BG_survival_story_RURAL" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    strength = { rng = { -2, 0 } },
    dexterity = { rng = { -3, -1 } },
    perception = { rng = { 2, 4 } },
    shop_groups = "NC_HUNTER_misc",
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { rng = { 0, -4 } } } } },
        { skill = "gun", bonus = { rng = { 2, 4 } } },
        { skill = "rifle", bonus = { rng = { 2, 4 } } },
        { skill = "archery", bonus = { rng = { 2, 4 } } },
        { skill = "speech", bonus = { rng = { 2, 5 } } },
    },
}

-- This is for NPCs who need to remain in a general area, such as a trader.
ccb.content.define_npc_class {
    id = "NC_SCAVENGER_NOMOVE",
    name = ccb.content.text("Scavenger"),
    common = false,
    job_description = ccb.content.text("I'm just trying to survive."),
    traits = {
        { group = "BG_survival_story_EVACUEE" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "GETS_RANDOM_MISSION_NOMOVE" },
    },
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -3 } } } },
        { skill = "gun", bonus = { rng = { 2, 4 } } },
        { skill = "pistol", bonus = { rng = { 2, 5 } } },
        { skill = "rifle", bonus = { rng = { 0, 3 } } },
        { skill = "archery", bonus = { rng = { 0, 3 } } },
    },
}

-- This is for NPCs who are spawned in by mapgen, to give them a mission.
ccb.content.define_npc_class {
    id = "NC_SCAVENGER_STATIC",
    name = ccb.content.text("Scavenger"),
    common = false,
    job_description = ccb.content.text("I'm just trying to survive."),
    traits = {
        { group = "BG_survival_story_EVACUEE" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "GETS_RANDOM_MISSION" },
    },
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -3 } } } },
        { skill = "gun", bonus = { rng = { 2, 4 } } },
        { skill = "pistol", bonus = { rng = { 2, 5 } } },
        { skill = "rifle", bonus = { rng = { 0, 3 } } },
        { skill = "archery", bonus = { rng = { 0, 3 } } },
    },
}

ccb.content.define_npc_class {
    id = "NC_SOLDIER",
    name = ccb.content.text("Soldier"),
    job_description = ccb.content.text("I'm just here for the paycheck."),
    traits = {
        { group = "BG_survival_story_SOLDIER" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    proficiencies = { "prof_gunsmithing_basic", "prof_spotting" },
    strength = { rng = { 0, 2 } },
    dexterity = { one_in = 2 },
    intelligence = { rng = { 0, -2 } },
    aggression = { rng = { 1, 3 } },
    bravery = { rng = { 0, 3 } },
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -3 } } } },
        { skill = "dodge", bonus = { rng = { 1, 2 } } },
        { skill = "melee", bonus = { rng = { 1, 2 } } },
        { skill = "unarmed", bonus = { rng = { 1, 2 } } },
        { skill = "rifle", bonus = { rng = { 3, 5 } } },
        { skill = "gun", bonus = { rng = { 2, 4 } } },
    },
}

ccb.content.define_npc_class {
    id = "NC_BARTENDER",
    name = ccb.content.text("Bartender"),
    job_description = ccb.content.text("I'm looking for new drink recipes."),
    traits = { { group = "NPC_starting_traits" }, { group = "Appearance_demographics" } },
    common = false,
    perception = { one_in = 4 },
    collector = { rng = { 1, 5 } },
    shop_groups = "NC_BARTENDER_misc",
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "speech", bonus = { rng = { 2, 5 } } },
    },
}

-- This is a unique NPC who doesn't get randomly selected background traits
ccb.content.define_npc_class {
    id = "NC_JUNK_SHOPKEEP",
    name = ccb.content.text("Shopkeep"),
    job_description = ccb.content.text("I'm a local shopkeeper."),
    traits = { { group = "NPC_starting_traits" }, { group = "Appearance_demographics" } },
    common = false,
    perception = { one_in = 4 },
    collector = { rng = { 1, 5 } },
    shop_groups = "NC_JUNK_SHOPKEEP_misc",
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "speech", bonus = { rng = { 2, 5 } } },
    },
}

-- NPCs can't run yet and we want this one to be fast, so road runner.
-- This is a unique NPC who doesn't get randomly selected background traits
ccb.content.define_npc_class {
    id = "NC_APIS",
    name = ccb.content.text("Apis"),
    job_description = ccb.content.text("I'm bugged - I shouldn't talk to you."),
    common = false,
    dexterity = { rng = { 2, 6 } },
    intelligence = { rng = { -4, -8 } },
    perception = { rng = { 2, 6 } },
    strength = { rng = { 2, 4 } },
    skills = {
        { skill = "dodge", level = { dice = { 5, 1 } } },
        { skill = "melee", level = { dice = { 5, 1 } } },
        { skill = "unarmed", level = { dice = { 5, 1 } } },
    },
    worn = "EMPTY_GROUP",
    carry = "EMPTY_GROUP",
    weapon = "EMPTY_GROUP",
    traits = {
        { "THRESH_INSECT", 100 },
        { "BEE", 100 },
        { "MANDIBLES", 100 },
        { "TAIL_STING", 100 },
        { "INSECT_ARMS_OK", 100 },
        { "CHITIN", 100 },
        { "CHITIN2", 100 },
        { "POISONOUS2", 100 },
        { "PAINRESIST", 100 },
        { "ADRENALINE", 100 },
        { "FLEET2", 100 },
        { "ANTENNAE", 100 },
        { "COMPOUND_EYES", 100 },
        { "MUTE_INSECT", 100 },
        { "PROBOSCIS", 100 },
        { "personality_brave", 100 },
        { "personality_aggressive_plus", 100 },
    },
}

ccb.content.define_npc_class {
    id = "NC_HALLU",
    name = ccb.content.text("Real Person"),
    job_description = ccb.content.text("I'm just wandering, like a totally real and normal NP… person!"),
    traits = {
        { group = "BG_survival_story_UNIVERSAL" },
        { group = "NPC_starting_traits" },
        { "HALLUCINATION", 100 },
    },
    common = false,
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 4, 2 } }, { rng = { -4, -1 } } } } } },
        },
    },
}

ccb.content.define_npc_class {
    id = "NC_SURVIVOR_CHEF",
    name = ccb.content.text("Chef"),
    job_description = ccb.content.text("I'm a chef."),
    traits = { { group = "NPC_starting_traits" }, { group = "Appearance_demographics" } },
    common = false,
    perception = { one_in = 4 },
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "throw", bonus = { rng = { 1, 3 } } },
        { skill = "cooking", bonus = { rng = { 3, 6 } } },
    },
}

ccb.content.define_npc_class {
    id = "NC_TRUE_FOODPERSON",
    name = ccb.content.text("Foodperson"),
    job_description = ccb.content.text("I AM FOODPERSON.  AND I BRING SUSTENANCE!"),
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { "PROF_FOODP", 100 },
    },
    common = false,
    worn = "NC_TRUE_FOODPERSON_worn",
    weapon = "NC_TRUE_FOODPERSON_melee",
    strength = { rng = { 0, 2 } },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 4, 2 } }, { rng = { -4, -1 } } } } } },
        },
        { skill = "bashing", bonus = { rng = { 1, 3 } } },
        { skill = "speech", bonus = { rng = { 1, 3 } } },
        { skill = "dodge", bonus = { rng = { 3, 6 } } },
    },
}

ccb.content.define_npc_class {
    id = "NC_CYBORG",
    name = ccb.content.text("Cyborg"),
    job_description = ccb.content.text("Zzzzzt… I… I'm a Cy… BEEEEEP… borg."),
    traits = {
        { group = "BG_survival_story_CYBORG" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 4, 2 } }, { rng = { -4, -1 } } } } } },
        },
    },
    common = false,
    worn = "NC_CYBORG_worn",
    carry = "NC_CYBORG_carried",
    weapon = "EMPTY_GROUP",
    bionics = {
        { id = "bio_ankles", chance = 100 },
        { id = "bio_dis_shock", chance = 100 },
        { id = "bio_dis_acid", chance = 100 },
        { id = "bio_drain", chance = 100 },
        { id = "bio_noise", chance = 100 },
        { id = "bio_power_weakness", chance = 100 },
        { id = "bio_itchy", chance = 100 },
        { id = "bio_nostril", chance = 100 },
        { id = "bio_thumbs", chance = 100 },
        { id = "bio_spasm", chance = 100 },
        { id = "bio_shakes", chance = 100 },
        { id = "bio_leaky", chance = 100 },
        { id = "bio_sleepy", chance = 100 },
        { id = "bio_deformity", chance = 100 },
        { id = "bio_voice", chance = 100 },
        { id = "bio_pokedeye", chance = 100 },
        { id = "bio_ankles", chance = 100 },
        { id = "bio_trip", chance = 100 },
        { id = "bio_stiff", chance = 100 },
        { id = "bio_armor_head", chance = 100 },
        { id = "bio_armor_torso", chance = 100 },
        { id = "bio_armor_arms", chance = 100 },
        { id = "bio_armor_legs", chance = 100 },
        { id = "bio_armor_eyes", chance = 100 },
        { id = "bio_razors", chance = 100 },
        { id = "bio_power_storage", chance = 100 },
        { id = "bio_torsionratchet", chance = 100 },
    },
}

ccb.content.define_npc_class {
    id = "NC_CYBORG_RESCUE",
    name = ccb.content.text("Cyborg"),
    job_description = ccb.content.text("I'm transhuman above and beyond."),
    traits = {
        { group = "BG_survival_story_CYBORG" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 4, 2 } }, { rng = { -4, -1 } } } } } },
        },
    },
    common = false,
    worn = "NC_ANCILLA_GRUNT_worn",
    carry = "NC_ANCILLA_GRUNT_carry",
    weapon = "EMPTY_GROUP",
    bionics = {
        { id = "bio_armor_head", chance = 100 },
        { id = "bio_armor_torso", chance = 100 },
        { id = "bio_armor_arms", chance = 100 },
        { id = "bio_armor_legs", chance = 100 },
        { id = "bio_armor_eyes", chance = 100 },
        { id = "bio_power_storage", chance = 100 },
        { id = "bio_painkiller", chance = 16 },
        { id = "bio_power_storage_mkII", chance = 90 },
    },
}

ccb.content.define_npc_class {
    id = "NC_CITY_COP",
    name = ccb.content.text("Former Cop"),
    job_description = ccb.content.text("I used to be a police officer, but I'm just a survivor now."),
    traits = { { group = "NPC_starting_traits" }, { group = "Appearance_demographics" } },
    common = false,
    perception = { one_in = 4 },
    shop_groups = "NC_CITY_COP_misc",
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "speech", bonus = { rng = { 2, 4 } } },
        { skill = "gun", bonus = { rng = { 4, 8 } } },
        { skill = "melee", bonus = { rng = { 3, 6 } } },
        { skill = "pistol", bonus = { rng = { 3, 6 } } },
        { skill = "rifle", bonus = { rng = { 3, 6 } } },
    },
}

ccb.content.define_npc_class {
    id = "NC_HOMELESS_BROKER",
    name = ccb.content.text("Scavenger"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    shop_groups = "homeless_broker_sell",
    worn = "NPC_homeless_worn",
    traits = {
        { group = "BG_survival_story_EVACUEE" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -3 } } } },
        { skill = "gun", bonus = { rng = { 2, 4 } } },
        { skill = "pistol", bonus = { rng = { 2, 5 } } },
        { skill = "rifle", bonus = { rng = { 0, 3 } } },
        { skill = "archery", bonus = { rng = { 0, 3 } } },
    },
}
