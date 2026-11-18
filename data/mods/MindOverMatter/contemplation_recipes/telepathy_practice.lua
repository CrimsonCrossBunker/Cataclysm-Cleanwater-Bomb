local ccb = require("ccb")
local content = ccb.content
local register = require("psychic_contemplation")

local crystal_tools = {
    { id = "matrix_crystal_drained", count = 1 },
    { id = "black_nether_crystal_pseudo_tool", count = 1 },
    { id = "matrix_crystal_telepathy", count = 1 },
}

register {
    id = "practice_telepathic_concentration",
    name = content.text("contemplation: concentration trance"),
    description = content.text("Contemplate your powers and improve your laser-like focus.\n\nPower Difficulty: 1\n\nCurrent Power Level: <u_spell_level:telepathic_concentration>"),
    spell = "telepathic_concentration",
    trait = "TELEPATH",
    proficiency = "prof_contemplation_telepathy",
    learning = "study",
    tools = crystal_tools,
}

register {
    id = "practice_telepathic_mind_sense",
    name = content.text("contemplation: mind sense"),
    description = content.text("Contemplate your powers and improve your ability to detect other minds.\n\nPower Difficulty: 2\n\nCurrent Power Level: <u_spell_level:telepathic_mind_sense>"),
    spell = "telepathic_mind_sense",
    trait = "TELEPATH",
    proficiency = "prof_contemplation_telepathy",
    learning = "study",
    tools = crystal_tools,
}

register {
    id = "practice_telepathic_shield",
    name = content.text("contemplation: telepathic shield"),
    description = content.text("Contemplate your powers and improve the resilience of your mind.\n\nPower Difficulty: 2\n\nCurrent Power Level: <u_spell_level:telepathic_shield>"),
    spell = "telepathic_shield",
    trait = "TELEPATH",
    proficiency = "prof_contemplation_telepathy",
    learning = "discover",
    tools = crystal_tools,
}

register {
    id = "practice_telepathic_mesmerize",
    name = content.text("contemplation: mesmerize"),
    description = content.text("Contemplate your powers and improve your ability to place your opponents into a trance.\n\nPower Difficulty: 3\n\nCurrent Power Level: <u_spell_level:telepathic_mesmerize>"),
    spell = "telepathic_mesmerize",
    trait = "TELEPATH",
    proficiency = "prof_contemplation_telepathy",
    learning = "discover",
    tools = crystal_tools,
}

register {
    id = "practice_telepathic_morale",
    name = content.text("contemplation: mood stabilization"),
    description = content.text("Contemplate your powers and improve your control of your own emotions or the emotions of others.\n\nPower Difficulty: 3\n\nCurrent Power Level: <u_spell_level:telepathic_morale>"),
    spell = "telepathic_morale",
    trait = "TELEPATH",
    proficiency = "prof_contemplation_telepathy",
    learning = "discover",
    tools = crystal_tools,
}

register {
    id = "practice_telepathic_blast",
    name = content.text("contemplation: synaptic overload"),
    description = content.text("Contemplate your powers and improve your mental strength to telepathically assault your enemies.\n\nPower Difficulty: 4\n\nCurrent Power Level: <u_spell_level:telepathic_blast>"),
    spell = "telepathic_blast",
    trait = "TELEPATH",
    proficiency = "prof_contemplation_telepathy",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_telepath_dust",
}

register {
    id = "practice_telepathic_beastmaster",
    name = content.text("contemplation: beastmaster"),
    description = content.text("Contemplate your powers and improve your ability to overpower the minds of animals.\n\nPower Difficulty: 4\n\nCurrent Power Level: <u_spell_level:telepathic_animal_mind_control>"),
    spell = "telepathic_animal_mind_control",
    trait = "TELEPATH",
    proficiency = "prof_contemplation_telepathy",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_telepath_dust",
}

register {
    id = "practice_telepathic_confusion",
    name = content.text("contemplation: sensory deprivation"),
    description = content.text("Contemplate your powers and improve your ability to confound your enemies's senses.\n\nPower Difficulty: 5\n\nCurrent Power Level: <u_spell_level:telepathic_confusion>"),
    spell = "telepathic_confusion",
    trait = "TELEPATH",
    proficiency = "prof_contemplation_telepathy",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_telepath_dust",
}

register {
    id = "practice_telepathic_invisibility",
    name = content.text("contemplation: obscurity"),
    description = content.text("Contemplate your powers and improve your ability to make your enemies ignore you.\n\nPower Difficulty: 6\n\nCurrent Power Level: <u_spell_level:telepathic_invisibility>"),
    spell = "telepathic_invisibility",
    trait = "TELEPATH",
    proficiency = "prof_contemplation_telepathy",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_telepath_dust",
}

register {
    id = "practice_telepathic_fear",
    name = content.text("contemplation: primal terror"),
    description = content.text("Contemplate your powers and improve your ability to turn your enemies' greatest fears against them.\n\nPower Difficulty: 6\n\nCurrent Power Level: <u_spell_level:telepathic_fear>"),
    spell = "telepathic_fear",
    trait = "TELEPATH",
    proficiency = "prof_contemplation_telepathy",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_telepath_dust",
}

register {
    id = "practice_telepathic_scream",
    name = content.text("contemplation: psychic scream"),
    description = content.text("Contemplate your powers and improve the volume of your undirected psionic shrieking.\n\nPower Difficulty: 7\n\nCurrent Power Level: <u_spell_level:telepathic_blast_radius>"),
    spell = "telepathic_blast_radius",
    trait = "TELEPATH",
    proficiency = "prof_contemplation_telepathy",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_telepath_dust",
}

register {
    id = "practice_telepathic_beast_taming",
    name = content.text("contemplation: beast tamer"),
    description = content.text("Contemplate your powers and improve your ability to control animals over the long term.\n\nPower Difficulty: 7\n\nCurrent Power Level: <u_spell_level:telepathic_beast_taming>"),
    spell = "telepathic_beast_taming",
    trait = "TELEPATH",
    proficiency = "prof_contemplation_telepathy",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_telepath_dust",
}

register {
    id = "practice_telepathic_mind_control",
    name = content.text("contemplation: mind control"),
    description = content.text("Contemplate your powers and improve your domination of others' minds.\n\nPower Difficulty: 8\n\nCurrent Power Level: <u_spell_level:telepathic_mind_control>"),
    spell = "telepathic_mind_control",
    trait = "TELEPATH",
    proficiency = "prof_contemplation_telepathy",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_telepath_dust",
}

register {
    id = "practice_telepathic_network",
    name = content.text("contemplation: network effect"),
    description = content.text("Contemplate your powers and improve your ability to link multiple people into a gestalt whole.\n\nPower Difficulty: 9\n\nCurrent Power Level: <u_spell_level:telepathic_network>"),
    spell = "telepathic_network",
    trait = "TELEPATH",
    proficiency = "prof_contemplation_telepathy",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_telepath_dust",
}
