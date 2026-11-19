local ccb = require("ccb")

-- Dairy farmer the Isherwood family.  Duplicate copy for the rescue mission
ccb.content.define_npc {
    id = "isherwood_carlos_copy",
    unique_name = ccb.content.text("Carlos Isherwood"),
    gender = "male",
    class = "NC_ISHERWOOD_CARLOS",
    attitude = 0,
    mission = "GUARD",
    age = 51,
    height = 176,
    strength = 9,
    dexterity = 8,
    intelligence = 7,
    perception = 9,
    personality = { aggression = -2, bravery = 4, collector = -2, altruism = -1 },
    chat = "TALK_ISHERWOOD_FAMILY_DUPLICATES",
    faction = "isherwood_family",
}

-- Dairy farmer the Isherwood family.  Duplicate copy for the rescue mission
ccb.content.define_npc {
    id = "isherwood_carlos_swat_copy",
    unique_name = ccb.content.text("Carlos Isherwood"),
    gender = "male",
    class = "NC_ISHERWOOD_CARLOS_SWAT",
    attitude = 0,
    mission = "GUARD",
    age = 51,
    height = 176,
    strength = 9,
    dexterity = 8,
    intelligence = 7,
    perception = 9,
    personality = { aggression = -2, bravery = 4, collector = -2, altruism = -1 },
    chat = "TALK_ISHERWOOD_FAMILY_DUPLICATES",
    faction = "isherwood_family",
}

ccb.content.define_npc_class {
    id = "NC_ISHERWOOD_CARLOS_SWAT",
    name = ccb.content.text("Carlos Isherwood"),
    job_description = ccb.content.text("I'm Jesse's husband, part of the Isherwood family."),
    traits = {
        { trait = "NIGHTVISION" },
        { trait = "BADKNEES" },
        { trait = "GOODMEMORY" },
        { trait = "SKIN_TAN" },
        { trait = "eye_color", variant = "gray" },
        { trait = "hair_short", variant = "gray" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    common = false,
    worn = "NC_Isherwood_swat_worn",
    weapon = "NC_ISHERWOOD_rifle",
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "speech", bonus = { rng = { 2, 4 } } },
        { skill = "melee", bonus = { rng = { 3, 6 } } },
        { skill = "survival", bonus = { rng = { 7, 10 } } },
        { skill = "gun", bonus = { rng = { 4, 8 } } },
        { skill = "rifle", bonus = { rng = { 7, 10 } } },
        { skill = "archery", bonus = { rng = { 8, 10 } } },
    },
}

-- Dairy farmer of the Isherwood family.  Duplicate for the rescue mission.
ccb.content.define_npc {
    id = "isherwood_eddie_copy",
    unique_name = ccb.content.text("Eddie Isherwood"),
    gender = "male",
    class = "NC_ISHERWOOD_EDDIE",
    attitude = 0,
    mission = "GUARD",
    age = 41,
    height = 179,
    strength = 9,
    dexterity = 7,
    intelligence = 7,
    perception = 8,
    personality = { aggression = -4, bravery = -1, collector = 1, altruism = 1 },
    chat = "TALK_ISHERWOOD_FAMILY_DUPLICATES",
    faction = "isherwood_family",
}

-- Dairy farmer of the Isherwood family.  Duplicate for the rescue mission.
ccb.content.define_npc {
    id = "isherwood_eddie_swat_copy",
    unique_name = ccb.content.text("Eddie Isherwood"),
    gender = "male",
    class = "NC_ISHERWOOD_EDDIE_SWAT",
    attitude = 0,
    mission = "GUARD",
    age = 41,
    height = 179,
    strength = 9,
    dexterity = 7,
    intelligence = 7,
    perception = 8,
    personality = { aggression = -4, bravery = -1, collector = 1, altruism = 1 },
    chat = "TALK_ISHERWOOD_FAMILY_DUPLICATES",
    faction = "isherwood_family",
}

ccb.content.define_npc_class {
    id = "NC_ISHERWOOD_EDDIE_SWAT",
    name = ccb.content.text("Eddie Isherwood"),
    job_description = ccb.content.text("I'm a dairy farmer, part of the Isherwood family"),
    traits = {
        { trait = "ASTHMA" },
        { trait = "JITTERY" },
        { trait = "OPTIMISTIC" },
        { trait = "SKIN_TAN" },
        { trait = "eye_color", variant = "hazel" },
        { trait = "hair_short", variant = "black" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    common = false,
    perception = { one_in = 4 },
    worn = "NC_Isherwood_swat_worn",
    weapon = "NC_ISHERWOOD_rifle",
    shop_groups = "NC_ISHERWOOD_EDDIE_misc",
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "speech", bonus = { rng = { 2, 4 } } },
        { skill = "melee", bonus = { rng = { 3, 6 } } },
        { skill = "survival", bonus = { rng = { 3, 6 } } },
        { skill = "gun", bonus = { rng = { 3, 6 } } },
        { skill = "rifle", bonus = { rng = { 4, 8 } } },
        { skill = "archery", bonus = { rng = { 4, 8 } } },
    },
}

-- Dairy farmer's son in the Isherwood family.  Duplicate for the rescue mission.
ccb.content.define_npc {
    id = "isherwood_luke_copy",
    unique_name = ccb.content.text("Luke Isherwood"),
    gender = "male",
    class = "NC_ISHERWOOD_LUKE",
    attitude = 0,
    mission = "GUARD",
    age = 16,
    height = 181,
    strength = 8,
    dexterity = 9,
    intelligence = 7,
    perception = 8,
    personality = { aggression = 2, bravery = 8, collector = 1, altruism = 2 },
    chat = "TALK_ISHERWOOD_FAMILY_DUPLICATES",
    faction = "isherwood_family",
}

-- Dairy farmer's son in the Isherwood family.  Duplicate for the rescue mission.
ccb.content.define_npc {
    id = "isherwood_luke_swat_copy",
    unique_name = ccb.content.text("Luke Isherwood"),
    gender = "male",
    class = "NC_ISHERWOOD_LUKE_SWAT",
    attitude = 0,
    mission = "GUARD",
    age = 16,
    height = 181,
    strength = 8,
    dexterity = 9,
    intelligence = 7,
    perception = 8,
    personality = { aggression = 2, bravery = 8, collector = 1, altruism = 2 },
    chat = "TALK_ISHERWOOD_FAMILY_DUPLICATES",
    faction = "isherwood_family",
}

ccb.content.define_npc_class {
    id = "NC_ISHERWOOD_LUKE_SWAT",
    name = ccb.content.text("Luke Isherwood"),
    job_description = ccb.content.text("I'm Eddie's son, part of the Isherwood family"),
    traits = {
        { trait = "FLEET" },
        { trait = "TOUGH" },
        { trait = "SKIN_TAN" },
        { trait = "eye_color", variant = "hazel" },
        { trait = "hair_short", variant = "black" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    common = false,
    perception = { one_in = 4 },
    worn = "NC_Isherwood_swat_worn",
    weapon = "NC_ISHERWOOD_rifle",
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "melee", bonus = { rng = { 3, 6 } } },
        { skill = "survival", bonus = { rng = { 3, 6 } } },
        { skill = "gun", bonus = { rng = { 3, 6 } } },
        { skill = "rifle", bonus = { rng = { 4, 8 } } },
        { skill = "fabrication", bonus = { rng = { 2, 7 } } },
        { skill = "archery", bonus = { rng = { 4, 8 } } },
    },
}

-- Horse trainer for the Isherwood family.  False copy for the Barry resue mission
ccb.content.define_npc {
    id = "isherwood_jesse_copy",
    unique_name = ccb.content.text("Jesse Isherwood"),
    gender = "female",
    class = "NC_ISHERWOOD_JESSE",
    attitude = 0,
    mission = "GUARD",
    age = 43,
    height = 168,
    strength = 7,
    dexterity = 9,
    intelligence = 8,
    perception = 9,
    personality = { aggression = 2, bravery = 4, collector = 1, altruism = 3 },
    chat = "TALK_ISHERWOOD_FAMILY_DUPLICATES",
    faction = "isherwood_family",
}

-- Horse trainer for the Isherwood family.  False copy for the Barry resue mission
ccb.content.define_npc {
    id = "isherwood_jesse_swat_copy",
    unique_name = ccb.content.text("Jesse Isherwood"),
    gender = "female",
    class = "NC_ISHERWOOD_JESSE_SWAT",
    attitude = 0,
    mission = "GUARD",
    age = 43,
    height = 168,
    strength = 7,
    dexterity = 9,
    intelligence = 8,
    perception = 9,
    personality = { aggression = 2, bravery = 4, collector = 1, altruism = 3 },
    chat = "TALK_ISHERWOOD_FAMILY_DUPLICATES",
    faction = "isherwood_family",
}

ccb.content.define_npc_class {
    id = "NC_ISHERWOOD_JESSE_SWAT",
    name = ccb.content.text("Jesse Isherwood"),
    job_description = ccb.content.text("I'm a horse trainer, part of the Isherwood family"),
    traits = {
        { trait = "WEAKSTOMACH" },
        { trait = "ANTIJUNK" },
        { trait = "ANIMALEMPATH" },
        { trait = "SKIN_PINK" },
        { trait = "eye_color", variant = "blue" },
        { trait = "hair_ponytail", variant = "brown" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    common = false,
    worn = "NC_Isherwood_swat_worn",
    weapon = "NC_ISHERWOOD_rifle",
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "speech", bonus = { rng = { 6, 9 } } },
        { skill = "melee", bonus = { rng = { 3, 6 } } },
        { skill = "survival", bonus = { rng = { 3, 6 } } },
        { skill = "gun", bonus = { rng = { 3, 6 } } },
        { skill = "rifle", bonus = { rng = { 4, 6 } } },
        { skill = "archery", bonus = { rng = { 4, 6 } } },
    },
}

-- Part of the Isherwood family.  False copy for the Barry resue mission.
ccb.content.define_npc {
    id = "isherwood_lisa_copy",
    unique_name = ccb.content.text("Lisa Isherwood"),
    gender = "female",
    class = "NC_ISHERWOOD_LISA",
    attitude = 0,
    mission = "GUARD",
    age = 20,
    height = 170,
    strength = 8,
    dexterity = 9,
    intelligence = 10,
    perception = 9,
    personality = { aggression = 1, bravery = 5, collector = 1, altruism = 3 },
    chat = "TALK_ISHERWOOD_FAMILY_DUPLICATES_CHRIS",
    faction = "isherwood_family",
}

-- Part of the Isherwood family.  False copy for the Barry resue mission.
ccb.content.define_npc {
    id = "isherwood_lisa_swat_copy",
    unique_name = ccb.content.text("Lisa Isherwood"),
    gender = "female",
    class = "NC_ISHERWOOD_LISA_SWAT",
    attitude = 0,
    mission = "GUARD",
    age = 20,
    height = 170,
    strength = 8,
    dexterity = 9,
    intelligence = 10,
    perception = 9,
    personality = { aggression = 1, bravery = 5, collector = 1, altruism = 3 },
    chat = "TALK_ISHERWOOD_FAMILY_DUPLICATES_CHRIS",
    faction = "isherwood_family",
}

ccb.content.define_npc_class {
    id = "NC_ISHERWOOD_LISA_SWAT",
    name = ccb.content.text("Lisa Isherwood"),
    job_description = ccb.content.text("Part of the Isherwood family"),
    traits = {
        { trait = "ANIMALEMPATH" },
        { trait = "ANTIJUNK" },
        { trait = "PRETTY" },
        { trait = "SKIN_LIGHT" },
        { trait = "eye_color", variant = "blue" },
        { trait = "hair_short_over_eye", variant = "brown" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    common = false,
    worn = "NC_Isherwood_swat_worn",
    weapon = "NC_ISHERWOOD_rifle",
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "melee", bonus = { rng = { 3, 6 } } },
        { skill = "survival", bonus = { rng = { 3, 6 } } },
        { skill = "gun", bonus = { rng = { 3, 5 } } },
        { skill = "rifle", bonus = { rng = { 2, 5 } } },
        { skill = "archery", bonus = { rng = { 2, 5 } } },
    },
}

-- Part of the Isherwood family.  False copy for the Barry resue mission.
ccb.content.define_npc {
    id = "isherwood_chris_copy",
    unique_name = ccb.content.text("Chris Isherwood"),
    gender = "male",
    class = "NC_ISHERWOOD_CHRIS",
    attitude = 0,
    mission = "GUARD",
    age = 21,
    height = 177,
    strength = 8,
    dexterity = 9,
    intelligence = 8,
    perception = 9,
    personality = { aggression = 2, bravery = 5, collector = -3, altruism = 1 },
    chat = "TALK_ISHERWOOD_FAMILY_DUPLICATES_CHRIS",
    faction = "isherwood_family",
}

-- Part of the Isherwood family.  False copy for the Barry resue mission.
ccb.content.define_npc {
    id = "isherwood_chris_swat_copy",
    unique_name = ccb.content.text("Chris Isherwood"),
    gender = "male",
    class = "NC_ISHERWOOD_CHRIS_SWAT",
    attitude = 0,
    mission = "GUARD",
    age = 21,
    height = 177,
    strength = 8,
    dexterity = 9,
    intelligence = 8,
    perception = 9,
    personality = { aggression = 2, bravery = 5, collector = -3, altruism = 1 },
    chat = "TALK_ISHERWOOD_FAMILY_DUPLICATES_CHRIS",
    faction = "isherwood_family",
}

ccb.content.define_npc_class {
    id = "NC_ISHERWOOD_CHRIS_SWAT",
    name = ccb.content.text("Chris Isherwood"),
    job_description = ccb.content.text("I'm Jesse and Carlos' son, part of the Isherwood family"),
    traits = {
        { trait = "FLEET" },
        { trait = "LIGHTSTEP" },
        { trait = "WEAKSTOMACH" },
        { trait = "ANTIJUNK" },
        { trait = "PRETTY" },
        { trait = "SKIN_LIGHT" },
        { trait = "eye_color", variant = "blue" },
        { trait = "hair_medium", variant = "black" },
        { trait = "NO_BASH" },
    },
    common = false,
    perception = { one_in = 4 },
    worn = "NC_Isherwood_swat_worn",
    weapon = "NC_ISHERWOOD_rifle",
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "speech", bonus = { rng = { 2, 4 } } },
        { skill = "melee", bonus = { rng = { 3, 6 } } },
        { skill = "survival", bonus = { rng = { 7, 10 } } },
        { skill = "gun", bonus = { rng = { 4, 8 } } },
        { skill = "rifle", bonus = { rng = { 7, 10 } } },
        { skill = "archery", bonus = { rng = { 8, 10 } } },
    },
}
