local ccb = require("ccb")

ccb.content.define_npc {
    id = "prepnet_gardener",
    suffix = ccb.content.text("Gardener"),
    class = "afs_prepnet_gardener",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_PrepNet_gardener_1",
    missions_offered = "MISSION_PrepNet_gardener_FUR_1",
    faction = "Prepnet_Phyle",
}

ccb.content.define_npc_class {
    id = "afs_prepnet_gardener",
    name = ccb.content.text("Gardener"),
    job_description = ccb.content.text("When the end came, we were ready.  Now I grow food for my phyle."),
    traits = { { group = "NPC_starting_traits" }, { group = "Appearance_demographics" } },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 4, 2 } }, { rng = { -4, -1 } } } } } },
        },
        { skill = "survival", bonus = { rng = { 2, 4 } } },
        { skill = "fabrication", bonus = { rng = { 1, 3 } } },
        { skill = "melee", bonus = { rng = { 3, 6 } } },
        { skill = "gun", bonus = { rng = { 3, 6 } } },
    },
    common = false,
    worn = "afs_gardener_worn",
    carry = "afs_gardener_carried",
    weapon = "afs_gardener_wield",
    shop_groups = "afs_gardener_misc",
    bionics = {
        { id = "bio_carbon", chance = 100 },
        { id = "bio_claws", chance = 100 },
        { id = "bio_dex_enhancer", chance = 100 },
        { id = "bio_laser", chance = 100 },
        { id = "bio_membrane", chance = 100 },
        { id = "bio_power_storage_mkII", chance = 100 },
        { id = "bio_purifier", chance = 100 },
        { id = "bio_radscrubber", chance = 100 },
        { id = "bio_sunglasses", chance = 100 },
        { id = "bio_tools", chance = 100 },
        { id = "bio_torsionratchet", chance = 100 },
    },
}

ccb.content.define_npc {
    id = "millyficent_whately",
    unique_name = ccb.content.text("Millyficent Whately"),
    suffix = ccb.content.text("Xenobiologist, madwoman"),
    class = "afs_xenobiologist_madwoman",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_Millyficent_1",
    missions_offered = "MISSION_migo_biology_1",
    faction = "whately_family",
    gender = "female",
}

ccb.content.define_npc_class {
    id = "afs_xenobiologist_madwoman",
    name = ccb.content.text("mi-go enthusiast"),
    job_description = ccb.content.text("I've been studying the mi-go for years…"),
    common = false,
    traits = {
        { trait = "hair_long", variant = "red" },
        { trait = "natural_hair_color_red" },
        { trait = "SKIN_LIGHT" },
        { trait = "WARM_NATURED" },
        { trait = "INT_UP_3" },
        { trait = "DEX_UP_2" },
        { trait = "STR_UP" },
    },
    dexterity = { rng = { -1, 0 } },
    intelligence = { rng = { 2, 5 } },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -4 } } } } },
        },
        { skill = "computer", bonus = { rng = { 1, 5 } } },
        { skill = "electronics", bonus = { rng = { 1, 5 } } },
        { skill = "firstaid", bonus = { rng = { 1, 4 } } },
        { skill = "cooking", bonus = { rng = { 6, 8 } } },
    },
}

ccb.content.define_npc_class {
    id = "whately_cousin",
    name = ccb.content.text("Whately Cousin"),
    common = false,
    job_description = ccb.content.text("Our family has been through hard times before.  We know how to survive."),
    skills = {
        { skill = "dodge", bonus = { rng = { 3, 6 } } },
        { skill = "melee", bonus = { rng = { 3, 6 } } },
        { skill = "unarmed", bonus = { rng = { 3, 6 } } },
    },
    strength = 2,
    dexterity = 2,
    traits = {
        { group = "trait_mutant_npc_common" },
        { group = "trait_group_migo" },
        {
            distribution = {
                { group = "trait_group_migo_nonthres" },
                { group = "trait_group_migo_postthres" },
            },
        },
        { "BGSS_Whately", 100 },
    },
}

ccb.content.define_npc {
    id = "cyrus_whately",
    unique_name = ccb.content.text("Cyrus Whately"),
    suffix = ccb.content.text("Patriarch, doomseer"),
    class = "afs_whately_patriarch",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_CYRUS_1",
    missions_offered = "MISSION_FRANKENSTEIN_1",
    faction = "whately_family",
    gender = "male",
}

ccb.content.define_npc_class {
    id = "afs_whately_patriarch",
    name = ccb.content.text("Aspiring Frankenstein"),
    job_description = ccb.content.text("Friend to outsiders…"),
    common = false,
    traits = {
        { "SKIN_LIGHT", 100 },
        { "MIGO_HEAT_RESIST", 100 },
        { "ALIEN_INT", 100 },
        { "THRESH_YUGGOTH", 100 },
        { "OTHERWORLDLY_GRACE", 100 },
        { "MIGO_BREATHE", 100 },
    },
    dexterity = { rng = { -1, 0 } },
    intelligence = { rng = { 2, 5 } },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -4 } } } } },
        },
        { skill = "computer", bonus = { rng = { 1, 5 } } },
        { skill = "electronics", bonus = { rng = { 1, 5 } } },
        { skill = "firstaid", bonus = { rng = { 1, 4 } } },
        { skill = "chemistry", bonus = { rng = { 6, 8 } } },
    },
}

ccb.content.define_npc {
    id = "wilhemina_whately",
    unique_name = ccb.content.text("Wilhemina Whately"),
    suffix = ccb.content.text("Shopkeeper"),
    class = "whately_cousin",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_WHATELY_1",
    faction = "whately_family",
    gender = "female",
}

ccb.content.define_npc {
    id = "nicodemus_whately",
    unique_name = ccb.content.text("Nicodemus Whately"),
    suffix = ccb.content.text("Whately, Hatchetman"),
    class = "whately_cousin",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_WHATELY_1",
    faction = "whately_family",
    gender = "male",
}

ccb.content.define_npc {
    id = "cryo_hacker",
    suffix = ccb.content.text("thawed hacker"),
    class = "CRYO_HACKER",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_THAWED_1",
    faction = "no_faction",
}

ccb.content.define_npc {
    id = "cryo_doctor",
    suffix = ccb.content.text("thawed doctor"),
    class = "CRYO_DOCTOR",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_THAWED_1",
    faction = "no_faction",
}

ccb.content.define_npc {
    id = "cryo_scientist",
    suffix = ccb.content.text("thawed scientist"),
    class = "CRYO_SCIENTIST",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_THAWED_1",
    faction = "no_faction",
}

ccb.content.define_npc {
    id = "sadie",
    unique_name = ccb.content.text("Sadie"),
    suffix = ccb.content.text("forgotten experiment"),
    class = "afs_forgotten_experiment",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_Sadie_1",
    missions_offered = "MISSION_sadie_heart",
    faction = "no_faction",
    gender = "female",
}

ccb.content.define_npc_class {
    id = "afs_forgotten_experiment",
    name = ccb.content.text("forgotten experiment"),
    job_description = ccb.content.text("What a magical world to explore…"),
    common = false,
    strength = { rng = { 3, 7 } },
    dexterity = { rng = { 3, 5 } },
    intelligence = { rng = { 3, 5 } },
    perception = { rng = { 3, 5 } },
    worn = "NC_CYBORG_worn",
    carry = "NC_DOCTOR_misc",
    weapon = "EMPTY_GROUP",
    traits = {
        { "PRETTY", 100 },
        { "OPTIMISTIC", 100 },
        { "FORGETFUL", 100 },
        { "STR_UP_3", 100 },
        { "THRESH_MEDICAL", 100 },
        { "CENOBITE", 100 },
        { group = "trait_group_medical" },
        {
            distribution = {
                { group = "trait_group_medical_nonthres" },
                { group = "trait_group_medical_postthres" },
            },
        },
        { "BGSS_Sadie", 100 },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -4 } } } } },
        },
        { skill = "firstaid", bonus = { rng = { 6, 8 } } },
    },
    bionics = {
        { id = "bio_ankles", chance = 5 },
        { id = "bio_batteries", chance = 20 },
        { id = "bio_carbon", chance = 30 },
        { id = "bio_claws", chance = 10 },
        { id = "bio_noise", chance = 10 },
        { id = "bio_power_weakness", chance = 5 },
        { id = "bio_itchy", chance = 15 },
        { id = "bio_laser", chance = 10 },
        { id = "bio_thumbs", chance = 10 },
        { id = "bio_spasm", chance = 10 },
        { id = "bio_shakes", chance = 10 },
        { id = "bio_dex_enhancer", chance = 20 },
        { id = "bio_sleepy", chance = 5 },
        { id = "bio_heat_absorb", chance = 20 },
        { id = "bio_eye_enhancer", chance = 20 },
        { id = "bio_recycler", chance = 100 },
        { id = "bio_digestion", chance = 100 },
        { id = "bio_pokedeye", chance = 10 },
        { id = "bio_hydraulics", chance = 10 },
        { id = "bio_painkiller", chance = 15 },
        { id = "bio_shock", chance = 10 },
        { id = "bio_speed", chance = 10 },
        { id = "bio_str_enhancer", chance = 100 },
        { id = "bio_armor_head", chance = 3 },
        { id = "bio_armor_torso", chance = 15 },
        { id = "bio_armor_arms", chance = 30 },
        { id = "bio_armor_legs", chance = 25 },
        { id = "bio_razors", chance = 15 },
        { id = "bio_nanobots", chance = 20 },
        { id = "bio_sunglasses", chance = 50 },
        { id = "bio_weight", chance = 50 },
        { id = "bio_power_storage", chance = 100 },
        { id = "bio_power_storage_mkII", chance = 70 },
        { id = "bio_microgen", chance = 100 },
        { id = "bio_microgen", chance = 75 },
        { id = "bio_microgen", chance = 50 },
        { id = "bio_microgen", chance = 25 },
        { id = "bio_microgen", chance = 10 },
        { id = "bio_torsionratchet", chance = 20 },
    },
}
