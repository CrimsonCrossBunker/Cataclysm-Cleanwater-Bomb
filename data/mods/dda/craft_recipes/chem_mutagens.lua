local ccb = require("ccb")
local content = ccb.content
local services = ccb.services

local LIGHT_EXERCISE = 2

-- 撤销 PR #86581 — 恢复僵尸尸体的实用性
content.add(content.Recipe {
    id = "mutagen",
    result = "mutagen",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 6,
    flags = { "SECRET" },
}
    :component_any({
            { id = "tallow_tainted", count = 2 },
            { id = "meat_tainted", count = 3 },
            { id = "meat_tainted_human", count = 3 },
            { id = "dry_meat_tainted", count = 3 },
            { id = "tainted_innards", count = 4 },
            { id = "tainted_innards_human", count = 4 },
            { id = "fetus", count = 1 },
            { id = "arm", count = 2 },
            { id = "leg", count = 2 }
        })
    :component_any({
            { id = "bleach", count = 250 },
            { id = "oxy_powder", count = 200 }
        })
    :component_any({
            { id = "ammonia_liquid", count = 1 },
            { id = "lye_powder", count = 100 }
        })
    :requirement("mutagen_production_standard", 25)
    :requires_skill("firstaid", 1)
    :book("recipe_creepy", 6)
    :book("recipe_animal", 6)
    :book("recipe_maiar", 5)
    :book("recipe_serum", 5)
    :book("recipe_labchem", 5)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_biochemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(80, 20)
    :result_charges(1)
)

-- jabberwocks have a few of these pumping in them, and they can be crushed down for a lot of mutagen
content.add(content.Recipe {
    id = "mutagen_jabberblood",
    result = "mutagen_jabberblood",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_MUTAGEN",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
}
    :component("jabberwock_heart", 1)
    :quality("CUT", 2, 1)
    :result_charges(1)
    :byproduct("jabberwock_heart_desiccated", 1)
)

content.add(content.Recipe {
    id = "iv_mutagen",
    result = "iv_mutagen",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("mutagen", 2)
    :requirement("serum_production_standard", 37)
    :requires_skill("firstaid", 3)
    :book("recipe_serum", 6)
    :book("recipe_labchem", 7)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(20, 5)
)

content.add(content.Recipe {
    id = "mutagen_plant",
    result = "mutagen_plant",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("mutagen", 1)
    :component("plant_sample", 1)
    :component_any({
            { id = "veggy", count = 3 },
            { id = "biollante_bud", count = 1 },
            { id = "datura_seed", count = 16 }
        })
    :component_any({
            { id = "fungicide", count = 200 },
            { id = "plant_sample", count = 1 }
        })
    :requirement("mutagen_production_standard", 25)
    :requires_skill("firstaid", 1)
    :book("recipe_creepy", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(80, 20)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "iv_mutagen_plant",
    result = "iv_mutagen_plant",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 8,
    flags = { "SECRET" },
}
    :component("mutagen_plant", 2)
    :component("plant_sample", 1)
    :requirement("serum_production_standard", 37)
    :requires_skill("firstaid", 3)
    :book("recipe_serum", 6)
    :book("recipe_creepy", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(20, 5)
)

content.add(content.Recipe {
    id = "mutagen_insect",
    result = "mutagen_insect",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("mutagen", 1)
    :component("insect_sample", 1)
    :component_any({
            { id = "bee_sting", count = 3 },
            { id = "wasp_sting", count = 3 }
        })
    :component_any({
            { id = "acidchitin_piece", count = 3 },
            { id = "insect_sample", count = 1 }
        })
    :requirement("mutagen_production_standard", 25)
    :requires_skill("firstaid", 1)
    :book("recipe_maiar", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_biochemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(80, 20)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "iv_mutagen_insect",
    result = "iv_mutagen_insect",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 8,
    flags = { "SECRET" },
}
    :component("mutagen_insect", 2)
    :component("insect_sample", 1)
    :requirement("serum_production_standard", 37)
    :requires_skill("firstaid", 3)
    :book("recipe_serum", 6)
    :book("recipe_maiar", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(20, 5)
)

content.add(content.Recipe {
    id = "mutagen_spider",
    result = "mutagen_spider",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("mutagen", 1)
    :component_any({
            { id = "eggs_spider", count = 1, requirement = true },
            { id = "chitin_piece", count = 4 }
        })
    :component("spider_sample", 1)
    :component_any({
            { id = "ammonia_liquid", count = 1 },
            { id = "lye_powder", count = 100 }
        })
    :requirement("mutagen_production_standard", 25)
    :requires_skill("firstaid", 1)
    :book("recipe_maiar", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_biochemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(80, 20)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "iv_mutagen_spider",
    result = "iv_mutagen_spider",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 8,
    flags = { "SECRET" },
}
    :component("mutagen_spider", 2)
    :component("spider_sample", 1)
    :requirement("serum_production_standard", 37)
    :requires_skill("firstaid", 3)
    :book("recipe_serum", 6)
    :book("recipe_maiar", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(20, 5)
)

content.add(content.Recipe {
    id = "mutagen_snail",
    result = "mutagen_snail",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("mutagen", 1)
    :component("gastropod_sample", 1)
    :component_any({
            { id = "salt", count = 600 },
            { id = "lead", count = 4 }
        })
    :component_any({
            { id = "stomach", count = 6 },
            { id = "stomach_large", count = 2 },
            { id = "gastropod_sample", count = 1 }
        })
    :requirement("mutagen_production_standard", 25)
    :requires_skill("firstaid", 1)
    :book("recipe_creepy", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_biochemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(80, 20)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "iv_mutagen_snail",
    result = "iv_mutagen_snail",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("mutagen_snail", 2)
    :component("gastropod_sample", 1)
    :requirement("serum_production_standard", 37)
    :requires_skill("firstaid", 3)
    :book("recipe_serum", 6)
    :book("recipe_creepy", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(20, 5)
)

content.add(content.Recipe {
    id = "mutagen_slime",
    result = "mutagen_slime",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("mutagen", 1)
    :component("slime_sample", 1)
    :component_any({
            { id = "mutagen", count = 2 },
            { id = "slime_sample", count = 2 }
        })
    :requirement("mutagen_production_standard", 40)
    :requires_skill("firstaid", 1)
    :book("recipe_maiar", 6)
    :book("recipe_creepy", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(80, 20)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "iv_mutagen_slime",
    result = "iv_mutagen_slime",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("mutagen_slime", 2)
    :component("slime_sample", 1)
    :requirement("serum_production_standard", 37)
    :requires_skill("firstaid", 3)
    :book("recipe_serum", 6)
    :book("recipe_maiar", 6)
    :book("recipe_creepy", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(20, 5)
)

content.add(content.Recipe {
    id = "mutagen_fish",
    result = "mutagen_fish",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("mutagen", 1)
    :component("fish_sample", 1)
    :component("water", 160)
    :component_any({
            { id = "fish", count = 3 },
            { id = "can_sardine", count = 2 },
            { id = "can_tuna", count = 2 },
            { id = "can_salmon", count = 2 },
            { id = "can_herring", count = 2 },
            { id = "fish_pickled", count = 2 },
            { id = "fish_sample", count = 1 }
        })
    :requirement("mutagen_production_standard", 25)
    :requires_skill("firstaid", 1)
    :book("recipe_animal", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_biochemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(80, 20)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "iv_mutagen_fish",
    result = "iv_mutagen_fish",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("mutagen_fish", 2)
    :component("fish_sample", 1)
    :requirement("serum_production_standard", 37)
    :requires_skill("firstaid", 3)
    :book("recipe_serum", 6)
    :book("recipe_animal", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(20, 5)
)

content.add(content.Recipe {
    id = "mutagen_rat",
    result = "mutagen_rat",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("mutagen", 1)
    :component("rat_sample", 1)
    :component_any({
            { id = "meat_tainted", count = 6 },
            { id = "dry_meat_tainted", count = 6 }
        })
    :component_any({
            { id = "quikclot", count = 2 },
            { id = "rat_sample", count = 1 }
        })
    :requirement("mutagen_production_standard", 25)
    :requires_skill("firstaid", 1)
    :book("recipe_creepy", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(80, 20)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "iv_mutagen_rat",
    result = "iv_mutagen_rat",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("mutagen_rat", 2)
    :component("rat_sample", 1)
    :requirement("serum_production_standard", 37)
    :requires_skill("firstaid", 3)
    :book("recipe_serum", 6)
    :book("recipe_creepy", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(20, 5)
)

content.add(content.Recipe {
    id = "mutagen_chiropteran",
    result = "mutagen_chiropteran",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("mutagen", 1)
    :component("chiropteran_sample", 1)
    :component_any({
            { id = "animal_blood", count = 6 },
            { id = "mutant_blood", count = 6 }
        })
    :component_any({
            { id = "meal_bone_tainted", count = 1 },
            { id = "chiropteran_sample", count = 1 }
        })
    :requirement("mutagen_production_standard", 25)
    :requires_skill("firstaid", 1)
    :book("recipe_creepy", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(80, 20)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "iv_mutagen_chiropteran",
    result = "iv_mutagen_chiropteran",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("mutagen_chiropteran", 2)
    :component("chiropteran_sample", 1)
    :requirement("serum_production_standard", 37)
    :requires_skill("firstaid", 3)
    :book("recipe_serum", 6)
    :book("recipe_creepy", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(20, 5)
)

content.add(content.Recipe {
    id = "mutagen_beast",
    result = "mutagen_beast",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("mutagen", 1)
    :component("beast_sample", 1)
    :component_any({
            { id = "meat", count = 3 },
            { id = "meat_scrap", count = 30 }
        })
    :component_any({
            { id = "animal_blood", count = 4 },
            { id = "beast_sample", count = 1 }
        })
    :requirement("mutagen_production_standard", 25)
    :requires_skill("firstaid", 1)
    :book("recipe_animal", 5)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(80, 20)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "iv_mutagen_beast",
    result = "iv_mutagen_beast",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("mutagen_beast", 2)
    :component("beast_sample", 1)
    :requirement("serum_production_standard", 37)
    :requires_skill("firstaid", 3)
    :book("recipe_serum", 6)
    :book("recipe_animal", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_biochemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(20, 5)
)

content.add(content.Recipe {
    id = "mutagen_ursine",
    result = "mutagen_ursine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("mutagen", 1)
    :component("ursine_sample", 1)
    :component("honey_bottled", 1)
    :component_any({
            { id = "honeycomb", count = 2 },
            { id = "ursine_sample", count = 1 }
        })
    :requirement("mutagen_production_standard", 25)
    :requires_skill("firstaid", 1)
    :book("recipe_animal", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(80, 20)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "iv_mutagen_ursine",
    result = "iv_mutagen_ursine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("mutagen_ursine", 2)
    :component("ursine_sample", 1)
    :requirement("serum_production_standard", 37)
    :requires_skill("firstaid", 3)
    :book("recipe_serum", 6)
    :book("recipe_animal", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(20, 5)
)

content.add(content.Recipe {
    id = "mutagen_mouse",
    result = "mutagen_mouse",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("mutagen", 1)
    :component("mouse_sample", 1)
    :component_any({
            { id = "meat", count = 2 },
            { id = "meat_scrap", count = 20 }
        })
    :component_any({
            { id = "quikclot", count = 2 },
            { id = "mouse_sample", count = 1 }
        })
    :requirement("mutagen_production_standard", 25)
    :requires_skill("firstaid", 1)
    :book("recipe_animal", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(80, 20)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "iv_mutagen_mouse",
    result = "iv_mutagen_mouse",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("mutagen_mouse", 2)
    :component("mouse_sample", 1)
    :requirement("serum_production_standard", 37)
    :requires_skill("firstaid", 3)
    :book("recipe_serum", 6)
    :book("recipe_animal", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(20, 5)
)

content.add(content.Recipe {
    id = "mutagen_feline",
    result = "mutagen_feline",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("mutagen", 1)
    :component("feline_sample", 1)
    :component_any({
            { id = "ammonia_liquid", count = 2 },
            { id = "lye_powder", count = 200 }
        })
    :component_any({
            { id = "iodine", count = 1 },
            { id = "feline_sample", count = 1 }
        })
    :requirement("mutagen_production_standard", 25)
    :requires_skill("firstaid", 1)
    :book("recipe_animal", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(80, 20)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "iv_mutagen_feline",
    result = "iv_mutagen_feline",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("mutagen_feline", 2)
    :component("feline_sample", 1)
    :requirement("serum_production_standard", 37)
    :requires_skill("firstaid", 3)
    :book("recipe_serum", 6)
    :book("recipe_animal", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(20, 5)
)

content.add(content.Recipe {
    id = "mutagen_lupine",
    result = "mutagen_lupine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("mutagen", 1)
    :component("lupine_sample", 1)
    :component_any({
            { id = "meat", count = 5 },
            { id = "meat_scrap", count = 50 }
        })
    :component_any({
            { id = "bone", count = 5 },
            { id = "lupine_sample", count = 1 }
        })
    :requirement("mutagen_production_standard", 25)
    :requires_skill("firstaid", 1)
    :book("recipe_animal", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(80, 20)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "iv_mutagen_lupine",
    result = "iv_mutagen_lupine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("mutagen_lupine", 2)
    :component("lupine_sample", 1)
    :requirement("serum_production_standard", 37)
    :requires_skill("firstaid", 3)
    :book("recipe_serum", 6)
    :book("recipe_animal", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(20, 5)
)

content.add(content.Recipe {
    id = "mutagen_cattle",
    result = "mutagen_cattle",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("mutagen", 1)
    :component("cattle_sample", 1)
    :component_any({
            { id = "milk_powder", count = 2 },
            { id = "cattle_sample", count = 1 }
        })
    :component_any({
            { id = "milk_raw", count = 6 },
            { id = "cattle_sample", count = 1 }
        })
    :requirement("mutagen_production_standard", 25)
    :requires_skill("firstaid", 1)
    :book("recipe_animal", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(80, 20)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "iv_mutagen_cattle",
    result = "iv_mutagen_cattle",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("mutagen_cattle", 2)
    :component("cattle_sample", 1)
    :requirement("serum_production_standard", 37)
    :requires_skill("firstaid", 3)
    :book("recipe_serum", 6)
    :book("recipe_animal", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(20, 5)
)

content.add(content.Recipe {
    id = "mutagen_cephalopod",
    result = "mutagen_cephalopod",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("mutagen", 1)
    :component("cephalopod_sample", 1)
    :component_any({
            { id = "meat_tainted", count = 6 },
            { id = "dry_meat_tainted", count = 6 },
            { id = "can_chowder", count = 1 },
            { id = "can_clams", count = 1 }
        })
    :component_any({
            { id = "permanent_ink", count = 800 },
            { id = "cephalopod_sample", count = 1 }
        })
    :requirement("mutagen_production_standard", 25)
    :requires_skill("firstaid", 1)
    :book("recipe_creepy", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(80, 20)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "iv_mutagen_cephalopod",
    result = "iv_mutagen_cephalopod",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("mutagen_cephalopod", 2)
    :component("cephalopod_sample", 1)
    :requirement("serum_production_standard", 37)
    :requires_skill("firstaid", 3)
    :book("recipe_serum", 6)
    :book("recipe_creepy", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(20, 5)
)

content.add(content.Recipe {
    id = "mutagen_bird",
    result = "mutagen_bird",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("mutagen", 1)
    :component("bird_sample", 1)
    :component_any({
            { id = "eggs_bird", count = 2, requirement = true },
            { id = "bird_sample", count = 1 }
        })
    :component("feather", 2)
    :requirement("mutagen_production_standard", 25)
    :requires_skill("firstaid", 1)
    :book("recipe_animal", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(80, 20)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "iv_mutagen_bird",
    result = "iv_mutagen_bird",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("mutagen_bird", 2)
    :component("bird_sample", 1)
    :requirement("serum_production_standard", 37)
    :requires_skill("firstaid", 3)
    :book("recipe_serum", 6)
    :book("recipe_animal", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(20, 5)
)

content.add(content.Recipe {
    id = "mutagen_lizard",
    result = "mutagen_lizard",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("mutagen", 1)
    :component("lizard_sample", 1)
    :component("eggs_reptile", 1, true)
    :component_any({
            { id = "bfipowder", count = 4 },
            { id = "lizard_sample", count = 1 }
        })
    :requirement("mutagen_production_standard", 25)
    :requires_skill("firstaid", 1)
    :book("recipe_animal", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(80, 20)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "iv_mutagen_lizard",
    result = "iv_mutagen_lizard",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("mutagen_lizard", 2)
    :component("lizard_sample", 1)
    :requirement("serum_production_standard", 37)
    :requires_skill("firstaid", 3)
    :book("recipe_serum", 6)
    :book("recipe_animal", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(20, 5)
)

content.add(content.Recipe {
    id = "mutagen_batrachian",
    result = "mutagen_batrachian",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("mutagen", 1)
    :component("batrachian_sample", 1)
    :component_any({
            { id = "chem_rocket_fuel", count = 1 },
            { id = "tool_rocket_candy", count = 2 }
        })
    :component_any({
            { id = "eggs_frog", count = 1, requirement = true },
            { id = "batrachian_sample", count = 1 }
        })
    :requirement("mutagen_production_standard", 25)
    :requires_skill("firstaid", 1)
    :book("recipe_animal", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(80, 20)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "iv_mutagen_batrachian",
    result = "iv_mutagen_batrachian",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("mutagen_batrachian", 2)
    :component("batrachian_sample", 1)
    :requirement("serum_production_standard", 37)
    :requires_skill("firstaid", 3)
    :book("recipe_serum", 6)
    :book("recipe_animal", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(20, 5)
)

content.add(content.Recipe {
    id = "mutagen_troglobite",
    result = "mutagen_troglobite",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("mutagen", 1)
    :component("troglobite_sample", 1)
    :component("mutant_bug_organs", 3)
    :component("human_sample", 1)
    :component_any({
            { id = "chem_saltpetre", count = 1 },
            { id = "troglobite_sample", count = 1 }
        })
    :requirement("mutagen_production_standard", 25)
    :requires_skill("firstaid", 1)
    :book("recipe_maiar", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_biochemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(80, 20)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "iv_mutagen_troglobite",
    result = "iv_mutagen_troglobite",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("mutagen_troglobite", 2)
    :component("troglobite_sample", 1)
    :requirement("serum_production_standard", 37)
    :requires_skill("firstaid", 3)
    :book("recipe_serum", 6)
    :book("recipe_maiar", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(20, 5)
)

content.add(content.Recipe {
    id = "mutagen_medical",
    result = "mutagen_medical",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("mutagen", 2)
    :component("medical_sample", 1)
    :requirement("mutagen_production_standard", 25)
    :requires_skill("firstaid", 1)
    :book("recipe_medicalmut", 7)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(80, 20)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "iv_mutagen_medical",
    result = "iv_mutagen_medical",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 8,
    flags = { "SECRET" },
}
    :component("mutagen_medical", 2)
    :component("medical_sample", 1)
    :requirement("serum_production_standard", 37)
    :requires_skill("firstaid", 3)
    :book("recipe_medicalmut", 7)
    :book("recipe_serum", 7)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(20, 5)
)

-- requires more human samples than comparable mutagen as you are trying to identify specific differences
-- from your mutated anatomy than from baseline humans.
content.add(content.Recipe {
    id = "purifier",
    result = "purifier",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("mutagen", 2)
    :component_any({
            { id = "bleach", count = 375 },
            { id = "oxy_powder", count = 300 }
        })
    :component("human_sample", 2)
    :component_any({
            { id = "ammonia_liquid", count = 2 },
            { id = "lye_powder", count = 200 }
        })
    :requirement("mutagen_production_standard", 25)
    :requires_skill("firstaid", 1)
    :book("record_patient", 7)
    :book("recipe_maiar", 6)
    :book("recipe_labchem", 5)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_biochemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(80, 20)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "iv_purifier",
    result = "iv_purifier",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 8,
    flags = { "SECRET" },
}
    :component("purifier", 2)
    :component("human_sample", 2)
    :requirement("serum_production_standard", 37)
    :requires_skill("firstaid", 3)
    :book("recipe_serum", 7)
    :book("recipe_labchem", 7)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_biochemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(20, 5)
)

content.add(content.Recipe {
    id = "mutagen_alpha_from_sample",
    result = "mutagen_alpha",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 8,
    flags = { "SECRET" },
}
    :component_any({
            { id = "purifier", count = 2 },
            { id = "iv_purifier", count = 1 }
        })
    :component("alpha_sample", 1)
    :requirement("mutagen_production_standard", 50)
    :requires_skill("firstaid", 1)
    :book("recipe_alpha", 7)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :result_charges(1)
)

content.add(content.Recipe {
    id = "iv_mutagen_alpha",
    result = "iv_mutagen_alpha",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 8,
    flags = { "SECRET" },
}
    :component("mutagen_alpha", 1)
    :component("alpha_sample", 1)
    :requirement("serum_production_standard", 37)
    :requires_skill("firstaid", 3)
    :book("recipe_alpha", 7)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(20, 5)
)

content.add(content.Recipe {
    id = "mutagen_elfa",
    result = "mutagen_elfa",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 72000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 8,
    flags = { "SECRET" },
}
    :component("mutagen_bird", 1)
    :component("elfa_sample", 1)
    :requirement("mutagen_production_standard", 31)
    :requires_skill("firstaid", 1)
    :book("recipe_elfa", 8)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :result_charges(1)
)

content.add(content.Recipe {
    id = "iv_mutagen_elfa",
    result = "iv_mutagen_elfa",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 8,
    flags = { "SECRET" },
}
    :component("mutagen_elfa", 1)
    :component("elfa_sample", 1)
    :requirement("serum_production_standard", 37)
    :requires_skill("firstaid", 3)
    :book("recipe_elfa", 8)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(20, 5)
)

content.add(content.Recipe {
    id = "mutagen_chimera",
    result = "mutagen_chimera",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 8,
    flags = { "SECRET" },
}
    :component("mutagen_beast", 1)
    :component("chimera_sample", 1)
    :requirement("mutagen_production_standard", 37)
    :requires_skill("firstaid", 1)
    :book("recipe_chimera", 7)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(20, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "iv_mutagen_chimera",
    result = "iv_mutagen_chimera",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 8,
    flags = { "SECRET" },
}
    :component("mutagen_chimera", 1)
    :component("chimera_sample", 1)
    :requirement("serum_production_standard", 37)
    :requires_skill("firstaid", 3)
    :book("recipe_chimera", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(20, 5)
)

content.add(content.Recipe {
    id = "mutagen_raptor",
    result = "mutagen_raptor",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 72000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 8,
    flags = { "SECRET" },
}
    :component("raptor_sample", 1)
    :component("purifier", 1)
    :requirement("mutagen_production_standard", 31)
    :requires_skill("firstaid", 1)
    :book("recipe_raptor", 7)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :result_charges(1)
)

content.add(content.Recipe {
    id = "iv_mutagen_raptor",
    result = "iv_mutagen_raptor",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 8,
    flags = { "SECRET" },
}
    :component("mutagen_raptor", 1)
    :component("raptor_sample", 1)
    :requirement("serum_production_standard", 37)
    :requires_skill("firstaid", 3)
    :book("recipe_raptor", 7)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(20, 5)
)

content.add(content.Recipe {
    id = "mutagen_rabbit",
    result = "mutagen_rabbit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 72000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("mutagen", 1)
    :component("rabbit_sample", 1)
    :component_any({
            { id = "animal_blood", count = 12 },
            { id = "rabbit_sample", count = 2 }
        })
    :requirement("mutagen_production_standard", 25)
    :requires_skill("firstaid", 1)
    :book("recipe_animal", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :result_charges(1)
)

content.add(content.Recipe {
    id = "iv_mutagen_rabbit",
    result = "iv_mutagen_rabbit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("mutagen_rabbit", 2)
    :component("rabbit_sample", 1)
    :requirement("serum_production_standard", 37)
    :requires_skill("firstaid", 3)
    :book("recipe_serum", 6)
    :book("recipe_animal", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(20, 5)
)

content.add(content.Recipe {
    id = "mutagen_crustacean",
    result = "mutagen_crustacean",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 9,
    flags = { "SECRET" },
}
    :tool_charges("surface_heat", 25, true)
    :component("mutagen", 1)
    :component("chitin_piece", 1)
    :component("crustacean_sample", 1)
    :component_any({
            { id = "ammonia_liquid", count = 1 },
            { id = "lye_powder", count = 100 }
        })
    :quality("CHEM", 3, 1)
    :requirement("mutagen_production_standard", 25)
    :requires_skill("firstaid", 1)
    :book("recipe_creepy", 8)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_biochemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(80, 20)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "iv_mutagen_crustacean",
    result = "iv_mutagen_crustacean",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 9,
    flags = { "SECRET" },
}
    :tool_charges("surface_heat", 37, true)
    :component("mutagen_crustacean", 2)
    :quality("CHEM", 3, 1)
    :requirement("serum_production_standard", 37)
    :requires_skill("firstaid", 3)
    :book("recipe_serum", 8)
    :book("recipe_creepy", 8)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(20, 5)
)

content.add(content.Recipe {
    id = "chimera_sample",
    result = "chimera_sample",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_MUTAGEN",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component("mutagen", 1)
    :component_any({
            { id = "feline_sample", count = 1 },
            { id = "lupine_sample", count = 1 },
            { id = "ursine_sample", count = 1 }
        })
    :component_any({
            { id = "fish_sample", count = 1 },
            { id = "lizard_sample", count = 1 },
            { id = "bird_sample", count = 1 }
        })
    :component_any({
            { id = "gastropod_sample", count = 1 },
            { id = "insect_sample", count = 1 },
            { id = "spider_sample", count = 1 }
        })
    :requirement("mutagen_production_standard", 10)
    :requires_skill("survival", 3)
    :book("recipe_animal", 5)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(20, 5)
)

content.add(content.Recipe {
    id = "beast_sample",
    result = "beast_sample",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_MUTAGEN",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component_any({
            { id = "feline_sample", count = 1 },
            { id = "lupine_sample", count = 1 },
            { id = "ursine_sample", count = 1 }
        })
    :component("feline_sample", 1)
    :component("lupine_sample", 1)
    :component("ursine_sample", 1)
    :requirement("serum_production_standard", 20)
    :requires_skill("survival", 3)
    :book("recipe_animal", 5)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(20, 5)
)

content.add(content.Recipe {
    id = "slime_sample",
    result = "slime_sample",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_MUTAGEN",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 6,
    flags = { "SECRET" },
}
    :component("slime_scrap", 20)
    :requirement("serum_production_standard", 10)
    :requires_skill("survival", 3)
    :book("recipe_creepy", 6)
    :book("recipe_maiar", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(20, 5)
)

content.add(content.Recipe {
    id = "elfa_sample",
    result = "elfa_sample",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_MUTAGEN",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 6,
    flags = { "SECRET" },
}
    :component_any({
            { id = "alpha_sample", count = 1 },
            { id = "slime_sample", count = 3 }
        })
    :component("plant_sample", 2)
    :requirement("mutagen_production_standard", 10)
    :requires_skill("survival", 3)
    :book("recipe_elfa", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(20, 5)
)

content.add(content.Recipe {
    id = "medical_sample",
    result = "medical_sample",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_MUTAGEN",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("human_sample", 1)
    :component_any({
            { id = "heroin", count = 5 },
            { id = "oxycodone", count = 10 },
            { id = "tramadol", count = 15 },
            { id = "diazepam", count = 15 },
            { id = "codeine", count = 20 },
            { id = "poppy_pain", count = 20 }
        })
    :component_any({
            { id = "lsd", count = 5 },
            { id = "prozac", count = 10 },
            { id = "thorazine", count = 10 },
            { id = "adderall", count = 10 },
            { id = "xanax", count = 10 },
            { id = "pills_sleep", count = 10 },
            { id = "poppy_sleep", count = 15 }
        })
    :component_any({
            { id = "vitamins", count = 5 },
            { id = "iodine", count = 5 },
            { id = "disinfectant", count = 25 },
            { id = "protein_powder", count = 20 }
        })
    :requires_skill("firstaid", 3)
    :book("recipe_serum", 4)
    :book("recipe_labchem", 4)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(20, 5)
)

content.add(content.Recipe {
    id = "raptor_sample",
    result = "raptor_sample",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_MUTAGEN",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("beast_sample", 1)
    :component("bird_sample", 1)
    :component("lizard_sample", 1)
    :requires_skill("survival", 3)
    :book("recipe_animal", 8)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(20, 5)
)

ccb.runtime.handler("study_alpha_mutagen", function(craft)
    local character = craft.character
    if character.subtype ~= "avatar" then
        return
    end
    local snapshot = services.characters.snapshot(character)
    if not snapshot.ok then
        error(snapshot.error.message)
    end
    local text
    if snapshot.value.stats.intelligence >= 9 then
        text = ccb.services.translate("You realize from reading this that you need at least one to two more doses of primer than usual to make the irreversible change compared to other mutagens.")
    else
        text = ccb.services.translate("Yep, this is a recipe for some advanced substance.")
    end
    for _ = 1, craft.batch do
        services.messages.add(text, "mixed")
    end
end, 1)

content.add(content.Recipe {
    id = "mutagen_alpha",
    result = "mutagen_alpha",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    skill = "chemistry",
    difficulty = 8,
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    flags = { "SECRET" },
}:requires_skill("firstaid", 1)
    :result_charges(1)
    :book("recipe_alpha", 7)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :requirement("mutagen_production_standard", 50)
    :component_any({ { id = "mutagen_slime", count = 3 }, { id = "iv_mutagen_slime", count = 1 } })
    :component_any({ { id = "mutagen_plant", count = 3 }, { id = "iv_mutagen_plant", count = 1 } })
    :component_any({ { id = "mutagen_bird", count = 3 }, { id = "iv_mutagen_bird", count = 1 } })
    :component_any({ { id = "purifier", count = 4 }, { id = "iv_purifier", count = 1 } })
    :on_complete("study_alpha_mutagen"))
