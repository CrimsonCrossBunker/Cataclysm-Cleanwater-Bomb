local ccb = require("ccb")
local content = ccb.content
local register = require("psychic_contemplation")

local crystal_tools = {
    { id = "matrix_crystal_drained", count = 1 },
    { id = "black_nether_crystal_pseudo_tool", count = 1 },
    { id = "matrix_crystal_pyrokinesis", count = 1 },
    { id = "matrix_crystal_pyrokinesis_artifact", count = 1 },
}

register {
    id = "practice_pyrokinetic_flash",
    name = content.text("contemplation: brilliant flash"),
    description = content.text("Contemplate your powers and improve your ability to create a burst of light.\n\nPower Difficulty: 1\n\nCurrent Power Level: <u_spell_level:pyrokinetic_flash>"),
    spell = "pyrokinetic_flash",
    trait = "PYROKINETIC",
    proficiency = "prof_contemplation_pyrokinesis",
    learning = "study",
    tools = crystal_tools,
}

register {
    id = "practice_pyrokinetic_intensify_flames",
    name = content.text("contemplation: intensify flames"),
    description = content.text("Contemplate your powers and improve your ability increase the strength of existing flames.\n\nPower Difficulty: 1\n\nCurrent Power Level: <u_spell_level:pyrokinetic_intensify_flames>"),
    spell = "pyrokinetic_intensify_flames",
    trait = "PYROKINETIC",
    proficiency = "prof_contemplation_pyrokinesis",
    learning = "study",
    tools = crystal_tools,
}

register {
    id = "practice_pyrokinetic_eruption",
    name = content.text("contemplation: fountain of flames"),
    description = content.text("Contemplate your powers and improve your ability to summon flames.\n\nPower Difficulty: 2\n\nCurrent Power Level: <u_spell_level:pyrokinetic_eruption>"),
    spell = "pyrokinetic_eruption",
    trait = "PYROKINETIC",
    proficiency = "prof_contemplation_pyrokinesis",
    learning = "discover",
    tools = crystal_tools,
}

register {
    id = "practice_pyrokinetic_cauterize",
    name = content.text("contemplation: cauterize"),
    description = content.text("Contemplate your powers and improve your ability to close your wounds with precisely-directed fire.\n\nPower Difficulty: 2\n\nCurrent Power Level: <u_spell_level:pyrokinetic_cauterize>"),
    spell = "pyrokinetic_cauterize",
    trait = "PYROKINETIC",
    proficiency = "prof_contemplation_pyrokinesis",
    learning = "discover",
    tools = crystal_tools,
}

register {
    id = "practice_pyrokinetic_quell_flames",
    name = content.text("contemplation: quell fire"),
    description = content.text("Contemplate your powers and improve your ability to douse flames.\n\nPower Difficulty: 3\n\nCurrent Power Level: <u_spell_level:pyrokinetic_quell_flames>"),
    spell = "pyrokinetic_quell_flames",
    trait = "PYROKINETIC",
    proficiency = "prof_contemplation_pyrokinesis",
    learning = "discover",
    tools = crystal_tools,
}

register {
    id = "practice_pyrokinetic_call_flames",
    name = content.text("contemplation: banked flames"),
    description = content.text("Contemplate your powers and improve your ability to summon a controlled flame.\n\nPower Difficulty: 3\n\nCurrent Power Level: <u_spell_level:pyrokinetic_call_flames>"),
    spell = "pyrokinetic_call_flames",
    trait = "PYROKINETIC",
    proficiency = "prof_contemplation_pyrokinesis",
    learning = "discover",
    tools = crystal_tools,
}

register {
    id = "practice_pyrokinetic_cloak",
    name = content.text("contemplation: cloak of warmth"),
    description = content.text("Contemplate your powers and improve your control of nearby temperatures.\n\nPower Difficulty: 4\n\nCurrent Power Level: <u_spell_level:pyrokinetic_cloak>"),
    spell = "pyrokinetic_cloak",
    trait = "PYROKINETIC",
    proficiency = "prof_contemplation_pyrokinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_pyrokin_dust",
}

register {
    id = "practice_pyrokinetic_flamethrower",
    name = content.text("contemplation: flamethrower"),
    description = content.text("Contemplate your powers and improve your ability to direct a spray of flame.\n\nPower Difficulty: 5\n\nCurrent Power Level: <u_spell_level:pyrokinetic_flamethrower>"),
    spell = "pyrokinetic_flamethrower",
    trait = "PYROKINETIC",
    proficiency = "prof_contemplation_pyrokinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_pyrokin_dust",
}

register {
    id = "practice_pyrokinetic_lance",
    name = content.text("contemplation: incandescent lance"),
    description = content.text("Contemplate your powers and improve your ability to focus heat into a searing point.\n\nPower Difficulty: 5\n\nCurrent Power Level: <u_spell_level:pyrokinetic_lance>"),
    spell = "pyrokinetic_lance",
    trait = "PYROKINETIC",
    proficiency = "prof_contemplation_pyrokinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_pyrokin_dust",
}

register {
    id = "practice_pyrokinetic_thermogenesis",
    name = content.text("contemplation: thermogenesis"),
    description = content.text("Contemplate your powers and improve your ability to warm the air to produce lasting heat.\n\nPower Difficulty: 6\n\nCurrent Power Level: <u_spell_level:pyrokinetic_thermogenesis>"),
    spell = "pyrokinetic_thermogenesis",
    trait = "PYROKINETIC",
    proficiency = "prof_contemplation_pyrokinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_pyrokin_dust",
}

register {
    id = "practice_pyrokinetic_aura",
    name = content.text("contemplation: blazing aura"),
    description = content.text("Contemplate your powers and improve your ability to heat the surrounding air to dangerous temperatures.\n\nPower Difficulty: 6\n\nCurrent Power Level: <u_spell_level:pyrokinetic_aura>"),
    spell = "pyrokinetic_aura",
    trait = "PYROKINETIC",
    proficiency = "prof_contemplation_pyrokinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_pyrokin_dust",
}

register {
    id = "practice_pyrokinetic_flame_immunity",
    name = content.text("contemplation: flameshield"),
    description = content.text("Contemplate your powers and improve your immunity to fire.\n\nPower Difficulty: 7\n\nCurrent Power Level: <u_spell_level:pyrokinetic_flame_immunity>"),
    spell = "pyrokinetic_flame_immunity",
    trait = "PYROKINETIC",
    proficiency = "prof_contemplation_pyrokinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_pyrokin_dust",
}

register {
    id = "practice_pyrokinetic_blast",
    name = content.text("contemplation: conflagration"),
    description = content.text("Contemplate your powers and improve your manifestation of explosions.\n\nPower Difficulty: 7\n\nCurrent Power Level: <u_spell_level:pyrokinetic_blast>"),
    spell = "pyrokinetic_blast",
    trait = "PYROKINETIC",
    proficiency = "prof_contemplation_pyrokinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_pyrokin_dust",
}

register {
    id = "practice_pyrokinetic_aoe_blast",
    name = content.text("contemplation: hellfire"),
    description = content.text("Contemplate your powers and improve your ability to call down sheets of fire on everything around you.\n\nPower Difficulty: 9\n\nCurrent Power Level: <u_spell_level:pyrokinetic_aoe_blast>"),
    spell = "pyrokinetic_aoe_blast",
    trait = "PYROKINETIC",
    proficiency = "prof_contemplation_pyrokinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_pyrokin_dust",
}

register {
    id = "practice_pyrokinetic_incineration",
    name = content.text("contemplation: crucible"),
    description = content.text("Contemplate your powers and improve your ability to completely incinerate your target.\n\nPower Difficulty: 10\n\nCurrent Power Level: <u_spell_level:pyrokinetic_incineration>"),
    spell = "pyrokinetic_incineration",
    trait = "PYROKINETIC",
    proficiency = "prof_contemplation_pyrokinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_pyrokin_dust",
}
