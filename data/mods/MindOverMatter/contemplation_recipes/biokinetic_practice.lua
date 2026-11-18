local ccb = require("ccb")
local content = ccb.content
local register = require("psychic_contemplation")

local crystal_tools = {
    { id = "matrix_crystal_drained", count = 1 },
    { id = "black_nether_crystal_pseudo_tool", count = 1 },
    { id = "matrix_crystal_biokinesis", count = 1 },
    { id = "matrix_crystal_biokinesis_artifact", count = 1 },
}

register {
    id = "practice_biokin_overcome_pain",
    name = content.text("contemplation: overcome pain"),
    description = content.text("Contemplate your powers and improve your ability to resist pain.\n\nPower Difficulty: 1\n\nCurrent Power Level: <u_spell_level:biokin_overcome_pain>"),
    spell = "biokin_overcome_pain",
    trait = "BIOKINETIC",
    proficiency = "prof_contemplation_biokinesis",
    learning = "known_only",
    tools = crystal_tools,
}

register {
    id = "practice_biokin_physical_enhance",
    name = content.text("contemplation: physical enhancement"),
    description = content.text("Contemplate your powers and improve your ability to enhance your physical strength and agility.\n\nPower Difficulty: 2\n\nCurrent Power Level: <u_spell_level:biokin_physical_enhance>"),
    spell = "biokin_physical_enhance",
    trait = "BIOKINETIC",
    proficiency = "prof_contemplation_biokinesis",
    learning = "known_only",
    tools = crystal_tools,
}

register {
    id = "practice_biokin_breathe_skin",
    name = content.text("contemplation: oxygen absorption"),
    description = content.text("Contemplate your powers and improve your ability to draw any possible oxygen from the environment.\n\nPower Difficulty: 2\n\nCurrent Power Level: <u_spell_level:biokin_breathe_skin>"),
    spell = "biokin_breathe_skin",
    trait = "BIOKINETIC",
    proficiency = "prof_contemplation_biokinesis",
    learning = "discover",
    tools = crystal_tools,
}

register {
    id = "practice_biokin_flexibility",
    name = content.text("contemplation: flexibility"),
    description = content.text("Contemplate your powers and improve your ability to move your body.\n\nPower Difficulty: 3\n\nCurrent Power Level: <u_spell_level:biokin_flexibility>"),
    spell = "biokin_flexibility",
    trait = "BIOKINETIC",
    proficiency = "prof_contemplation_biokinesis",
    learning = "discover",
    tools = crystal_tools,
}

register {
    id = "practice_biokin_dash",
    name = content.text("contemplation: burst of speed"),
    description = content.text("Contemplate your powers and improve your ability to cross distances in moments.\n\nPower Difficulty: 3\n\nCurrent Power Level: <u_spell_level:biokin_dash>"),
    spell = "biokin_dash",
    trait = "BIOKINETIC",
    proficiency = "prof_contemplation_biokinesis",
    learning = "discover",
    tools = crystal_tools,
}

register {
    id = "practice_biokin_armor_skin",
    name = content.text("contemplation: armor skin"),
    description = content.text("Contemplate your powers and improve your ability to harden your flesh against incoming damage.\n\nPower Difficulty: 4\n\nCurrent Power Level: <u_spell_level:biokin_armor_skin>"),
    spell = "biokin_armor_skin",
    trait = "BIOKINETIC",
    proficiency = "prof_contemplation_biokinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_biokin_dust",
}

register {
    id = "practice_biokin_climate_control",
    name = content.text("contemplation: temperature adaptability"),
    description = content.text("Contemplate your powers and improve your ability to withstand temperature variations.\n\nPower Difficulty: 4\n\nCurrent Power Level: <u_spell_level:biokin_climate_control>"),
    spell = "biokin_climate_control",
    trait = "BIOKINETIC",
    proficiency = "prof_contemplation_biokinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_biokin_dust",
}

register {
    id = "practice_biokin_adrenaline",
    name = content.text("contemplation: adrenaline trigger"),
    description = content.text("Contemplate your powers and improve your ability to trigger a burst of adrenaline on command.\n\nPower Difficulty: 4\n\nCurrent Power Level: <u_spell_level:biokin_adrenaline>"),
    spell = "biokin_adrenaline",
    trait = "BIOKINETIC",
    proficiency = "prof_contemplation_biokinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_biokin_dust",
}

register {
    id = "practice_biokin_enhance_mobility",
    name = content.text("contemplation: enhance mobility"),
    description = content.text("Contemplate your powers and improve your ability to deal with encumbering gear.\n\nPower Difficulty: 5\n\nCurrent Power Level: <u_spell_level:biokin_enhance_mobility>"),
    spell = "biokin_enhance_mobility",
    trait = "BIOKINETIC",
    proficiency = "prof_contemplation_biokinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_biokin_dust",
}

register {
    id = "practice_biokin_hammerhand",
    name = content.text("contemplation: hammerhand"),
    description = content.text("Contemplate your powers and improve your ability to eschew the use of tools, using your own body in place of a hammer or wrench.\n\nPower Difficulty: 5\n\nCurrent Power Level: <u_spell_level:biokin_hammerhand>"),
    spell = "biokin_hammerhand",
    trait = "BIOKINETIC",
    proficiency = "prof_contemplation_biokinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_biokin_dust",
}

register {
    id = "practice_biokin_reflex_enhance",
    name = content.text("contemplation: heightened reflexes"),
    description = content.text("Contemplate your powers and improve your ability to enhance your reflexes.\n\nPower Difficulty: 6\n\nCurrent Power Level: <u_spell_level:biokin_reflex_enhance>"),
    spell = "biokin_reflex_enhance",
    trait = "BIOKINETIC",
    proficiency = "prof_contemplation_biokinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_biokin_dust",
}

register {
    id = "practice_biokin_sealed_system",
    name = content.text("contemplation: sealed system"),
    description = content.text("Contemplate your powers and improve your ability to hermetically seal your body.\n\nPower Difficulty: 7\n\nCurrent Power Level: <u_spell_level:biokin_sealed_system>"),
    spell = "biokin_sealed_system",
    trait = "BIOKINETIC",
    proficiency = "prof_contemplation_biokinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_biokin_dust",
}

register {
    id = "practice_biokin_metabolism_enhance",
    name = content.text("contemplation: metabolic hyperefficiency"),
    description = content.text("Contemplate your powers and improve your ability to extract every possible nutrient from your food and water.\n\nPower Difficulty: 7\n\nCurrent Power Level: <u_spell_level:biokin_metabolism_enhance>"),
    spell = "biokin_metabolism_enhance",
    trait = "BIOKINETIC",
    proficiency = "prof_contemplation_biokinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_biokin_dust",
}

register {
    id = "practice_biokin_vitaminosis",
    name = content.text("contemplation: vitaminosis"),
    description = content.text("Contemplate your powers and improve your ability to convert calories into vitamins.\n\nPower Difficulty: 8\n\nCurrent Power Level: <u_spell_level:biokin_vitaminosis>"),
    spell = "biokin_vitaminosis",
    trait = "BIOKINETIC",
    proficiency = "prof_contemplation_biokinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_biokin_dust",
}

register {
    id = "practice_biokin_guided_evolution",
    name = content.text("contemplation: guided evolution"),
    description = content.text("Contemplate your powers and improve your ability to alter how mutations are expressed.\n\nPower Difficulty: 9\n\nCurrent Power Level: <u_spell_level:biokin_guided_evolution>"),
    spell = "biokin_guided_evolution",
    trait = "BIOKINETIC",
    proficiency = "prof_contemplation_biokinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_biokin_dust",
}

register {
    id = "practice_biokin_combat_dance",
    name = content.text("contemplation: combat dance"),
    description = content.text("Contemplate your powers and improve your overall combat prowess.\n\nPower Difficulty: 8\n\nCurrent Power Level: <u_spell_level:biokin_combat_dance>"),
    spell = "biokin_combat_dance",
    trait = "BIOKINETIC",
    proficiency = "prof_contemplation_biokinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_biokin_dust",
}

register {
    id = "practice_biokin_perfected_motion",
    name = content.text("contemplation: perfected motion"),
    description = content.text("Contemplate your powers and improve your ability to outrun a racehorse.\n\nPower Difficulty: 9\n\nCurrent Power Level: <u_spell_level:biokin_perfected_motion>"),
    spell = "biokin_perfected_motion",
    trait = "BIOKINETIC",
    proficiency = "prof_contemplation_biokinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_biokin_dust",
}

register {
    id = "practice_biokin_hurricane_blows",
    name = content.text("contemplation: hurricane blows"),
    description = content.text("Contemplate your powers and improve your ability to strike your opponents faster than thought.\n\nPower Difficulty: 10\n\nCurrent Power Level: <u_spell_level:biokin_hurricane_blows>"),
    spell = "biokin_hurricane_blows",
    trait = "BIOKINETIC",
    proficiency = "prof_contemplation_biokinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_biokin_dust",
}
